import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khatabook/controller_class/Home_Controller.dart';
import 'package:khatabook/database/db_Helper.dart';

class Delet_update_screen extends StatefulWidget {
  const Delet_update_screen({Key? key}) : super(key: key);

  @override
  State<Delet_update_screen> createState() => _delet_update_screenState();
}

class _delet_update_screenState extends State<Delet_update_screen> {
  Home_Controller home_controller = Get.put(Home_Controller());
  DbHelper db = DbHelper();

  TextEditingController utxtname = TextEditingController();
  TextEditingController utxtnamber = TextEditingController();
  TextEditingController utxtaddres = TextEditingController();

  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async {
    home_controller.AllDataList.value = await db.readData();
  }

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
                        Text(
                          "Name:",
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          "${home_controller.customerData!.name}",
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                    Container(
                      height: 1,
                      width: double.infinity,
                      color: Colors.grey,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Contect:",
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          "${home_controller.customerData!.namber}",
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
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
                utxtname = TextEditingController(
                    text: home_controller.customerData!.name!);
                utxtnamber = TextEditingController(
                    text: home_controller.customerData!.namber!);
                utxtaddres = TextEditingController(
                    text: home_controller.customerData!.addres!);
                Get.defaultDialog(
                    title: "PUDETE | DELELTE",
                    content: Column(
                      children: [
                        TextField(
                          controller: utxtname,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Enter Name",
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextField(
                          controller: utxtnamber,
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
                                                db.updateData(
                                                    home_controller
                                                        .customerData!.id!,
                                                    utxtname.text,
                                                    utxtnamber.text,
                                                    utxtaddres.text);
                                                getData();
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
                                                db.deletData(home_controller
                                                    .customerData!.id!);
                                                getData();
                                                Get.back();
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
