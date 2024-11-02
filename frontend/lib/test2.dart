// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// class test extends StatefulWidget {
//   const test({ Key? key }) : super(key: key);
//
//   @override
//   State<test> createState() => _testState();
// }
//
// class _testState extends State<test> {
//   @override
//   Widget build(BuildContext context) {
//     return
//     Scaffold(
//
//
//
//       appBar:AppBar(
//         backgroundColor :Color.fromARGB(255, 126, 91, 80),
//         toolbarHeight:50 ,
//         title: Text("الماد المسجله"),
//         centerTitle: true,
//       ),
//
//
//       body: ListView(children: [
//         Container(
//           height: 150,
//           width: double.infinity,
//
//           decoration: BoxDecoration(
//             boxShadow:[BoxShadow(
//               blurStyle: BlurStyle.outer,
//                offset: const Offset(
//                         5.0,
//                         5.0,
//                       ),
//                       blurRadius: 10.0,
//                       spreadRadius: 2.0,
//             color: Color.fromARGB(255, 192, 93, 57),
//
//             )
//
//             ] ,
//             borderRadius: BorderRadius.only( topLeft: Radius.circular(50),
//             bottomLeft: Radius.circular(55),
//             bottomRight: Radius.circular(55),  )
//           ),
//           margin: EdgeInsets.fromLTRB(60, 20, 60, 50),
//           padding: EdgeInsets.all(15),
//           child: Column(
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//
//
//                 children: [
//
//
//                   Text("رياضيات ",
//                  ),
//                   SizedBox(width: 8),
//
//                    Text(" :اسم المادة",
//                     style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                   ),
//
//                   ),
//                 ],
//               ),
//             Divider(height:3 ,),
//               Row(
//                  mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                  Text("100000"),
//                  SizedBox(width: 5),
//                   Text(":الكلفة الكلية",
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                   ),),
//
//
//                 ],
//               ),
//               Divider( height: 3,),
//               Row(
//                  mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//
//                   Text("50000"),
//                   SizedBox(width: 5),
//                    Text(":الدفوعات",
//                     style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                   ),),
//                 ],
//               ),
//               Divider(height: 2,),
//
//               Row(
//
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   TextButton(onPressed: (){},
//                    child:Text("المواعيد",
//                    style: TextStyle(color: Color.fromARGB(255, 192, 93, 57),fontSize: 15),),
//                     ),
//                     Icon(Icons.arrow_forward),
//                 ],
//               ),
//             ],
//           ),
//
//         )
//         ,
//
//         Container(
//           height: 150,
//           width: double.infinity,
//
//           decoration: BoxDecoration(
//             boxShadow:[BoxShadow(
//               blurStyle: BlurStyle.outer,
//                offset: const Offset(
//                         5.0,
//                         5.0,
//                       ),
//                       blurRadius: 10.0,
//                       spreadRadius: 2.0,
//             color: Color.fromARGB(255, 192, 93, 57),
//
//             )
//
//             ] ,
//             borderRadius: BorderRadius.only( topLeft: Radius.circular(50),
//             bottomLeft: Radius.circular(50),
//             bottomRight: Radius.circular(50),  )
//           ),
//           margin: EdgeInsets.only( left:60,right: 60, bottom:20),
//           padding: EdgeInsets.all(15),
//           child: Column(
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//
//
//                 children: [
//
//
//                   Text("رياضيات ",
//                  ),
//                   SizedBox(width: 8),
//
//                    Text(" :اسم المادة",
//                     style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                   ),
//
//                   ),
//                 ],
//               ),
//             Divider(height:3 ,),
//               Row(
//                  mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                  Text("100000"),
//                  SizedBox(width: 5),
//                   Text(":الكلفة الكلية",
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                   ),),
//
//
//                 ],
//               ),
//               Divider( height: 3,),
//               Row(
//                  mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//
//                   Text("50000"),
//                   SizedBox(width: 5),
//                    Text(":الدفوعات",
//                     style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                   ),),
//                 ],
//               ),
//               Divider(height: 2,),
//
//               Row(
//
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   TextButton(onPressed: (){},
//                    child:Text("المواعيد",
//                    style: TextStyle(color: Color.fromARGB(255, 192, 93, 57),fontSize: 15),),
//                     ),
//                     Icon(Icons.arrow_forward),
//                 ],
//               ),
//             ],
//           ),
//
//         ),
//          SizedBox(height: 20,),
//         Container(),
//       ]),
//     );
//   }
// }