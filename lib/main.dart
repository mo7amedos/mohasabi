import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mohasabi/Auth/login.dart';
import 'package:mohasabi/config/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Mohasabi.auth = FirebaseAuth.instance;
  Mohasabi.sharedPreferences = await SharedPreferences.getInstance();
  Mohasabi.firestore = FirebaseFirestore.instance;
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,

    );
  }
}


class SplashScreen extends StatefulWidget {

  @override
  _SplashScreenState createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen> {
  @override
  // ignore: must_call_super
  void initState() {
    // TODO: implement initState

    displaySplash();
  }

  displaySplash() {
    Timer(Duration(seconds: 2), () async {
      if (await Mohasabi.auth.currentUser != null) {
        var variable = await  FirebaseFirestore.instance.collection(Mohasabi.collectionUser)
            .doc(Mohasabi.sharedPreferences.getString(Mohasabi.userUID)).get();
        Mohasabi.sharedPreferences.setString(Mohasabi.userRole, variable[Mohasabi.userRole]);
          Route route = MaterialPageRoute(builder: (_) =>  Home(role:Mohasabi.sharedPreferences.getString(Mohasabi.userRole),));
          Navigator.pushReplacement(context, route);
      } else {
        Route route = MaterialPageRoute(builder: (_) => Login());
        Navigator.pushReplacement(context, route);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: new BoxDecoration(
            color: AppColors.LightGold
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/splash.png",
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,)
            ],
          ),
        ),
      ),
    );
  }
}


