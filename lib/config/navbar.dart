import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mohasabi/config/config.dart';
import 'package:mohasabi/home.dart';
import 'package:mohasabi/myprofile.dart';
import 'package:mohasabi/requests.dart';
import 'package:mohasabi/training.dart';

import '../info.dart';


class NavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) =>  Home()),),
          ),
          ListTile(
            leading: Icon(Icons.account_circle_rounded,color: AppColors.LightGold),
            title: Text('البيانات الشخصية'),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) =>  MyProfile()),),
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
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.description,color: AppColors.LightGold),
            title: Text('من نحن ؟'),
            onTap: () =>  Navigator.push(context, MaterialPageRoute(builder: (context) =>  Info()),),
          ),
          ListTile(
            leading: Icon(Icons.contact_phone_rounded,color: AppColors.LightGold),
            title: Text('تواصل معنا'),
            onTap: () => null

          ),
          Divider(),
          ListTile(
            title: Text('الخروج'),
            leading: Icon(Icons.exit_to_app,color: AppColors.LightGold),
            onTap: () => showDialog(context: context,
                builder: (context)=> AlertDialog(
                  title: Text('Exit App'),
                  content: Text('Do you want to exit an App?'),
                  actions: [
                    ElevatedButton(onPressed: () => Navigator.of(context).pop(false), child:Text('No'),),
                    ElevatedButton(onPressed: () => SystemNavigator.pop(), child:Text('Yes'),)

                  ],
                )
            ),
          ),
        ],
      ),
    );
  }
}