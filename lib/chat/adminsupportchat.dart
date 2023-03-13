import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mohasabi/Model/services.dart';
import 'package:mohasabi/requests.dart';



import '../config/NavBar.dart';
import '../config/config.dart';


class AdminSupportChat extends StatefulWidget {
  final MessageSupportModel messageSupportModel;

  const AdminSupportChat({Key key, this.messageSupportModel}) : super(key: key);

  @override
  State<AdminSupportChat> createState() => _AdminSupportChatState();
}

class _AdminSupportChatState extends State<AdminSupportChat>{
  final TextEditingController _textController = TextEditingController();
  bool isFromMe = false ;
  String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
  @override
  Widget build(BuildContext context) {
    Future<bool> _back() async {
      return await Navigator.push(context, MaterialPageRoute(builder: (context) => Requests()));
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
                    title: Text("طلب رقم:"+widget.messageSupportModel.chatid ,style: TextStyle(color: AppColors.Black,fontSize: 25, fontWeight: FontWeight.bold),),
                    centerTitle: true,
                  ),
                  body:  Column(
                      children: [
                        SizedBox(height: 10,),
                        Expanded(
                            child: StreamBuilder(
                              stream: FirebaseFirestore.instance.collection(Mohasabi.collectionMessages).
                              doc(Mohasabi.collectionSupport).collection(widget.messageSupportModel.customerid).
                              doc(widget.messageSupportModel.chatid).
                              collection(Mohasabi.collectionMessages).snapshots(),
                              builder: (context,snapshot){
                                if (!snapshot.hasData) {
                                  return Center(
                                      child: Text('ابدا المحادثه'));
                                } else {
                                   return ListView.builder(
                                     shrinkWrap: true,
                                     itemCount: snapshot.data.docs.length,
                                     itemBuilder: (BuildContext context, int index) {
                                       Messages messages = Messages.fromJson(snapshot.data.docs[index].data());
                                       if(messages.idfrom == Mohasabi.sharedPreferences.getString(Mohasabi.userUID)){
                                         isFromMe = true;
                                       }else{
                                         isFromMe = false;
                                       };
                                       return Directionality(
                                         textDirection: isFromMe
                                         ?TextDirection.rtl
                                         :TextDirection.ltr,
                                         child: ListTile(
                                           leading: CircleAvatar(
                                             backgroundImage: isFromMe
                                             ?NetworkImage(Mohasabi.sharedPreferences.getString(Mohasabi.userAvatarUrl))
                                             :AssetImage("assets/images/icon.png"),
                                           ),
                                           title: isFromMe
                                           ?Text(Mohasabi.sharedPreferences.getString(Mohasabi.userName))
                                           :Text("محاسبي"),
                                           subtitle: Text(messages.content),
                                           trailing: Text(""),
                                         ),
                                       );
                                     },
                                   );
                                }
                              },
                            )
                        ),
                        Divider(height: 1.0),
                        Align(
                          alignment: FractionalOffset.bottomCenter,
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                color: AppColors.White,
                                borderRadius: BorderRadius.circular(20)
                              ),
                              child:Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextField(
                                            controller: _textController,
                                            decoration: InputDecoration.collapsed(hintText: 'اكتب رسالتك',)
                                          ),
                                        ),
                                      ),

                                      IconButton(
                                        icon: Icon(Icons.send,color: AppColors.LightGold),
                                        onPressed: () {
                                          _textController.text.isNotEmpty
                                          ?Sendadminmsg(widget.messageSupportModel.chatid,widget.messageSupportModel.customerid)
                                          :null;
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          ),
                        ),
                      ],
                    ),
                ),
              )
            ],
          ),
        ),
    );}
  Future Sendadminmsg(String requestid,String idto) async {
    String time = DateTime.now().millisecondsSinceEpoch.toString();
    FirebaseFirestore.instance.collection(Mohasabi.collectionMessages).doc(Mohasabi.collectionSupport)
        .collection(idto).doc(requestid).
    collection(Mohasabi.collectionMessages).
    doc(time).set({
      "content": _textController.text.toString(),
      "idfrom": "admin",
      "idto": idto,
      "type": 0,
      "timestamp": time,
    });
    setState(() {
      _textController.clear();
      timestamp=DateTime.now().millisecondsSinceEpoch.toString();
    });
  }
}