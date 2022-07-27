#include <ace/Acceptor.h>
#include <ace/INET_Addr.h>
#include <ace/Reactor.h>
#include <ace/SOCK_Acceptor.h>
#include <ace/SOCK_Stream.h>
#include <ace/Svc_Handler.h>

#include <cstdlib>
#include <cstring>
#include <iostream>
#include <string>

const u_short HTTP_PORT = 8080;
const size_t BUFFER_SIZE = 64*1024;

const int HANDLER_ERROR = -1, HANDLER_REMOVE = -1, HANDLER_OK = 0, HANDLER_CALL = 1;

enum class HttpError { NotFound = 404 };

class HttpConnection : public ACE_Svc_Handler<ACE_SOCK_Stream, ACE_NULL_SYNCH> {
  //TODO: determine correct sync policy for ACE_Svc_Handler base class

public:
  HttpConnection()
    : buffer_(BUFFER_SIZE)
  {}

  int open(void* acceptor); // called by ACE_Acceptor

private:
  int handle_input(ACE_HANDLE h);

  bool requestIsComplete(std::string& target) const;
  bool parseRequestLine(const std::string& requestLine,
                        std::string& target) const;
  void respond() const;
  void respondError(HttpError err) const;

  ACE_Message_Block buffer_;
};

using HttpAcceptor = ACE_Acceptor<HttpConnection, ACE_SOCK_Acceptor>;

int HttpConnection::open(void*)
{
  if (-1 == reactor()->register_handler(this, READ_MASK)) {
    return HANDLER_ERROR;
  }
  return HANDLER_OK;
}

int HttpConnection::handle_input(ACE_HANDLE)
{
  const auto bytes = peer().recv(buffer_.wr_ptr(), buffer_.space(),
                                 &ACE_Time_Value::zero);
  if (bytes < 0 && errno == ETIME) {
    return HANDLER_OK;
  }

  if (bytes <= 0) {
    return HANDLER_ERROR;
  }

  buffer_.wr_ptr(bytes);

  std::string target;
  if (requestIsComplete(target)) {
    if (target == "/index.html") {
      respond();
    } else {
      respondError(HttpError::NotFound);
    }
    //TODO: real connection management with half-close and reading 0 from client
    peer().close();
    return HANDLER_REMOVE;
  }
  return HANDLER_OK;
}

bool HttpConnection::parseRequestLine(const std::string& requestLine,
                                      std::string& target) const
{
  // Only GET is supported
  static const char METHOD_GET[] = "GET ";
  static const size_t GET_LEN = sizeof(METHOD_GET) - 1 /* no nul terminator */;
  if (requestLine.find(METHOD_GET) != 0) return false;

  const auto targetEnd = requestLine.find(' ', GET_LEN);
  if (targetEnd == std::string::npos ||
      requestLine.find("HTTP/1.", targetEnd + 1) != targetEnd + 1) {
    return false;
  }

  target = std::string(requestLine, GET_LEN, targetEnd - GET_LEN);
  return true;
}

bool HttpConnection::requestIsComplete(std::string& target) const
{
  const std::string req(buffer_.rd_ptr(), buffer_.length());
  std::cout << req << std::endl;
  const auto reqLineEnd = req.find("\r\n");
  if (reqLineEnd == std::string::npos ||
      !parseRequestLine(std::string(req, 0, reqLineEnd), target)) {
    return false;
  }
  return req.find("\r\n\r\n") != std::string::npos;
}

void HttpConnection::respond() const
{
  static const char RESPONSE[] = "HTTP/1.1 200 \r\n"
    "\r\n"
    "<!DOCTYPE html><html><body>Hello, World.</body></html>";
  peer().send(RESPONSE, sizeof(RESPONSE) - 1 /* nul terminator excluded */);
}

void HttpConnection::respondError(HttpError err) const
{
  char response[] = "HTTP/1.1 XXX \r\n\r\n";
  std::strncpy(&response[9], std::to_string(static_cast<int>(err)).c_str(), 3);
  peer().send(response, sizeof(response) - 1 /* nul terminator excluded */);
}

int main()
{
  const auto reactor = ACE_Reactor::instance();
  HttpAcceptor accept;
  const ACE_INET_Addr listen(HTTP_PORT);
  if (HANDLER_ERROR == accept.open(listen, reactor)) {
    return EXIT_FAILURE;
  }

  if (HANDLER_ERROR == reactor->run_reactor_event_loop()) {
    return EXIT_FAILURE;
  }
}
