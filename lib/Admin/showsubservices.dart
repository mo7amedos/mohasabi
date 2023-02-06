import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diamond_bottom_bar/diamond_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mohasabi/Auth/login.dart';
import 'package:mohasabi/Model/services.dart';
import 'package:mohasabi/chat/chat.dart';
import 'package:mohasabi/config/config.dart';
import 'package:mohasabi/mycase.dart';
import 'package:mohasabi/myprofile.dart';
import 'package:mohasabi/plans.dart';
import 'package:mohasabi/requests.dart';
import 'package:mohasabi/subservices.dart';
import 'package:mohasabi/training.dart';


import '../config/NavBar.dart';
import 'addsubservices.dart';

class ShowSubServices extends StatefulWidget {
  @override
  State<ShowSubServices> createState() => _ShowSubServicesState();
}

class _ShowSubServicesState extends State<ShowSubServices> {
  int _selectedIndex = 1;
  String _selectedValueCompany,_selectedValueIndividual ;

  Widget _selectedWidget;

  @override
  Widget build(BuildContext context) {
    Future<bool> showExitPopup() async {
      return await showDialog( //show confirm dialogue
        //the return value will be from "Yes" or "No" options
        context: context,
        builder: (context) => AlertDialog(
          title: Text('الخروج',textDirection: TextDirection.rtl),
          content: Text('هل تريد الخروج من التطبيق',textDirection: TextDirection.rtl),
          actions:[
            ElevatedButton(
              onPressed: () => SystemNavigator.pop(),

              style: ElevatedButton.styleFrom(backgroundColor: AppColors.DarkGold),
              //return false when click on "NO"
              child:Text('نعم'),
            ),

            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(false),
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.LightGold),

              //return true when click on "Yes"
              child:Text('لا'),
            ),

          ],
        ),
      )??false; //if showDialouge had returned null, then return false
    }
    return WillPopScope(
      onWillPop: showExitPopup,
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
                    title: Text("عرض الخدمات فرعية" ,style: TextStyle(color: AppColors.Black,fontSize: 25, fontWeight: FontWeight.bold),),
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