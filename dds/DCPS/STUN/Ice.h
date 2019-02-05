/*
 *
 *
 * Distributed under the OpenDDS License.
 * See: http://www.opendds.org/license.html
 */

#ifndef OPENDDS_RTPS_ICE_H
#define OPENDDS_RTPS_ICE_H

#include "ace/INET_Addr.h"
#include "dds/DCPS/Serializer.h"
#include "dds/DCPS/STUN/Stun.h"
#include "dds/DdsDcpsInfoUtilsC.h"
#include "dds/DCPS/GuidUtils.h"

#include <cassert>
#include <sstream>

#if !defined (ACE_LACKS_PRAGMA_ONCE)
#pragma once
#endif /* ACE_LACKS_PRAGMA_ONCE */

OPENDDS_BEGIN_VERSIONED_NAMESPACE_DECL

namespace OpenDDS {
namespace ICE {

  template <typename T>
  std::string stringify(T x) {
    std::stringstream str;
    str << x;
    return str.str();
  }

  enum AgentType {
    FULL = 0x0,
    LITE = 0x1,
  };

  enum CandidateType {
    HOST = 0x0,
    SERVER_REFLEXIVE = 0x1,
    PEER_REFLEXIVE = 0x2,
    RELAYED = 0x3,
  };

  struct Candidate {
    ACE_INET_Addr address;
    // Transport - UDP or TCP
    std::string foundation;
    // Component ID
    uint32_t priority;
    CandidateType type;
    // Related Address and Port
    // Extensibility Parameters

    ACE_INET_Addr base;  // Not sent.

    bool operator==(const Candidate& other) const;
  };

  bool candidates_sorted(const Candidate& x, const Candidate& y);
  bool candidates_equal(const Candidate& x, const Candidate& y);

  Candidate make_host_candidate(const ACE_INET_Addr& address);
  Candidate make_server_reflexive_candidate(const ACE_INET_Addr& address, const ACE_INET_Addr& base, const ACE_INET_Addr& server_address);
  Candidate make_peer_reflexive_candidate(const ACE_INET_Addr& address, const ACE_INET_Addr& base, const ACE_INET_Addr& server_address, uint32_t priority);
  Candidate make_peer_reflexive_candidate(const ACE_INET_Addr& address, uint32_t priority, size_t q);

  struct AgentInfo {
    typedef std::vector<Candidate> CandidatesType;
    typedef CandidatesType::const_iterator const_iterator;

    CandidatesType candidates;
    AgentType type;
    // Connectivity-Check Pacing Value
    std::string username;
    std::string password;
    // Extensions

    const_iterator begin() const { return candidates.begin(); }
    const_iterator end() const { return candidates.end(); }
    bool operator==(const AgentInfo& other) const {
      return this->candidates == other.candidates && this->type == other.type && this->username == other.username && this->password == other.password;
    }
    bool operator!=(const AgentInfo& other) const { return !(*this == other); }
  };

  typedef std::vector<ACE_INET_Addr> AddressListType;

  class Endpoint {
  public:
    virtual ~Endpoint() {}
    virtual AddressListType host_addresses() const = 0;
    virtual void send(const ACE_INET_Addr& address, const STUN::Message& message) = 0;
    virtual ACE_INET_Addr stun_server_address() const = 0;
  };

  class OpenDDS_Stun_Export Agent {
  public:
    virtual void add_endpoint(Endpoint * a_endpoint) = 0;
    virtual AgentInfo get_local_agent_info(Endpoint * a_endpoint) const = 0;
    virtual void start_ice(Endpoint * a_endpoint,
                           DCPS::RepoId const & a_local_guid,
                           DCPS::RepoId const & a_remote_guid,
                           AgentInfo const & a_remote_agent_info) = 0;
    virtual void stop_ice(DCPS::RepoId const & a_local_guid,
                          DCPS::RepoId const & a_remote_guid) = 0;
    virtual ACE_INET_Addr get_address(Endpoint * a_endpoint,
                                      DCPS::RepoId const & a_local_guid,
                                      DCPS::RepoId const & a_remote_guid) const = 0;

    // Receive a STUN message.
    virtual void receive(Endpoint * a_endpoint,
                         ACE_INET_Addr const & a_local_address,
                         ACE_INET_Addr const & a_remote_address,
                         STUN::Message const & a_message) = 0;

    static Agent* instance();
  };

  std::ostream& operator<<(std::ostream& stream, const ACE_INET_Addr& address);
  std::ostream& operator<<(std::ostream& stream, const STUN::TransactionId& tid);
  std::ostream& operator<<(std::ostream& stream, const ICE::Candidate& candidate);
  std::ostream& operator<<(std::ostream& stream, const ICE::AgentInfo& agent_info);

} // namespace ICE
} // namespace OpenDDS

OPENDDS_END_VERSIONED_NAMESPACE_DECL

#endif /* OPENDDS_RTPS_ICE_H */
