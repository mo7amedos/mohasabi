import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mohasabi/Admin/adminrequests.dart';
import 'package:mohasabi/Admin/dataentry.dart';
import 'package:mohasabi/Admin/showmainservices.dart';
import 'package:mohasabi/config/config.dart';
import 'package:mohasabi/home.dart';
import 'package:mohasabi/Auth/myprofile.dart';
import 'package:mohasabi/requests.dart';
import 'package:mohasabi/training.dart';

import '../Auth/login.dart';
import '../info.dart';


class NavBar extends StatelessWidget {
  final String role;

  const NavBar({Key key, this.role}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if(role == "customer")
    {
      return Drawer(
        child: ListView(
          // Remove padding
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(Mohasabi.sharedPreferences.getString(Mohasabi.userName)),
              accountEmail: Text(Mohasabi.sharedPreferences.getString(Mohasabi.userEmail)),
              currentAccountPicture: CircleAvatar(
                backgroundImage: Mohasabi.sharedPreferences.getString(Mohasabi.userAvatarUrl)==null ?
                AssetImage('assets/images/icon.png')
                    :NetworkImage(Mohasabi.sharedPreferences.getString(Mohasabi.userAvatarUrl),),
              ),
              decoration: BoxDecoration(
                color: AppColors.White,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/cover.jpg')
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home_rounded,color: AppColors.LightGold),
              title: Text('الصفحة الرئيسيه'),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) =>  Home(role: Mohasabi.sharedPreferences.getString(Mohasabi.userRole),)),),
            ),
            ListTile(
              leading: Icon(Icons.account_circle_rounded,color: AppColors.LightGold),
              title: Text('البيانات الشخصية'),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) =>  MyProfile(tabNo: 0,)),),
            ),
            ListTile(
              leading: Icon(Icons.notifications,color: AppColors.LightGold),
              title: Text('طلباتي'),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) =>  Requests()),),
            ),
            ListTile(
              leading: Icon(Icons.model_training_rounded,color: AppColors.LightGold),
              title: Text('تدريبات'),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) =>  Training()),),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.settings,color: AppColors.LightGold),
              title: Text('الاعدادات'),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) =>  DataEntry()),),
            ),
            ListTile(
              leading: Icon(Icons.description,color: AppColors.LightGold),
              title: Text('من نحن ؟'),
              onTap: () =>  Navigator.push(context, MaterialPageRoute(builder: (context) =>  Info()),),
            ),
            ListTile(
              leading: Icon(Icons.contact_phone_rounded,color: AppColors.LightGold),
              title: Text('تواصل معنا'),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) =>  AdminRequests()),),
            ),

            Divider(),
            ListTile(
              title: Text('الخروج'),
              leading: Icon(Icons.exit_to_app,color: AppColors.LightGold),
              onTap: () => showDialog(context: context,
                builder: (context)=> AlertDialog(
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
              ),
            ),
            ListTile(
                title: Text('تسجيل خروج'),
                leading: Icon(Icons.logout_rounded,color: AppColors.LightGold),
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  Mohasabi.sharedPreferences.clear();
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  Login()),);
                }

            ),

          ],
        ),
      );
    }
    //Admin
    else{
      return Drawer(
        child: ListView(
          // Remove padding
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(Mohasabi.sharedPreferences.getString(Mohasabi.userName)),
              accountEmail: Text(Mohasabi.sharedPreferences.getString(Mohasabi.userEmail)),
              currentAccountPicture: CircleAvatar(
                backgroundImage: Mohasabi.sharedPreferences.getString(Mohasabi.userAvatarUrl)==null ?
                AssetImage('assets/images/icon.png')
                    :NetworkImage(Mohasabi.sharedPreferences.getString(Mohasabi.userAvatarUrl),),
              ),
              decoration: BoxDecoration(
                color: AppColors.White,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/cover.jpg')
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home_rounded,color: AppColors.LightGold),
              title: Text('الصفحة الرئيسيه'),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) =>  Home(role: Mohasabi.sharedPreferences.getString(Mohasabi.userRole),)),),
            ),
            ListTile(
              leading: Icon(Icons.notifications,color: AppColors.LightGold),
              title: Text('الطلبات'),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) =>  AdminRequests()),),
            ),
            ListTile(
              leading: Icon(Icons.model_training_rounded,color: AppColors.LightGold),
              title: Text('تدريبات'),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) =>  Training()),),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.add,color: AppColors.LightGold),
              title: Text('ادخال الخدمات رئيسية'),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) =>  DataEntry()),),
            ),
            ListTile(
              leading: Icon(Icons.account_tree_rounded,color: AppColors.LightGold),
              title: Text('ادخال الخدمات فرعية'),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) =>  ShowMainServices()),),
            ),
            ListTile(
              leading: Icon(Icons.description,color: AppColors.LightGold),
              title: Text('من نحن ؟'),
              onTap: () =>  Navigator.push(context, MaterialPageRoute(builder: (context) =>  Info()),),
            ),

            Divider(),
            ListTile(
              title: Text('الخروج'),
              leading: Icon(Icons.exit_to_app,color: AppColors.LightGold),
              onTap: () => showDialog(context: context,
                builder: (context)=> AlertDialog(
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
              ),
            ),
            ListTile(
                title: Text('تسجيل خروج'),
                leading: Icon(Icons.logout_rounded,color: AppColors.LightGold),
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  Mohasabi.sharedPreferences.clear();
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  Login()),);
                }

            ),

          ],
        ),
      );

    }

  }
}