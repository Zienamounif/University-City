
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_university/screens/personhouse.dart';
import 'package:project_university/screens/services.dart'; 
import 'package:project_university/screens/text.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;
import '../auth/login/Login_Screen.dart';
import '../models/Desicion_Model.dart';
import 'complain.dart';

class services extends StatefulWidget {
  services({ Key? key }) : super(key: key);

  @override
  State<services> createState() => _servicesState();
}

class _servicesState extends State<services> {
  String name='';
  getName()async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('user_name')!;  
    });
    return name;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getName();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor:Color.fromARGB(255, 225, 250, 252),
        appBar:AppBar(
          title:Text("الخدمات"),
          centerTitle: true,
          backgroundColor :Color.fromARGB(255, 60, 141, 144),
          toolbarHeight:50.h,
        ),
        drawer: Drawer(
          backgroundColor:Color.fromARGB(255, 225, 250, 252),
            child:Column(
                children:[
                Container(
                  color: Color.fromARGB(255, 60, 141, 144),
                  width: double.infinity,
                  height: 170.h,
                  padding: EdgeInsets.only(top: 20.h,bottom: 15.h,left: 25.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                     Padding(
                       padding: const EdgeInsets.only(right: 15).r,
                       child: CircleAvatar(
                        radius: 40,
                        backgroundColor:Color.fromARGB(255, 225, 250, 252),
                        child: Icon(Icons.person,color:Color.fromARGB(255, 60, 141, 144),size:35),
                       ),
                     ),
                     SizedBox(height: 10.h,),
                     Padding(
                       padding: const EdgeInsets.only( right:25.0),
                       child: Text("${name}",
                       style: TextStyle(color: Colors.white,fontSize: 20
                       ),),
                     ) ,
                    ],
                  ),
                ),
                SizedBox(height: 20.h,),
                 ListTile(
                    leading: Icon(Icons.exit_to_app,color:Color.fromARGB(255, 60, 141, 144),size: 30, ),
                    title: Text("تسجيل الخروج",style: TextStyle(fontSize: 20),),
                    onTap: (){
                      showDialog(context: context, builder: (context){
                        return AlertDialog(
                          title: Text("تسجيل الخروج ؟",textAlign: TextAlign.end),
                          actions: [
                            InkWell(onTap: (){
                              Navigator.of(context).pop();
                            },child: Container(
                                margin:const EdgeInsets.all(10),
                                child:  Text("كلا",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.blue)))),
                            SizedBox(width: 7,),
                            Container(
                                child: InkWell(onTap: ()async{
                                  SharedPreferences pref=await SharedPreferences.getInstance();
                                  pref.remove('stu_id');
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(builder:(context)=> Login_Screen()),
                                          (route) => false);
                                },child:
                                Text("نعم",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.blue)),),
                                margin: EdgeInsets.all(10)),
                          ],
                        );
                      });
                    },
                  ),
                 SizedBox(height: 10.h,),
               ListTile(
                    leading: Icon(Icons.home_outlined,color:Color.fromARGB(255, 60, 141, 144), size: 30,),
                    title: Text("معلومات السكن الجامعي",style: TextStyle(fontSize: 20),),
                    onTap: (){
                   Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(builder: (context) {
                            return person();
                          }));
                    },
                  ),
            ]
            ) ,
        ),
        body: Padding(
          padding: const EdgeInsets.only( top:20,right: 90,left: 90).r,
          child: ListView(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            children: [
               SizedBox(height: 20.w,),
                InkWell(
                  onTap: (){
                    Navigator.of(context)
                        .pushReplacement(MaterialPageRoute(builder: (context) {
                      return Studen();}));
                  },
                  child: Container(
                      height: 195,
                     decoration: BoxDecoration(
                          boxShadow:[
                              BoxShadow(
                                blurStyle: BlurStyle.outer,
                                 offset: const Offset(
                                 0.3,
                                0.3,
                                ),
                                blurRadius: 7.0,
                                spreadRadius: 0.1,
                          color: Color.fromARGB(255, 60, 141, 144),

                             )

                             ] ,
                      border: Border.all(width: 2,
                      color: Color.fromARGB(255, 60, 141, 144),),
                      borderRadius: BorderRadius.circular(50),
                       ),
                  child: Column(

                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     Container (
                     alignment: Alignment.center,
                     child:CircleAvatar(
                      backgroundImage: AssetImage("images/1.jpg"),
                      radius: 50.r,
                     ),
                      ),
               SizedBox(height: 10.w,),
              Container(
                  height: 20.h,
                  width: 90.w,
                  child: Text("إرسال طلب تسجيل"),
                  ),
              ],), ),
                ),

            SizedBox(height: 25,),
                Container(
                  padding: EdgeInsets.all(10).r,
                   height:170.h,
                   decoration: BoxDecoration(
                            boxShadow:[
                            BoxShadow(
                              blurStyle: BlurStyle.outer,
                               offset: const Offset(
                               0.3,
                              0.3,
                              ),
                              blurRadius: 7.0,
                              spreadRadius: 0.1,
                        color: Color.fromARGB(255, 60, 141, 144),
                           )
                           ],
                    border: Border.all(width: 2.w,
                    color: Color.fromARGB(255, 60, 141, 144),),
                    borderRadius: BorderRadius.circular(50),
                     ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      InkWell(
                      child:Container (
                       alignment: Alignment.center,
                      child:CircleAvatar(
                       backgroundImage: AssetImage("images/3.png"),
                        radius: 50.r,
                   ),
                    ),
                        onTap: () {

                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Text_Screen( )));

                       },),
           SizedBox(height: 5.w,),
              Container(
                height: 30.w,
                alignment: Alignment.center,
                child: Text("قرارات المدينه الجامعية", ),
                ),

       ] )

           ),
           SizedBox(height: 25.w,),
                Container(
                  padding: EdgeInsets.all(8).r,
                    height:170.h,
                   decoration: BoxDecoration(
                            boxShadow:[
                            BoxShadow(
                              blurStyle: BlurStyle.outer,
                               offset: const Offset(
                               0.3,
                              0.3,
                              ),
                              blurRadius: 7.0,
                              spreadRadius: 0.1,
                        color: Color.fromARGB(255, 60, 141, 144),

                           )
                           ] ,
                    border: Border.all(width: 2.w,
                    color: Color.fromARGB(255, 60, 141, 144),),
                    borderRadius: BorderRadius.circular(50).r,
                     ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      InkWell(
                      child:Container (
                       alignment: Alignment.center,
                      child:CircleAvatar(
                       backgroundImage:AssetImage("images/5.png"),

                        radius: 50.r,
                   ),
                    ),
                        onTap: () {
                      Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return  Complain();
                          }));
                        },
                       ),
           SizedBox(height: 5.h,),
              Container(
                height: 40.w,
                alignment: Alignment.center,
                child: Text("تقديم شكوى", ),
                ),

           ] ))]),
        )),
    );
  }
}