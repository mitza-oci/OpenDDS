#include "../IDL/ServiceTypeSupportImpl.h"

#include <dds/DCPS/Marked_Default_Qos.h>

using namespace DDS;
using namespace Service;

int main(int argc, char* argv[])
{
  DomainParticipantFactory_var dpf = TheParticipantFactoryWithArgs(argc, argv);
  DomainParticipant_var dp = dpf->create_participant(4, PARTICIPANT_QOS_DEFAULT, 0, 0);

  DeviceListTypeSupport_var ts = new DeviceListTypeSupportImpl;
  ts->register_type(dp, "");
  CORBA::String_var type_name = ts->get_type_name();
  Topic_var topic = dp->create_topic("Example", type_name,
                                     TOPIC_QOS_DEFAULT, 0, 0);

  Publisher_var pub = dp->create_publisher(PUBLISHER_QOS_DEFAULT, 0, 0);
  DataWriterQos dw_qos;
  pub->get_default_datawriter_qos(dw_qos);
  dw_qos.durability.kind = TRANSIENT_LOCAL_DURABILITY_QOS;
  DataWriter_var dw = pub->create_datawriter(topic, dw_qos, 0, 0);
  DeviceListDataWriter_var dldw = DeviceListDataWriter::_narrow(dw);

  const DeviceList dl{"test", SeqDeviceList()};

  for (int i = 0; i < 100; ++i) {
    dldw->write(dl, DDS::HANDLE_NIL);
    ACE_OS::sleep(1);
  }
}
