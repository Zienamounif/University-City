import 'dart:convert';

//import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:project_university/screens/serves.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/Model_Send.dart';

class Studen extends StatefulWidget {
  Studen({Key? key}) : super(key: key);

  @override
  State<Studen> createState() => _StudenState();
}

class _StudenState extends State<Studen> {
// التسجيل عالسكن الجامعي

/*
{
      'first_name': first_name,
      'last_name':last_name,
      'gender':gender,
        'student_id':'1',
       'father_name': father ,
        'mother_name': mother ,
        'governorate': mohafaza,
        'phone': phone,
        'is_disabled':isDisabled,
        'collage': collage,
        'collage_id':collageId,
        'year': year ,
        'is_successded':succed,
        'freind_collage_id': NumberFriend
  }
 */

  Future<Maison> sendAdd(
      String first_name,
      String last_name,
      String father,
      String mother,
      String collage,
      String year,
      String collageId,
      String mohafaza,
      String gender,
      String phone,
      String numberFriend,
      bool isDisabled,
      bool succed) async {
    final prefs = await SharedPreferences.getInstance();
    var id = prefs.getString('id');
    var body = json.encode({
      "student_id": "$id",
      "first_name": first_name,
      "last_name": last_name,
      "gender": gender,
      "father_name": father,
      "mother_name": mother,
      "is_disabled": isDisabled.toString(),
      "collage": collage,
      "collage_id": collageId.toString(),
      "year": year.toString(),
      "governorate": mohafaza,
      "phone": phone.toString(),
      "is_successded": succed.toString()
    });
    // print(bod)
    print(body);
    try {
      var respone = await http.post(
          Uri.parse('http://192.168.45.61:8080/api/active-house'),
          headers: {'Content-Type': 'application/json'},
          body: body);
      print(respone.statusCode);
      print((respone.body));
      print(    (respone.statusCode == 400 &&
                  jsonDecode(respone.body)['message'] !=
                      "Student governorate is unavailable") &&
              (respone.statusCode == 400 &&
                  jsonDecode(respone.body)['message'] !=
                      "Student failed is unavailable now"));
      if (respone.statusCode == 200 ||
          respone.statusCode == 201 ||
          (respone.statusCode == 400 &&
                  jsonDecode(respone.body)['message'] !=
                      "Student governorate is unavailable") &&
              (respone.statusCode == 400 &&
                  jsonDecode(respone.body)['message'] !=
                      "Student failed is unavailable now")) 
                      {
        var bed = House.fromJson(jsonDecode(respone.body)['house'].first).bed;
        prefs.setString('bed', bed.toString());
        var room = House.fromJson(jsonDecode(respone.body)['house'].first).room;
        prefs.setString('room', room.toString());
        var floor =
            House.fromJson(jsonDecode(respone.body)['house'].first).floor;

        prefs.setString('floor', floor.toString());
        print("zzzzzzzzzzzzzzzzzzzzzzzzzzzzzz   " + floor.toString());
        var fees = House.fromJson(jsonDecode(respone.body)['house'].first).fees;
        prefs.setString('fees', fees.toString());
        var buildingNumber =
            House.fromJson(jsonDecode(respone.body)['house'].first).build;
        prefs.setString('build', buildingNumber.toString());
        return Maison.fromJson(jsonDecode(respone.body));
      } else if (respone.statusCode == 404 ||
          (respone.statusCode == 400 &&
              (jsonDecode(respone.body)['message'] ==
                      "Student governorate is unavailable" ||
                  jsonDecode(respone.body)['message'] ==
                      "Student failed is unavailable now"))) {
        print('40000000000000000004');
        prefs.setString('bed', 'null');
        prefs.setString('room', 'null');

        prefs.setString('floor', 'null');
        prefs.setString('fees', 'null');
        prefs.setString('build', 'null');
        return Maison(house: [
          House(
              bed: 0,
              build: 0,
              createdAt: 'as',
              discount: 0,
              fees: 0,
              floor: 0,
              isFreind: 0,
              id: 0,
              isProtected: 0,
              room: 0,
              status: 'a',
              studentId: "00",
              type: '',
              updatedAt: '')
        ], message: jsonDecode(respone.body)['message']);
      } else {
        print('elsssssssssssse');

        return Maison(house: [
          House(
              bed: 0,
              build: 0,
              createdAt: 'as',
              discount: 0,
              fees: 0,
              floor: 0,
              isFreind: 0,
              id: 0,
              isProtected: 0,
              room: 0,
              status: 'a',
              studentId: "00",
              type: '',
              updatedAt: '')
        ], message: jsonDecode(respone.body)['message']);
      }
    } catch (e, s) {
      print(s);
      print(e);
      throw Exception(e);
    }
  }

  bool check = false;
  bool disability = false;

  var item = ["أنثى", "ذكر"];
  var itemss = ["راسب", "ناجح"];
  var country = [
    "القنيطرة",
    "درعا",
    "دمشق",
    "ريف دمشق",
    "حمص",
    "حماة",
    "إدلب",
    "حلب",
    " اللاذقية",
    "طرطوس",
    "دير الزور ",
    "الحسكة",
    "الرقة",
    " السويداء",
  ];
  var year = ["الأولى", "الثانية", "الثالثة", "الرابعه", "الخامسة", "السادسة"];

  var genderValue = null;
  var dropdownvalue1 = null;
  var dropdownvalue2 = null;

  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController fathernameController = TextEditingController();
  TextEditingController mothernameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController collageController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController numberFriendController = TextEditingController();

  var value;
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => services()));
        return false;
      },
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Color.fromARGB(255, 225, 250, 252),
            body: ListView(
              padding: EdgeInsets.only(top: 50, left: 20, right: 20).r,
              scrollDirection: Axis.vertical,
              children: [
                Center(
                  child: Container(
                    height: 50.w,
                    child: Text(
                      "ارسل طلب تسجيل بالمدينه الجامعيه",
                      style: TextStyle(
                        fontSize: 30.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    height: 50.w,
                    child: Text(
                      "الرجاء إدخال معلومات حقيقية",
                      style: TextStyle(
                        fontSize: 20.sp,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                TextFormField(
                  controller: firstnameController,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25).r,
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 60, 141, 144),
                            width: 2.w,
                          )),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 2.w,
                          )),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "الاسم الأول ",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1.w,
                        ),
                        borderRadius: BorderRadius.circular(25).r,
                      )),
                  validator: (text) {},
                ),
                SizedBox(
                  height: 20.h,
                ),
                TextFormField(
                  controller: lastnameController,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25).r,
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 60, 141, 144),
                            width: 2.w,
                          )),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 2.w,
                          )),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "الاسم الأخير  ",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 1.w),
                        borderRadius: BorderRadius.circular(25).r,
                      )),
                ),
                SizedBox(
                  height: 20.h,
                ),
                TextFormField(
                  controller: fathernameController,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25).r,
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 60, 141, 144),
                            width: 2.w,
                          )),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 2.w,
                          )),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "اسم الأب",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 1.w),
                        borderRadius: BorderRadius.circular(25).r,
                      )),
                ),
                SizedBox(
                  height: 20.h,
                ),
                TextFormField(
                  controller: mothernameController,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25).r,
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 60, 141, 144),
                            width: 2.w,
                          )),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 2.w,
                          )),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "اسم الأم",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 1.w),
                        borderRadius: BorderRadius.circular(25).r,
                      )),
                ),
                SizedBox(
                  height: 20.h,
                ),
                TextFormField(
                  controller: collageController,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25).r,
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 60, 141, 144),
                            width: 2.w,
                          )),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 2.w,
                          )),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "الكلية الجامعية",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: Colors.white),
                        borderRadius: BorderRadius.circular(25).r,
                      )),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  width: double.infinity,
                  height: 57.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: 1.w, color: Colors.white),
                    borderRadius: BorderRadius.circular(25).r,
                  ),
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButton(
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: Color.fromARGB(255, 60, 141, 144),
                      ),
                      hint: Text("أختر السنه الدراسية"),
                      items: year.map((String i) {
                        return DropdownMenuItem(
                          child: Text(i),
                          value: i,
                        );
                      }).toList(),
                      onChanged: (newvalue) {
                        setState(() {
                          dropdownvalue2 = newvalue;
                        });
                      },
                      value: dropdownvalue2,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                TextFormField(
                  controller: numberController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25).r,
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 60, 141, 144),
                            width: 2.w,
                          )),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 2.w,
                          )),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: " الرقم الجامعي ",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 1),
                        borderRadius: BorderRadius.circular(25).r,
                      )),
                ),
                SizedBox(
                  height: 20.h,
                ),
                TextFormField(
                  controller: phoneNumberController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25).r,
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 60, 141, 144),
                            width: 2.w,
                          )),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 2.w,
                          )),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "رقم الجوال",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 1),
                        borderRadius: BorderRadius.circular(25).r,
                      )),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  width: double.infinity,
                  height: 57.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: 1.w, color: Colors.white),
                    borderRadius: BorderRadius.circular(25).r,
                  ),
                  alignment: Alignment.center,
                  child: DropdownButton(
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Color.fromARGB(255, 60, 141, 144),
                    ),
                    hint: Text("أختر المحافظه المقيم بها"),
                    items: country.map((String i) {
                      return DropdownMenuItem(
                        child: Text(i),
                        value: i,
                      );
                    }).toList(),
                    onChanged: (newvalue) {
                      setState(() {
                        dropdownvalue1 = newvalue;
                      });
                    },
                    value: dropdownvalue1,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'ناجح',
                      style: TextStyle(fontSize: 22),
                    ),
                    Radio(
                      value: true,
                      groupValue: value,
                      onChanged: (val) {
                        setState(() {
                          value = val!;
                          print('$value');
                        });
                      },
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Row(
                      children: [
                        Text('راسب', style: TextStyle(fontSize: 22)),
                        Radio(
                          value: false,
                          groupValue: value,
                          onChanged: (val) {
                            setState(() {
                              value = val!;
                              print('$value');
                            });
                          },
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Checkbox(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10).r),
                      value: disability,
                      onChanged: (val) {
                        setState(() {
                          disability = val!;
                          print(disability);
                          check = true;
                        });
                      },
                      activeColor: Color.fromARGB(255, 60, 141, 144),
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    Text(
                      "هل يوجد إعاقه",
                      style: TextStyle(
                        fontSize: 25.sp,
                      ),
                    ),
                  ],
                ),
                check == true
                    ? Column(
                        children: [
                          SizedBox(
                            height: 10.h,
                          ),
                          TextFormField(
                            controller: numberFriendController,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25).r,
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 60, 141, 144),
                                    width: 2.w,
                                  )),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                    width: 2.w,
                                  )),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(25).r,
                              ),
                              hintText:
                                  " أدخل الرقم الجامعي للشخص الذي ترغب بالسكن معه",
                            ),
                          ),
                        ],
                      )
                    : Container(),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  width: double.infinity,
                  height: 57.h,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(width: 1, color: Colors.white),
                      borderRadius: BorderRadius.circular(25)),
                  alignment: Alignment.center,
                  child: DropdownButton(
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Color.fromARGB(255, 60, 141, 144),
                    ),
                    hint: Text("الجنس"),
                    items: item.map((String i) {
                      return DropdownMenuItem(
                        child: Text(i),
                        value: i,
                      );
                    }).toList(),
                    onChanged: (newvalue) {
                      setState(() {
                        genderValue = newvalue;
                      });
                    },
                    value: genderValue,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () async {
                        if (numberFriendController == null ||
                            numberFriendController == '') {
                          await sendAdd(
                                  firstnameController.text,
                                  lastnameController.text,
                                  fathernameController.text,
                                  mothernameController.text,
                                  collageController.text,
                                  dropdownvalue2,
                                  numberController.text,
                                  dropdownvalue1,
                                  genderValue,
                                  phoneNumberController.text,
                                  '',
                                  disability,
                                  value)
                              .then((value) {
                            if (value.message! == 'Student is already added' ||
                                value.message! ==
                                    'Student is not found in registeration lists') {
                               showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('on snap!',
                               style: TextStyle(
                                      color: Colors.red
                                    )),
                                    content: Text('${value.message!}!'),
                                    actions: [
                                      TextButton(
                                        child: Text("OK"),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );                               
                            }
                            if (value.message! == 'House Added Successfully') {
                             showDialog(
                              
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Success',
                              style: TextStyle(
                                      color: Color.fromARGB(255, 60, 141, 144),
                                    )),
                                    content: Text('${value.message!}!'),
                                    actions: [
                                      TextButton(
                                        child: Text("OK"),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          });
                        } else {
                          await sendAdd(
                                  firstnameController.text,
                                  lastnameController.text,
                                  fathernameController.text,
                                  mothernameController.text,
                                  collageController.text,
                                  dropdownvalue2,
                                  numberController.text,
                                  dropdownvalue1,
                                  genderValue,
                                  phoneNumberController.text,
                                  numberFriendController.text,
                                  disability,
                                  value)
                              .then((value) {
                            if (value.message! == 'Student is already added' ||
                                value.message! ==
                                    'Student is not found in registeration lists') {
                              showDialog(
                                
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('on snap!',
                                style: TextStyle(
                                      color: Colors.red
                                    )),
                                    content: Text('${value.message!}!'),
                                    actions: [
                                      TextButton(
                                        child: Text("OK"),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                            if (value.message! == 'House Added Successfully') {
                              showDialog(
                                barrierColor: Color.fromARGB(255, 60, 141, 144),
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Success',
                                      style: TextStyle(
                                      color: Color.fromARGB(255, 60, 141, 144),
                                    )),
                                    content: Text('${value.message!}!'),
                                    actions: [
                                      TextButton(
                                        child: Text("OK"),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                            if (value.message! ==
                                'Student governorate is unavailable') {
                              showDialog(
                               
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Faild',
                                   style: TextStyle(
                                      color: Colors.red
                                    )),
                                    content: Text('${value.message!}!'),
                                    actions: [
                                      TextButton(
                                        child: Text("OK"),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                            if (value.message! ==
                                'Student failed is unavailable now') {
                              showDialog(
                               
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Faild',
                                    style: TextStyle(
                                      color: Colors.red
                                    )),
                                    content: Text(
                                        'Please wait till the registertion process ends.'),
                                    actions: [
                                      TextButton(
                                        child: Text("OK"),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          });
                        }
                      },
                      child: Text(
                        "التالي",
                        style: TextStyle(
                            color: Color.fromARGB(255, 60, 141, 144),
                            fontSize: 30),
                      ),
                    ),
                    SizedBox(
                      width: 60.w,
                    ),
                   
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => services()));
                      },
                      child: Text(
                        "رجوع",
                        style: TextStyle(
                            color: Color.fromARGB(255, 60, 141, 144),
                            fontSize: 30.sp),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
