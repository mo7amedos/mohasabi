import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AppColors{
  static const Color DarkGold = const Color(0xFF8E793E);
  static const Color LightGold = const Color(0xFFAD974F);
  static const Color IntellectualGrey =const  Color(0xFF231F20);
  static const Color LightGrey = const Color(0xFFEAEAEA);
  static const Color White = const Color(0xFFFFFFFF);
  static const Color Black = const Color(0xAA000000);
}
class Names{
  static const String AppName ="محاسبي";
}
class Mohasabi{

  static SharedPreferences sharedPreferences;
  static User user;
  static FirebaseAuth auth;
  static FirebaseFirestore firestore ;

  static String collectionUser = "users";
  static String collectionAdimn = "admins";
  static String collectionServices = "services";
  static String collectionSubservices = "subservices";
  static String collectionCompanies ='companies';
  static String collectionIndividuals ='individuals';
  static String collectionRequests = "requests";
  static String collectionMessages = "messages";
  static String collectionSupport = "support";





  static final String userName = 'name';
  static final String userEmail = 'email';
  static final String userUID = 'uid';
  static final String userPhone = 'phone';
  static final String userAvatarUrl = 'url';
  static final String userRole = 'role';

}