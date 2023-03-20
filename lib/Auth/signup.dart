

import 'package:easy_stepper/easy_stepper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mohasabi/Auth/login.dart';
import 'package:mohasabi/Auth/utils/constants.dart';
import 'package:mohasabi/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../DialogBox/errorDialog.dart';
import '../config/config.dart';

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
final TextEditingController _nameTextEditingController = TextEditingController();
final TextEditingController _mobileTextEditingController = TextEditingController();
FirebaseAuth _auth = FirebaseAuth.instance;



class Signup extends StatefulWidget {
  final String email,password;
  Signup({Key key, this.email, this.password}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}
class _SignupState extends State<Signup>{
  String _name,_mobile;

  @override
  Widget build(BuildContext context) {
    Future<bool> _back() async {
      return await Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
    }
    return WillPopScope(
      onWillPop: _back,
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Scaffold(
                appBar: AppBar(
                  iconTheme: IconThemeData(color: AppColors.Black),
                  backgroundColor: AppColors.White,
                  title: Text("انشاء الحساب" ,style: TextStyle(color: AppColors.Black,fontSize: 25, fontWeight: FontWeight.bold),),
                  centerTitle: true,
                ),
                body:  SingleChildScrollView(
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Form(
                      key: _formKey,
                        child: Column(
                          children: [
                            SizedBox(height: 20,),
                            //الاسم
                            Directionality(
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
                                      controller: _nameTextEditingController,
                                      textAlignVertical: TextAlignVertical.bottom,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(30),
                                          borderSide: BorderSide.none,
                                        ),
                                        filled: true,
                                        fillColor: Colors.white,
                                        hintText: "الاسم",
                                        prefixIcon: Icon(Icons.person_outline_rounded,color: AppColors.LightGold,),
                                      ),
                                      validator: (input) {
                                        if (input.isEmpty) {
                                          return 'من فضلك ادخل الاسم';
                                        }
                                      },
                                      onSaved: (input) => _name = input,
                                    ),
                                  ),
                                ),
                              ),

                            ),
                            SizedBox(height: 20,),
                            //الهاتف
                            Directionality(
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
                                      keyboardType: TextInputType.number,
                                      controller: _mobileTextEditingController,
                                      textAlignVertical: TextAlignVertical.bottom,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(30),
                                          borderSide: BorderSide.none,
                                        ),
                                        filled: true,
                                        fillColor: Colors.white,
                                        hintText: "الهاتف",
                                        prefixIcon: Icon(Icons.phone_android_rounded,color: AppColors.LightGold,),
                                      ),
                                      validator: (input) {
                                        if (input.isEmpty) {
                                          return 'من فضلك ادخل الهاتف';
                                        }
                                      },
                                      onSaved: (input) => _mobile = input,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Align(
                                alignment: Alignment.bottomCenter,
                                child: ElevatedButton(
                                    onPressed: () {
                                      Register(widget.email, widget.password);
                                    },
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(vertical: 14),
                                    shape: const StadiumBorder(),
                                    primary: kSecondaryColor,
                                    elevation: 8,
                                    shadowColor: Colors.black87,
                                  ),
                                  child: Text("انشاء حساب",
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                ))

                          ],
                        )
                    ),
                  ),
                ),
              ),
            )
          ],
        ),

      ),
    );  }

  void Register(email,password) async {
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();
      try{
        User firebaseUser;
        await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        )
            .then((auth) {
          firebaseUser = auth.user;
        }).catchError((error) {
          showDialog(
              builder: (C) {
                return ErrorAlertDialog(
                  message: error.message.toString(),
                );
              });
        });
        if (firebaseUser != null) {
          saveUserInfoToFirestore(firebaseUser).then((value) {
            Navigator.push(context, MaterialPageRoute(builder: (context) =>  Home()));
          });
        }
      }catch (e) {
        print(e.message);
      }

    }

  }
  Future saveUserInfoToFirestore(User fUser) async {
    FirebaseFirestore.instance.collection("users").doc(fUser.uid).set({
      "uid": fUser.uid,
      "email": fUser.email,
      "name": _nameTextEditingController.text.trim(),
      "phone":_mobileTextEditingController.text.trim(),
      "role":"customer"
    });
    await Mohasabi.sharedPreferences.setString("uid", fUser.uid);
    await Mohasabi.sharedPreferences.setString(Mohasabi.userEmail, fUser.email);
    await Mohasabi.sharedPreferences.setString(Mohasabi.userRole, "customer");
    await Mohasabi.sharedPreferences.setString(Mohasabi.userName, _nameTextEditingController.text.trim());
    await Mohasabi.sharedPreferences.setString(Mohasabi.userPhone, _mobileTextEditingController.text.trim());
  }
}



