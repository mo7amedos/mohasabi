import 'package:diamond_bottom_bar/diamond_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mohasabi/plans.dart';
import 'package:mohasabi/training.dart';

import 'Auth/login.dart';
import 'config/navbar.dart';
import 'config/config.dart';
import 'home.dart';
import 'info.dart';
import 'mycase.dart';
import 'myprofile.dart';

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
  Widget _selectedWidget;
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
                  child: Column(
                    children: [
                      SizedBox(height: 10,),
                      //Card
                      Container(
                        margin: EdgeInsets.only(left: 10,right: 10),
                        width: MediaQuery.of(context).size.width,
                        child: Card(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                               ListTile(
                                 onTap: (){
                                   Navigator.push(context, MaterialPageRoute(builder: (context) =>  MyCase()),);
                                 },
                                leading: Icon(Icons.notifications_active_rounded, size: 50,color: AppColors.LightGold),
                                title: Text('طلب رقم : 224588',textDirection: TextDirection.rtl),
                                subtitle: Text('توكيل عام',textDirection: TextDirection.rtl),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10,right: 10),
                        width: MediaQuery.of(context).size.width,
                        child: Card(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ListTile(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) =>  MyCase()),);
                                },
                                leading: Icon(Icons.notifications_active_rounded, size: 50,color: AppColors.LightGold),
                                title: Text('طلب رقم : 224588',textDirection: TextDirection.rtl),
                                subtitle: Text('توكيل عام',textDirection: TextDirection.rtl),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10,right: 10),
                        width: MediaQuery.of(context).size.width,
                        child: Card(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ListTile(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) =>  MyCase()),);
                                },
                                leading: Icon(Icons.notifications_active_rounded, size: 50,color: AppColors.LightGold),
                                title: Text('طلب رقم : 224588',textDirection: TextDirection.rtl),
                                subtitle: Text('توكيل عام',textDirection: TextDirection.rtl),
                              ),
                            ],
                          ),
                        ),
                      ),



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