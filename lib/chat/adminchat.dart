import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mohasabi/Admin/adminrequests.dart';
import 'package:mohasabi/Model/services.dart';
import 'package:mohasabi/requests.dart';
import 'package:mohasabi/widgets/custom_button.dart';
import 'package:mohasabi/widgets/custom_text.dart';
import 'package:url_launcher/url_launcher.dart';



import '../config/NavBar.dart';
import '../config/config.dart';


class AdminChat extends StatefulWidget {
  final RequestModel requestmodel;

  const AdminChat({Key key, this.requestmodel}) : super(key: key);

  @override
  State<AdminChat> createState() => _AdminChatState();
}

class _AdminChatState extends State<AdminChat>{
  final TextEditingController _textController = TextEditingController();
  bool isFromMe = false ;
  int activeStep = 0;
  String textCase;
  String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
  @override
  Widget build(BuildContext context) {
    activeStep = widget.requestmodel.status;
    print(activeStep);
    if(activeStep==0){
      textCase = "برجاء تقديم الاوراق المطلوبة";
    }else if(activeStep==1){
      textCase = "تم تقديم الملفات و جاري المراجعة";
    }
    else if(activeStep==2){
      textCase = "في انتظار تاكيد عمليه تحوبل المبلغ";
    }
    else if(activeStep==3){
      textCase = "جاري العمل علي طلبكم ";
    }else if(activeStep==4){
      textCase = "في انتظار تاكيد عمليه تحوبل المبلغ";
    } else if(activeStep==5){
      textCase = "تمت العملية بنجاح";
  }
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
                    title: Text("طلب رقم:"+widget.requestmodel.requestid ,style: TextStyle(color: AppColors.Black,fontSize: 25, fontWeight: FontWeight.bold),),
                    centerTitle: true,
                  ),
                  body:  Column(
                      children: [
                        SizedBox(height: 10,),
                        Directionality(textDirection: TextDirection.rtl,
                          child: EasyStepper(
                          activeStep: activeStep,
                          lineLength: 20,
                          stepShape: StepShape.rRectangle,
                          stepBorderRadius: 15,
                          borderThickness: 2,
                          padding: 20,
                          stepRadius: 28,
                          finishedStepBorderColor: AppColors.LightGold,
                          finishedStepTextColor: AppColors.Black,
                          finishedStepBackgroundColor: AppColors.LightGold,
                          activeStepIconColor: AppColors.LightGold,
                          disableScroll: false,
                          enableStepTapping: false,
                          lineColor: AppColors.LightGrey,
                          activeStepBorderColor: AppColors.LightGrey,
                          activeStepTextColor: AppColors.Black,
                          unreachedStepBorderColor: AppColors.LightGrey ,
                          unreachedStepBackgroundColor:  AppColors.LightGrey,
                          unreachedStepIconColor: AppColors.White ,
                          unreachedStepTextColor:  AppColors.Black,
                          steps: const [
                            EasyStep(
                              icon: Icon(Icons.add_a_photo_rounded),
                              title: 'تقديم الاوراق',
                            ),
                            EasyStep(
                              icon: Icon(Icons.rate_review_rounded),
                              title: 'المراجعة',
                            ),
                            EasyStep(
                              icon: Icon(Icons.payment_rounded),
                              title: 'دفع جزء من الحساب',
                            ),
                            EasyStep(
                              icon: Icon(Icons.work),
                              title: 'بدء العمل',
                            ),
                            EasyStep(
                              icon: Icon(Icons.payment_rounded),
                              title: 'دفع باقي الحساب',
                            ),
                            EasyStep(
                              icon: Icon(Icons.add_task_rounded),
                              title: 'اكتمل',
                            ),
                          ],
                          onStepReached: (index) => setState(() => activeStep = index),
                        ),),
                        SizedBox(
                          height: 30,
                          width: MediaQuery.of(context).size.width,
                          child: InkWell(
                            onTap: _launchURL,
                            child: const Text(
                              'Click here to open a website',
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                          ),
                        SizedBox(
                          height: 30,
                        width: MediaQuery.of(context).size.width,
                        child: Align(
                          alignment: Alignment.topCenter,
                            child: Text(textCase,style: TextStyle(fontSize: 20,),textDirection: TextDirection.rtl, ))
                          ,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomButton(onPress: (){
                              FirebaseFirestore.instance.collection(Mohasabi.collectionRequests).doc(widget.requestmodel.requestid).update({
                                "status": widget.requestmodel.status+1
                              });
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AdminRequests()));
                            },text: "الخطوه التاليه",),
                            CustomButton(onPress: (){
                              if(widget.requestmodel.status == 0){
                                FirebaseFirestore.instance.collection(Mohasabi.collectionRequests).doc(widget.requestmodel.requestid).update({
                                  "status": widget.requestmodel.status
                                });
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AdminRequests()));
                              }else{
                                FirebaseFirestore.instance.collection(Mohasabi.collectionRequests).doc(widget.requestmodel.requestid).update({
                                  "status": widget.requestmodel.status-1
                                });
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AdminRequests()));
                              }
                            },text: "الخطوه السابقة",),
                          ],
                        ),
                        Expanded(
                            child: StreamBuilder(
                              stream: FirebaseFirestore.instance.collection(Mohasabi.collectionMessages).
                              doc(Mohasabi.collectionCase).collection(widget.requestmodel.customerid).
                              doc(widget.requestmodel.requestid).
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
                                          ?Sendadminmsg(widget.requestmodel.requestid,widget.requestmodel.customerid)
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
    FirebaseFirestore.instance.collection(Mohasabi.collectionMessages).doc(idto).collection(Mohasabi.collectionMessages).
    doc(requestid).
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
  _launchURL() async {
    Uri _url = Uri.parse("https://google.com");
    if (await launchUrl(_url)) {
      await launchUrl(_url);
    } else {
      throw 'Could not launch $_url';
    }
  }
}