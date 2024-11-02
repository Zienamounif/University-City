import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:project_university/screens/serves.dart';
import 'package:shared_preferences/shared_preferences.dart';
 
import '../Domain.dart';
import '../models/Problem_Model.dart';

class Complain extends StatefulWidget {
  const Complain({Key? key}) : super(key: key);

  @override
  State<Complain> createState() => _ComplainState();
}

class _ComplainState extends State<Complain> {
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();

// تقديم شكوى

  Future<Problem_Model>sendProblem(String title,String content)async{
    final prefs = await SharedPreferences.getInstance();
    var stuu_id= prefs.getString('id');
    final response =await http.post(Uri.parse('http://192.168.45.61:8080/api/add-complaint'),
        body: {
          'title':title,
          'content':content,
          'student_id':'$stuu_id'
        }
    );
    print(response.body);
    if(response.statusCode==200||response.statusCode==201){
      var data= jsonDecode(response.body);
      if(data['message']=="Complaint Added Successfully"){
          ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(
            backgroundColor: Colors.green,
            content: Text("تم اسال الشكوى")));
      }else{
        ScaffoldMessenger.of(context)
            .showSnackBar(  SnackBar(
            backgroundColor: Colors.red,
            content: Text("لم يتم ارسال الشكوى")));
      }
      print(data);
      print('1');
      return Problem_Model.fromJson(data);
    }else{
      print(response.statusCode);
      throw Exception("خطا في api ارسال الشكوى");
    }
  }

  GlobalKey<FormState>formstate=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 60, 141, 144),
          title: Text("تقديم شكوى"),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
                return services();
              }));
            },
          ),
        ),
        backgroundColor: Color.fromARGB(255, 225, 250, 252),
        body: ListView(children: [
          Form(
            key: formstate,
              child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 50, left: 25, right: 25).r,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      " قم بكتابة الشكوى في حال وجود مشكلة ستتم مراجعتها من قبل الإدارة",
                      style: TextStyle(fontSize: 20.sp),
                       textDirection: TextDirection.rtl,
                    ),
                  ),
                ),
                SizedBox(
                  height: 25.h,
                ),
               TextFormField(
                  controller: title,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20).r,
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 60, 141, 144),
                          width: 2.w,
                        )),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20).r,
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 60, 141, 144),
                          width: 2.h,
                        )),
                    labelText: "   عنوان الشكوى   ",
                    labelStyle: TextStyle(fontSize: 20.sp,
                    color: Colors.black,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20).r,
                    ),
                  )
                ),
                SizedBox(
                  height: 20.h,
                ),
                TextFormField(
                  controller: content,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20).r,
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 60, 141, 144),
                          width: 2.w,
                        )),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20).r,
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 60, 141, 144),
                          width: 2.h,
                        )),
                    labelText: "   أكتب الشكوى هنا   ",
                    labelStyle: TextStyle(fontSize: 20.sp,
                    color: Colors.black,
                    ),
           contentPadding: EdgeInsets.symmetric( horizontal: 20.w,vertical: 18.w),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25).r,
                    ),
                  ),
                  maxLines: 10,
                ),
                SizedBox(
                  height: 20.h,
                ),
                InkWell(
                  child: Container(
                    width: double.infinity,
                    height: 45.h,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Color.fromARGB(255, 145, 220, 223),
                        Color.fromARGB(255, 60, 141, 144),
                      ]),
                      border: Border.all(
                          width: 2.w, color: Color.fromARGB(255, 60, 141, 144)),
                      borderRadius: BorderRadius.circular(10).r,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "إرسال الشكوى",
                      style: TextStyle(fontSize: 20.sp, color: Colors.white),
                    ),
                  ),
                  onTap: (){
                    if(isclicked==false){
                      if(formstate.currentState!.validate()){
                        sendProblem(title.text,content.text);
                      }}else{
                      ScaffoldMessenger.of(context)
                          .showSnackBar(  SnackBar(
                          backgroundColor: Colors.red,
                          content: Text("الرجاء الانتظار لحظة")));
                    }
                  },
                ),
                // InkWell(
                //   child: Container(
                //     width: double.infinity,
                //     height: 45.h,
                //     decoration: BoxDecoration(
                //       gradient: LinearGradient(colors: [
                //         Color.fromARGB(255, 145, 220, 223),
                //         Color.fromARGB(255, 60, 141, 144),
                //       ]),
                //       border: Border.all(
                //           width: 2.w, color: Color.fromARGB(255, 60, 141, 144)),
                //       borderRadius: BorderRadius.circular(10).r,
                //     ),
                //     alignment: Alignment.center,
                //     child: Text(
                //       "إرسال الشكوى",
                //       style: TextStyle(fontSize: 20.sp, color: Colors.white),
                //     ),
                //   ),
                //   onTap: (){
                //     if(isclicked==false){
                //
                //       sename();
                //       }else{
                //       ScaffoldMessenger.of(context)
                //           .showSnackBar(  SnackBar(
                //           backgroundColor: Colors.red,
                //           content: Text("الرجاء الانتظار لحظة")));
                //     }
                //   },
                // ),
              ],
            ),
          ))
        ]),
      ),
    );
  }
  // sename()async{
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString('name', "value");
  // }
  bool isclicked=false;
}
