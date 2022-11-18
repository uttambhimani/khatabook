import 'package:get/get.dart';
import 'package:khatabook/database/db_Helper.dart';
import 'package:khatabook/model_class/model_class.dart';

class Home_Controller extends GetxController{

  RxList<Map> AllDataList =<Map>[].obs;

  Model? customerData;

  RxList<Map> productList = <Map>[].obs;
  RxList<Map> productList1 = <Map>[].obs;

  RxString filterdate = "".obs;


  EntryEditModel? entryEditModel;

  RxInt totalsum = 0.obs;
  RxInt pendingsum = 0.obs;

  RxInt greensum = 0.obs;
  RxInt redsum = 0.obs;


  int i=0;

  var date = DateTime.now();

  void getData(dynamic date1)
  {
    date = date1;
  }

  void addition() {

    int index = 0;
    totalsum.value=0;
    pendingsum.value=0;

    print(customerData!.id);

    for(index=0;index<productList.length;index++) {
      if (productList[index]["payment_status"] == 0) {
        totalsum.value = totalsum.value + int.parse(productList[index]["amount"]);
      }
      else {
        pendingsum.value = pendingsum.value + int.parse(productList[index]["amount"]);
      }
    }
  }

  // ===================================================

  void homeaddition() async{
    DbHelper db = DbHelper();

    productList1.value = await db.productreadData();


    int index = 0;
    greensum.value=0;
    redsum.value=0;

    for(index=0;index<productList1.length;index++) {
      if (productList1[index]["payment_status"] == 0) {
        greensum.value = greensum.value +
            int.parse(productList1[index]["amount"]);
      }
      else {
        redsum.value = redsum.value +
            int.parse(productList1[index]["amount"]);
      }
    }
  }

  //================================================================================+++
  //================================================================================+++


  RxList bookList =[].obs;
  RxList filterbookList =[].obs;

  void filterserchListData(String query)async{
    filterbookList = bookList;
    if(query.isNotEmpty)
      {
        List filtersearchdatalist =[].obs;

        for(var search in filterbookList)
          {
            if(search["name"].toLowerCase().contains(query.toLowerCase()));
            {
              filtersearchdatalist.add(search);
            }
          }
        bookList.value=filtersearchdatalist;
      }
    else
      {
        DbHelper db =DbHelper();

        bookList.value =await db.readData();
      }
  }

}

