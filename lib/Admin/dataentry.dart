import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cross_file/cross_file.dart';
import 'dart:io';
import 'package:easy_stepper/easy_stepper.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mohasabi/Admin/showmainservices.dart';
import 'package:mohasabi/DialogBox/errorDialog.dart';

import '../DialogBox/loadingDialog.dart';
import '../config/NavBar.dart';
import '../config/config.dart';
import '../home.dart';

final TextEditingController _nameTextEditingController = TextEditingController();
final TextEditingController _descriptionTextEditingController = TextEditingController();
/*final GlobalKey<FormState> _formKeycomapny = GlobalKey<FormState>();
final GlobalKey<FormState> _formKeyindividual = GlobalKey<FormState>();*/



class DataEntry extends StatefulWidget {

  @override
  State<DataEntry> createState() => _DataEntryState();
}

class _DataEntryState extends State<DataEntry>{

  firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
  File _imageFile;
  String userImageUrl = "";
  String serviceId = Random().nextInt(2).toString()+DateTime.now().millisecond.toString();
  String refType="";
  String refService="";
  String type="";
  bool uploading =false;

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;
    Future<bool> _back() async {
      return await Navigator.push(context, MaterialPageRoute(builder: (context) => Home(role: Mohasabi.sharedPreferences.getString(Mohasabi.userRole))));
    }
    return WillPopScope(
      onWillPop: _back,
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: DefaultTabController(
                initialIndex: 0,
                length: 2,
                child: Scaffold(
                  drawer: NavBar(),
                  appBar: AppBar(
                    iconTheme: IconThemeData(color: AppColors.Black),
                    backgroundColor: AppColors.White,
                    title: Text("اضافة خدمة رئيسية" ,style: TextStyle(color: AppColors.Black,fontSize: 25, fontWeight: FontWeight.bold),),
                    centerTitle: true,
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
                        child: Form(
                          child: Column(
                            children: [
                              SizedBox(height: 30,),
                              InkWell(
                                onTap: () {
                                  _selectAndPickImage();
                                },
                                child: CircleAvatar(
                                  radius: _screenWidth *0.15,
                                  backgroundColor: AppColors.LightGold,
                                  backgroundImage: _imageFile == null ? null : FileImage(_imageFile),
                                  child: _imageFile ==null ? Icon(Icons.add_photo_alternate,size: _screenWidth*0.15,color: AppColors.White,):
                                  null,
                                ) ,
                              ),
                              SizedBox(height: 30,),

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
                                          hintText: "اسم الخدمة",
                                          prefixIcon: Icon(Icons.person_outline_rounded,color: AppColors.LightGold,),
                                        ),
                                        validator: (input) {
                                          if (input.isEmpty) {
                                            return 'من فضلك ادخل الاسم';
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                ),

                              ),
                              SizedBox(height: 10,),
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
                                        controller: _descriptionTextEditingController,
                                        textAlignVertical: TextAlignVertical.bottom,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(30),
                                            borderSide: BorderSide.none,
                                          ),
                                          filled: true,
                                          fillColor: Colors.white,
                                          hintText: "اسم الوصف",
                                          prefixIcon: Icon(Icons.description_rounded,color: AppColors.LightGold,),
                                        ),
                                        validator: (input) {
                                          if (input.isEmpty) {
                                            return 'من فضلك ادخل الوصف';
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                ),

                              ),
                              SizedBox(height: 10,),
                              InkWell(onTap: (){
                                if(uploading==true){
                                  return null;
                                }
                                else{
                                  setState(() {
                                    refType="Company";
                                    refService="Main";
                                    type="company";
                                  });
                                  CheckAndSaveImage();
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 30),
                                decoration: BoxDecoration(
                                  color: AppColors.LightGold,
                                  borderRadius: BorderRadius.circular(20),
                                  // adding color will hide the splash effect
                                  // color: Colors.blueGrey.shade200,
                                ),
                                child: Text("اضافة",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: AppColors.White)),
                              ),),
                            /*  SizedBox(height: 50,),
                              InkWell(onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) =>  ShowMainServices()),
                );
                },
                                child: Container(
                                  alignment: Alignment.bottomCenter,
                                  padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 30),
                                  decoration: BoxDecoration(
                                    color: AppColors.LightGold,
                                    borderRadius: BorderRadius.circular(20),
                                    // adding color will hide the splash effect
                                    // color: Colors.blueGrey.shade200,
                                  ),
                                  child: Text("عرض الخدمات الرئيسية",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: AppColors.White)),
                                ),)*/
                            ],
                          ),
                        )
                      ),
                      //افراد
                      SingleChildScrollView(
                          child: Form(
                            child: Column(
                              children: [
                                SizedBox(height: 30,),
                                InkWell(
                                  onTap: () {
                                    _selectAndPickImage();
                                  },
                                  child: CircleAvatar(
                                  radius: _screenWidth *0.15,
                                  backgroundColor: AppColors.LightGold,
                                  backgroundImage: _imageFile == null ? null : FileImage(_imageFile),
                                  child: _imageFile ==null ? Icon(Icons.add_photo_alternate,size: _screenWidth*0.15,color: AppColors.White,):
                                  null,
                                ) ,
                                ),
                                SizedBox(height: 30,),

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
                                            hintText: "اسم الخدمة",
                                            prefixIcon: Icon(Icons.person_outline_rounded,color: AppColors.LightGold,),
                                          ),
                                          validator: (input) {
                                            if (input.isEmpty) {
                                              return 'من فضلك ادخل الاسم';
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                  ),

                                ),
                                SizedBox(height: 10,),
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
                                          controller: _descriptionTextEditingController,
                                          textAlignVertical: TextAlignVertical.bottom,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(30),
                                              borderSide: BorderSide.none,
                                            ),
                                            filled: true,
                                            fillColor: Colors.white,
                                            hintText: "اسم الوصف",
                                            prefixIcon: Icon(Icons.description_rounded,color: AppColors.LightGold,),
                                          ),
                                          validator: (input) {
                                            if (input.isEmpty) {
                                              return 'من فضلك ادخل الوصف';
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                  ),

                                ),
                                SizedBox(height: 10,),
                                InkWell(onTap: (){
                                  if(uploading==true){
                                    return null;
                                  }
                                  else{
                                    setState(() {
                                      refType="Individual";
                                      refService="Main";
                                      type="individual";
                                    });
                                    CheckAndSaveImage();
                                  }
                                },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 30),
                                    decoration: BoxDecoration(
                                      color: AppColors.LightGold,
                                      borderRadius: BorderRadius.circular(20),
                                      // adding color will hide the splash effect
                                      // color: Colors.blueGrey.shade200,
                                    ),
                                    child: Text("اضافة",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: AppColors.White)),
                                  ),),
                                SizedBox(height: 50,),
                                InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) =>  ShowMainServices()),
                                    );
                                  },
                                  child: Container(
                                    alignment: Alignment.bottomCenter,
                                    padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 30),
                                    decoration: BoxDecoration(
                                      color: AppColors.LightGold,
                                      borderRadius: BorderRadius.circular(20),
                                      // adding color will hide the splash effect
                                      // color: Colors.blueGrey.shade200,
                                    ),
                                    child: Text("عرض الخدمات الرئيسية",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: AppColors.White)
                                    ),
                                  ),)
                              ],
                            ),
                          )
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),

      ),
    );  }
  Future<void> CheckAndSaveImage() async {
        _nameTextEditingController.text.isNotEmpty &&
    _descriptionTextEditingController.text.isNotEmpty
        ? uploadToStorage()
        : ErrorAlertDialog(message:"برجاء كتابة اسم الخدمة و الوصف");
  }
  Future<void> _selectAndPickImage() async {
    _imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);

  }
  uploadToStorage() async {
    if (_imageFile == null) {
      showDialog(
          context: context,
          builder: (c) {
            return LoadingAlertDialog(message: "برجاء ارفاق الصورة");
          });
    } else {
      setState(() {
        uploading=true;
      });
      showDialog(
          context: context,
          builder: (c) {
            return LoadingAlertDialog(message: "برجاء الانتظار......");
          });
      String imageFileName = DateTime.now().millisecond.toString();
      Reference storageReference =
      FirebaseStorage.instance.ref('Services').child(refType).child(refService).child(imageFileName);
      UploadTask storageUploadTask =
      storageReference.putFile(_imageFile);
      TaskSnapshot storageTaskSnapshot =
      await storageUploadTask.whenComplete(() => null);
      await storageTaskSnapshot.ref.getDownloadURL().then((urlImage) {
        userImageUrl = urlImage;
        SaveServiceToFirestore(userImageUrl,type);
      });
    }
  }
  Future SaveServiceToFirestore(String userImageUrl,String type) async {
    FirebaseFirestore.instance.collection(Mohasabi.collectionServices).doc(serviceId).set({
      "title": _nameTextEditingController.text.trim().toString(),
      "description": _descriptionTextEditingController.text.trim().toString(),
      "imgurl": userImageUrl,
      "idservice": serviceId,
      "type": type,

    });
    setState(() {
      _imageFile=null;
      userImageUrl="";
      uploading=false;
      serviceId=Random().nextInt(2).toString()+DateTime.now().millisecond.toString();
      _descriptionTextEditingController.clear();
      _nameTextEditingController.clear();
      Navigator.pop(context);
      type="";
      refService=null;
      refType=null;
    });
  }
}