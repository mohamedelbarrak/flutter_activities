import 'package:cloud_firestore/cloud_firestore.dart';

import 'firebase_base_model.dart';

class UserModel extends FireBaseModel<UserModel> {
  String? id;
  String? name;
  String? email;
  Timestamp? timestamp;
  String? birthday;
  String? address;
  int? postalCode;
  String? city;
  String? password;

  UserModel({this.id}) : super('users') {
    id = id ?? generateRandomString(5);
  }

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data["birthday"] = birthday;
    data["time_stamp"] = timestamp;
    data["address"] = address;
    data["postal_code"] = postalCode;
    data["city"] = city;
    data["password"] = password;

    return data;
  }

  @override
  UserModel fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    timestamp = json["time_stamp"];
    email = json["email"];
    birthday = json["birthday"];
    address = json["address"];
    postalCode = json["postal_code"];
    city = json["city"];
    password = json["password"];

    return this;
  }

  @override
  UserModel fromJsonList(Map<String, dynamic> json) {
    UserModel userModel = UserModel();
    userModel.id = json['id'];
    userModel.name = json['name'];
    userModel.timestamp = json["time_stamp"];
    userModel.email = json["email"];
    userModel.birthday = json["birthday"];
    userModel.address = json["address"];
    userModel.postalCode = json["postal_code"];
    userModel.city = json["city"];
    userModel.password = json["password"];

    return userModel;
  }
}
