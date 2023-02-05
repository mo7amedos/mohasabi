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


import 'info.dart';
import 'config/navbar.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 1;
  String _selectedValueCompany,_selectedValueIndividual ;

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
                      //شركات
                      SingleChildScrollView(
                        child: Column(children: [

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
                                  child:FutureBuilder<QuerySnapshot>(
                                    future: FirebaseFirestore.instance.collection(Mohasabi.collectionUser).
                                    doc(Mohasabi.sharedPreferences.getString(Mohasabi.userUID)).
                                    collection(Mohasabi.collectionCompanies).get(),
                                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                      if (snapshot.hasData) {
                                        List<DropdownMenuItem> dropdownItems = [];
                                        for (int i = 0; i < snapshot.data.docs.length; i++) {
                                          CompanyModel model =CompanyModel.fromJson(snapshot.data.docs[i].data());
                                          //DocumentSnapshot document = snapshot.data.docs[i];
                                          dropdownItems.add(
                                            DropdownMenuItem(
                                              child: Text(model.name),
                                              value: model.id,
                                            ),
                                          );
                                        }

                                        return DropdownButton(
                                          value: _selectedValueCompany,
                                          items: dropdownItems,
                                          onChanged: (value){ //get value when changed
                                            setState(() {
                                              _selectedValueCompany = value;
                                            });
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
                                        );
                                      } else {
                                        return CircularProgressIndicator();
                                      }
                                    },
                                  )

                              )
                          ),
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
                            //Drop down List
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
                                    child:FutureBuilder<QuerySnapshot>(
                                      future: FirebaseFirestore.instance.collection(Mohasabi.collectionUser).doc(Mohasabi.sharedPreferences.getString(Mohasabi.userUID)).collection(Mohasabi.collectionIndividuals).get(),
                                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                        if (snapshot.hasData) {
                                          List<DropdownMenuItem> dropdownItems = [];
                                          for (int i = 0; i < snapshot.data.docs.length; i++) {
                                            CompanyModel model =CompanyModel.fromJson(snapshot.data.docs[i].data());
                                            //DocumentSnapshot document = snapshot.data.docs[i];
                                            dropdownItems.add(
                                              DropdownMenuItem(
                                                child: Text(model.name),
                                                value: model.id,
                                              ),
                                            );
                                          }

                                          return DropdownButton(
                                            value: _selectedValueIndividual,
                                            items: dropdownItems,
                                            onChanged: (value){ //get value when changed
                                              setState(() {
                                                _selectedValueIndividual = value;
                                              });
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
                                          );
                                        } else {
                                          return CircularProgressIndicator();
                                        }
                                      },
                                    )

                                )
                            ),
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
                                              ElevatedButton(
                                                  style: ElevatedButton.styleFrom(shape: CircleBorder(side: BorderSide(color: AppColors.LightGold))),
                                                  child: IconButton(iconSize: 120, icon: Icon (Icons.apartment_rounded,),
                                                      onPressed: () =>  Navigator.push(context, MaterialPageRoute(builder: (context) =>  SubServices()),)
                                                  )
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