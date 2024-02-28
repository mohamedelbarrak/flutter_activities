import 'package:cloud_firestore/cloud_firestore.dart';

import '../utils/constant.dart';
import 'firebase_base_model.dart';

class ActivityModel extends FireBaseModel<ActivityModel> {
  String? id;
  String? title;
  String? image;
  Timestamp? timestamp;
  String? category;
  String? location;
  String? totalPeople;
  String? price;
  List<String>? isCartAdd;

  ActivityModel({this.id}) : super('activities') {
    id = id ?? generateRandomString(5);
  }

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['image'] = image;
    data["category"] = category;
    data["time_stamp"] = timestamp;
    data["location"] = location;
    data["total_peoples"] = totalPeople;
    data["price"] = price;
    data['is_cart_add'] = isCartAdd?.map((e) => e.toString()).toList() ?? [];

    return data;
  }

  @override
  ActivityModel fromJson(Map<String, dynamic> json) {
    List<dynamic> isCartMap = json["is_cart_add"];

    id = json['id'];
    title = json['title'];
    timestamp = json["time_stamp"];
    image = json["image"];
    category = json["category"];
    location = json["location"];
    totalPeople = json["total_peoples"];
    price = json["price"];
    isCartAdd = isCartMap.map((e) => e.toString()).toList() ?? [];

    return this;
  }

  @override
  ActivityModel fromJsonList(Map<String, dynamic> json) {
    List<dynamic> isCartMap = json["is_cart_add"];
    ActivityModel activityModel = ActivityModel();
    activityModel.id = json['id'];
    activityModel.title = json['title'];
    activityModel.timestamp = json["time_stamp"];
    activityModel.image = json["image"];
    activityModel.category = json["category"];
    activityModel.location = json["location"];
    activityModel.totalPeople = json["total_peoples"];
    activityModel.price = json["price"];
    activityModel.isCartAdd = isCartMap.map((e) => e.toString()).toList() ?? [];

    return activityModel;
  }

  bool isAddToCart() {
    return Constants.userModel == null
        ? false
        : isCartAdd?.contains(Constants.userModel!.id) ?? false;
  }

  Future<void> addToCart() async {
    await FirebaseFirestore.instance.doc("activities/$id").set({
      "is_cart_add": FieldValue.arrayUnion([Constants.userModel!.id])
    }, SetOptions(merge: true));
    isCartAdd = isCartAdd ?? [];
    isCartAdd!.add(Constants.userModel!.id!);
  }

  Future<void> removeFromCart() async {
    await FirebaseFirestore.instance.doc("activities/$id").set({
      "is_cart_add": FieldValue.arrayRemove([Constants.userModel!.id])
    }, SetOptions(merge: true));
    isCartAdd = isCartAdd ?? [];
    isCartAdd!.remove(Constants.userModel!.id);
  }
}
