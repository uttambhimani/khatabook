import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khatabook/controller_class/Home_Controller.dart';
import 'package:khatabook/database/db_Helper.dart';

class Customer_Detail_Screen extends StatefulWidget {
  const Customer_Detail_Screen({Key? key}) : super(key: key);

  @override
  State<Customer_Detail_Screen> createState() => _Customer_Detail_ScreenState();
}

class _Customer_Detail_ScreenState extends State<Customer_Detail_Screen> {
  TextEditingController txtname = TextEditingController();
  TextEditingController txtnamber = TextEditingController();
  TextEditingController txtaddres = TextEditingController();

  Home_Controller home_controller =  Get.put(Home_Controller());

  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async {
    DbHelper db = DbHelper();
    home_controller.AllDataList.value=await db.readData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo,
        ),
        body: Center(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Container(
                height: 100,
                width: 300,
                child: TextField(
                  controller: txtname,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter Customer Name",
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: 50,
                    width: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.black,
                        )),
                    child: Text(
                      "🚩    +91",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 50,
                    width: 200,
                    child: TextField(
                      controller: txtnamber,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Mobile Namber",
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                height: 100,
                width: 300,
                child: TextField(
                  controller: txtaddres,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter Addres",
                  ),
                ),
              ),
              Expanded(
                  child: Container(
                height: 10,
              )),
              Container(
                  height: 50,
                  width: 400,
                  child: ElevatedButton(
                      onPressed: () {
                        DbHelper db = DbHelper();
                        db.insertData(
                            txtname.text, txtnamber.text, txtaddres.text);
                         getData();
                        Get.back();
                      },
                      child: Text("ADD CUSTOMER"))),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}
