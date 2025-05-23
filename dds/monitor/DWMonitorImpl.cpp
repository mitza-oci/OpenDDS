/*
 *
 *
 * Distributed under the OpenDDS License.
 * See: http://www.opendds.org/license.html
 */

#include "DWMonitorImpl.h"
#include "monitorC.h"
#include "monitorTypeSupportImpl.h"
#include "dds/DCPS/DataWriterImpl.h"
#include <dds/DdsDcpsInfrastructureC.h>

OPENDDS_BEGIN_VERSIONED_NAMESPACE_DECL

namespace OpenDDS {
namespace Monitor {

DWMonitorImpl::DWMonitorImpl(DCPS::DataWriterImpl* dw,
                             DataWriterReportDataWriter_ptr dw_writer)
  : dw_(dw)
  , dw_writer_(DataWriterReportDataWriter::_duplicate(dw_writer))
{
}

DWMonitorImpl::~DWMonitorImpl()
{
}

void
DWMonitorImpl::report() {
  if (!CORBA::is_nil(dw_writer_.in())) {
    DataWriterReport report;
    report.dp_id = dw_->get_dp_id();
    DDS::Publisher_var pub = dw_->get_publisher();
    report.pub_handle = pub->get_instance_handle();
    report.dw_id = dw_->get_guid();
    DDS::Topic_var topic = dw_->get_topic();
    OpenDDS::DCPS::TopicImpl* ti = dynamic_cast<DCPS::TopicImpl*>(topic.in());
    if (!ti) {
      ACE_ERROR((LM_ERROR, ACE_TEXT("(%P|%t) DWMonitorImpl::report():")
        ACE_TEXT(" failed to obtain TopicImpl.\n")));
      return;
    }
    report.topic_id = ti->get_id();
    DCPS::DataWriterImpl::InstanceHandleVec instances;
    dw_->get_instance_handles(instances);
    CORBA::ULong length = 0;
    report.instances.length(static_cast<CORBA::ULong>(instances.size()));
    for (DCPS::DataWriterImpl::InstanceHandleVec::iterator iter = instances.begin();
         iter != instances.end();
         ++iter) {
      report.instances[length++] = *iter;
    }
    DCPS::RepoIdSet readers;
    dw_->get_readers(readers);
    length = 0;
    report.associations.length(static_cast<CORBA::ULong>(readers.size()));
    for (DCPS::RepoIdSet::iterator iter = readers.begin();
         iter != readers.end();
         ++iter) {
      report.associations[length].dr_id = *iter;
      length++;
    }
    dw_writer_->write(report, DDS::HANDLE_NIL);
  }
}

}
}

OPENDDS_END_VERSIONED_NAMESPACE_DECL
