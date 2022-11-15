
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khatabook/screen_class/costomer_info_Screen.dart';
import 'package:khatabook/screen_class/customer_detail_screen.dart';
import 'package:khatabook/screen_class/delet_update_screen.dart';
import 'package:khatabook/screen_class/entry_edit_screen.dart';
import 'package:khatabook/screen_class/filter_screen.dart';
import 'package:khatabook/screen_class/history_screen.dart';
import 'package:khatabook/screen_class/home_screen.dart';
import 'package:khatabook/screen_class/you_gave_screen.dart';
import 'package:khatabook/screen_class/you_got_screen.dart';

void main(){
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/':(context)=>Home_Screen(),
        'cd':(context)=>Customer_Detail_Screen(),
        'ci':(context)=>Customer_info_Screen(),
        'du':(context)=>Delet_update_screen(),
        'ug':(context)=>You_Gave_Screen(),
        'uo':(context)=>You_Got_Screen(),
        'entry':(context)=>Entry_Edit_Screen(),
        'history':(context)=>HistoryScreen(),
        'filter':(context)=>FilterdateScreen(),
      },
    )
  );
}
