import 'package:diamond_bottom_bar/diamond_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mohasabi/requests.dart';

import 'config/NavBar.dart';
import 'config/config.dart';
import 'home.dart';


class Plans extends StatefulWidget {

  @override
  State<Plans> createState() => _PlansState();
}

class _PlansState extends State<Plans>{
  void onPressed(index) {
    setState(() {
      _selectedIndex = index;
      if (index == 0) {
        Navigator.push(context, MaterialPageRoute(builder: (context) =>  Home(role: Mohasabi.sharedPreferences.getString(Mohasabi.userRole))),
        ) ;
        //in middle
      } else if (index == 1) {
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
      return await Navigator.push(context, MaterialPageRoute(builder: (context) => Home(role: Mohasabi.sharedPreferences.getString(Mohasabi.userRole))));
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
                    Icons.request_quote_rounded,
                  ],
                  selectedLightColor: AppColors.LightGold,
                  centerIcon: Icons.local_offer_rounded,
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
                      Text("صفحه العروض ",style: TextStyle(fontSize: 50),)
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