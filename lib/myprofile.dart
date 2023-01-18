import 'package:diamond_bottom_bar/diamond_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mohasabi/requests.dart';
import 'package:mohasabi/training.dart';

import 'Auth/login.dart';
import 'NavBar.dart';
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
        Navigator.push(context, MaterialPageRoute(builder: (context) =>  Home()),
        ) as Widget;
      } else if (index == 1) {
        Navigator.push(context, MaterialPageRoute(builder: (context) =>  Training()),);
      }//in middle
      else if (index == 2) {
        Navigator.push(context, MaterialPageRoute(builder: (context) =>  Info()),);
      }else if (index == 3) {
        Navigator.push(context, MaterialPageRoute(builder: (context) =>  Requests()),);
      }
      else if (index == 4) {
        Navigator.push(context, MaterialPageRoute(builder: (context) =>  MyProfile()),);
      }
    });
  }
  int _selectedIndex = 4;
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
                    Icons.model_training_rounded,
                    Icons.request_quote_rounded,
                    Icons.account_circle_rounded,

                  ],
                  selectedLightColor: AppColors.LightGold,
                  centerIcon: Icons.info_rounded,
                  selectedIndex: _selectedIndex,
                  onItemPressed: onPressed,
                ),
                appBar: AppBar(
                  iconTheme: IconThemeData(color: AppColors.Black),
                  backgroundColor: AppColors.White,
                  title: Text(Names.AppName ,style: TextStyle(color: AppColors.Black,fontSize: 25, fontWeight: FontWeight.bold),),
                  centerTitle: true,
                ),
                body:  SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 40,),
                      Text("صفحه الملف الشخصي",style: TextStyle(fontSize: 50),)

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