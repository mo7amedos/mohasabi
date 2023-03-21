import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diamond_bottom_bar/diamond_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mohasabi/Admin/addserviceinfo.dart';
import 'package:mohasabi/Admin/showmainservices.dart';
import 'package:mohasabi/Auth/login.dart';
import 'package:mohasabi/Model/services.dart';
import 'package:mohasabi/chat/chat.dart';
import 'package:mohasabi/config/config.dart';
import 'package:mohasabi/mycase.dart';
import 'package:mohasabi/Auth/myprofile.dart';
import 'package:mohasabi/plans.dart';
import 'package:mohasabi/requests.dart';
import 'package:mohasabi/subservices.dart';
import 'package:mohasabi/training.dart';


import '../config/NavBar.dart';
import 'addsubservices.dart';

class ShowSubServices extends StatefulWidget {
  final String ID ;
  final ServicesModel model;

  const ShowSubServices({Key key, this.ID, this.model}) : super(key: key);
  @override
  State<ShowSubServices> createState() => _ShowSubServicesState();
}

class _ShowSubServicesState extends State<ShowSubServices> {
  @override
  Widget build(BuildContext context) {
    Future<bool> _back() async {
      return await Navigator.push(context, MaterialPageRoute(builder: (context) => ShowMainServices()));
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
                  title: Text("اختار الخدمة المراد اضافة تفاصيلها" ,style: TextStyle(color: AppColors.Black,fontSize: 15, fontWeight: FontWeight.bold),),
                  centerTitle: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0),
                    ),
                  ),
                ),
                body:  SingleChildScrollView(
                  child: Column(
                    children: [
                    SizedBox(height: 10,),
                    //الخدمات
                    FutureBuilder<QuerySnapshot>(
                      future: FirebaseFirestore.instance.collection(Mohasabi.collectionServices).
                      doc(widget.ID).collection(Mohasabi.collectionSubservices).get(),
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
                                          Navigator.push(context,
                                            MaterialPageRoute(builder: (context) =>  AddServiceInfo(model: widget.model,idsub:model.idsubservice)),);
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
              ),
            )
          ],
        ),

      ),
    );
  }

}