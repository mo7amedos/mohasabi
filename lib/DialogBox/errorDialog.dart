import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mohasabi/config/config.dart';

class ErrorAlertDialog extends StatelessWidget
{
  final String message;
  const ErrorAlertDialog({Key key, this.message}) : super(key: key);


  @override
  Widget build(BuildContext context)
  {
    return AlertDialog(
      key: key,
      content: Text(message),
      actions: <Widget>[
        // ignore: deprecated_member_use
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: AppColors.LightGold),
          onPressed: () {
          Navigator.pop(context);
        },
          child: Center(
            child: Text("تاكيد"),
          ),
        )
      ],
    );
  }
}
