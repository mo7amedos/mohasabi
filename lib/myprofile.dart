import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diamond_bottom_bar/diamond_bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mohasabi/DialogBox/loadingDialog.dart';
import 'package:mohasabi/addcompany.dart';
import 'package:mohasabi/plans.dart';
import 'package:mohasabi/requests.dart';
import 'package:mohasabi/training.dart';
import 'package:mohasabi/widgets/custom_button.dart';

import 'Auth/login.dart';
import 'widgets/customTextField.dart';
import 'config/navbar.dart';
import 'config/config.dart';
import 'home.dart';
import 'info.dart';

class MyProfile extends StatefulWidget {

  @override
  State<MyProfile> createState() => _MyProfileState();
}
final TextEditingController _nameTextEditingController = TextEditingController();
final TextEditingController _mobileTextEditingController = TextEditingController();
final TextEditingController _emailTextEditingController = TextEditingController();
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
  GlobalKey<FormState> _myinfoformKey = GlobalKey<FormState>();

  bool addCompany = false;
  int _selectedIndex = 1;
  @override
  Widget build(BuildContext context) {

    setState(() {
      _nameTextEditingController..text=Mohasabi.sharedPreferences.getString(Mohasabi.userName);
      _mobileTextEditingController..text=Mohasabi.sharedPreferences.getString(Mohasabi.userPhone);
      _emailTextEditingController..text=Mohasabi.sharedPreferences.getString(Mohasabi.userEmail);
    });
    var size = MediaQuery.of(context).size;
    String _name,_mobile,_email;

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
                      //بياناتي
                      SingleChildScrollView(
                  child: Form(
                    key: _myinfoformKey,
                    child: Column(
                            children: [
                              //الصورة
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: double.infinity,
                                  height: size.height * 0.18,
                                  child: CircleAvatar(
                                    backgroundColor: AppColors.DarkGold,
                                    radius: 150,
                                    child: CircleAvatar(
                                      radius: 70,
                                      backgroundImage: NetworkImage(Mohasabi.sharedPreferences.getString(Mohasabi.userAvatarUrl)
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              //الاسم
                              CustomTextField(controller: _nameTextEditingController,icon: Icons.person_outline_rounded,hintText: "الاسم",onsave: _name),

                              //الهاتف
                              CustomTextField(controller: _mobileTextEditingController,icon: Icons.phone,hintText: "الهاتف",onsave: _mobile),

                              //الايميل
                              CustomTextField(controller: _emailTextEditingController,icon: Icons.email_rounded,hintText: "البريد الالكتروني",onsave: _email),

                              //تحديث
                              CustomButton(onPress: (){
                                if(_myinfoformKey.currentState.validate()){
                                  _myinfoformKey.currentState.save();
                                  updateUserInfoToFirestore();
                                }
                              },text: "تحديث",)
                            ],
                          ),
                  ),
                      ),
                      //شركات
                      Scaffold(
                        floatingActionButton: FloatingActionButton(
                            heroTag: 'uniqueTag',
                            backgroundColor: AppColors.LightGold,
                            child: addCompany==false? Icon(Icons.add,color: AppColors.White):Icon(Icons.account_balance_sharp,color: AppColors.White),
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => AddCompany(),));
                            }
                        ),
                      ),
                      //افراد
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

  Future updateUserInfoToFirestore() async {
    FirebaseFirestore.instance.collection("users").doc(Mohasabi.sharedPreferences.getString(Mohasabi.userUID)).update({
      "email": _emailTextEditingController.text.toString(),
      "name": _nameTextEditingController.text.toString(),
      "phone":_mobileTextEditingController.text.trim(),
    });
    await Mohasabi.sharedPreferences.setString(Mohasabi.userEmail, _emailTextEditingController.text.toString());
    await Mohasabi.sharedPreferences.setString(Mohasabi.userName, _nameTextEditingController.text.trim());
    await Mohasabi.sharedPreferences.setString(Mohasabi.userPhone, _mobileTextEditingController.text.trim());
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("تم التحديث بنجاح"),));

  }
}