/*
 *
 *
 * Distributed under the OpenDDS License.
 * See: http://www.opendds.org/license.html
 */

#include "EndpointManager.h"

#include <openssl/rand.h>
#include <openssl/err.h>

#include "Checklist.h"

OPENDDS_BEGIN_VERSIONED_NAMESPACE_DECL

namespace OpenDDS {
namespace ICE {

  // Perform server-reflexive candidate gathering this often.
  const ACE_Time_Value server_reflexive_address_period(30);
  // Send this many binding indications to the STUN server before sending a binding request.
  const size_t server_reflexive_indication_count = 10;

  EndpointManager::EndpointManager(AgentImpl * a_agent_impl, Endpoint * a_endpoint) :
    Task(a_agent_impl),
    agent_impl(a_agent_impl),
    endpoint(a_endpoint),
    m_requesting(true),
    m_send_count(0) {

    set_host_addresses(endpoint->host_addresses());
    enqueue(ACE_Time_Value().now());
  }

  void EndpointManager::start_ice(DCPS::RepoId const & a_local_guid,
                                  DCPS::RepoId const & a_remote_guid,
                                  AgentInfo const & a_remote_agent_info) {
    GuidPair guidp(a_local_guid, a_remote_guid);

    // Try to find by guid.
    Checklist * guid_checklist = 0;
    {
      GuidPairToChecklistType::const_iterator pos = m_guid_pair_to_checklist.find(guidp);
      if (pos != m_guid_pair_to_checklist.end()) {
        guid_checklist = pos->second;
      }
    }

    // Try to find by username.
    Checklist * username_checklist = 0;
    {
      UsernameToChecklistType::const_iterator pos = m_username_to_checklist.find(a_remote_agent_info.username);
      if (pos != m_username_to_checklist.end()) {
        username_checklist = pos->second;
      } else {
        username_checklist = create_checklist(a_remote_agent_info);
      }
    }

    if (guid_checklist != username_checklist) {
      if (guid_checklist != 0) {
        guid_checklist->remove_guid(guidp);
      }
      username_checklist->add_guid(guidp);
    }

    AgentInfo old_remote_agent_info = username_checklist->original_remote_agent_info();
    if (old_remote_agent_info == a_remote_agent_info) {
      // No change.
      return;
    }

    old_remote_agent_info.password = a_remote_agent_info.password;
    if (old_remote_agent_info == a_remote_agent_info) {
      // Password change.
      username_checklist->set_remote_password(a_remote_agent_info.password);
      return;
    }

    // Re-using username.
    // TODO(jrw972)
    assert(false);
  }

  ACE_INET_Addr EndpointManager::get_address(DCPS::RepoId const & a_local_guid,
                                             DCPS::RepoId const & a_remote_guid) const {
    GuidPair guidp(a_local_guid, a_remote_guid);
    GuidPairToChecklistType::const_iterator pos = m_guid_pair_to_checklist.find(guidp);
    if (pos != m_guid_pair_to_checklist.end()) {
      return pos->second->selected_address();
    }

    return ACE_INET_Addr();
  }


  void EndpointManager::receive(ACE_INET_Addr const & a_local_address,
                                ACE_INET_Addr const & a_remote_address,
                                STUN::Message const & a_message) {
    switch (a_message.class_) {
    case STUN::REQUEST:
      request(a_local_address, a_remote_address, a_message);
      break;
    case STUN::INDICATION:
      // Do nothing.
      break;
    case STUN::SUCCESS_RESPONSE:
      success_response(a_local_address, a_remote_address, a_message);
      break;
    case STUN::ERROR_RESPONSE:
      error_response(a_remote_address, a_message);
      break;
    }
  }

  void EndpointManager::set_host_addresses(AddressListType const & a_host_addresses) {
    // TODO(jrw972):  Filter out addresses not allowed by the spec.
    // TODO(jrw972):  Set up periodic task to repopulate these.
    if (m_host_addresses != a_host_addresses) {
      m_host_addresses = a_host_addresses;
      regenerate_agent_info();
    }
  }

  void EndpointManager::set_server_reflexive_address(ACE_INET_Addr const & a_server_reflexive_address,
                                                     ACE_INET_Addr const & a_stun_server_address) {
    if (m_server_reflexive_address != a_server_reflexive_address ||
        m_stun_server_address != a_stun_server_address) {
      m_server_reflexive_address = a_server_reflexive_address;
      m_stun_server_address = a_stun_server_address;
      regenerate_agent_info();
    }
  }

  void EndpointManager::regenerate_agent_info() {
    // Populate candidates.
    m_agent_info.candidates.clear();
    for (AddressListType::const_iterator pos = m_host_addresses.begin(), limit = m_host_addresses.end(); pos != limit; ++pos) {
      m_agent_info.candidates.push_back(make_host_candidate(*pos));
      if (m_server_reflexive_address != ACE_INET_Addr() &&
          m_stun_server_address != ACE_INET_Addr()) {
        m_agent_info.candidates.push_back(make_server_reflexive_candidate(m_server_reflexive_address, *pos, m_stun_server_address));
      }
    }

    // Eliminate duplicates.
    std::sort(m_agent_info.candidates.begin (), m_agent_info.candidates.end (), candidates_sorted);
    AgentInfo::CandidatesType::iterator last = std::unique(m_agent_info.candidates.begin (), m_agent_info.candidates.end (), candidates_equal);
    m_agent_info.candidates.erase(last, m_agent_info.candidates.end());

    int rc =  RAND_bytes(reinterpret_cast<unsigned char*>(&m_ice_tie_breaker), sizeof(m_ice_tie_breaker));
    unsigned long err = ERR_get_error();
    if (rc != 1) {
      /* RAND_bytes failed */
      /* `err` is valid    */
      // TODO(jrw972)
    }

    // Set the type.
    m_agent_info.type = FULL;

    // Generate username and password.
    uint32_t username = 0;
    rc = RAND_bytes(reinterpret_cast<unsigned char*>(&username), sizeof(username));
    err = ERR_get_error();
    if (rc != 1) {
      /* RAND_bytes failed */
      /* `err` is valid    */
      // TODO(jrw972)
    }
    m_agent_info.username = stringify(username);

    uint64_t password[2] = { 0, 0 };
    rc = RAND_bytes(reinterpret_cast<unsigned char*>(&password[0]), sizeof(password));
    err = ERR_get_error();
    if (rc != 1) {
      /* RAND_bytes failed */
      /* `err` is valid    */
      // TODO(jrw972)
    }
    m_agent_info.password = stringify(password[0]) + stringify(password[1]);

    std::cout << m_agent_info << std::endl;

    // Start over.
    UsernameToChecklistType old_checklists = m_username_to_checklist;

    for (UsernameToChecklistType::const_iterator pos = old_checklists.begin(),
           limit = old_checklists.end();
         pos != limit; ++pos) {
      Checklist * old_checklist = pos->second;
      AgentInfo const remote_agent_info = old_checklist->original_remote_agent_info();
      GuidSetType const guids = old_checklist->guids();
      old_checklist->remove_guids();
      Checklist * new_checklist = create_checklist(remote_agent_info);
      new_checklist->add_guids(guids);
    }

    // TODO(jrw972):  Propagate changed info up.
  }

  void EndpointManager::execute(ACE_Time_Value const & a_now) {
    m_next_stun_server_address = endpoint->stun_server_address();
    if (m_next_stun_server_address != ACE_INET_Addr()) {
      m_binding_request = STUN::Message();
      m_binding_request.class_ = m_requesting ? STUN::REQUEST : STUN::INDICATION;
      m_binding_request.method = STUN::BINDING;
      m_binding_request.generate_transaction_id();
      // TODO(jrw972):  Consider using fingerprint.

      endpoint->send(m_next_stun_server_address, m_binding_request);
      if (!m_requesting && m_send_count == server_reflexive_indication_count - 1) {
        m_requesting = true;
      }
      m_send_count = (m_send_count + 1) % server_reflexive_indication_count;
    } else {
      m_requesting = true;
      m_send_count = 0;
    }
    enqueue(a_now + server_reflexive_address_period);
  }

  bool EndpointManager::success_response(STUN::Message const & message) {
    if (message.transaction_id != m_binding_request.transaction_id) {
      return false;
    }

    ACE_INET_Addr server_reflexive_address;
    if (message.get_mapped_address(server_reflexive_address)) {
      set_server_reflexive_address(server_reflexive_address, m_next_stun_server_address);
      m_requesting = false;
      m_send_count = 0;
    } else {
      set_server_reflexive_address(ACE_INET_Addr(), ACE_INET_Addr());
      m_requesting = true;
      m_send_count = 0;
    }
    return true;
  }

  Checklist * EndpointManager::create_checklist(AgentInfo const & remote_agent_info) {
    Checklist* checklist = new Checklist(this, m_agent_info, remote_agent_info, m_ice_tie_breaker);
    //std::cout << local_agent_info_.username << " new checklist for " << remote_agent_info.username << std::endl;
    //std::cout << local_agent_info_.username << " now has " << m_checklists.size() << " checklists " << std::endl;
    // Add the deferred triggered first in case there was a nominating check.
    DeferredTriggeredChecksType::iterator pos = m_deferred_triggered_checks.find(remote_agent_info.username);
    if (pos != m_deferred_triggered_checks.end()) {
      const DeferredTriggeredCheckListType& list = pos->second;
      for (DeferredTriggeredCheckListType::const_iterator pos = list.begin(), limit = list.end(); pos != limit; ++pos) {
        checklist->generate_triggered_check(pos->local_address, pos->remote_address, pos->priority, pos->use_candidate);
      }
      m_deferred_triggered_checks.erase(pos);
    }
    checklist->unfreeze();

    return checklist;
  }

  // STUN Message processing.
  void EndpointManager::request(ACE_INET_Addr const & local_address,
                                ACE_INET_Addr const & remote_address,
                                STUN::Message const & message) {
    if (message.contains_unknown_comprehension_required_attributes()) {
      std::cerr << "TODO: Send 420 with unknown attributes" << std::endl;
      return;
    }

    if (!message.has_fingerprint()) {
      std::cerr << "TODO: Send 400 (Bad Request)" << std::endl;
      return;
    }

    if (!message.has_ice_controlled() && !message.has_ice_controlling()) {
      std::cerr << "TODO: Send 400 (Bad Request)" << std::endl;
      return;
    }

    bool use_candidate = message.has_use_candidate();
    if (use_candidate && message.has_ice_controlled()) {
      std::cerr << "TODO: Send 400 (Bad Request)" << std::endl;
      return;
    }

    uint32_t priority;
    if (!message.get_priority(priority)) {
      std::cerr << "TODO: Send 400 (Bad Request)" << std::endl;
      return;
    }

    std::string username;
    if (!message.get_username(username)) {
      std::cerr << "TODO: Send 400 (Bad Request)" << std::endl;
      return;
    }
    if (!message.has_message_integrity()) {
      std::cerr << "TODO: Send 400 (Bad Request)" << std::endl;
      return;
    }

    size_t idx = username.find(':');
    if (idx == std::string::npos) {
      std::cerr << "TODO: Send 400 (Bad Request)" << std::endl;
      return;
    }

    if (username.substr(0, idx) != m_agent_info.username) {
      std::cerr << "TODO: Send 401 (Unauthorized)" << std::endl;
      return;
    }

    const std::string remote_username = username.substr(++idx);

    // Check the message_integrity.
    if (!message.verify_message_integrity(m_agent_info.password)) {
      std::cerr << "TODO: Send 401 (Unauthorized)" << std::endl;
      return;
    }

    switch (message.method) {
    case STUN::BINDING:
      {
        // 7.3
        STUN::Message response;
        response.class_ = STUN::SUCCESS_RESPONSE;
        response.method = STUN::BINDING;
        memcpy(response.transaction_id.data, message.transaction_id.data, sizeof(message.transaction_id.data));
        response.append_attribute(STUN::make_mapped_address(remote_address));
        response.append_attribute(STUN::make_xor_mapped_address(remote_address));
        response.append_attribute(STUN::make_message_integrity());
        response.password = m_agent_info.password;
        response.append_attribute(STUN::make_fingerprint());
        endpoint->send(remote_address, response);

        // std::cout << local_agent_info_.username << " respond to " << remote_username << ' ' << remote_address << ' ' << message.transaction_id << " use_candidate=" << use_candidate << std::endl;

        // Hack to get local port.
        const_cast<ACE_INET_Addr&>(local_address).set(port(), local_address.get_ip_address());

        // 7.3.1.3
        UsernameToChecklistType::const_iterator pos = m_username_to_checklist.find(remote_username);
        if (pos != m_username_to_checklist.end()) {
          // We have a checklist.
          Checklist* checklist = pos->second;
          checklist->generate_triggered_check(local_address, remote_address, priority, use_candidate);
        } else {
          std::pair<DeferredTriggeredChecksType::iterator, bool> x = m_deferred_triggered_checks.insert(std::make_pair(remote_username, DeferredTriggeredCheckListType()));
          x.first->second.push_back(DeferredTriggeredCheck(local_address, remote_address, priority, use_candidate));
        }
      }
      break;
    default:
      // Unknown method.  Stop processing.
      std::cerr << "TODO: Send error for unsupported method" << std::endl;
      break;
    }
  }

  void EndpointManager::success_response(ACE_INET_Addr const & local_address,
                                         ACE_INET_Addr const & remote_address,
                                         STUN::Message const & message) {
    if (message.contains_unknown_comprehension_required_attributes()) {
      std::cerr << "TODO: Success response with unknown attributes" << std::endl;
      return;
    }

    switch (message.method) {
    case STUN::BINDING:
      {
        if (success_response(message)) {
          return;
        }

        // std::cout << local_agent_info_.username << " response from " << remote_address << ' ' << message.transaction_id << std::endl;

        TransactionIdToChecklistType::const_iterator pos = m_transaction_id_to_checklist.find(message.transaction_id);
        if (pos == m_transaction_id_to_checklist.end()) {
          // Probably a check that got cancelled.
          return;
        }

        // Checklist is responsible for updating the map.
        pos->second->success_response(local_address, remote_address, message);
      }
      break;
    default:
      // Unknown method.  Stop processing.
      std::cerr << "TODO: Send error for unsupported method" << std::endl;
      break;
    }
  }

  void EndpointManager::error_response(ACE_INET_Addr const & /*address*/,
                                       STUN::Message const & a_message) {
    if (a_message.contains_unknown_comprehension_required_attributes()) {
      std::cerr << "TODO: Error response with unknown attributes" << std::endl;
      return;
    }

    // See section 7.2.5.2.4
    std::cerr << "TODO: Agent::error_response" << std::endl;
    assert(false);
  }

  void EndpointManager::compute_active_foundations(ActiveFoundationSet & a_active_foundations) const {
    for (UsernameToChecklistType::const_iterator pos = m_username_to_checklist.begin(),
           limit = m_username_to_checklist.end(); pos != limit; ++pos) {
      const Checklist* checklist = pos->second;
      checklist->compute_active_foundations(a_active_foundations);
    }
  }

  void EndpointManager::check_invariants() const {
    for (UsernameToChecklistType::const_iterator pos = m_username_to_checklist.begin(),
           limit = m_username_to_checklist.end(); pos != limit; ++pos) {
      const Checklist* checklist = pos->second;
      checklist->check_invariants();
    }
  }

  void EndpointManager::unfreeze(FoundationType const & a_foundation) {
    for (UsernameToChecklistType::const_iterator pos = m_username_to_checklist.begin(),
           limit = m_username_to_checklist.end(); pos != limit; ++pos) {
      pos->second->unfreeze(a_foundation);
    }
  }

} // namespace ICE
} // namespace OpenDDS

OPENDDS_END_VERSIONED_NAMESPACE_DECL
