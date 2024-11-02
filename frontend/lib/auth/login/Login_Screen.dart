import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Domain.dart';
import '../../screens/serves.dart';
import '../signup.dart';
import 'package:http/http.dart'as http;

import 'Login_Model.dart';
class Login_Screen extends StatefulWidget {
  const Login_Screen({Key? key}) : super(key: key);

  @override
  State<Login_Screen> createState() => _Login_ScreenState();
}

class _Login_ScreenState extends State<Login_Screen> {
  TextEditingController txtemail = new TextEditingController();
  TextEditingController txtpass = new TextEditingController();
  bool pass=true;
  bool isLoading=false;
  GlobalKey<FormState>formstate=GlobalKey<FormState>();
  ////////////////////////////////////////////////////////////////////////////
  Future<Login_Model> login(String Email, String password) async {
    print('AAAAAAAA');
    isLoading = true;
    setState(() {});
    var response = await http.post(
        Uri.parse("http://192.168.45.61:8080/api/sign-in"),
        body: {
          'email': Email,
          'password': password
        }
    );
    isLoading = false;
    setState(() {
    });

    if (response.statusCode == 200||response.statusCode==201) {


      print('asasasasasasasas');
      print(response.statusCode);
      var responsbody = jsonDecode(response.body);
      final prefs = await SharedPreferences.getInstance();
              prefs.setString('user_name',jsonDecode(response.body) ['student']['user_name']);

      var Stu_Id=Login_Model.fromJson(responsbody).student!.id;
      var Stu_name=Login_Model.fromJson(responsbody).student!.firstName;
      prefs.setString('id',Stu_Id.toString());
      prefs.setString('name',Stu_name.toString());
      print(responsbody);
      if (responsbody['message']=="Logged In Successfully") {
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder:(context)=>services()),(route) => false);
        ScaffoldMessenger.of(context).showSnackBar( SnackBar(
            backgroundColor: Colors.green,content: Text("تم تسجيل الدخول بنجاح")));}
      else {
        ScaffoldMessenger.of(context)
            .showSnackBar(  SnackBar(
            backgroundColor: Colors.red,
            content: Text("لم يتم تسجيل الدخول")));
      }
      return Login_Model.fromJson(responsbody);
    } else {
      print(response.statusCode);
      throw ('خطأ في اي بي اي تسجيل الدخول');
    }
  }
  bool islocked=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 225, 250, 252),
      appBar: AppBar(
        backgroundColor:Color.fromARGB(255, 60, 141, 144),
        centerTitle: true,
        title: Text("تسجيل الدخول"),
      ),
      body: Form(
        key: formstate,
        child: ListView(
            children:[
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 150,left: 5,right: 5).r,
                    padding: EdgeInsets.all(20).r,
                    child: Column(
                      children: [
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
                              border:OutlineInputBorder(borderSide: BorderSide(width: 1.w))),
                        ),
                        SizedBox(
                          height: 28.h,
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
                          obscureText: pass,
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

                                  borderRadius: BorderRadius.circular(20).r,
                                  borderSide: BorderSide(
                                    color:Color.fromARGB(255, 60, 141, 144),
                                    width: 2,
                                  )),
                              prefixIcon: Icon(Icons.lock,
                                color: Color.fromARGB(255, 60, 141, 144),),
                              hintText: "كلمة المرور",
                              hintStyle: TextStyle(fontSize: 20.sp),
                              suffixIcon: IconButton(icon:Icon(Icons.remove_red_eye_outlined) ,onPressed: (){
                                setState(() {
                                  pass=!pass;
                                });
                              },),
                              border:
                              OutlineInputBorder(borderSide: BorderSide(width: 1.w))),
                        ),
                        SizedBox(height: 20.w,),
                        InkWell(
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
                              "تسجيل الدخول ",
                              style: TextStyle(fontSize: 20.sp,
                                  color: Colors.white),
                            ),
                          ),
                          onTap: () {
                            if(islocked==false){
                              if(formstate.currentState!.validate()){
                                login(txtemail.text,txtpass.text);
                              }}else{
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(  SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text("الرجاء الانتظار لحظة")));
                            }
                          },
                        ),
                        SizedBox(height: 15.w,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.of(context)
                                    .pushReplacement(MaterialPageRoute(builder: (context) {
                                  return Signup();
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
                              "  اذا كنت لاتملك حساب",
                              style: TextStyle(fontSize: 18.sp),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )

                ],
              ),
            ]
        ),
      ),
    );
  }
}