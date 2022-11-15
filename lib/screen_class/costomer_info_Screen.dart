import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khatabook/database/db_Helper.dart';
import 'package:khatabook/model_class/model_class.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controller_class/Home_Controller.dart';

class Customer_info_Screen extends StatefulWidget {
  const Customer_info_Screen({Key? key}) : super(key: key);

  @override
  State<Customer_info_Screen> createState() => _Customer_info_ScreenState();
}

class _Customer_info_ScreenState extends State<Customer_info_Screen> {
  Home_Controller home_controller = Get.put(Home_Controller());
  DbHelper db = DbHelper();

  @override
  void initState() {
    getData();
    productGetdata();
    super.initState();
  }

  void getData() async {
    home_controller.AllDataList.value = await db.readData();
  }

  void productGetdata() async {
    home_controller.productList.value = await db.productreadData(id:home_controller.customerData!.id!);

    home_controller.addition();

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          title: Row(
            children: [
              IconButton(
                  onPressed: () {
                    Get.toNamed('du');
                  },
                  icon: Icon(
                    Icons.person_pin,
                    size: 30,
                  )),
              Text("${home_controller.customerData!.name}"),
            ],
          ),
          actions: [
            IconButton(
                onPressed: () {
                  String number =
                      "tel: ${home_controller.customerData!.namber}";
                  launchUrl(Uri.parse(number));
                },
                icon: Icon(Icons.call)),
          ],
        ),
        body: Column(
          children: [
            Container(
              height: 150,
              width: double.infinity,
              color: Colors.indigo,
              child: Container(
                margin: EdgeInsets.all(10),
                height: 50,
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total Incom",
                            style: TextStyle(fontSize: 20),
                          ),
                          Obx(
                            () => Text(
                              "₹ ${home_controller.totalsum.value}",
                              style:
                                  TextStyle(fontSize: 27, color: Colors.green),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 1,
                      width: double.infinity,
                      color: Colors.grey,
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total expense",
                            style: TextStyle(fontSize: 20),
                          ),
                          Obx(
                            ()=> Text(
                              "₹ ${home_controller.pendingsum.value}",
                              style: TextStyle(fontSize: 27, color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.shade200,
                  border: Border.all(
                    color: Colors.white70,
                  )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.picture_as_pdf,
                        size: 30,
                        color: Colors.indigo,
                      )),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.currency_rupee_rounded,
                        size: 30,
                        color: Colors.indigo,
                      )),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.whatsapp,
                        size: 30,
                        color: Colors.indigo,
                      )),
                  IconButton(
                      onPressed: () {
                        String smss =
                            "sms: ${home_controller.customerData!.namber}";
                        launchUrl(Uri.parse(smss));
                        Share.share("your payment day is here plea");
                      },
                      icon: Icon(
                        Icons.sticky_note_2_outlined,
                        size: 30,
                        color: Colors.indigo,
                      )),
                ],
              ),
            ),
            Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.shade200,
                  border: Border.all(
                    color: Colors.white70,
                  )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("Date | Time"),
                  Text("Remark"),
                  Text("You gave | You got"),
                ],
              ),
            ),
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: home_controller.productList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        home_controller.entryEditModel = EntryEditModel(
                          balance: home_controller.productList.value[index]
                              ['amount'],
                          date: home_controller.productList.value[index]
                              ['date'],
                          poductname: home_controller.productList.value[index]
                              ['name'],
                          time: home_controller.productList.value[index]
                              ['time'],
                          id: home_controller.productList.value[index]['id']
                              .toString(),
                        );
                        Get.toNamed('entry');
                      },
                      child: Container(
                        child: Card(
                          elevation: 1,
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  Text(
                                      "${home_controller.productList.value[index]['date']}"),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                      "${home_controller.productList.value[index]['time']}"),
                                ],
                              ),
                              Expanded(
                                  child: SizedBox(
                                width: 100,
                              )),
                              Text(
                                  "${home_controller.productList.value[index]['name']}"),
                              Expanded(
                                  child: SizedBox(
                                width: 35,
                              )),
                              Container(
                                alignment: Alignment.center,
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  color: Colors.red.shade200,
                                  border: Border.all(color: Colors.red),
                                ),
                                child: home_controller.productList[index]
                                            ['payment_status'] ==
                                        1
                                    ? Text(
                                        "${home_controller.productList[index]['amount']}",
                                        style: TextStyle(color: Colors.white),
                                      )
                                    : Text(""),
                              ),
                              Container(
                                alignment: Alignment.center,
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                    color: Colors.green.shade200,
                                    border: Border.all(color: Colors.green)),
                                child: home_controller.productList[index]
                                            ['payment_status'] ==
                                        0
                                    ? Text(
                                        "${home_controller.productList[index]['amount']}",
                                        style: TextStyle(color: Colors.white),
                                      )
                                    : Text(""),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: 80,
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.toNamed("ug");
                  },
                  child: Text("You Gave ₹"),
                  style: ElevatedButton.styleFrom(primary: Colors.red.shade800),
                ),
                SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.toNamed("uo");
                  },
                  child: Text("You Got  ₹"),
                  style:
                      ElevatedButton.styleFrom(primary: Colors.green.shade900),
                ),
              ],
            ),
            SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }
}
