
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mohasabi/Model/services.dart';
import 'package:mohasabi/mycase.dart';
import 'package:mohasabi/requests.dart';


import 'DialogBox/loadingDialog.dart';
import 'config/NavBar.dart';
import 'config/config.dart';
import 'home.dart';


class Description extends StatefulWidget {
  final ServicesModel model;

  const Description({Key key, this.model}) : super(key: key);

  @override
  State<Description> createState() => _DescriptionState();
}

class _DescriptionState extends State<Description>{
  String type ;
  String _selectedValue ;

  @override
  Widget build(BuildContext context) {

    type = widget.model.type;
    print(_selectedValue);
    Future<bool> _back() async {
      return await Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
    }
    return WillPopScope(
      onWillPop: _back,
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Scaffold(
                drawer: NavBar(),
                appBar: AppBar(
                  iconTheme: IconThemeData(color: AppColors.Black),
                  backgroundColor: AppColors.White,
                  title: Text(widget.model.title ,style: TextStyle(color: AppColors.Black,fontSize: 25, fontWeight: FontWeight.bold),),
                  centerTitle: true,
                ),
                body:  SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 10,),
                      //dropbox
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DecoratedBox(
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
                                        doc(Mohasabi.sharedPreferences.getString(Mohasabi.userUID)).collection(type).get(),
                                        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                          if (snapshot.hasData) {
                                            List<DropdownMenuItem> dropdownItems = [];
                                            for (int i = 0; i < snapshot.data.docs.length; i++) {
                                              CompanyModel model =CompanyModel.fromJson(snapshot.data.docs[i].data());
                                              //DocumentSnapshot document = snapshot.data.docs[i];
                                              dropdownItems.add(
                                                DropdownMenuItem(
                                                  child: Text(model.name),
                                                  value: model.name,
                                                ),
                                              );
                                            }
                                            return Directionality(
                                              textDirection: TextDirection.rtl,
                                              child: DropdownButton(
                                                hint: Text("من فضلك اختار الحساب",style: TextStyle(color: AppColors.White),),
                                                value: _selectedValue,
                                                items: dropdownItems,
                                                onChanged: (value){ //get value when changed
                                                  setState(() {
                                                    _selectedValue = value;
                                                  });
                                                },
                                                icon: Icon(Icons.arrow_circle_down_sharp),
                                                iconEnabledColor: Colors.white, //Icon color
                                                style: TextStyle(  //te
                                                    color: Colors.white, //Font color
                                                    fontSize: 20 ,
                                                    fontWeight: FontWeight.bold//font size on dropdown button
                                                ),
                                                borderRadius: BorderRadius.circular(20),
                                                dropdownColor: AppColors.LightGold, //dropdown background color
                                                underline: Container(), //remove underline
                                                isExpanded: true, //make true to make width 100%
                                              ),
                                            );
                                          } else {
                                            return CircularProgressIndicator();
                                          }
                                        },
                                      )

                                  )
                              ),
                      ),
                      SizedBox(height: 10,),
                      //وصف الخدمة و السعر
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Directionality(
                                textDirection: TextDirection.rtl,
                                child: Text("السعر : ${widget.model.price}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),)
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Directionality(
                                textDirection: TextDirection.rtl,
                                child: Align(
                                  alignment: Alignment.topRight,
                                    child: Text("وصف الخدمة:",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,),))
                            ),
                          ),

                        ],
                      ),
                      //الوصف و الطلبات
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0,left: 8.0,bottom: 8.0),
                        child: Directionality(textDirection: TextDirection.rtl,
                            child: Column(
                              children: [
                                Text(widget.model.description,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: Align(
                                          alignment: Alignment.topRight,
                                          child: Text("الطلبات(المرفقات):",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,),))
                                  ),
                                ),
                               ListView.builder(
                                 shrinkWrap: true,
                                   itemCount: widget.model.requriments.length ,
                                   itemBuilder: (c,index){
                                     if(widget.model.requriments.isNotEmpty){
                                       return Card(
                                         child: Padding(
                                           padding: EdgeInsets.all(8.0),
                                           child: Column(
                                             crossAxisAlignment: CrossAxisAlignment.center,
                                             children: <Widget>[
                                               Text(widget.model.requriments[index],style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),textAlign: TextAlign.center,)                                  ],
                                           ),
                                         ),
                                       );                                      }else{
                                       return Text("لا توجد متطلبات",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),);
                                     }
                                   }
                               )
                              ],
                            )
                        ),
                      ),
                      //الارفاق
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: FractionalOffset.bottomCenter,
                        child:InkWell(
                          onTap: (){
                            if(_selectedValue==null){
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("من فضلك اختار الحساب "),));
                            }else{
                              //upload code
                              uploadFiles();
                            }
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
                          child: Text("ارفاق",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: AppColors.White)
                          ),
                        ),
                        ),),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),

      ),
    );  }

  Future uploadFiles() async {

    List files = [];

    List result  = await FilePicker.getMultiFile(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'doc','xlsx','png'],
    );

    if (result != null) {
      for (var file in result) {
        files.add(file);
      }
    }
    print(files);

    List downloadUrls = await uploadFilesToStorage(files);

    return downloadUrls;
  }

  Future<List> uploadFilesToStorage(List files) async {
    showDialog(
        context: context,
        builder: (c) {
          return LoadingAlertDialog(message: "برجاء الانتظار......");
        });
    List downloadUrls = [];
    int rand = Random().nextInt(9000000)+1000000;
    String Requestid =rand.toString();

    for (var file in files) {
      String fileName = file.path.split('/').last;
      Reference ref = FirebaseStorage.instance.ref("Requests").child(Requestid).child(fileName);
      UploadTask uploadTask = ref.putFile(file);

      String downloadUrl = await (await uploadTask).ref.getDownloadURL();
      downloadUrls.add(downloadUrl);
    }
    SaveRequestToFirestore(Requestid,downloadUrls);
    return downloadUrls;
  }
  Future SaveRequestToFirestore(String Requestid,List downloadUrls) async{
    FirebaseFirestore.instance.collection(Mohasabi.collectionUser).doc(Mohasabi.sharedPreferences.getString(Mohasabi.userUID)).
    collection(Mohasabi.collectionRequests).doc(Requestid).set({
      "requestid":Requestid,
      "title":widget.model.title,
      "idsubservice":widget.model.idsubservice,
      "price":widget.model.price,
      "customername":Mohasabi.sharedPreferences.getString(Mohasabi.userName),
      "customerid":Mohasabi.sharedPreferences.getString(Mohasabi.userUID),
      "customerphone":Mohasabi.sharedPreferences.getString(Mohasabi.userPhone),
      "files":downloadUrls,
      "organization":_selectedValue.toString(),
      "status":1,
      "publishedDate": DateTime.now(),
    });
    FirebaseFirestore.instance.collection(Mohasabi.collectionRequests).
    doc(Requestid).set({
      "requestid":Requestid,
      "title":widget.model.title,
      "idsubservice":widget.model.idsubservice,
      "price":widget.model.price,
      "customername":Mohasabi.sharedPreferences.getString(Mohasabi.userName),
      "customerid":Mohasabi.sharedPreferences.getString(Mohasabi.userUID),
      "customerphone":Mohasabi.sharedPreferences.getString(Mohasabi.userPhone),
      "files":downloadUrls,
      "organization":_selectedValue.toString(),
      "status":1,
      "publishedDate": DateTime.now(),
    });
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("تم تسجيل طلبك رقم "+Requestid),));


    Navigator.push(context, MaterialPageRoute(builder: (context) =>  Requests()),);

  }
}