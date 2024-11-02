import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_university/screens/serves.dart';
import 'package:shared_preferences/shared_preferences.dart';

class person extends StatefulWidget {
  const person({Key? key}) : super(key: key);

  @override
  State<person> createState() => _personState();
}

class _personState extends State<person> {
  // معلومات السكن الجامعي

  String floor = '';
  getfloor() async {
    final prefs = await SharedPreferences.getInstance();
    floor = prefs.getString('floor')!;
    setState(() {});
    return floor;
  }

  String? bed;
  getbed() async {
    final prefs = await SharedPreferences.getInstance();
    bed = prefs.getString('bed')!;
    setState(() {});
    return bed;
  }

  String fees = '';
  getfees() async {
    final prefs = await SharedPreferences.getInstance();
    fees = prefs.getString('fees')!;
    setState(() {});
    return fees;
  }

  String buildingNumber = '';
  getBuild() async {
    final prefs = await SharedPreferences.getInstance();
    buildingNumber = prefs.getString('build')!;
    setState(() {});
    return buildingNumber;
  }

  String room = '';
  getroom() async {
    final prefs = await SharedPreferences.getInstance();
    room = prefs.getString('room')!;
    setState(() {});
    return room;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getbed();
    getfees();
    getroom();
    getfloor();
    getBuild();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 225, 250, 252),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 60, 141, 144),
        centerTitle: true,
        title: Text("معلومات السكن "),
        leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => services()));
            },
            icon: Icon(Icons.arrow_back_ios)),
      ),
      body: Container(
        height: 400,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurStyle: BlurStyle.outer,
                offset: const Offset(
                  5.0,
                  5.0,
                ),
                blurRadius: 10.0,
                spreadRadius: 2.0,
                color: Color.fromARGB(255, 60, 141, 144),
              )
            ],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50),
              bottomLeft: Radius.circular(55),
              bottomRight: Radius.circular(55),
            )),
        margin: EdgeInsets.fromLTRB(45, 80, 45, 50).r,
        padding: EdgeInsets.only(top: 40, left: 10, right: 10).r,
        child: Column(
          children: [
            // TextButton(
            //     onPressed: () async {
            //       var prefs = await SharedPreferences.getInstance();
            //       floor = prefs.getString('floor')!;
            //       print(floor);
            //     },
            //     child: Text('print')),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                fees != null ? Text("$buildingNumber") : Container(),
                SizedBox(width: 5.h),
                const Text(
                  " :رقم الوحدة ",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Divider(
              height: 3.h,
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                floor == null ? Container() : Text("$floor"),
                SizedBox(width: 5.w),
                Text(
                  ":رقم الطابق",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Divider(
              height: 3.h,
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                room == null ? Container() : Text("$room"),
                SizedBox(width: 5.w),
                Text(
                  ":رقم الغرفة",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Divider(
              height: 3.h,
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                bed == null ? Container() : Text("$bed"),
                SizedBox(width: 5),
                Text(
                  ":رقم التخت",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Divider(
              height: 3.h,
            ),
                        SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                room == null ? Container() : Text("$fees"),
                SizedBox(width: 5.w),
                Text(
                  ":الكلفة",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Divider(
              height: 3.h,
            ),
          ],
        ),
      ),
    );
  }
}
