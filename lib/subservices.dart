import 'package:diamond_bottom_bar/diamond_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mohasabi/mycase.dart';
import 'package:mohasabi/requests.dart';
import 'package:mohasabi/training.dart';

import 'Auth/login.dart';
import 'NavBar.dart';
import 'config/config.dart';
import 'home.dart';
import 'info.dart';
import 'myprofile.dart';

class SubServices extends StatefulWidget {

  @override
  State<SubServices> createState() => _SubServicesState();
}

class _SubServicesState extends State<SubServices>{
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
  int _selectedIndex = 0;
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
                  title: Text("الخدمات الفرعية" ,style: TextStyle(color: AppColors.Black,fontSize: 25, fontWeight: FontWeight.bold),),
                  centerTitle: true,
                ),
                body:  SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 10,),
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(height: 40,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                //Button
                                Column(
                                  children: [
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(shape: CircleBorder(side: BorderSide(color: AppColors.LightGold))),
                                        child: IconButton(iconSize: 120, icon: Icon (Icons.apartment_rounded,),
                                            onPressed: () =>  Navigator.push(context, MaterialPageRoute(builder: (context) => MyCase()),)
                                        )
                                    ),
                                    Text("خدمات ضرائب",style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),)
                                  ],
                                ),
                                Column(
                                  children: [
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(shape: CircleBorder(side: BorderSide(color: AppColors.LightGold))),
                                        child: IconButton(iconSize: 120, icon: Icon (Icons.apartment_rounded,),
                                            onPressed: () =>  Navigator.push(context, MaterialPageRoute(builder: (context) => MyCase()),)
                                        )
                                    ),
                                    Text("خدمات ضرائب",style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),)
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 30,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                //Button
                                Column(
                                  children: [
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(shape: CircleBorder(side: BorderSide(color: AppColors.LightGold))),
                                        child: IconButton(iconSize: 120, icon: Icon (Icons.apartment_rounded,),
                                            onPressed: () =>  Navigator.push(context, MaterialPageRoute(builder: (context) => MyCase()),)
                                        )
                                    ),
                                    Text("خدمات ضرائب",style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),)
                                  ],
                                ),
                                Column(
                                  children: [
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(shape: CircleBorder(side: BorderSide(color: AppColors.LightGold))),
                                        child: IconButton(iconSize: 120, icon: Icon (Icons.apartment_rounded,),
                                            onPressed: () =>  Navigator.push(context, MaterialPageRoute(builder: (context) => MyCase()),)
                                        )
                                    ),
                                    Text("خدمات ضرائب",style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),)
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 30,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                //Button
                                Column(
                                  children: [
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(shape: CircleBorder(side: BorderSide(color: AppColors.LightGold))),
                                        child: IconButton(iconSize: 120, icon: Icon (Icons.apartment_rounded,),
                                            onPressed: () =>  Navigator.push(context, MaterialPageRoute(builder: (context) => MyCase()),)
                                        )
                                    ),
                                    Text("خدمات ضرائب",style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),)
                                  ],
                                ),
                                Column(
                                  children: [
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(shape: CircleBorder(side: BorderSide(color: AppColors.LightGold))),
                                        child: IconButton(iconSize: 120, icon: Icon (Icons.apartment_rounded,),
                                            onPressed: () =>  Navigator.push(context, MaterialPageRoute(builder: (context) => MyCase()),)
                                        )
                                    ),
                                    Text("خدمات ضرائب",style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),)
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 30,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                //Button
                                Column(
                                  children: [
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(shape: CircleBorder(side: BorderSide(color: AppColors.LightGold))),
                                        child: IconButton(iconSize: 120, icon: Icon (Icons.apartment_rounded,),
                                            onPressed: () =>  Navigator.push(context, MaterialPageRoute(builder: (context) => MyCase()),)
                                        )
                                    ),
                                    Text("خدمات ضرائب",style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),)
                                  ],
                                ),
                                Column(
                                  children: [
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(shape: CircleBorder(side: BorderSide(color: AppColors.LightGold))),
                                        child: IconButton(iconSize: 120, icon: Icon (Icons.apartment_rounded,),
                                            onPressed: () =>  Navigator.push(context, MaterialPageRoute(builder: (context) => MyCase()),)
                                        )
                                    ),
                                    Text("خدمات ضرائب",style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),)
                                  ],
                                ),
                              ],
                            ),
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
    );  }

}