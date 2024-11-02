// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart';
// import 'package:project_university/serves.dart';
// import 'package:http/http.dart' as http;
// import 'main.dart';

// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class decisions extends StatefulWidget {
//   const decisions({Key? key}) : super(key: key);

//   @override
//   State<decisions> createState() => _decisionsState();
// }

// class _decisionsState extends State<decisions> {
//   Future<dynamic> getDecisions() async {
//     String url = "";
//     final response = await http.get(Uri.parse(url));
//     if (response.statusCode == 200 || response.statusCode == 201) {
//       return jsonDecode(response.body);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Color.fromARGB(255, 225, 250, 252),
//         appBar: AppBar(
//           backgroundColor: Color.fromARGB(255, 60, 141, 144),
//           title: Text("قرارات المدينة الجامعية"),
//           centerTitle: true,
//           leading: IconButton(
//             icon: Icon(Icons.arrow_back),
//             onPressed: () {
//               Navigator.of(context).push(MaterialPageRoute(builder: (context) {
//                 return services();
//               }));
//             },
//           ),
//         ),
//         body: FutureBuilder(
//           future: getDecisions(),
//           builder: (context, AsyncSnapshot<dynamic> snapshot) {
//             if (snapshot.hasData &&
//                 snapshot.connectionState == ConnectionState.done) {
//               return ListView.builder(
//                   itemCount: snapshot.data['decisions'].length,
//                   itemBuilder: (context, index) {
//                     return desCard(snapshot.data['decisions'][index]['title'],
//                         snapshot.data['decisions'][index]['content']);
//                   });
//             } else {
//               return const Center(
//                 child: CircularProgressIndicator(),
//               );
//             }
//           },
//         ));
//   }

//   desCard(title, content) {
//     return Column(
//       children: [
//         Container(
        
//           color:Colors.white ,
//           height: 200,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.only(topLeft: Radius.circular(50),bottomRight: Radius.circular(50)),
//             border: Border.all(
//               width: 2.w,
//               color: Color.fromARGB(255, 60, 141, 144),
//             ),
//             boxShadow: [
//               BoxShadow(color: Color.fromARGB(255, 223, 222, 222),blurRadius: 0.2,spreadRadius: 0.2)
//             ],
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(15).r,
//             child: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     Text(
//                       title,
//                       textAlign: TextAlign.justify,
//                       textDirection: TextDirection.rtl,
//                       style: TextStyle(
//                         fontSize: 20.sp,
//                       ),
//                     ),
//                   ],
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     Expanded(
//                         child: Text(
//                       content,
//                       textDirection: TextDirection.rtl,
//                     )),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//         SizedBox(
//           height: 20.h,
//         )
//       ],
//     );
//   }
// }


// ListView.builder(
//           padding:EdgeInsets.only( top:50.h,right: 20.h,left: 20.h) ,
//           itemCount: 5,
//           itemBuilder: ((context, i){
//           return Column(
//             children: [
//               Container(
                
//                 height: 200,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(20).r,
//                   border: Border.all(width: 2.w,
//                   color: Color.fromARGB(255, 60, 141, 144),),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(15).r,
//                   child: Column(
                    
//                     children: [
//                       Row(
                        
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           Text(" زينة",
//                           textAlign: TextAlign.justify,
//                           textDirection: TextDirection.rtl,  ),
//                         ],
//                       ),
                      
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           Expanded(
//                             child: Text(" السنة الخامسة زينة محمد منيف هندسة معلوماتيه في تشرين تخصص برمجيات ",
//                             textDirection: TextDirection.rtl,  )),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20.h,)
//             ],
//           );
//         } ))