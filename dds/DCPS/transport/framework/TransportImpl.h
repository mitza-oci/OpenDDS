/*
 * Distributed under the OpenDDS License.
 * See: http://www.opendds.org/license.html
 */

#ifndef OPENDDS_DCPS_TRANSPORT_FRAMEWORK_TRANSPORTIMPL_H
#define OPENDDS_DCPS_TRANSPORT_FRAMEWORK_TRANSPORTIMPL_H

#include "TransportDefs.h"
#include "TransportInst_rch.h"
#include "TransportInst.h"
#include "DataLinkCleanupTask.h"

#include <dds/DCPS/AtomicBool.h>
#include <dds/DCPS/DiscoveryListener.h>
#include <dds/DCPS/EventDispatcher.h>
#include <dds/DCPS/PoolAllocator.h>
#include <dds/DCPS/PoolAllocator.h>
#include <dds/DCPS/RcObject.h>
#include <dds/DCPS/ReactorTask.h>
#include <dds/DCPS/ReactorTask_rch.h>
#include <dds/DCPS/dcps_export.h>

#include <dds/DdsDcpsPublicationC.h>
#include <dds/DdsDcpsSubscriptionC.h>
#include <dds/OpenDDSConfigWrapper.h>
#include <dds/OpenddsDcpsExtC.h>
#if OPENDDS_CONFIG_SECURITY
#  include <dds/DdsSecurityCoreC.h>
#endif

#include <ace/Synch_Traits.h>

OPENDDS_BEGIN_VERSIONED_NAMESPACE_DECL

namespace OpenDDS {
namespace DCPS {

class TransportClient;
class TransportReceiveListener;
class DataLink;
class TransportInst;
class Monitor;
struct AssociationData;
typedef RcHandle<TransportClient> TransportClient_rch;
typedef WeakRcHandle<TransportClient> TransportClient_wrch;

/** The TransportImpl class includes the abstract methods that must be implemented
*   by any implementation to provide data delivery service to the DCPS implementation.
*   This includes methods to send data, received data, configure the operation, and
*   manage associations and datalinks between local and remote objects of the implementation.
*
*   Notes about object ownership:
*   1)Has longer lifetime than the publisher and subscriber objects. The publishers
*     and subscribers are owned by the DomainParticipant and transport factory shutdown
*     is always after DomainParticipant factory shutdown.
*   2)The concrete transport object owns the datalink objects.
*   3)Own  a DataLinkCleanup object.
*   4)Reference to TransportInst object and TransportReactorTask object owned
*     by TransportRegistry.
*   5)During transport shutdown, if this object does not have ownership of an object
*     but has a references via smart pointer then the reference should be freed;
*     if this object has ownership of task objects then the tasks should be closed.
*/
class OpenDDS_Dcps_Export TransportImpl : public virtual RcObject {
public:

  virtual ~TransportImpl();

  /// Remove any pending_release mappings.
  virtual void unbind_link(DataLink* link);

  /// Callback from the DataLink to clean up any associated resources.
  /// This usually is done when the DataLink is lost. The call is made with
  /// no transport/DCPS locks held.
  bool release_link_resources(DataLink* link);

  /// Expose the configuration information so others can see what
  /// we can do.
  TransportInst_rch config() const;

  /// Called by our connection_info() method to allow the concrete
  /// TransportImpl subclass to do the dirty work since it really
  /// is the one that knows how to populate the supplied
  /// TransportLocator object.
  virtual bool connection_info_i(TransportLocator& local_info, ConnectionInfoFlags flags) const = 0;

  virtual void register_for_reader(const GUID_t& /*participant*/,
                                   const GUID_t& /*writerid*/,
                                   const GUID_t& /*readerid*/,
                                   const TransportLocatorSeq& /*locators*/,
                                   OpenDDS::DCPS::DiscoveryListener* /*listener*/) { }

  virtual void unregister_for_reader(const GUID_t& /*participant*/,
                                     const GUID_t& /*writerid*/,
                                     const GUID_t& /*readerid*/) { }

  virtual void register_for_writer(const GUID_t& /*participant*/,
                                   const GUID_t& /*readerid*/,
                                   const GUID_t& /*writerid*/,
                                   const TransportLocatorSeq& /*locators*/,
                                   DiscoveryListener* /*listener*/) { }

  virtual void unregister_for_writer(const GUID_t& /*participant*/,
                                     const GUID_t& /*readerid*/,
                                     const GUID_t& /*writerid*/) { }

  virtual void update_locators(const GUID_t& /*remote*/,
                               const TransportLocatorSeq& /*locators*/) { }

  virtual void get_last_recv_locator(const GUID_t& /*remote_id*/,
                                     const GuidVendorId_t& /*vendor_id*/,
                                     TransportLocator& /*locators*/) {}

  virtual void append_transport_statistics(TransportStatisticsSequence& /*seq*/) {}

  /// Interface to the transport's reactor for scheduling timers.
  ACE_Reactor_Timer_Interface* timer() const;

  ACE_Reactor* reactor() const;
  bool is_shut_down() const;

  /// Create the reactor task using sync send or optionally async send
  /// by parameter on supported Windows platforms only.
  void create_reactor_task(bool useAsyncSend = false, const OPENDDS_STRING& name = "");

  /// Diagnostic aid.
  void dump();
  OPENDDS_STRING dump_to_str();

  void report();

  struct ConnectionAttribs {
    GUID_t local_id_;
    Priority priority_;
    bool local_reliable_, local_durable_;
    SequenceNumber max_sn_;

    ConnectionAttribs()
      : local_id_(GUID_UNKNOWN)
      , priority_(0)
      , local_reliable_(false)
      , local_durable_(false)
      , max_sn_(SequenceNumber::SEQUENCENUMBER_UNKNOWN())
    {}
  };

  struct RemoteTransport {
    GUID_t repo_id_;
    TransportBLOB blob_;
    TransportBLOB discovery_blob_;
    MonotonicTime_t participant_discovered_at_;
    ACE_CDR::ULong context_;
    Priority publication_transport_priority_;
    bool reliable_, durable_;
  };

  struct AcceptConnectResult {
    enum Status { ACR_SUCCESS, ACR_FAILED };
    explicit AcceptConnectResult(Status ok = ACR_FAILED)
      : success_(ok == ACR_SUCCESS), link_() {}
    AcceptConnectResult(const DataLink_rch& link)
      : success_(link), link_(link) {}
    /// If false, the accept or connect has failed and link_ is ignored.
    bool success_;
    /// If success_ is true, link_ may either be null or have a valid DataLink.
    /// If link_ is null the DataLink is not ready for use, and
    /// TransportClient::use_datalink() is called later.
    DataLink_rch link_;
  };

  virtual WeakRcHandle<ICE::Endpoint> get_ice_endpoint() { return WeakRcHandle<ICE::Endpoint>(); }

  /// Accessor to obtain a "copy" of the reference to the reactor task.
  /// Caller is responsible for the "copy" of the reference that is
  /// returned.
  ReactorTask_rch reactor_task();

  EventDispatcher_rch event_dispatcher() { return event_dispatcher_; }

  DDS::DomainId_t domain() const { return domain_; }

protected:
  TransportImpl(TransportInst_rch config,
                DDS::DomainId_t domain);

  bool open();

  /// connect_datalink() is called from TransportClient to initiate an
  /// association as the active peer.  A DataLink may be returned if
  /// one is already connected and ready to use, otherwise
  /// initiate a connection to the passive side and return from this
  /// method.  Upon completion of the physical connection, the
  /// transport calls back to TransportClient::use_datalink().
  virtual AcceptConnectResult connect_datalink(const RemoteTransport& remote,
                                               const ConnectionAttribs& attribs,
                                               const TransportClient_rch& client) = 0;

  /// accept_datalink() is called from TransportClient to initiate an
  /// association as the passive peer.  A DataLink may be returned if
  /// one is already connected and ready to use, otherwise
  /// passively wait for a physical connection from the active
  /// side (either in the form of a connection event or handshaking
  /// message).  Upon completion of the physical connection, the
  /// transport calls back to TransportClient::use_datalink().
  virtual AcceptConnectResult accept_datalink(const RemoteTransport& remote,
                                              const ConnectionAttribs& attribs,
                                              const TransportClient_rch& client) = 0;

  /// stop_accepting_or_connecting() is called from TransportClient
  /// to terminate the accepting process begun by accept_datalink()
  /// or connect_datalink().  This allows the TransportImpl to clean
  /// up any resources associated with this pending connection.
  /// The TransportClient* passed in to accept or connect is not
  /// valid after this method is called.
  virtual void stop_accepting_or_connecting(const TransportClient_wrch& client,
                                            const GUID_t& remote_id,
                                            bool disassociate,
                                            bool association_failed) = 0;


  /// Called during the shutdown() method in order to give the
  /// concrete TransportImpl subclass a chance to do something when
  /// the shutdown "event" occurs.
  virtual void shutdown_i() = 0;

  typedef ACE_SYNCH_MUTEX     LockType;
  typedef ACE_Guard<LockType> GuardType;

  /// Lock to protect the pending_connections_ data member
  mutable LockType pending_connections_lock_;

  typedef OPENDDS_MULTIMAP(TransportClient_wrch, DataLink_rch) PendConnMap;
  PendConnMap pending_connections_;
  void add_pending_connection(const TransportClient_rch& client, DataLink_rch link);
  void shutdown();

private:
  /// We have a few friends in the transport framework so that they
  /// can access our private methods.  We do this to avoid pollution
  /// of our public interface with internal framework methods.
  friend class TransportInst;
  friend class TransportClient;
  friend class DataLink;
  /// Called by the TransportRegistry when this TransportImpl object
  /// is released while the TransportRegistry is handling a release()
  /// "event".

  /// The DataLink itself calls this method when it thinks it is
  /// no longer used for any associations.  This occurs during
  /// a "remove associations" operation being performed by some
  /// TransportClient that uses this TransportImpl.  The
  /// TransportClient is known to have acquired our reservation_lock_,
  /// so there won't be any reserve_datalink() calls being made from
  /// any other threads while we perform this release.
  virtual void release_datalink(DataLink* link) = 0;

  virtual void client_stop(const GUID_t&) {}

  DataLink* find_connect_i(const GUID_t& local_id,
                           const AssociationData& remote_association,
                           const ConnectionAttribs& attribs,
                           bool active, bool connect);

#if OPENDDS_CONFIG_SECURITY
  virtual void local_crypto_handle(DDS::Security::ParticipantCryptoHandle) {}
#endif

  virtual OPENDDS_STRING transport_type() const = 0;

  /// Called by our friend, the TransportClient.
  /// Accessor for the TransportInterfaceInfo.  Accepts a reference
  /// to a TransportInterfaceInfo object that will be "populated"
  /// with this TransportImpl's connection information (ie, how
  /// another process would connect to this TransportImpl).
  bool connection_info(TransportLocator& local_info, ConnectionInfoFlags flags) const;

  /// Lock to protect the config_ and reactor_task_ data members.
  mutable LockType lock_;

  /// A reference to the TransportInst
  /// object that was supplied to us during our configure() method.
  WeakRcHandle<TransportInst> config_;

  /// The reactor (task) object - may not even be used if the concrete
  /// subclass (of TransportImpl) doesn't require a reactor.
  ReactorTask_rch reactor_task_;

  struct DoClear : EventBase {
    explicit DoClear(RcHandle<DataLink> link) : link_(link) {}
    void handle_event()
    {
      DataLink_rch link = link_.lock();
      if (link) {
        link->clear_associations();
      }
    }
    WeakRcHandle<DataLink> link_;
  };

  /// smart ptr to the associated DL cleanup task
  EventDispatcher_rch event_dispatcher_;

  /// Monitor object for this entity
  unique_ptr<Monitor> monitor_;

protected:
  /// Id of the last link established.
  AtomicBool is_shut_down_;
  DDS::DomainId_t domain_;

  static StatisticSeq stats_template();
  void fill_stats(StatisticSeq& stats, DDS::UInt32& idx) const;
};

} // namespace DCPS
} // namespace OpenDDS

OPENDDS_END_VERSIONED_NAMESPACE_DECL

#if defined (__ACE_INLINE__)
#include "TransportImpl.inl"
#endif /* __ACE_INLINE__ */

#endif  /* OPENDDS_DCPS_TRANSPORTIMPL_H */
