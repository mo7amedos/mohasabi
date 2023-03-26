import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mohasabi/Admin/showsubservices.dart';
import 'package:mohasabi/Model/services.dart';
import 'package:mohasabi/config/config.dart';

import '../config/NavBar.dart';
import '../home.dart';
import 'addsubservices.dart';

class ShowMainServices extends StatefulWidget {
  @override
  State<ShowMainServices> createState() => _ShowMainServicesState();
}

class _ShowMainServicesState extends State<ShowMainServices> {

  @override
  Widget build(BuildContext context) {
    Future<bool> _back() async {
      return await Navigator.push(context, MaterialPageRoute(builder: (context) => Home(role: Mohasabi.sharedPreferences.getString(Mohasabi.userRole))));
    }
    return WillPopScope(
      onWillPop: _back,
      child: SafeArea(
          child: Column(
              children: [
            Expanded(
              child: DefaultTabController(
                initialIndex: 0,
                length: 2,
                child: Scaffold(
                  drawer: NavBar(),
                  appBar: AppBar(
                    iconTheme: IconThemeData(color: AppColors.Black),
                    backgroundColor: AppColors.White,
                    title: Text("اختار الخدمة المراد اضافة خدمة بداخلها" ,style: TextStyle(color: AppColors.Black,fontSize: 15, fontWeight: FontWeight.bold),),
                    centerTitle: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                      ),
                    ),
                    bottom: const TabBar(
                      indicator: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10)),
                          color: AppColors.LightGold),
                      tabs: <Widget>[
                        Tab(
                          child: Text("شركات",style: TextStyle(color: AppColors.Black,fontSize: 15,fontWeight: FontWeight.bold),),
                        ),
                        Tab(
                          child: Text("افراد",style: TextStyle(color: AppColors.Black,fontSize: 15,fontWeight: FontWeight.bold),),
                        ),

                      ],
                    ),
                  ),
                  body:  TabBarView(
                    children: <Widget>[
                      //شركات
                      SingleChildScrollView(
                        child: Column(children: [
                          SizedBox(height: 10,),
                      //الخدمات
                  FutureBuilder<QuerySnapshot>(
                    future: FirebaseFirestore.instance.collection(Mohasabi.collectionServices).where("type",isEqualTo: "company").get(),
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasData) {
                        return GridView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                          itemCount: snapshot.data.docs.length,
                          itemBuilder: (BuildContext context, int index) {
                            ServicesModel model = ServicesModel.fromJson(snapshot.data.docs[index].data());
                            return Card(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    InkWell(
                                      child: Container(
                                          child: Image.network(model.imgurl,fit: BoxFit.fill),height: 120),
                                      onTap: (){
                                        showDialog(context: context, builder: (context) => AlertDialog(
                                          title: Text('ماذا تريد',textDirection: TextDirection.rtl),
                                          actions:[
                                            ElevatedButton(
                                              onPressed: () => Navigator.push(context, MaterialPageRoute(
                                            builder: (context) =>  AddSubServices(model: model,)),),
                                        style: ElevatedButton.styleFrom(backgroundColor: AppColors.DarkGold),
                                              //return false when click on "NO"
                                              child:Text('اضافة خدمة'),
                                            ),
                                            ElevatedButton(
                                              onPressed: () => Navigator.push(context,
                                                MaterialPageRoute(builder: (context) =>  ShowSubServices(ID: model.idservice,model: model,)),),
                                              style: ElevatedButton.styleFrom(backgroundColor: AppColors.LightGold),
                                              //return true when click on "Yes"
                                              child:Text('اضافة معلومات عن الخدمة'),
                                            ),

                                          ],
                                        ),);
                                      },
                                    ),
                                    SizedBox(height: 5,),
                                    Text(model.title,style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),textAlign: TextAlign.center,)                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  )


                  ],),
                      ),
                      //افراد
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(height: 10,),

                            FutureBuilder<QuerySnapshot>(
                              future: FirebaseFirestore.instance.collection(Mohasabi.collectionServices).where("type",isEqualTo: "individual").get(),
                              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (snapshot.hasData) {
                                  return GridView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                    ),
                                    itemCount: snapshot.data.docs.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      ServicesModel model = ServicesModel.fromJson(snapshot.data.docs[index].data());
                                      //DocumentSnapshot document = snapshot.data.docs[index];

                                      return Card(
                                        child: Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: <Widget>[
                                              InkWell(
                                                child: Container(
                                                    child: Image.network(model.imgurl,fit: BoxFit.fill),height: 120),
                                                onTap: (){
                                                  Navigator.push(context, MaterialPageRoute(builder: (context) =>  AddSubServices(model: model,)),);
                                                },
                                              ),
                                              SizedBox(height: 5,),
                                              Text(model.title,style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),textAlign: TextAlign.center,)                                ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                } else {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              },
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
              ],
            ),

      ),
    );
  }

}