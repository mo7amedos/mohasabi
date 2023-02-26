import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diamond_bottom_bar/diamond_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mohasabi/Model/services.dart';
import 'package:mohasabi/chat/adminchat.dart';
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
              child: Scaffold(
                drawer: NavBar(),
                appBar: AppBar(
                  iconTheme: IconThemeData(color: AppColors.Black),
                  backgroundColor: AppColors.White,
                  title: Text("طلباتي" ,style: TextStyle(color: AppColors.Black,fontSize: 25, fontWeight: FontWeight.bold),),
                  centerTitle: true,
                ),
                body:  SingleChildScrollView(
                  physics: ScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(height: 10,),
                    /*  FutureBuilder(
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
                        },),*/
                      FutureBuilder(
                        future: FirebaseFirestore.instance.collection(Mohasabi.collectionMessages).get(),
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
                        },),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),

      ),
    );  }

}