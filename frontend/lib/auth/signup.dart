import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../Domain.dart';
import 'login/Login_Screen.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool isloading = false;
  TextEditingController txtemail = new TextEditingController();
  TextEditingController txtpass = new TextEditingController();
  TextEditingController txtpname = new TextEditingController();
  final formkey =GlobalKey<FormState>();

  Future SigUP(String first_name, String email, String password) async{

    var response=await http.post(Uri.parse('http://192.168.45.61:8080/api/sign-up'),
        body:{
          "user_name": first_name,
          "email": email,
          "password": password,
     //     "is_disabled":null
        }
    );
      print(jsonDecode(response.body));

    if(response.statusCode==200||response.statusCode==201){
      var responsebody=jsonDecode(response.body);
      if(responsebody["message"]=="Registered Successfully"){
    final prefs = await SharedPreferences.getInstance();
        prefs.setString('user_name',jsonDecode(response.body) ['student']['user_name']);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login_Screen()));
        ScaffoldMessenger.of(context).showSnackBar( SnackBar(
            backgroundColor: Colors.green,
            content: Text("تم إنشاء الحساب بنجاح")));
      }else{
        ScaffoldMessenger.of(context).showSnackBar( SnackBar(
            backgroundColor: Colors.red,
            content: Text("لا يمكن انشاء الحساب")));
      }
      return responsebody;
    }else {
      print(response.statusCode);
      throw ('خطأ في اي بي اي انشاء الحساب');
    }
  }

  bool isclicked=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 225, 250, 252),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 60, 141, 144),
        centerTitle: true,
        title: Text(
          "إنشاء حساب",
          style: TextStyle(fontSize: 25.sp),
        ),

      ),
      body: Form(
        key:formkey ,
        child: ListView(
          children:[ Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Container(
              //   margin: EdgeInsets.only(top: ),
              //   child: Text(
              //     "أدخل البيانات التالية",
              //     style: TextStyle(
              //       fontSize: 25.sp,
              //       color: Color.fromARGB(255, 60, 141, 144),
              //       fontWeight: FontWeight.bold,
              //     ),
              //   ),
              // ),

              Container(
                padding: EdgeInsets.only(left: 25, bottom: 10,right: 25,top: 165).r,
                child: Form(
                    child: Column(
                  children: [
                   TextFormField(
                     validator: (val){
                       if (val!.isEmpty){
                         return "تفقد الحقل";
                       }
                     },
                      controller: txtpname,
                      style: TextStyle(
                        fontSize: 30.sp,
                      ),
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        label: Text("Name"),
                        labelStyle: TextStyle(color: Color.fromARGB(255, 60, 141, 144)),
                        contentPadding: EdgeInsets.symmetric( horizontal: 20,vertical: 18).r,
                        focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20).r,
                              borderSide: BorderSide(
                                color:Color.fromARGB(255, 60, 141, 144),
                                width: 2.w,
                              )),
                          enabledBorder: OutlineInputBorder(

                              borderRadius: BorderRadius.circular(20).r,
                              borderSide: BorderSide(
                                color:Color.fromARGB(255, 60, 141, 144),
                                width: 2,
                              )),
                          prefixIcon: Icon(Icons.person,
                          color:Color.fromARGB(255, 60, 141, 144) ,),
                         hintText: " الاسم",
                         hintStyle: TextStyle(fontSize: 20.sp),


                          border:
                        OutlineInputBorder(borderSide: BorderSide(width: 1.w))),
                    ),
                    SizedBox(
                      height: 25.w,
                    ),
                  TextFormField(
                    validator: (val){
                      if (val!.isEmpty){
                        return "تفقد الحقل";
                      }
                    },
                      controller: txtemail,
                      style: TextStyle(
                        fontSize: 30.sp,
                      ),
                      decoration: InputDecoration(

                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        label: Text("Email"),
                        labelStyle: TextStyle(color: Color.fromARGB(255, 60, 141, 144)),
                        contentPadding: EdgeInsets.symmetric( horizontal: 20,vertical: 18).r,
                        focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20).r,
                              borderSide: BorderSide(
                                color:Color.fromARGB(255, 60, 141, 144),
                                width: 2.w,
                              )),
                          enabledBorder: OutlineInputBorder(

                              borderRadius: BorderRadius.circular(20).r,
                              borderSide: BorderSide(
                                color:Color.fromARGB(255, 60, 141, 144),
                                width: 2,
                              )),
                          prefixIcon: Icon(Icons.email_outlined,
                          color:Color.fromARGB(255, 60, 141, 144) ,),
                         hintText: " البريد الألكتروني",
                         hintStyle: TextStyle(fontSize: 20.sp),
                          border:
                        OutlineInputBorder(borderSide: BorderSide(width: 1.w))),
                    ),
                    SizedBox(
                      height: 25.w,
                    ),
                   TextFormField(
                     validator: (val){
                       if (val!.isEmpty){
                         return "تفقد الحقل";
                       }
                     },
                      controller: txtpass,
                      style: TextStyle(
                        fontSize: 30.sp,
                      ),
                      obscureText: true,
                      decoration: InputDecoration(
                         floatingLabelBehavior: FloatingLabelBehavior.always,
                        label: Text("password"),
                        labelStyle:TextStyle(color: Color.fromARGB(255, 60, 141, 144)) ,
                         contentPadding: EdgeInsets.symmetric( horizontal: 20.w,vertical: 18.w),
                         focusedBorder: OutlineInputBorder(

                              borderRadius: BorderRadius.circular(20).r,
                              borderSide: BorderSide(
                                color:Color.fromARGB(255, 60, 141, 144),
                                width: 2.w,
                              )),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                color:Color.fromARGB(255, 60, 141, 144),
                                width: 2.w,
                              )),
                          prefixIcon: Icon(Icons.lock,
                          color: Color.fromARGB(255, 60, 141, 144),),
                          hintText: "كلمة المرور",
                          hintStyle: TextStyle(fontSize: 20.sp),
                          border:
                         OutlineInputBorder(borderSide: BorderSide(width: 1.w))),
                    ),
                    SizedBox(
                      height: 25.w,
                    ),
                   Container(
                      child: InkWell(
                        child: Container(
                           width: double.infinity,
                          height: 45.w,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors:[
                                Color.fromARGB(255, 145, 220, 223)
                                ,Color.fromARGB(255, 60, 141, 144),]
                                 ),
                            border: Border.all(
                              width: 2.w,
                              color: Color.fromARGB(255, 60, 141, 144)
                            ),
                            borderRadius: BorderRadius.circular(10).r,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "إنشاء حساب ",
                            style: TextStyle(fontSize: 20.sp,
                            color: Colors.white),
                          ),
                        ),
                        onTap: () {
                          if(isclicked==false){
                            if(formkey.currentState!.validate()){
                              SigUP(txtpname.text,txtemail.text,txtpass.text);
                            }}else{
                            ScaffoldMessenger.of(context)
                                .showSnackBar(  SnackBar(
                                backgroundColor: Colors.red,
                                content: Text("الرجاء الانتظار لحظة")));
                          }
                        },
                      ),
                    ),
                  ],
                )),
              ),
              SizedBox(height: 15.w,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .pushReplacement(MaterialPageRoute(builder: (context) {
                        return Login_Screen();
                      }
                      )
                      );
                    },
                    child: Text(
                      " إضغط هنا",
                      style:
                      TextStyle(color: Color.fromARGB(255, 60, 141, 144), fontSize: 30.sp),
                    ),
                  ),
                  SizedBox(width: 5.w,),
                  Text(
                    "  اذا كنت تملك حساب",
                    style: TextStyle(fontSize: 20.sp),
                  ),
                ],
              ),
            ],
          ),
          ]
        ),
      ),
    );

  }



}


