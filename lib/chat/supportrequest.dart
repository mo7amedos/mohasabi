import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diamond_bottom_bar/diamond_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mohasabi/Model/services.dart';
import 'package:mohasabi/chat/adminchat.dart';
import 'package:mohasabi/plans.dart';

import '../chat/chat.dart';
import '../config/NavBar.dart';
import '../config/config.dart';
import '../home.dart';


class SupportRequests extends StatefulWidget {
  @override
  State<SupportRequests> createState() => _SupportRequestsState();
}

class _SupportRequestsState extends State<SupportRequests>{
  final TextEditingController _tiltleTextEditingController = TextEditingController();
  final GlobalKey<FormState> _formKeyRequestChat = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String _title;
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
                  title: Text("طلباتي" ,style: TextStyle(color: AppColors.Black,fontSize: 25, fontWeight: FontWeight.bold),),
                  centerTitle: true,
                ),
                body:  SingleChildScrollView(
                  physics: ScrollPhysics(),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                          child: Text("طلب دعم جديد", style: TextStyle(fontSize: 25))),
                    Form(
                    key:_formKeyRequestChat ,
                        child: Column(
                      children: [
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: TextFormField(
                            controller: _tiltleTextEditingController,
                            keyboardType: TextInputType.text,
                            textAlignVertical: TextAlignVertical.bottom,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: "الموضوع",
                              prefixIcon: Icon(Icons.add,color: AppColors.LightGold,),
                            ),
                            validator: (input) {
                              if (input.isEmpty) {
                                return 'من فضلك عنوان الاستفسار';
                              }
                            },
                            onSaved: (input) => _title = input,
                          ),

                        ),
                        Align(
                            alignment: Alignment.bottomCenter,
                            child: ElevatedButton(
                              onPressed: () {
                                if(_formKeyRequestChat.currentState.validate()){
                                  _formKeyRequestChat.currentState.save();
                                  CreateChatRequest();
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.LightGold,
                                shape: const StadiumBorder(),
                                elevation: 8,
                                shadowColor: AppColors.LightGold,
                              ),
                              child: Text("ابدا المحادثه",
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                            )),
                      ],
                    )),
                      Container(
                          alignment: Alignment.center,
                          child: Text("طلبات سابقة", style: TextStyle(fontSize: 25))),
                      SizedBox(height: 10,),
                      FutureBuilder(
                        future: FirebaseFirestore.instance.collection(Mohasabi.collectionMessages).doc(Mohasabi.collectionSupport)
                            .collection(Mohasabi.sharedPreferences.getString(Mohasabi.userUID)).get(),
                        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: snapshot.data.docs.length,
                              itemBuilder: (BuildContext context, int index) {
                                Messages model = Messages.fromJson(snapshot.data.docs[index].data());
                                return  Container(
                                  margin: EdgeInsets.only(left: 10,right: 10),
                                  width: MediaQuery.of(context).size.width,
                                  child: Card(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        ListTile(
                                          onTap: (){
                                            Navigator.push(context, MaterialPageRoute(builder: (context) =>  Chat(chatid:model.chatid)),);
                                          },
                                          leading: Icon(Icons.chat_rounded, size: 50,color: AppColors.LightGold),
                                          title: Text(model.title,textDirection: TextDirection.rtl),
                                          subtitle: Text("",textDirection: TextDirection.rtl),
                                        ),
                                      ],
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
                        },),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),

      ),
    );  }

  Future CreateChatRequest() async {
    String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    FirebaseFirestore.instance.collection(Mohasabi.collectionMessages).
    doc(Mohasabi.collectionSupport).collection(Mohasabi.sharedPreferences.getString(Mohasabi.userUID)).
    doc(timestamp).
    set({
      "title": _tiltleTextEditingController.text.toString(),
      "chatid":timestamp
    });
    FirebaseFirestore.instance.collection(Mohasabi.collectionSupportMessages).
    doc(timestamp).
    set({
      "customerid": Mohasabi.sharedPreferences.getString(Mohasabi.userUID),
      "customername":Mohasabi.sharedPreferences.getString(Mohasabi.userName),
      "chatid":timestamp,
      "publishedDate":DateTime.now()
    });
    setState(() {
      _tiltleTextEditingController.clear();
      timestamp=DateTime.now().millisecondsSinceEpoch.toString();
    });
  }
}