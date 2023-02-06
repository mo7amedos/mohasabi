import 'package:diamond_bottom_bar/diamond_bottom_bar.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mohasabi/requests.dart';
import 'package:mohasabi/training.dart';

import 'Auth/login.dart';
import 'config/navbar.dart';
import 'config/config.dart';
import 'home.dart';
import 'info.dart';
import 'myprofile.dart';

class MyCase extends StatefulWidget {

  @override
  State<MyCase> createState() => _MyCaseState();
}

class _MyCaseState extends State<MyCase>{
  int activeStep = 0;

  @override
  Widget build(BuildContext context) {
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
                  title: Text("رقم الطلب" ,style: TextStyle(color: AppColors.Black,fontSize: 25, fontWeight: FontWeight.bold),),
                  centerTitle: true,
                ),
                body:  SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 10,),
                      Directionality(textDirection: TextDirection.rtl, child: EasyStepper(
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
                      SizedBox(height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Text("مساحه للمحادثة و تقديم الاوراق ",style: TextStyle(fontSize: 50),textDirection: TextDirection.rtl, )
                        ,),


                    ],
                  ),
                ),
              ),
            )
          ],
        ),

      ),
    );  }

}