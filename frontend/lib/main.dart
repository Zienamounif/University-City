import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter/material.dart';
import 'package:project_university/screens/serves.dart';
import 'package:shared_preferences/shared_preferences.dart'; 
import 'auth/login/Login_Screen.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  Widget widget;
  final prefs = await SharedPreferences.getInstance();
  var stuu_id= prefs.getString('id');
  if(stuu_id==null){
    widget=Login_Screen();
  }else{
    widget=services();
  }
  runApp(MyApp(widget));
}

class MyApp extends StatelessWidget {
  Widget startwidget;
   MyApp(this.startwidget,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit (
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
       builder: (context , child) {
        return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: startwidget
        );
      }
    );
  }
}


