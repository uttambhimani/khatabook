import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:khatabook/controller_class/Home_Controller.dart';
import 'package:khatabook/database/db_Helper.dart';

class You_Got_Screen extends StatefulWidget {
  const You_Got_Screen({Key? key}) : super(key: key);

  @override
  State<You_Got_Screen> createState() => _payment_screenState();
}

class _payment_screenState extends State<You_Got_Screen> {
  Home_Controller home_controller = Get.put(Home_Controller());

  TextEditingController txtproduct = TextEditingController();
  TextEditingController txtamount = TextEditingController();
  TextEditingController txtdate = TextEditingController();
  TextEditingController txttime = TextEditingController();
  DbHelper db = DbHelper();

  @override
  void initState() {
    getData();
    productgetdata();
    super.initState();
  }

  void getData() async {

    home_controller.productList.value = await db.readData();
  }
  void productgetdata() async {
    home_controller.productList.value =
    await db.productreadData(home_controller.customerData!.id!);
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Add Payment"),
          backgroundColor: Colors.indigo,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 20, left: 10, right: 10),
                height: 100,
                width: 350,
                child: TextField(
                  controller: txtproduct,
                  style: TextStyle(color: Colors.black, fontSize: 18),
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: "Product Name",
                    labelStyle: TextStyle(color: Colors.grey),
                    prefixIcon: Icon(Icons.shopping_cart, color: Colors.grey),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                      BorderSide(color: Colors.blue.shade900, width: 3),
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(right: 10, left: 10),
                height: 100,
                width: 350,
                child: TextField(
                  controller: txtamount,
                  style: TextStyle(color: Colors.black, fontSize: 18),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Amount",
                    labelStyle: TextStyle(color: Colors.grey),
                    prefixIcon:
                    Icon(Icons.currency_rupee_rounded, color: Colors.grey),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                      BorderSide(color: Colors.blue.shade900, width: 3),
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(right: 10, left: 10),
                height: 100,
                width: 350,
                child: TextField(
                  controller: txtdate,
                  style: TextStyle(color: Colors.black, fontSize: 18),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Date",
                    labelStyle: TextStyle(color: Colors.grey),
                    prefixIcon: InkWell(
                        onTap: () {
                          datespikerDilog();
                        },
                        child: Icon(Icons.calendar_month, color: Colors.grey)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                      BorderSide(color: Colors.blue.shade900, width: 3),
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(right: 10, left: 10),
                height: 100,
                width: 350,
                child: TextField(
                  controller: txttime,
                  style: TextStyle(color: Colors.black, fontSize: 18),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Time",
                    labelStyle: TextStyle(color: Colors.grey),
                    prefixIcon: InkWell(
                        onTap: () {
                          timepickerdilog();
                        },
                        child: Icon(Icons.timelapse, color: Colors.grey)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                      BorderSide(color: Colors.blue.shade900, width: 3),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                height: 50,
                width: 100,
                child: ElevatedButton(
                  onPressed: () {
                    db.productinsertData(
                        txtproduct.text,
                        txtamount.text,
                        txtdate.text,
                        txttime.text,
                        int.parse(
                            home_controller.customerData!.id!), 0);
                    getData();
                    productgetdata();
                    Get.back();

                  },
                  child: Text("Submit"),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.indigo,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void datespikerDilog() async {
    var date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2001),
        lastDate: DateTime(3000));
    home_controller.getData(date);
    if (date != null) {
      txtdate.text = DateFormat('dd-MM-yyyy').format(date);
    }
  }

  void timepickerdilog() async {
    TimeOfDay? t1 =
    await showTimePicker(context: context, initialTime: TimeOfDay.now());

    if (t1 != null) {
      DateTime parsedtime =
      DateFormat.jm().parse(t1.format(context).toString());

      String formetdtime = DateFormat('hh:mm').format(parsedtime);

      txttime.text = formetdtime;
    }
  }
}
