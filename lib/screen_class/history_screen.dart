import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khatabook/controller_class/Home_Controller.dart';
import 'package:khatabook/database/db_Helper.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  Home_Controller home_controller = Get.put(Home_Controller());

  DbHelper db = DbHelper();

  void getData() async {
    home_controller.productList.value = await db.productreadData();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue.shade900,
          elevation: 0,
          title: Text(
            "History",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
          ),
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
                  () =>
                  Expanded(
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
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
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
                                              "${home_controller
                                                  .productList[index]['date']}",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                            Text(
                                              "${home_controller
                                                  .productList[index]['time']}",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: 70,
                                        alignment: Alignment.center,
                                        child: Text(
                                          "${home_controller
                                              .productList[index]['name']}",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        width: 70,
                                        alignment: Alignment.center,
                                        color: Colors.red.shade200,
                                        child: home_controller
                                            .productList[index]
                                        ['payment_status'] ==
                                            1
                                            ? Text(
                                          "${home_controller
                                              .productList[index]['amount']}",
                                          style:
                                          TextStyle(color: Colors.black,),
                                        )
                                            : Text(""),
                                      ),
                                      Container(
                                        width: 70,
                                        alignment: Alignment.center,
                                        color: Colors.green.shade200,
                                        child: home_controller
                                            .productList[index]
                                        ['payment_status'] ==
                                            0
                                            ? Text(
                                          "${home_controller
                                              .productList[index]['amount']}",
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
}
