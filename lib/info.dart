import 'package:flutter/cupertino.dart';

class Info extends StatefulWidget {

  @override
  State<Info> createState() => _InfoState();
}
class _InfoState extends State<Info> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("بيانات عن الشركه و معلومات", style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),)
      ],
    );
  }
  
}
