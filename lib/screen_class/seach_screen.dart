import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khatabook/controller_class/Home_Controller.dart';
import 'package:khatabook/model_class/model_class.dart';

class Search_Screen extends StatefulWidget {
  const Search_Screen({Key? key}) : super(key: key);

  @override
  State<Search_Screen> createState() => _Search_ScreenState();
}

class _Search_ScreenState extends State<Search_Screen> {
  Home_Controller home_controller =Get.put(Home_Controller());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Container(
            height: 45,
            width: double.infinity,
            child: TextField(
              onChanged: (value){
                home_controller.filterserchListData(value);
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
                hintText: "Search",
              ),
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body:Obx(
            ()=>ListView.builder(
              itemCount: home_controller.bookList.length,
              itemBuilder: (context,index)
              {
                return InkWell(
                  onTap: (){
                    home_controller.customerData =Model(
                      id: home_controller.bookList.value[index]['id'].toString(),
                      name: home_controller.bookList.value[index]['name'],
                      namber: home_controller.bookList.value[index]['namber'],
                    );
                    Get.toNamed('ci');
                  },
                  child: ListTile(
                    title: Text("${home_controller.bookList[index]["name"]}"),
                  ),
                );
              },
            )
        ),
      ),
    );
  }
}
