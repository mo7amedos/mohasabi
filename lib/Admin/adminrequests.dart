import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diamond_bottom_bar/diamond_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mohasabi/Model/services.dart';
import 'package:mohasabi/chat/adminchat.dart';
import 'package:mohasabi/chat/adminsupportchat.dart';
import 'package:mohasabi/plans.dart';

import '../chat/chat.dart';
import '../config/NavBar.dart';
import '../config/config.dart';
import '../home.dart';


class AdminRequests extends StatefulWidget {
  @override
  State<AdminRequests> createState() => _AdminRequestsState();
}

class _AdminRequestsState extends State<AdminRequests>{
  @override
  Widget build(BuildContext context) {
    Future<bool> _back() async {
      return await Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
    }
    return WillPopScope(
      onWillPop: _back,
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child:DefaultTabController(
                initialIndex: 0,
                length: 2,
                child:  Scaffold(
                  drawer: NavBar(),
                  appBar: AppBar(
                    iconTheme: IconThemeData(color: AppColors.Black),
                    backgroundColor: AppColors.White,
                    title: Text("صفحه التحكم" ,style: TextStyle(color: AppColors.Black,fontSize: 25, fontWeight: FontWeight.bold),),
                    centerTitle: true,
                    bottom: const TabBar(
                      indicator: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10)),
                          color: AppColors.LightGold),
                      tabs: <Widget>[
                        Tab(
                          child: Text("طلبات",style: TextStyle(color: AppColors.Black,fontSize: 15,fontWeight: FontWeight.bold),),
                        ),
                        Tab(
                          child: Text("الدعم",style: TextStyle(color: AppColors.Black,fontSize: 15,fontWeight: FontWeight.bold),),
                        ),

                      ],
                    ),

                  ),
                  body:  TabBarView(
                    children: [
                      //الطلبات
                      SingleChildScrollView(
                        physics: ScrollPhysics(),
                        child: Column(
                          children: [
                            SizedBox(height: 10,),
                            FutureBuilder(
                              future: FirebaseFirestore.instance.collection(Mohasabi.collectionRequests).orderBy("publishedDate",descending: false).get(),
                              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (snapshot.hasData) {
                                  return ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: snapshot.data.docs.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      RequestModel model = RequestModel.fromJson(snapshot.data.docs[index].data());
                                      return  Container(
                                        margin: EdgeInsets.only(left: 10,right: 10),
                                        width: MediaQuery.of(context).size.width,
                                        child: Card(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              ListTile(
                                                onTap: (){
                                                  Navigator.push(context, MaterialPageRoute(builder: (context) =>  AdminChat(requestmodel:model)),);
                                                },
                                                leading: Icon(Icons.notifications_active_rounded, size: 50,color: AppColors.LightGold),
                                                title: Text('طلب رقم :'+model.requestid,textDirection: TextDirection.rtl),
                                                subtitle: Text(model.title,textDirection: TextDirection.rtl),
                                              ),
                                            ],
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
                              },),
                          ],
                        ),
                      ),
                      //الدعم
                      SingleChildScrollView(
                        physics: ScrollPhysics(),
                        child: Column(
                          children: [
                            SizedBox(height: 10,),
                            FutureBuilder(
                              future: FirebaseFirestore.instance.collection(Mohasabi.collectionSupportMessages).get(),
                              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (snapshot.hasData) {
                                  return ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: snapshot.data.docs.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      MessageSupportModel model = MessageSupportModel.fromJson(snapshot.data.docs[index].data());
                                      return  Container(
                                        margin: EdgeInsets.only(left: 10,right: 10),
                                        width: MediaQuery.of(context).size.width,
                                        child: Card(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              ListTile(
                                                onTap: (){
                                                  Navigator.push(context, MaterialPageRoute(builder: (context) =>  AdminSupportChat(messageSupportModel:model)),);
                                                },
                                                leading: Icon(Icons.notifications_active_rounded, size: 50,color: AppColors.LightGold),
                                                title: Text('طلب رقم :'+model.chatid,textDirection: TextDirection.rtl),
                                                subtitle: Text(model.customername,textDirection: TextDirection.rtl),
                                              ),
                                            ],
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
                              },),
                            /*FutureBuilder(
                    future: FirebaseFirestore.instance.collection(Mohasabi.collectionRequests).get(),
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data.docs.length,
                          itemBuilder: (BuildContext context, int index) {
                            Messages model = Messages.fromJson(snapshot.data.docs[index].data());
                            return  Container(
                              margin: EdgeInsets.only(left: 10,right: 10),
                              width: MediaQuery.of(context).size.width,
                              child: Card(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    ListTile(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context) =>  Chat()),);
                                      },
                                      leading: Icon(Icons.chat_rounded, size: 50,color: AppColors.LightGold),
                                      title: Text('طلب دعم',textDirection: TextDirection.rtl),
                                      subtitle: Text("",textDirection: TextDirection.rtl),
                                    ),
                                  ],
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
                    },),*/
                          ],
                        ),
                      ),
                    ],
                  )
                )
              )
            )
          ],
        ),

      ),
    );  }

}