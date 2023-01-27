import 'package:diamond_bottom_bar/diamond_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mohasabi/Auth/login.dart';
import 'package:mohasabi/chat/chat.dart';
import 'package:mohasabi/config/config.dart';
import 'package:mohasabi/mycase.dart';
import 'package:mohasabi/myprofile.dart';
import 'package:mohasabi/plans.dart';
import 'package:mohasabi/requests.dart';
import 'package:mohasabi/subservices.dart';
import 'package:mohasabi/training.dart';


import 'info.dart';
import 'config/navbar.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 1;
   Widget _selectedWidget;
   //bottom bar
  void onPressed(index) {
    setState(() {
      _selectedIndex = index;
      if (index == 0) {
        Navigator.push(context, MaterialPageRoute(builder: (context) =>  Plans()),
        );
        //in middle
      } else if (index == 1) {
      }
      else if (index == 2) {
        Navigator.push(
          context, MaterialPageRoute(builder: (context) => Requests()),);
      }
    });
  }
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
                  floatingActionButton: FloatingActionButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>  Chat()),
                      );
                    },
                    backgroundColor: AppColors.LightGold,
                    child: const Icon(Icons.chat_rounded,color: AppColors.White),
                  ),
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
                    actions: [
                      IconButton(onPressed: null, icon: Icon(Icons.search_rounded,color: AppColors.Black,))
                    ],
                    iconTheme: IconThemeData(color: AppColors.Black),
                    backgroundColor: AppColors.White,
                    title: Text(Names.AppName ,style: TextStyle(color: AppColors.Black,fontSize: 25, fontWeight: FontWeight.bold),),
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
                      SingleChildScrollView(
                        child: Column(children: [

                          SizedBox(
                            height: 10,
                          ),
                          //Drop down List
                          DecoratedBox(
                              decoration: BoxDecoration(
                                  color:AppColors.LightGold, //background color of dropdown button
                                  border: Border.all(color: AppColors.DarkGold, width:3), //border of dropdown button
                                  borderRadius: BorderRadius.circular(50), //border raiuds of dropdown button
                                  boxShadow: <BoxShadow>[ //apply shadow on Dropdown button
                                    BoxShadow(
                                        color: Color.fromRGBO(0, 0, 0, 0.57), //shadow for button
                                        blurRadius: 5) //blur radius of shadow
                                  ]
                              ),

                              child:Padding(
                                  padding: EdgeInsets.only(left:30, right:30),
                                  child:DropdownButton(
                                    value: "شركة ماركو للدهانات",
                                    items: [ //add items in the dropdown
                                      DropdownMenuItem(
                                        child: Text("المصرية للتصنيع"),
                                        value: "المصرية للتصنيع",
                                      ),
                                      DropdownMenuItem(
                                          child: Text("الشركة العربية للبترول"),
                                          value: "الشركة العربية للبترول"
                                      ),
                                      DropdownMenuItem(
                                        child: Text("شركة ماركو للدهانات"),
                                        value: "شركة ماركو للدهانات",
                                      )

                                    ],
                                    onChanged: (value){ //get value when changed
                                      print("You have selected $value");
                                    },

                                    icon: Padding( //Icon at tail, arrow bottom is default icon
                                        padding: EdgeInsets.only(left:20),
                                        child:Icon(Icons.arrow_circle_down_sharp)
                                    ),
                                    iconEnabledColor: Colors.white, //Icon color
                                    style: TextStyle(  //te
                                        color: Colors.white, //Font color
                                        fontSize: 20 //font size on dropdown button
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                    dropdownColor: AppColors.LightGold, //dropdown background color
                                    underline: Container(), //remove underline
                                    isExpanded: true, //make true to make width 100%
                                  )
                              )
                          ),
                           Column(
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
                                              onPressed: () =>  Navigator.push(context, MaterialPageRoute(builder: (context) =>  SubServices()),)
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
                                                onPressed: () =>  Navigator.push(context, MaterialPageRoute(builder: (context) =>  SubServices()),)
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
                                                onPressed: () =>  Navigator.push(context, MaterialPageRoute(builder: (context) =>  SubServices()),)
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
                                                onPressed: () =>  Navigator.push(context, MaterialPageRoute(builder: (context) =>  SubServices()),)
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
                                                onPressed: () =>  Navigator.push(context, MaterialPageRoute(builder: (context) =>  SubServices()),)
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
                                                onPressed: () =>  Navigator.push(context, MaterialPageRoute(builder: (context) =>  SubServices()),)
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
                                                onPressed: () =>  Navigator.push(context, MaterialPageRoute(builder: (context) =>  SubServices()),)
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
                                                onPressed: () =>  Navigator.push(context, MaterialPageRoute(builder: (context) =>  SubServices()),)
                                            )
                                        ),
                                        Text("خدمات ضرائب",style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),)
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),

                        ],),
                      ),
                      //افراد
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(height: 10,),
                            //Drop down List
                            DecoratedBox(
                                decoration: BoxDecoration(
                                    color:AppColors.LightGold, //background color of dropdown button
                                    border: Border.all(color: AppColors.DarkGold, width:3), //border of dropdown button
                                    borderRadius: BorderRadius.circular(50), //border raiuds of dropdown button
                                    boxShadow: <BoxShadow>[ //apply shadow on Dropdown button
                                      BoxShadow(
                                          color: Color.fromRGBO(0, 0, 0, 0.57), //shadow for button
                                          blurRadius: 5) //blur radius of shadow
                                    ]
                                ),

                                child:Padding(
                                    padding: EdgeInsets.only(left:30, right:30),
                                    child:DropdownButton(
                                      value: "عيادة دكتور احمد",
                                      items: [ //add items in the dropdown
                                        DropdownMenuItem(
                                          child: Text("عيادة دكتور احمد"),
                                          value: "عيادة دكتور احمد",
                                        ),
                                        DropdownMenuItem(
                                            child: Text("محل النجمة"),
                                            value: "محل النجمة"
                                        ),
                                        DropdownMenuItem(
                                          child: Text("عطاره الشمس"),
                                          value: "عطاره الشمس",
                                        )

                                      ],
                                      onChanged: (value){ //get value when changed
                                        print("You have selected $value");
                                      },

                                      icon: Padding( //Icon at tail, arrow bottom is default icon
                                          padding: EdgeInsets.only(left:20),
                                          child:Icon(Icons.arrow_circle_down_sharp)
                                      ),
                                      iconEnabledColor: Colors.white, //Icon color
                                      style: TextStyle(  //te
                                          color: Colors.white, //Font color
                                          fontSize: 20 //font size on dropdown button
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                      dropdownColor: AppColors.LightGold, //dropdown background color
                                      underline: Container(), //remove underline
                                      isExpanded: true, //make true to make width 100%
                                    )
                                )
                            ),
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
                                            onPressed: () =>  Navigator.push(context, MaterialPageRoute(builder: (context) =>  SubServices()),)
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
                                            onPressed: () =>  Navigator.push(context, MaterialPageRoute(builder: (context) =>  SubServices()),)
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
                                            onPressed: () =>  Navigator.push(context, MaterialPageRoute(builder: (context) =>  SubServices()),)
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
                                            onPressed: () =>  Navigator.push(context, MaterialPageRoute(builder: (context) =>  SubServices()),)
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
                                            onPressed: () =>  Navigator.push(context, MaterialPageRoute(builder: (context) =>  SubServices()),)
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
                                            onPressed: () =>  Navigator.push(context, MaterialPageRoute(builder: (context) =>  SubServices()),)
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
                                            onPressed: () =>  Navigator.push(context, MaterialPageRoute(builder: (context) =>  SubServices()),)
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
                                            onPressed: () =>  Navigator.push(context, MaterialPageRoute(builder: (context) =>  SubServices()),)
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
    );
  }

}