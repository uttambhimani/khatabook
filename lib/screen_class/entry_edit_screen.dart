import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khatabook/controller_class/Home_Controller.dart';
import 'package:khatabook/database/db_Helper.dart';

class Entry_Edit_Screen extends StatefulWidget {
  const Entry_Edit_Screen({Key? key}) : super(key: key);

  @override
  State<Entry_Edit_Screen> createState() => _delet_update_screenState();
}

class _delet_update_screenState extends State<Entry_Edit_Screen> {
  Home_Controller home_controller = Get.put(Home_Controller());
 DbHelper bd DbHelper
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          title: Text("Entry Details"),
        ),
        body: Column(
          children: [
            Container(
              height: 250,
              width: double.infinity,
              color: Colors.indigo,
              child: Container(
                margin: EdgeInsets.all(50),
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,

                      children: [
                        Icon(Icons.person),
                        Column(
                          children: [
                            Text("${home_controller.customerData!.name}",style: TextStyle(fontSize: 20),),
                            Text("${home_controller.entryEditModel!.date}"),
                          ],
                        ),
                        Text("${home_controller.entryEditModel!.balance}",style: TextStyle(fontSize: 25),),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,

                      children: [
                        Text("Runing Balance",style: TextStyle(fontSize: 20),),
                        Text("${home_controller.entryEditModel!.balance}",style: TextStyle(fontSize: 25),),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("Product Name",style: TextStyle(fontSize: 20),),
                        Text("${home_controller.entryEditModel!.poductname}",style: TextStyle(fontSize: 25),),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Expanded(
                child: Container(
              height: 1,
            )),
            ElevatedButton(
              onPressed: () {
                Get.defaultDialog(
                    title: "PUDETE | DELELTE",
                    content: Column(
                      children: [
                        TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Enter Name",
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Moblie No",
                          ),
                        ),
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Get.defaultDialog(
                                  title: "",
                                  content: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.edit,
                                            size: 30,
                                            color: Colors.green.shade900,
                                          ),
                                          Text("EDITE"),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text("Are you sure Edit this contect"),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        children: [
                                          TextButton(
                                              onPressed: () {
                                                Get.back();
                                              },
                                              child: Text("No")),
                                          TextButton(
                                              onPressed: () {
                                                DbHelper db = DbHelper();
                                              },
                                              child: Text("Yes")),
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              },
                              child: Text("EDIT"),
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.blue),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Get.defaultDialog(
                                  title: "",
                                  content: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.delete,
                                            size: 30,
                                            color: Colors.red,
                                          ),
                                          Text("DELETE"),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text("Are you sure delete this contect"),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        children: [
                                          TextButton(
                                              onPressed: () {
                                                Get.back();
                                              },
                                              child: Text("No")),
                                          TextButton(
                                              onPressed: () {
                                                DbHelper db = DbHelper();
                                              },
                                              child: Text("Yes")),
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              },
                              child: Text("DELETE"),
                              style:
                                  ElevatedButton.styleFrom(primary: Colors.red),
                            ),
                          ],
                        )
                      ],
                    ));
              },
              child: Text("UPDETE | DELETE"),
              style: ElevatedButton.styleFrom(primary: Colors.green.shade900),
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
