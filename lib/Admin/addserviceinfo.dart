
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:easy_stepper/easy_stepper.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:mohasabi/Admin/showmainservices.dart';

import 'package:mohasabi/Model/services.dart';

import '../config/NavBar.dart';
import '../config/config.dart';

final TextEditingController _infoTextEditingController = TextEditingController();

class AddServiceInfo extends StatefulWidget {
  final ServicesModel model;
  final String idsub;


  const AddServiceInfo({Key key, this.model, this.idsub}) : super(key: key);
  @override
  State<AddServiceInfo> createState() => _AddServiceInfoState();
}

class _AddServiceInfoState extends State<AddServiceInfo>{

  firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;

  var list = [];


  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;
    Future<bool> _back() async {
      return await Navigator.push(context, MaterialPageRoute(builder: (context) => ShowMainServices()));
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
                  title: Text("اضافة معلومات الخدمة" ,style: TextStyle(color: AppColors.Black,fontSize: 25, fontWeight: FontWeight.bold),),
                  centerTitle: true,
                ),
                body:  SingleChildScrollView(
                  child: Form(
                    child: Column(
                      children: [
                        SizedBox(height: 30,),
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 8),
                            child: Material(
                              elevation: 8,
                              shadowColor: Colors.black87,
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(30),
                              child: TextFormField(
                                controller: _infoTextEditingController,
                                textAlignVertical: TextAlignVertical.bottom,
                                maxLines: null,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide.none,
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: "ادخل البيانات",
                                  prefixIcon: Icon(Icons.description_rounded,color: AppColors.LightGold,),

                                ),
                              ),
                            ),
                          ),

                        ),
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: Container(
                            child: Column(
                              children: [
                                ListView.builder(
                                    padding: const EdgeInsets.only(right: 10),
                                    shrinkWrap: true,
                                    itemCount: list.length,
                                    itemBuilder: (context,index){
                                      return Text("."+list[index],style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),);
                                    }

                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              onTap: (){
                                if(_infoTextEditingController.text.isNotEmpty){
                                  list.add(_infoTextEditingController.text.toString());
                                  setState(() {
                                  });
                                  _infoTextEditingController.clear();
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text("تم اضافة الطلب"),
                                  ));
                                }
                                else{
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text("برجاء ادخال الطلبات..."),
                                  ));
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                                decoration: BoxDecoration(
                                  color: AppColors.LightGold,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text("اضافة الطلبات",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: AppColors.White)),
                              ),
                            ),
                            InkWell(
                              onTap: (){
                                if(_infoTextEditingController.text.isNotEmpty){
                                  EditDescriptionFirebase();
                                }
                                else{
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text("برجاء ادخال البيانات..."),
                                  ));
                                }
                                },
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                                decoration: BoxDecoration(
                                  color: AppColors.LightGold,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text("تعديل الوصف",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: AppColors.White)),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
                        InkWell(
                          onTap: (){
                            if(list.isNotEmpty){
                              AddRequirmentsFirebase();
                            }
                            else{
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("برجاء ادخال الطلبات..."),
                              ));
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                            decoration: BoxDecoration(
                              color: AppColors.LightGold,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text("ارفع جميع الطلبات",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: AppColors.White)),
                          ),
                        ),
                      ],
                    ),
                  )
                ),
              ),
            )
          ],
        ),

      ),
    );  }
  Future EditDescriptionFirebase() async {
    FirebaseFirestore.instance.collection(Mohasabi.collectionServices).
    doc(widget.model.idservice).
    collection(Mohasabi.collectionSubservices).
    doc(widget.idsub).update({
      "description": _infoTextEditingController.text.trim().toString(),
    });
    setState(() {
      _infoTextEditingController.clear();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("تم تعديل الوصف"),));

    });
  }
  Future AddRequirmentsFirebase() async {
    FirebaseFirestore.instance.collection(Mohasabi.collectionServices).
    doc(widget.model.idservice).
    collection(Mohasabi.collectionSubservices).
    doc(widget.idsub).update({
      "requriments":FieldValue.arrayUnion(list),
    });
    setState(() {
      _infoTextEditingController.clear();
      list.clear();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("تم حفظ الطلبات"),));

    });
  }
}