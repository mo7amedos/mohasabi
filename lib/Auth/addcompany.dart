import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mohasabi/Model/services.dart';

import 'package:mohasabi/widgets/customTextField.dart';
import 'package:mohasabi/widgets/custom_button.dart';

import '../config/NavBar.dart';
import '../config/config.dart';

import 'myprofile.dart';

class AddCompany extends StatefulWidget {

  final  bool Add ;
  final  CompanyModel model;

  const AddCompany({Key key, this.Add, this.model}) : super(key: key);
  @override
  State<AddCompany> createState() => _AddCompanyState();
}
final TextEditingController _nameTextEditingController = TextEditingController();
final TextEditingController _mobileTextEditingController = TextEditingController();
final TextEditingController _emailTextEditingController = TextEditingController();
final TextEditingController _addressTextEditingController = TextEditingController();
final TextEditingController _activityTextEditingController = TextEditingController();

class _AddCompanyState extends State<AddCompany>{
  String _selectedValue,_selectedValue2 ;
  String _name,_mobile,_email,_address,_activity;
  bool ShowSecondDropdown = false;
  @override
  Widget build(BuildContext context) {
   final GlobalKey<FormState> _mycompanyformKey = GlobalKey<FormState>();
    Future<bool> _back() async {
      return await Navigator.push(context, MaterialPageRoute(builder: (context) => MyProfile(tabNo: 1,)));
    }
    //اضافة شركة
    if(widget.Add){
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
                    title: Text(Names.AppName ,style: TextStyle(color: AppColors.Black,fontSize: 25, fontWeight: FontWeight.bold),),
                    centerTitle: true,
                  ),
                  body:  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20,bottom: 10),
                      child: Form(
                          key: _mycompanyformKey,
                          child: ShowSecondDropdown?
                          //لو اشخاص
                          Column(
                            children: [
                              CustomTextField(controller: _nameTextEditingController,onsave: _name,icon: Icons.account_balance_sharp,hintText: "اسم الشركة",),
                              CustomTextField(controller: _mobileTextEditingController,onsave: _mobile,icon: Icons.phone,hintText: "الهاتف",),
                              CustomTextField(controller: _addressTextEditingController,onsave: _address,icon: Icons.location_on_rounded,hintText: "العنوان",),
                              CustomTextField(controller: _emailTextEditingController,onsave: _email,icon: Icons.email_rounded,hintText: "الايميل",),
                              CustomTextField(controller: _activityTextEditingController,onsave: _activity,icon: Icons.local_activity_rounded,hintText: "النشاط",),
                              SizedBox(height: 10,),
                              DecoratedBox(
                                  decoration: BoxDecoration(
                                      color:AppColors.White, //background color of dropdown button
                                      borderRadius: BorderRadius.circular(50), //border raiuds of dropdown button
                                      boxShadow: <BoxShadow>[ //apply shadow on Dropdown button
                                        BoxShadow(
                                            color: Color.fromRGBO(0, 0, 0, 0.57), //shadow for button
                                            blurRadius: 5) //blur radius of shadow
                                      ]
                                  ),
                                  child:Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: Padding(
                                        padding: EdgeInsets.only(left:30, right:30),
                                        child:DropdownButton(
                                          hint: Text("نوع الشركة"),
                                          value: _selectedValue,
                                          onChanged: (value){ //get value when changed
                                            setState(() {
                                              _selectedValue = value;
                                              _selectedValue=="شركات اشخاص"?
                                              ShowSecondDropdown=true:
                                              ShowSecondDropdown=false;
                                            });
                                          },
                                          items: [ //add items in the dropdown
                                            DropdownMenuItem(
                                              alignment: Alignment.centerRight,
                                              child: Text("شركات اشخاص"),
                                              value: "شركات اشخاص",
                                            ),
                                            DropdownMenuItem(
                                                alignment: Alignment.centerRight,
                                                child: Text("شركة مساهمة خاصة"),
                                                value: "شركة مساهمة خاصة"
                                            ),
                                            DropdownMenuItem(
                                              alignment: Alignment.centerRight,
                                              child: Text("شركة مساهمة عامة"),
                                              value: "شركة مساهمة عامة",
                                            ),
                                            DropdownMenuItem(
                                              alignment: Alignment.centerRight,
                                              child: Text("شركة ذات مسؤلية محدودة"),
                                              value: "شركة ذات مسؤلية محدودة",
                                            ),
                                            DropdownMenuItem(
                                              alignment: Alignment.centerRight,
                                              child: Text("شركة التوصية بالاسهم"),
                                              value: "شركة التوصية بالاسهم",
                                            ),

                                          ],

                                          icon: Padding( //Icon at tail, arrow bottom is default icon
                                              padding: EdgeInsets.only(right:50),
                                              child:Icon(Icons.arrow_circle_down_sharp,color: AppColors.LightGold,)
                                          ),
                                          style: TextStyle(  //te
                                              color: Colors.black45, //Font color
                                              fontSize: 20 //font size on dropdown button
                                          ),
                                          borderRadius: BorderRadius.circular(20),
                                          dropdownColor: AppColors.White, //dropdown background color
                                          underline: Container(),
                                          //remove underline
                                        )
                                    ),
                                  )
                              ),
                              SizedBox(height: 20,),
                              DecoratedBox(
                                  decoration: BoxDecoration(
                                      color:AppColors.White, //background color of dropdown button
                                      borderRadius: BorderRadius.circular(50), //border raiuds of dropdown button
                                      boxShadow: <BoxShadow>[ //apply shadow on Dropdown button
                                        BoxShadow(
                                            color: Color.fromRGBO(0, 0, 0, 0.57), //shadow for button
                                            blurRadius: 5) //blur radius of shadow
                                      ]
                                  ),
                                  child:Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: Padding(
                                        padding: EdgeInsets.only(left:30, right:30),
                                        child:DropdownButton(
                                          hint: Text("نوع الشركة الاشخاص"),
                                          value: _selectedValue2,
                                          onChanged: (value){ //get value when changed
                                            setState(() {
                                              _selectedValue2 = value;
                                            });
                                          },
                                          items: [ //add items in the dropdown
                                            DropdownMenuItem(
                                              alignment: Alignment.centerRight,
                                              child: Text("تضامن"),
                                              value: "تضامن",
                                            ),
                                            DropdownMenuItem(
                                                alignment: Alignment.centerRight,
                                                child: Text("توصية بسيطة"),
                                                value: "توصية بسيطة"
                                            ),
                                            DropdownMenuItem(
                                              alignment: Alignment.centerRight,
                                              child: Text("خاصة"),
                                              value: "خاصة",
                                            ),


                                          ],

                                          icon: Padding( //Icon at tail, arrow bottom is default icon
                                              padding: EdgeInsets.only(right:90),
                                              child:Icon(Icons.arrow_circle_down_sharp,color: AppColors.LightGold,)
                                          ),
                                          style: TextStyle(  //te
                                              color: Colors.black45, //Font color
                                              fontSize: 20 //font size on dropdown button
                                          ),
                                          borderRadius: BorderRadius.circular(20),
                                          dropdownColor: AppColors.White, //dropdown background color
                                          underline: Container(),
                                          //remove underline
                                        )
                                    ),
                                  )
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CustomButton (onPress: (){
                                  if(_mycompanyformKey.currentState.validate()){
                                    _mycompanyformKey.currentState.save();
                                    addCompanyToFirestoreWith2Category();
                                  }
                                },text: "اضافة الشركة ",),
                              )
                            ],
                          )://لو مش اشخاص
                          Column(
                            children: [
                              CustomTextField(controller: _nameTextEditingController,onsave: _name,icon: Icons.account_balance_sharp,hintText: "اسم الشركة",),
                              CustomTextField(controller: _mobileTextEditingController,onsave: _mobile,icon: Icons.phone,hintText: "الهاتف",),
                              CustomTextField(controller: _addressTextEditingController             ,onsave: _address,icon: Icons.location_on_rounded,hintText: "العنوان",),
                              CustomTextField(controller: _emailTextEditingController,onsave: _email,icon: Icons.email_rounded,hintText: "الايميل",),
                              CustomTextField(controller: _activityTextEditingController,onsave: _activity,icon: Icons.local_activity_rounded,hintText: "النشاط",),
                              SizedBox(height: 10,),
                              DecoratedBox(
                                  decoration: BoxDecoration(
                                      color:AppColors.White, //background color of dropdown button
                                      borderRadius: BorderRadius.circular(50), //border raiuds of dropdown button
                                      boxShadow: <BoxShadow>[ //apply shadow on Dropdown button
                                        BoxShadow(
                                            color: Color.fromRGBO(0, 0, 0, 0.57), //shadow for button
                                            blurRadius: 5) //blur radius of shadow
                                      ]
                                  ),
                                  child:Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: Padding(
                                        padding: EdgeInsets.only(left:30, right:30),
                                        child:DropdownButton(
                                          hint: Text("نوع الشركة"),
                                          value: _selectedValue,
                                          onChanged: (value){ //get value when changed
                                            setState(() {
                                              _selectedValue = value;
                                              _selectedValue=="شركات اشخاص"?
                                              ShowSecondDropdown=true:
                                              ShowSecondDropdown=false;
                                            });
                                          },
                                          items: [ //add items in the dropdown
                                            DropdownMenuItem(
                                              alignment: Alignment.centerRight,
                                              child: Text("شركات اشخاص"),
                                              value: "شركات اشخاص",
                                            ),
                                            DropdownMenuItem(
                                                alignment: Alignment.centerRight,
                                                child: Text("شركة مساهمة خاصة"),
                                                value: "شركة مساهمة خاصة"
                                            ),
                                            DropdownMenuItem(
                                              alignment: Alignment.centerRight,
                                              child: Text("شركة مساهمة عامة"),
                                              value: "شركة مساهمة عامة",
                                            ),
                                            DropdownMenuItem(
                                              alignment: Alignment.centerRight,
                                              child: Text("شركة ذات مسؤلية محدودة"),
                                              value: "شركة ذات مسؤلية محدودة",
                                            ),
                                            DropdownMenuItem(
                                              alignment: Alignment.centerRight,
                                              child: Text("شركة التوصية بالاسهم"),
                                              value: "شركة التوصية بالاسهم",
                                            ),

                                          ],

                                          icon: Padding( //Icon at tail, arrow bottom is default icon
                                              padding: EdgeInsets.only(right:50),
                                              child:Icon(Icons.arrow_circle_down_sharp,color: AppColors.LightGold,)
                                          ),
                                          style: TextStyle(  //te
                                              color: Colors.black45, //Font color
                                              fontSize: 20 //font size on dropdown button
                                          ),
                                          borderRadius: BorderRadius.circular(20),
                                          dropdownColor: AppColors.White, //dropdown background color
                                          underline: Container(),
                                          //remove underline
                                        )
                                    ),
                                  )
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CustomButton (onPress: (){
                                  if(_mycompanyformKey.currentState.validate()){
                                    _mycompanyformKey.currentState.save();
                                    addCompanyToFirestoreWith1Category();
                                  }
                                },text: "اضافة الشركة ",),
                              )
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
      );
    }
    //تعديل شركة
    else{
      if(widget.model.category2.isEmpty){
        ShowSecondDropdown=false;
      }
      else{
        ShowSecondDropdown=true;
      }

      WidgetsBinding.instance?.addPostFrameCallback((_) {
        if(ShowSecondDropdown){
          _nameTextEditingController..text=widget.model.name;
          _addressTextEditingController..text=widget.model.address;
          _mobileTextEditingController..text=widget.model.phone;
          _activityTextEditingController..text=widget.model.activity;
          _emailTextEditingController..text=widget.model.email;
        }else{
          _nameTextEditingController..text=widget.model.name;
          _addressTextEditingController..text=widget.model.address;
          _mobileTextEditingController..text=widget.model.phone;
          _activityTextEditingController..text=widget.model.activity;
          _emailTextEditingController..text=widget.model.email;
        }
      });
      _selectedValue=widget.model.category;
      _selectedValue2=widget.model.category2;

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
                    title: Text("تعديل بيانات الشركة" ,style: TextStyle(color: AppColors.Black,fontSize: 25, fontWeight: FontWeight.bold),),
                    centerTitle: true,
                  ),
                  body:  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20,bottom: 10),
                      child: Form(
                          key: _mycompanyformKey,
                          child: ShowSecondDropdown?
                          //لو اشخاص
                          Column(
                            children: [
                              CustomTextField(controller: _nameTextEditingController,onsave: _name,icon: Icons.account_balance_sharp,hintText: "اسم الشركة",),
                              CustomTextField(controller: _mobileTextEditingController,onsave: _mobile,icon: Icons.phone,hintText: "الهاتف",),
                              CustomTextField(controller: _addressTextEditingController,onsave: _address,icon: Icons.location_on_rounded,hintText: "العنوان",),
                              CustomTextField(controller: _emailTextEditingController,onsave: _email,icon: Icons.email_rounded,hintText: "الايميل",),
                              CustomTextField(controller: _activityTextEditingController,onsave: _activity,icon: Icons.local_activity_rounded,hintText: "النشاط",),
                              SizedBox(height: 10,),
                              DecoratedBox(
                                  decoration: BoxDecoration(
                                      color:AppColors.White, //background color of dropdown button
                                      borderRadius: BorderRadius.circular(50), //border raiuds of dropdown button
                                      boxShadow: <BoxShadow>[ //apply shadow on Dropdown button
                                        BoxShadow(
                                            color: Color.fromRGBO(0, 0, 0, 0.57), //shadow for button
                                            blurRadius: 5) //blur radius of shadow
                                      ]
                                  ),
                                  child:Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: Padding(
                                        padding: EdgeInsets.only(left:30, right:30),
                                        child:DropdownButton(
                                          hint: Text("نوع الشركة"),
                                          value: _selectedValue,
                                          onChanged: (value){ //get value when changed
                                            setState(() {
                                              _selectedValue = value;
                                              _selectedValue=="شركات اشخاص"?
                                              ShowSecondDropdown=true:
                                              ShowSecondDropdown=false;
                                            });
                                          },
                                          items: [ //add items in the dropdown
                                            DropdownMenuItem(
                                              alignment: Alignment.centerRight,
                                              child: Text("شركات اشخاص"),
                                              value: "شركات اشخاص",
                                            ),
                                            DropdownMenuItem(
                                                alignment: Alignment.centerRight,
                                                child: Text("شركة مساهمة خاصة"),
                                                value: "شركة مساهمة خاصة"
                                            ),
                                            DropdownMenuItem(
                                              alignment: Alignment.centerRight,
                                              child: Text("شركة مساهمة عامة"),
                                              value: "شركة مساهمة عامة",
                                            ),
                                            DropdownMenuItem(
                                              alignment: Alignment.centerRight,
                                              child: Text("شركة ذات مسؤلية محدودة"),
                                              value: "شركة ذات مسؤلية محدودة",
                                            ),
                                            DropdownMenuItem(
                                              alignment: Alignment.centerRight,
                                              child: Text("شركة التوصية بالاسهم"),
                                              value: "شركة التوصية بالاسهم",
                                            ),

                                          ],

                                          icon: Padding( //Icon at tail, arrow bottom is default icon
                                              padding: EdgeInsets.only(right:50),
                                              child:Icon(Icons.arrow_circle_down_sharp,color: AppColors.LightGold,)
                                          ),
                                          style: TextStyle(  //te
                                              color: Colors.black45, //Font color
                                              fontSize: 20 //font size on dropdown button
                                          ),
                                          borderRadius: BorderRadius.circular(20),
                                          dropdownColor: AppColors.White, //dropdown background color
                                          underline: Container(),
                                          //remove underline
                                        )
                                    ),
                                  )
                              ),
                              SizedBox(height: 20,),
                              DecoratedBox(
                                  decoration: BoxDecoration(
                                      color:AppColors.White, //background color of dropdown button
                                      borderRadius: BorderRadius.circular(50), //border raiuds of dropdown button
                                      boxShadow: <BoxShadow>[ //apply shadow on Dropdown button
                                        BoxShadow(
                                            color: Color.fromRGBO(0, 0, 0, 0.57), //shadow for button
                                            blurRadius: 5) //blur radius of shadow
                                      ]
                                  ),
                                  child:Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: Padding(
                                        padding: EdgeInsets.only(left:30, right:30),
                                        child:DropdownButton(
                                          hint: Text("نوع الشركة الاشخاص"),
                                          value: _selectedValue2,
                                          onChanged: (value){ //get value when changed
                                            setState(() {
                                              _selectedValue2 = value;
                                            });
                                          },
                                          items: [ //add items in the dropdown
                                            DropdownMenuItem(
                                              alignment: Alignment.centerRight,
                                              child: Text("تضامن"),
                                              value: "تضامن",
                                            ),
                                            DropdownMenuItem(
                                                alignment: Alignment.centerRight,
                                                child: Text("توصية بسيطة"),
                                                value: "توصية بسيطة"
                                            ),
                                            DropdownMenuItem(
                                              alignment: Alignment.centerRight,
                                              child: Text("خاصة"),
                                              value: "خاصة",
                                            ),


                                          ],

                                          icon: Padding( //Icon at tail, arrow bottom is default icon
                                              padding: EdgeInsets.only(right:90),
                                              child:Icon(Icons.arrow_circle_down_sharp,color: AppColors.LightGold,)
                                          ),
                                          style: TextStyle(  //te
                                              color: Colors.black45, //Font color
                                              fontSize: 20 //font size on dropdown button
                                          ),
                                          borderRadius: BorderRadius.circular(20),
                                          dropdownColor: AppColors.White, //dropdown background color
                                          underline: Container(),
                                          //remove underline
                                        )
                                    ),
                                  )
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CustomButton (onPress: (){
                                  if(_mycompanyformKey.currentState.validate()){
                                    _mycompanyformKey.currentState.save();
                                    editCompanyFromFirestoreWith2Category();
                                  }
                                },text: "تعديل الشركة ",),
                              )
                            ],
                          )://لو مش اشخاص
                          Column(
                            children: [
                              CustomTextField(controller: _nameTextEditingController,onsave: _name,icon: Icons.account_balance_sharp,hintText: "اسم الشركة",),
                              CustomTextField(controller: _mobileTextEditingController,onsave: _mobile,icon: Icons.phone,hintText: "الهاتف",),
                              CustomTextField(controller: _addressTextEditingController             ,onsave: _address,icon: Icons.location_on_rounded,hintText: "العنوان",),
                              CustomTextField(controller: _emailTextEditingController,onsave: _email,icon: Icons.email_rounded,hintText: "الايميل",),
                              CustomTextField(controller: _activityTextEditingController,onsave: _activity,icon: Icons.local_activity_rounded,hintText: "النشاط",),
                              SizedBox(height: 10,),
                              DecoratedBox(
                                  decoration: BoxDecoration(
                                      color:AppColors.White, //background color of dropdown button
                                      borderRadius: BorderRadius.circular(50), //border raiuds of dropdown button
                                      boxShadow: <BoxShadow>[ //apply shadow on Dropdown button
                                        BoxShadow(
                                            color: Color.fromRGBO(0, 0, 0, 0.57), //shadow for button
                                            blurRadius: 5) //blur radius of shadow
                                      ]
                                  ),
                                  child:Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: Padding(
                                        padding: EdgeInsets.only(left:30, right:30),
                                        child:DropdownButton(
                                          hint: Text("نوع الشركة"),
                                          value: _selectedValue,
                                          onChanged: (value){ //get value when changed
                                            setState(() {
                                              _selectedValue = value;
                                              _selectedValue=="شركات اشخاص"?
                                              ShowSecondDropdown=true:
                                              ShowSecondDropdown=false;
                                            });
                                          },
                                          items: [ //add items in the dropdown
                                            DropdownMenuItem(
                                              alignment: Alignment.centerRight,
                                              child: Text("شركات اشخاص"),
                                              value: "شركات اشخاص",
                                            ),
                                            DropdownMenuItem(
                                                alignment: Alignment.centerRight,
                                                child: Text("شركة مساهمة خاصة"),
                                                value: "شركة مساهمة خاصة"
                                            ),
                                            DropdownMenuItem(
                                              alignment: Alignment.centerRight,
                                              child: Text("شركة مساهمة عامة"),
                                              value: "شركة مساهمة عامة",
                                            ),
                                            DropdownMenuItem(
                                              alignment: Alignment.centerRight,
                                              child: Text("شركة ذات مسؤلية محدودة"),
                                              value: "شركة ذات مسؤلية محدودة",
                                            ),
                                            DropdownMenuItem(
                                              alignment: Alignment.centerRight,
                                              child: Text("شركة التوصية بالاسهم"),
                                              value: "شركة التوصية بالاسهم",
                                            ),

                                          ],

                                          icon: Padding( //Icon at tail, arrow bottom is default icon
                                              padding: EdgeInsets.only(right:50),
                                              child:Icon(Icons.arrow_circle_down_sharp,color: AppColors.LightGold,)
                                          ),
                                          style: TextStyle(  //te
                                              color: Colors.black45, //Font color
                                              fontSize: 20 //font size on dropdown button
                                          ),
                                          borderRadius: BorderRadius.circular(20),
                                          dropdownColor: AppColors.White, //dropdown background color
                                          underline: Container(),
                                          //remove underline
                                        )
                                    ),
                                  )
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CustomButton (onPress: (){
                                  if(_mycompanyformKey.currentState.validate()){
                                    _mycompanyformKey.currentState.save();
                                    editCompanyFromFirestoreWith1Category();
                                  }
                                },text: "تعديل الشركة ",),
                              )
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
      );
    }

  }

  Future addCompanyToFirestoreWith2Category() async {
    String id = DateTime.now().millisecond.toString();
    FirebaseFirestore.instance.collection("users").doc(Mohasabi.sharedPreferences.getString(Mohasabi.userUID)).
    collection(Mohasabi.collectionCompany).doc(id).set({
      "id":id,
      "name": _nameTextEditingController.text.toString(),
      "phone":_mobileTextEditingController.text.trim().toString(),
      "address":_addressTextEditingController.text.toString(),
      "email": _emailTextEditingController.text.trim().toString(),
      "activity":_activityTextEditingController.text.toString(),
      "category":_selectedValue,
      "category2":_selectedValue2,
    });
    setState(() {
      _nameTextEditingController.clear();
      _activityTextEditingController.clear();
      _mobileTextEditingController.clear();
      _addressTextEditingController.clear();
      _emailTextEditingController.clear();
      ShowSecondDropdown=false;
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("تم اضافة الشركة بنجاح"),));

  }
  Future addCompanyToFirestoreWith1Category() async {
    String id = DateTime.now().millisecond.toString();
    FirebaseFirestore.instance.collection("users").doc(Mohasabi.sharedPreferences.getString(Mohasabi.userUID)).
    collection(Mohasabi.collectionCompany).doc(id).set({
      "id":id,
      "name": _nameTextEditingController.text.toString(),
      "phone":_mobileTextEditingController.text.trim().toString(),
      "address":_addressTextEditingController.text.toString(),
      "email": _emailTextEditingController.text.trim().toString(),
      "activity":_activityTextEditingController.text.toString(),
      "category":_selectedValue,
      "category2":""
    });
    setState(() {
      _nameTextEditingController.clear();
      _activityTextEditingController.clear();
      _mobileTextEditingController.clear();
      _addressTextEditingController.clear();
      _emailTextEditingController.clear();
      ShowSecondDropdown=false;
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("تم اضافة الشركة بنجاح"),));

  }
  Future editCompanyFromFirestoreWith2Category() async {
    FirebaseFirestore.instance.collection(Mohasabi.collectionUser).doc(Mohasabi.sharedPreferences.getString(Mohasabi.userUID)).
    collection(Mohasabi.collectionCompany).doc(widget.model.id).update({
      "name": _nameTextEditingController.text.toString(),
      "phone":_mobileTextEditingController.text.trim().toString(),
      "address":_addressTextEditingController.text.toString(),
      "email": _emailTextEditingController.text.trim().toString(),
      "activity":_activityTextEditingController.text.toString(),
      "category":_selectedValue,
      "category2":_selectedValue2,
    });

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("تم تعديل بيانات الشركة بنجاح"),));

  }
  Future editCompanyFromFirestoreWith1Category() async {
    FirebaseFirestore.instance.collection(Mohasabi.collectionUser).doc(Mohasabi.sharedPreferences.getString(Mohasabi.userUID)).
    collection(Mohasabi.collectionCompany).doc(widget.model.id).set({
      "name": _nameTextEditingController.text.toString(),
      "phone":_mobileTextEditingController.text.trim().toString(),
      "address":_addressTextEditingController.text.toString(),
      "email": _emailTextEditingController.text.trim().toString(),
      "activity":_activityTextEditingController.text.toString(),
      "category":_selectedValue,
      "category2":""
    });

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("تم تعديل بيانات الشركة بنجاح"),));

  }
}