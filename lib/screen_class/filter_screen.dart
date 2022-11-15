import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:khatabook/controller_class/Home_Controller.dart';
import 'package:khatabook/database/db_Helper.dart';

class FilterdateScreen extends StatefulWidget {
  const FilterdateScreen({Key? key}) : super(key: key);

  @override
  State<FilterdateScreen> createState() => _FilterdateScreenState();
}

class _FilterdateScreenState extends State<FilterdateScreen> {
  Home_Controller home_controller = Get.put(Home_Controller());

  DbHelper db = DbHelper();

  void productgateData() async {
    home_controller.productList.value =
    await db.ProductFilterReadData(home_controller.filterdate.value);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    productgateData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.blue.shade900,
          elevation: 0,
          title: Text(
            "${home_controller.filterdate.value}",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  datepickerDialogue();
                  print(home_controller.filterdate.value);
                  productgateData();
                },
                icon: Icon(Icons.calendar_month)),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                child: Row(
                  children: [
                    Text(
                      "Date/Time",
                      style: TextStyle(color: Colors.black),
                    ),
                    SizedBox(
                      width: 65,
                    ),
                    Text(
                      "Remark",
                      style: TextStyle(color: Colors.black),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "You Gave | You Got",
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
            Obx(
              () => Expanded(
                child: ListView.builder(
                  itemCount: home_controller.productList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        height: 70,
                        width: double.infinity,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 110,
                                    alignment: Alignment.centerLeft,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "${home_controller.productList[index]['date']}",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        Text(
                                          "${home_controller.productList[index]['time']}",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: 70,
                                    alignment: Alignment.center,
                                    child: Text(
                                      "${home_controller.productList[index]['name']}",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    width: 60,
                                    alignment: Alignment.center,
                                    color: Colors.red.shade200,
                                    child: home_controller.productList[index]
                                                ['payment_status'] ==
                                            1
                                        ? Text(
                                            "${home_controller.productList[index]['amount']}",
                                            style:
                                                TextStyle(color: Colors.white),
                                          )
                                        : Text(""),
                                  ),
                                  Container(
                                    width: 60,
                                    alignment: Alignment.center,
                                    color: Colors.green.shade200,
                                    child: home_controller.productList[index]
                                                ['payment_status'] ==
                                            0
                                        ? Text(
                                            "${home_controller.productList[index]['amount']}",
                                            style:
                                                TextStyle(color: Colors.black),
                                          )
                                        : Text(""),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void datepickerDialogue() async {
    var date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2001),
        lastDate: DateTime(3000));
    home_controller.getData(date);
    if (date != null) {
      home_controller.filterdate.value = DateFormat('dd-MM-yyyy').format(date);
    }
  }
}
