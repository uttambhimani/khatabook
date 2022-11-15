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
  TextEditingController utxtpname = TextEditingController();
  TextEditingController utxtamount = TextEditingController();
  TextEditingController utxtdate = TextEditingController();
  TextEditingController utxttime = TextEditingController();

  DbHelper db = DbHelper();

  @override
  void initState() {
    getData();
    productGetData();
    super.initState();
  }
   void getData()async{
     home_controller.AllDataList.value = await db.readData();

   }
  void productGetData() async {
    home_controller.productList.value = await db.productreadData(id: home_controller.customerData!.id!);
    home_controller.addition();
    home_controller.homeaddition();
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
                        Icon(Icons.person),
                        Column(
                          children: [
                            Text(
                              "${home_controller.customerData!.name}",
                              style: TextStyle(fontSize: 20),
                            ),
                            Text("${home_controller.entryEditModel!.date}"),
                          ],
                        ),
                        Text(
                          "${home_controller.entryEditModel!.balance}",
                          style: TextStyle(fontSize: 25),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Runing Balance",
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          "${home_controller.entryEditModel!.balance}",
                          style: TextStyle(fontSize: 25),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Product Name",
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          "${home_controller.entryEditModel!.poductname}",
                          style: TextStyle(fontSize: 25),
                        ),
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
                utxtpname = TextEditingController(
                    text: home_controller.entryEditModel!.poductname);
                utxtamount = TextEditingController(
                    text: home_controller.entryEditModel!.balance);
                utxtdate = TextEditingController(
                    text: home_controller.entryEditModel!.date);
                utxttime = TextEditingController(
                    text: home_controller.entryEditModel!.time!);

                Get.defaultDialog(
                    title: "PUDETE | DELELTE",
                    content: Column(
                      children: [
                        TextField(
                          controller: utxtpname,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Customer Product",
                              prefixIcon: Icon(Icons.person)),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextField(
                          controller: utxtamount,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Amount",
                              prefixIcon: Icon(Icons.currency_rupee)),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextField(
                          controller: utxtdate,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Date",
                              prefixIcon: Icon(Icons.date_range)),
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
                                                db.productupdateData(
                                                    home_controller
                                                        .entryEditModel!.id!,
                                                    utxtpname.text,
                                                    utxtamount.text,
                                                    utxtdate.text,
                                                    utxttime.text);

                                                Get.back();
                                                productGetData();
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

                                                db.productdeleteData(
                                                    home_controller
                                                        .entryEditModel!.id!);
                                                productGetData();
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
