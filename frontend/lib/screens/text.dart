import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_university/screens/serves.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;

import '../Domain.dart';
import '../models/Desi2.dart';
import '../models/Desicion_Model.dart';
class Text_Screen extends StatefulWidget {
  Text_Screen( { Key? key }) : super(key: key);

  @override
  State<Text_Screen> createState() => _Text_ScreenState();
}

class _Text_ScreenState extends State<Text_Screen> {

  /*

  قرارات المدينة الجامعية
  */

  Future<Model_Desicion>getDecisions()async{
    final response =await http.get(Uri.parse('http://192.168.45.61:8080/api/view-decisions'));
    print(response.body);
    if(response.statusCode==200||response.statusCode==201){
      print(response.statusCode);
      var data= jsonDecode(response.body);
      print(data);
      return Model_Desicion.fromJson(data);
    }else{
      print(response.statusCode);
      throw Exception("خطأ ي api قرارات المدينة");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 225, 250, 252),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 60, 141, 144),
          title: Text("قرارات المدينة الجامعية"),
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
        body:FutureBuilder(
          future: getDecisions(),
          builder: (BuildContext context, AsyncSnapshot<Model_Desicion> snapshot) {
            print(snapshot.error);
            if(snapshot.hasData){
              return ListView.builder(
                  padding:EdgeInsets.only( top:50.h,right: 20.h,left: 20.h) ,
                  itemCount:snapshot.data!.decisions!.length,
                  itemBuilder: ((context, index){
                    return Container(
                      height: 200.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow:[
                            BoxShadow(
                              blurStyle: BlurStyle.outer,
                              offset: const Offset(
                                5.0,
                                5.0,
                              ),
                              blurRadius: 10.0,
                              spreadRadius: 4.0,
                              color: Color.fromARGB(255, 60, 141, 144),
                            )
                          ] ,
                          borderRadius: BorderRadius.only( topLeft: Radius.circular(50),
                            bottomLeft: Radius.circular(55),
                            bottomRight: Radius.circular(55),  )
                      ),
                      margin: EdgeInsets.fromLTRB(25, 20, 25, 50),
                      padding: EdgeInsets.all(15),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "${snapshot.data!.decisions![index].title}",
                                textAlign: TextAlign.justify,
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                  fontSize: 20.sp,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5,),
                          Divider(height: 3.h,),
                          SizedBox(height: 10.h,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Expanded(
                                  child: Text(
                                    "${snapshot.data!.decisions![index].content}",
                                    textDirection: TextDirection.rtl,
                                  )),
                            ],
                          ),
                        ],
                      ),
                    );
                  } ));
            }else{
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },

        )
    );
  }
}