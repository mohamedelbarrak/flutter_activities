import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

abstract class FireBaseModel<T> {
  String tableName;
  T? t;

  FireBaseModel(this.tableName);

  Future<void> add() async {
    await FirebaseFirestore.instance
        .collection(tableName)
        .doc(toJson()["id"])
        .set(toJson());
  }

  Future<T> getSingle(String id) async {
    var document =
        await FirebaseFirestore.instance.collection(tableName).doc(id).get();
    print("--------------------------------------------------------");
    print(id);
    print(document.data());
    return fromJson(document.data()!);
  }

  Future<List<T>> getList({
    dynamic field,
    dynamic isEqualTo,
    dynamic isNotEqualTo,
    dynamic isLessThan,
    dynamic isLessThanOrEqualTo,
    dynamic isGreaterThan,
    dynamic isGreaterThanOrEqualTo,
    dynamic arrayContains,
    List<dynamic>? arrayContainsAny,
    List<dynamic>? whereIn,
    List<dynamic>? whereNotIn,
    bool? isNull,
  }) async {
    print("entering");
    CollectionReference documentSReference =
        FirebaseFirestore.instance.collection(tableName);
    print("entering 2");

    if (field != null) {
      print("where condition");
      QuerySnapshot documents = await documentSReference
          .where(field,
              isEqualTo: isEqualTo,
              isNotEqualTo: isNotEqualTo,
              isLessThan: isLessThan,
              isLessThanOrEqualTo: isGreaterThanOrEqualTo,
              isGreaterThan: isGreaterThan,
              isGreaterThanOrEqualTo: isLessThanOrEqualTo,
              arrayContains: arrayContains,
              arrayContainsAny: arrayContainsAny,
              whereIn: whereIn,
              whereNotIn: whereNotIn,
              isNull: isNull)
          .get();

      List<T> list = [];
      documents.docs.forEach((element) {
        list.add(fromJsonList(element.data() as Map<String, dynamic>));
      });
      return list;
    }
    print(" no where condition");

    QuerySnapshot documents = await documentSReference.get();
    List<T> list = [];
    for (var element in documents.docs) {
      var user = fromJsonList(element.data() as Map<String, dynamic>);
      //  print(user);
      list.add(user);
      //print(list);
    }
    print(list);
    return list;
  }

  Future<void> update() async {
    await FirebaseFirestore.instance
        .collection(tableName)
        .doc(toJson()["id"])
        .set(toJson());
  }

  Map<String, dynamic> toJson();

  T fromJson(Map<String, dynamic> json);

  T fromJsonList(Map<String, dynamic> json);

  String generateRandomString(int len) {
    var r = Random();
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(len, (index) => _chars[r.nextInt(_chars.length)])
        .join();
  }
}

String generateRandomString(int len) {
  var r = Random();
  const chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  return List.generate(len, (index) => chars[r.nextInt(chars.length)]).join();
}
