import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diamond_bottom_bar/diamond_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mohasabi/Model/services.dart';
import 'package:mohasabi/plans.dart';

import 'config/navbar.dart';
import 'config/config.dart';
import 'home.dart';
import 'mycase.dart';

class Requests extends StatefulWidget {
  @override
  State<Requests> createState() => _RequestsState();
}

class _RequestsState extends State<Requests>{
  void onPressed(index) {
    setState(() {
      _selectedIndex = index;
      if (index == 0) {
        Navigator.push(context, MaterialPageRoute(builder: (context) =>  Home()),
        );
        //in middle
      } else if (index == 1) {
      }
      else if (index == 2) {
        Navigator.push(context, MaterialPageRoute(builder: (context) =>  Plans()),);
      }
    });
  }
  int _selectedIndex = 1;
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
                bottomNavigationBar: DiamondBottomNavigation(
                  selectedColor: AppColors.LightGold,
                  unselectedColor: AppColors.Black,
                  itemIcons: const [
                    Icons.home_rounded,
                    Icons.local_offer_rounded,
                  ],
                  selectedLightColor: AppColors.LightGold,
                  centerIcon: Icons.request_quote_rounded,
                  selectedIndex: _selectedIndex,
                  onItemPressed: onPressed,
                ),
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
                      FutureBuilder(
                        future: FirebaseFirestore.instance.collection(Mohasabi.collectionUser).
                      doc(Mohasabi.sharedPreferences.getString(Mohasabi.userUID)).collection(Mohasabi.collectionRequests).orderBy("publishedDate",descending: false).get(),
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
                                            Navigator.push(context, MaterialPageRoute(builder: (context) =>  MyCase(requestmodel:model)),);
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
              ),
            )
          ],
        ),

      ),
    );  }

}