import 'package:diamond_bottom_bar/diamond_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mohasabi/plans.dart';
import 'package:mohasabi/requests.dart';
import 'package:mohasabi/training.dart';

import 'Auth/login.dart';
import 'config/navbar.dart';
import 'config/config.dart';
import 'home.dart';
import 'info.dart';

class MyProfile extends StatefulWidget {

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile>{
  void onPressed(index) {
    setState(() {
      _selectedIndex = index;
      if (index == 0) {
        Navigator.push(context, MaterialPageRoute(builder: (context) =>  Plans()),
        ) as Widget;
        //in middle
      } else if (index == 1) {
        Navigator.push(context, MaterialPageRoute(builder: (context) =>  Home()),);
      }//in middle
      else if (index == 2) {
        Navigator.push(context, MaterialPageRoute(builder: (context) =>  Requests()),);
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
              child: DefaultTabController(
                initialIndex: 0,
                length: 3,
                child: Scaffold(
                  drawer: NavBar(),
                  bottomNavigationBar: DiamondBottomNavigation(
                    selectedColor: AppColors.LightGold,
                    unselectedColor: AppColors.Black,
                    itemIcons: const [
                      Icons.local_offer_rounded,
                      Icons.request_quote_rounded,
                    ],
                    selectedLightColor: AppColors.LightGold,
                    centerIcon: Icons.home_rounded,
                    selectedIndex: _selectedIndex,
                    onItemPressed: onPressed,
                  ),
                  appBar: AppBar(
                    iconTheme: IconThemeData(color: AppColors.Black),
                    backgroundColor: AppColors.White,
                    title: Text(Names.AppName ,style: TextStyle(color: AppColors.Black,fontSize: 25, fontWeight: FontWeight.bold),),
                    centerTitle: true,
                    bottom: const TabBar(
                      indicator: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10)),
                          color: AppColors.LightGold),
                      tabs: <Widget>[
                        Tab(
                          child: Text("بياناتي",style: TextStyle(color: AppColors.Black,fontSize: 15,fontWeight: FontWeight.bold),),
                        ),
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
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(height: 40,),
                            Text("صفحه الملف الشخصي",style: TextStyle(fontSize: 50),)

                          ],
                        ),
                      ),
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(height: 40,),
                            Text("لا يوجد شركات",style: TextStyle(fontSize: 50),)

                          ],
                        ),
                      ),
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(height: 40,),
                            Text("لا يوجد افراد",style: TextStyle(fontSize: 50),)

                          ],
                        ),
                      ),
                    ],
                  )
                ),
              ),
            )
          ],
        ),

      ),
    );  }

}