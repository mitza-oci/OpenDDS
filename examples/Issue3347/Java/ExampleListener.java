import DDS.*;
import OpenDDS.DCPS.*;
import Service.*;

public class ExampleListener extends DDS._DataReaderListenerLocalBase {

  public void on_data_available(DataReader reader) {
    DeviceListDataReader mdr = DeviceListDataReaderHelper.narrow(reader);
    if (mdr == null) {
      System.err.println("ERROR: read: narrow failed.");
      return;
    }

    DeviceList list = new DeviceList("", new Device[]{});
    DeviceListHolder mh = new DeviceListHolder(list);

    SampleInfoHolder sih = new SampleInfoHolder(new SampleInfo());
    sih.value.source_timestamp = new DDS.Time_t();

    while (true) {
      final int status = mdr.take_next_sample(mh, sih);
      if (status == RETCODE_OK.value) {
        if (sih.value.valid_data) {
          System.out.println("id -> " + mh.value.id);
        }
      } else if (status == RETCODE_NO_DATA.value) {
        return;
      } else {
        System.err.println("ERROR: read Message: Error: " + status);
        return;
      }
    }
  }

  public void on_requested_deadline_missed(DDS.DataReader reader, RequestedDeadlineMissedStatus status) {
  }

  public void on_requested_incompatible_qos(DDS.DataReader reader, RequestedIncompatibleQosStatus status) {
  }

  public void on_sample_rejected(DDS.DataReader reader, SampleRejectedStatus status) {
  }

  public void on_liveliness_changed(DDS.DataReader reader, LivelinessChangedStatus status) {
  }

  public void on_subscription_matched(DDS.DataReader reader, SubscriptionMatchedStatus status) {
  }

  public void on_sample_lost(DDS.DataReader reader, SampleLostStatus status) {
  }
}
