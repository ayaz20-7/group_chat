import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:group_chat/features/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    super.name = "username",
    super.email,
    super.phoneNumber,
    super.isOnline,
    super.uid,
    super.status = "",
    super.profileUrl,
    super.dob,
    super.gender,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      isOnline: json['isOnline'],
      uid: json['uid'],
      status: json['status'],
      profileUrl: json['profileUrl'],

    );
  }

  factory UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    return UserModel(
      name: snapshot.get('name'),
      email: snapshot.get('email'),
      phoneNumber: snapshot.get('phoneNumber'),
      isOnline: snapshot.get('isOnline'),
      uid: snapshot.get('uid'),
      status: snapshot.get('status'),
      profileUrl: snapshot.get('profileUrl'),
      dob: snapshot.get('dob'),
      gender: snapshot.get('gender'),
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      "name": name,
      "email": email,
      "phoneNumber": phoneNumber,
      "isOnline": isOnline,
      "uid": uid,
      "status": status,
      "profileUrl": profileUrl,
      "dob": dob,
      "gender": gender,
    };
  }
}
