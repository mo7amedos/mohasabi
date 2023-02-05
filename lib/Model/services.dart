import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class ServicesModel {
  String title;
  String description;
  String imgurl;
  int serviceid;
  String type;

  ServicesModel({
    this.description,
    this.imgurl,
    this.serviceid,
    this.title,
    this.type
});

ServicesModel.fromJson(Map<String,dynamic>json){
  title = json['title'];
  type = json['type'];
  serviceid = json['serviceid'];
  imgurl = json['imgurl'];
  description = json['description'];
}

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['imgurl'] = this.imgurl;
    data['type'] = this.type;
    data['serviceid'] = this.serviceid;


    return data;
  }

}
