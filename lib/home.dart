import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diamond_bottom_bar/diamond_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mohasabi/Admin/adminrequests.dart';
import 'package:mohasabi/Admin/showmainservices.dart';
import 'package:mohasabi/Admin/showsubservices.dart';
import 'package:mohasabi/Model/services.dart';
import 'package:mohasabi/config/config.dart';
import 'package:mohasabi/plans.dart';
import 'package:mohasabi/requests.dart';
import 'package:mohasabi/subservices.dart';
import 'package:mohasabi/training.dart';

import 'Admin/dataentry.dart';
import 'chat/supportrequest.dart';
import 'config/navbar.dart';

class Home extends StatefulWidget {
  final String role;

  const Home({Key key, this.role}) : super(key: key);
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
    //صفحة العميل
    if(widget.role == "customer")
    {
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
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>  SupportRequests()),
                        );
                      },
                      backgroundColor: AppColors.LightGold,
                      child: const Icon(Icons.chat_rounded,color: AppColors.White),
                    ),
                    drawer: NavBar(role: Mohasabi.sharedPreferences.getString(Mohasabi.userRole)),
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
                                                  Navigator.push(context, MaterialPageRoute(builder: (context) =>  SubServices(Id: model.idservice,)),);
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
                                                    Navigator.push(context, MaterialPageRoute(builder: (context) =>  SubServices(Id: model.idservice,)),);
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
    //صفحة التحكم
    else
      {
        return WillPopScope(
          onWillPop: showExitPopup,
          child: Scaffold(
            drawer: NavBar(role: Mohasabi.sharedPreferences.getString(Mohasabi.userRole)),
            appBar: AppBar(
              iconTheme: IconThemeData(color: AppColors.Black),
              backgroundColor: AppColors.White,
              title: Text("صفحة التحكم" ,style: TextStyle(color: AppColors.Black,fontSize: 25, fontWeight: FontWeight.bold),),
              centerTitle: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0),
                ),
              ),

            ),
            body: SingleChildScrollView(
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
                          style: ElevatedButton.styleFrom(
                              shape: CircleBorder(side: BorderSide(color: AppColors.LightGold)),
                          backgroundColor: AppColors.LightGrey),
                          child: IconButton(iconSize: 120, icon: Icon (Icons.add,color: AppColors.LightGold,)),
                        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) =>  DataEntry()),),
                      ),
                      Text("ادخال الخدمات",style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),)
                    ],
                  ),
                  Column(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: CircleBorder(side: BorderSide(color: AppColors.LightGold)),
                            backgroundColor: AppColors.LightGrey),
                        child: IconButton(iconSize: 120, icon: Icon (Icons.account_tree_rounded,color: AppColors.LightGold,)),
                        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) =>  ShowMainServices()),),
                      ),
                      Text("ادخال خدمة فرعية",style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),)
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
                            style: ElevatedButton.styleFrom(
                                shape: CircleBorder(side: BorderSide(color: AppColors.LightGold)),
                                backgroundColor: AppColors.LightGrey),
                            child: IconButton(iconSize: 120, icon: Icon (Icons.price_change_rounded,color: AppColors.LightGold,)),
                           // onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) =>  ShowSubServices()),),
                          ),
                          Text("خطط الاسعار",style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),)
                        ],
                      ),
                      Column(
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: CircleBorder(side: BorderSide(color: AppColors.LightGold)),
                                backgroundColor: AppColors.LightGrey),
                            child: IconButton(iconSize: 120, icon: Icon (Icons.notifications,color: AppColors.LightGold,)),
                            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) =>  AdminRequests()),),
                          ),
                          Text("الطلبات",style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),)
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
                            style: ElevatedButton.styleFrom(
                                shape: CircleBorder(side: BorderSide(color: AppColors.LightGold)),
                                backgroundColor: AppColors.LightGrey),
                            child: IconButton(iconSize: 120, icon: Icon (Icons.model_training_rounded,color: AppColors.LightGold,)),
                            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) =>  Training()),),
                          ),
                          Text("التدريبات",style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),)
                        ],
                      ),
                      Column(
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: CircleBorder(side: BorderSide(color: AppColors.LightGold)),
                                backgroundColor: AppColors.LightGrey),
                            child: IconButton(iconSize: 120, icon: Icon (Icons.info_outline_rounded,color: AppColors.LightGold,)),
                            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) =>  AdminRequests()),),
                          ),
                          Text("من نحن",style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),)
                        ],
                      ),
                    ],
                  ),


                ],
            ),
        ),
          )
        );
      }
  }

}