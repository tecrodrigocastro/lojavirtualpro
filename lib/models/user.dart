import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  User({this.email, this.password, this.name, this.id});

 

  User.fromDOcument(DocumentSnapshot document){
    id = document.documentID;
    name = document.data['name']as String;
    email = document.data['email'] as String;
  }

  String email;
  String password;
  String name;
  String confirmPass;
  String id;

  DocumentReference get firestoreRef =>
  Firestore.instance.document('users/$id');

   CollectionReference get cartReference => firestoreRef.collection('cart');

  Future<void> saveData() async {
    await firestoreRef.setData(toMap());
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
    };
  }
}
