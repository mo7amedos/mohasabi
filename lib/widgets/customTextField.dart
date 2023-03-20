import 'package:flutter/material.dart';

import '../config/config.dart';

class CustomTextField extends StatelessWidget
{
  final TextEditingController controller;
  final IconData icon;
  final String hintText;
  String onsave;



  CustomTextField(
      {Key key, this.controller, this.icon, this.hintText,this.onsave}
      ) : super(key: key);



  @override
  Widget build(BuildContext context)
  {
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
              controller: controller,
              textAlignVertical: TextAlignVertical.bottom,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
                hintText: hintText,
                prefixIcon: Icon(icon,color: AppColors.LightGold,),
              ),
              validator: (input) {
                if (input.isEmpty) {
                  return 'من فضلك ادخل $hintText';
                }
              },
              onSaved: (input) => onsave = input,
            ),
          ),
        ),
      ),
    );
  }
}
