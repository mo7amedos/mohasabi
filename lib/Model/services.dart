import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class ServicesModel {
  String title;
  String description;
  String imgurl;
  String idservice;
  String type;
  String price;
  String idsubservice;
  List requriments;



  ServicesModel({
    this.description,
    this.imgurl,
    this.idservice,
    this.title,
    this.type,
    this.price,
    this.idsubservice,
    this.requriments,
});

ServicesModel.fromJson(Map<String,dynamic>json){
  title = json['title'];
  type = json['type'];
  idservice = json['idservice'];
  imgurl = json['imgurl'];
  description = json['description'];
  price = json['price'];
  idsubservice = json['idsubservice'];
  requriments = List<String>.from(json['requriments']).toList();

}

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['imgurl'] = this.imgurl;
    data['type'] = this.type;
    data['idservice'] = this.idservice;
    data['price'] = this.price;
    data['idsubservice'] = this.idsubservice;
    data['requriments'] = this.requriments;

    return data;
  }

}

class CompanyModel {
  String name;
  String mobile;
  String address;
  String activity;
  String type;
  String email;
  String id;

  CompanyModel({
    this.activity,
    this.address,
    this.mobile,
    this.name,
    this.type,
    this.email,
    this.id
  });

  CompanyModel.fromJson(Map<String,dynamic>json){
    name = json['name'];
    type = json['type'];
    mobile = json['mobile'];
    address = json['address'];
    activity = json['activity'];
    email = json['email'];
    id = json['id'];


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['activity'] = this.activity;
    data['address'] = this.address;
    data['type'] = this.type;
    data['mobile'] = this.mobile;
    data['name'] = this.name;
    data['id'] = this.id;




    return data;
  }

}

class RequestModel {
  Timestamp publishedDate;
  String customerid;
  String customername;
  String customerphone;
  String idsubservice;
  String organization;
  String price;
  String requestid;
  String title;
  List files;
  int status;

  RequestModel({
    this.publishedDate,
    this.price,
    this.idsubservice,
    this.title,
    this.customerid,
    this.customername,
    this.customerphone,
    this.organization,
    this.requestid,
    this.files,
    this.status
  });

  RequestModel.fromJson(Map<String,dynamic>json){
    publishedDate = json['publishedDate'];
    price = json['price'];
    idsubservice = json['idsubservice'];
    title = json['title'];
    customerid = json['customerid'];
    customername = json['customername'];
    customerphone = json['customerphone'];
    organization = json['organization'];
    requestid = json['requestid'];
    files = List<String>.from(json['files']).toList();
    status = json['status'];


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.publishedDate != null) {
      data['publishedDate'] = this.publishedDate;
    }
    data['requestid'] = this.requestid;
    data['activity'] = this.organization;
    data['address'] = this.customerphone;
    data['type'] = this.customername;
    data['mobile'] = this.price;
    data['name'] = this.idsubservice;
    data['id'] = this.title;
    data['id'] = this.customerid;
    data['files'] = this.files;
    data['status'] = this.status;



    return data;
  }

}
class PublishedDate {
  String date;

  PublishedDate({this.date});

  PublishedDate.fromJson(Map<String, dynamic> json) {
    date = json['$date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['$date'] = this.date;
    return data;
  }


}


