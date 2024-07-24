// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';

class Rider {
  String id;
  String name;
  String phoneNumber;
  String idCardNumber;
  String plateNumber;
  String avatarImgUrl;
  // String status; // 'online', 'offline'
  // DateTime? shiftStart;
  // DateTime? shiftEnd;

  Rider({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.idCardNumber,
    required this.plateNumber,
    required this.avatarImgUrl,
  });
  factory Rider.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return Rider(
      id: doc.id,
      name: data['name'] as String,
      phoneNumber: data['phoneNumber'] as String,
      plateNumber: data['plateNumber'] as String,
      idCardNumber: data['idCardNumber'] as String,
      avatarImgUrl: data['avatarImgUrl'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
      'idCardNumber': idCardNumber,
      'plateNumber': plateNumber,
      'avatarImgUrl': avatarImgUrl,
    };
  }
}
