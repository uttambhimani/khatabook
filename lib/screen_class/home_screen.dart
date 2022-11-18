import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khatabook/controller_class/Home_Controller.dart';
import 'package:khatabook/database/db_Helper.dart';
import 'package:khatabook/model_class/model_class.dart';

class Home_Screen extends StatefulWidget {
  const Home_Screen({Key? key}) : super(key: key);

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {
  Home_Controller home_controller = Get.put(Home_Controller());
  DbHelper db = DbHelper();

  @override
  void initState() {
    getData();
    productgetData();
    super.initState();
  }

  void getData() async {
    home_controller.AllDataList.value = await db.readData();
  }

  void productgetData() async {
    home_controller.productList.value = await db.productreadData();
    home_controller.homeaddition();
    home_controller.addition();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          title: Text("Khatabook"),
          actions: [
            IconButton(onPressed: (){
              Get.toNamed("search");

            }, icon: Icon(Icons.search,size: 30,),),

            IconButton(
                onPressed: () {
                  Get.toNamed('filter');
                },
                icon: Icon(
                  Icons.filter_alt,
                  size: 30,
                )),
          ],
        ),
        body: Center(
          child: Column(
            children: [
              SizedBox(
                height: 6,
              ),
              Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.indigo,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  margin: EdgeInsets.all(10),
                  height: 100,
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Obx(
                                () => Text(
                                  "₹ ${home_controller.greensum.value}",
                                  style: TextStyle(
                                      fontSize: 40,
                                      color: Colors.green.shade900),
                                ),
                              ),
                              Text(
                                "You Will Give",
                                style: TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Obx(
                                () => Text(
                                  "₹ ${home_controller.redsum.value}",
                                  style: TextStyle(
                                      fontSize: 40, color: Colors.red.shade900),
                                ),
                              ),
                              Text(
                                "You Will Get",
                                style: TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Expanded(
                          child: SizedBox(
                        height: 1,
                      )),
                      Container(
                        child: TextButton(
                            onPressed: () {
                              Get.toNamed('history');
                            },
                            child: Text(
                              "VIEW HOSTORY >",
                              style:
                                  TextStyle(color: Colors.indigo, fontSize: 17),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: Container(
                  child: Obx(
                    () => ListView.builder(
                        itemCount: home_controller.AllDataList.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              home_controller.customerData = Model(
                                  id: home_controller
                                      .AllDataList.value[index]['id']
                                      .toString(),
                                  name: home_controller.AllDataList.value[index]
                                      ['name'],
                                  namber: home_controller
                                      .AllDataList.value[index]['mobile'],
                                  addres: home_controller
                                      .AllDataList.value[index]['address']);

                              Get.toNamed('ci');
                            },
                            child: Container(
                              child: Card(
                                elevation: 3,
                                child: ListTile(
                                  title: Text(
                                      "${home_controller.AllDataList.value[index]['name']}"),
                                  subtitle: Text(
                                      "${home_controller.AllDataList.value[index]['mobile']}"),
                                  trailing: Obx(
                                    () => Text(
                                      "₹ ${home_controller.pendingsum.value}",
                                      style: TextStyle(fontSize: 25),
                                    ),
                                  ),
                                  leading: IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.person_pin,
                                      size: 50,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Get.toNamed('cd');
          },
          icon: Icon(Icons.add),
          label: Text("Add to Customer"),
          backgroundColor: Colors.indigo,
        ),
      ),
    );
  }
}
