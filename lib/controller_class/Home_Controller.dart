import 'package:get/get.dart';
import 'package:khatabook/model_class/model_class.dart';

class Home_Controller extends GetxController{

  RxList<Map> AllDataList =<Map>[].obs;

  Model? customerData;

  RxList<Map> productList = <Map>[].obs;

  EntryEditModel? entryEditModel;

  int i=0;

  var date = DateTime.now();

  void getData(dynamic date1)
  {
    date = date1;
  }
}
