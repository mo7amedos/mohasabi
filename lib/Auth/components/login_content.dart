import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:mohasabi/Auth/signup.dart';
import 'package:mohasabi/home.dart';
import 'package:mohasabi/plans.dart';
import 'package:mohasabi/training.dart';

import '../../DialogBox/errorDialog.dart';
import '../../DialogBox/loadingDialog.dart';
import '../../config/config.dart';
import '../../myprofile.dart';
import '../utils/constants.dart';
import '../utils/helper_functions.dart';
import '../animations/change_screen_animation.dart';
import 'bottom_text.dart';
import 'top_text.dart';

enum Screens {
  createAccount,
  welcomeBack,
}
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
final TextEditingController _emailTextEditingController = TextEditingController();
final TextEditingController _passwordTextEditingController = TextEditingController();
FirebaseAuth _auth = FirebaseAuth.instance;


class LoginContent extends StatefulWidget {
  const LoginContent({Key key}) : super(key: key);
  @override
  State<LoginContent> createState() => _LoginContentState();
}

class _LoginContentState extends State<LoginContent>
    with TickerProviderStateMixin {
  String _email, _password;

  List<Widget> createAccountContent;
  List<Widget> loginContent;

  _LoginContentState();

  /* Widget inputField(String hint, IconData iconData) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 8),
        child: SizedBox(
          height: 50,
          child: Material(
            elevation: 8,
            shadowColor: Colors.black87,
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(30),
            child: TextFormField(
              textDirection: TextDirection.rtl,
              textAlignVertical: TextAlignVertical.bottom,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
                hintText: hint,
                prefixIcon: Icon(iconData),

              ),
              validator: (input) {
                if (input.isEmpty) {
                  return hint;
                }
              },
              onSaved: (input) => _password = input,
            ),
            ),
          ),
        ),
      ),
    );
  }*/
  Widget inputEmail(){
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 8),
        child: SizedBox(
          height: 50,
          child: Material(
            elevation: 8,
            shadowColor: Colors.black87,
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(30),
            child: TextFormField(
              controller: _emailTextEditingController,
              keyboardType: TextInputType.emailAddress,
              textAlignVertical: TextAlignVertical.bottom,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
                hintText: "البريد الاكتروني",
                prefixIcon: Icon(Icons.email_rounded,color: AppColors.LightGold,),
              ),
              validator: (input) {
                if (input.isEmpty) {
                  return 'من فضلك ادخل كلمة المرور';
                }
              },
              onSaved: (input) => _email = input,
            ),
          ),
        ),
      ),

    );
  }

  Widget inputPassword() {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 8),
        child: SizedBox(
          height: 50,
          child: Material(
            elevation: 8,
            shadowColor: Colors.black87,
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(30),
            child: TextFormField(
              controller: _passwordTextEditingController,
              obscureText: true,
              textAlignVertical: TextAlignVertical.bottom,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
                hintText: "كلمة المرور",
                prefixIcon: Icon(Icons.lock_outline_rounded,color: AppColors.LightGold,),

              ),
              validator: (input) {
                if (input.isEmpty) {
                  return 'من فضلك ادخل كلمة المرور';
                }
              },
              onSaved: (input) => _password = input,
            ),
          ),
        ),
      ),

    );
  }

  Widget loginButton(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 90, vertical: 16),
      child: ElevatedButton(
        onPressed: () {
          if (title == "انشاء حساب") {
            if( _emailTextEditingController.text.isNotEmpty &&
                _passwordTextEditingController.text.isNotEmpty)
            {
              if(EmailValidator.validate(_emailTextEditingController.text.trim())){
                signUp();
              }else{
                showDialog(
                    context: context,
                    builder: (C) {
                      return ErrorAlertDialog(
                        message: "من فضلك ادخلك بريدك الاكتروني صحيح",
                      );
                    });
              }
            }else {
              showDialog(
                context: context,
                builder: (C) {
                  return ErrorAlertDialog(
                    message: "من فضلك ادخلك بريدك الاكتروني و كلمه المرور",
                  );
                });
            }



          }
          else if (title == "تسجيل دخول") {
            _emailTextEditingController.text.isNotEmpty &&
                _passwordTextEditingController.text.isNotEmpty
                ? loginUser()
                : showDialog(
                context: context,
                builder: (C) {
                  return ErrorAlertDialog(
                    message: "من فضلك ادخلك بريدك الاكتروني و كلمه المرور",
                  );
                });

          }
          else if (title == "التدريبات") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Training()),
            );
          };
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: const StadiumBorder(),
          primary: kSecondaryColor,
          elevation: 8,
          shadowColor: Colors.black87,
        ),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget loginGuestButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 135, vertical: 16),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Training()),
          );
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: const StadiumBorder(),
          primary: kSecondaryColor,
          elevation: 8,
          shadowColor: Colors.black87,
        ),
        child: Text(
          "التدريبات",
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget orDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 130, vertical: 8),
      child: Row(
        children: [
          Flexible(
            child: Container(
              height: 1,
              color: kPrimaryColor,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'او',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Flexible(
            child: Container(
              height: 1,
              color: kPrimaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget logos() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/facebook.png'),
          const SizedBox(width: 24),
          Image.asset('assets/images/google.png'),
        ],
      ),
    );
  }

  Widget forgotPassword() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 110),
      child: TextButton(
        onPressed: () {},
        child: const Text(
          'هل نسيت كلمة المرور',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: kSecondaryColor,
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    createAccountContent = [
      Form(
        key: _formKey,
          child: Column(children: [
        inputEmail(),
        inputPassword(),
      ],)),
      loginButton('انشاء حساب'),
      orDivider(),
      loginGuestButton(),
      orDivider(),
      logos(),
    ];

    loginContent = [
      inputEmail(),
      inputPassword(),
      loginButton('تسجيل دخول'),
      orDivider(),
      loginGuestButton(),
      forgotPassword(),
    ];

    ChangeScreenAnimation.initialize(
      vsync: this,
      createAccountItems: createAccountContent.length,
      loginItems: loginContent.length,
    );

    for (var i = 0; i < createAccountContent.length; i++) {
      createAccountContent[i] = HelperFunctions.wrapWithAnimatedBuilder(
        animation: ChangeScreenAnimation.createAccountAnimations[i],
        child: createAccountContent[i],
      );
    }

    for (var i = 0; i < loginContent.length; i++) {
      loginContent[i] = HelperFunctions.wrapWithAnimatedBuilder(
        animation: ChangeScreenAnimation.loginAnimations[i],
        child: loginContent[i],
      );
    }

    super.initState();
  }

  @override
  void dispose() {
    ChangeScreenAnimation.dispose();
    super.dispose();
  }

 /* void signUp() async {
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();
      try{
        User firebaseUser;
        await _auth.createUserWithEmailAndPassword(
          email: _email,
          password: _password,
        )
            .then((auth) {
          firebaseUser = auth.user;
        }).catchError((error) {
          Navigator.pop(context);
          showDialog(
              context: context,
              builder: (C) {
                return ErrorAlertDialog(
                  message: error.message.toString(),
                );
              });
        });
        if (firebaseUser != null) {
          Navigator.push(context, MaterialPageRoute(builder: (context) =>  Signup(_email,_password)));
        }
      }catch (e) {
        print(e.message);
      }

    }

  }*/
  void signUp() async {
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();
      try{
        Navigator.push(context, MaterialPageRoute(builder: (context) =>  Signup(email: _email,password: _password,)));

      }catch (e) {
        print(e.message);
      }

    }

  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Positioned(
          top: 116,
          left: 24,
          child: TopText(),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 180),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: createAccountContent,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: loginContent,
              ),
            ],
          ),
        ),
        const Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(bottom: 30),
            child: BottomText(),
          ),
        ),
      ],
    );
  }
  void loginUser() async {
    showDialog(
        context: context,
        builder: (C) {
          return LoadingAlertDialog(
            message: "برجاء الانتظار ...",
          );
        });
    User firebaseUser;
    await _auth.signInWithEmailAndPassword(
      email: _emailTextEditingController.text.trim(),
      password: _passwordTextEditingController.text.trim(),
    )
        .then((authUser) {
      firebaseUser = authUser.user;
    }).catchError((error) {
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (C) {
            return ErrorAlertDialog(
              message: error.message.toString(),
            );
          });
    });
    if (firebaseUser != null) {
      readData(firebaseUser).then((s) {
        Navigator.pop(context);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (C) => Home()));
      });
    }
  }

  Future readData(User fUser) async {
    FirebaseFirestore.instance.collection("users").doc(fUser.uid).get()
        .then((dataSnapshot) async {
      await Mohasabi.sharedPreferences.setString("uid", dataSnapshot.data()[Mohasabi.userUID]);
      await Mohasabi.sharedPreferences.setString(Mohasabi.userEmail, dataSnapshot.data()[Mohasabi.userEmail]);
      await Mohasabi.sharedPreferences.setString(Mohasabi.userName, dataSnapshot.data()[Mohasabi.userName]);
      await Mohasabi.sharedPreferences.setString(Mohasabi.userPhone, dataSnapshot.data()[Mohasabi.userPhone]);
    });
  }
}
