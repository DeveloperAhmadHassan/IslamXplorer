import 'dart:io';

class AppUser{
  String? uid;
  String? email;
  String? phone;
  Gender? gender;
  String? birthdate;
  String? userName;
  File? profilePic;
  String? type;
  AppUser({
    this.uid,
    this.email,
    this.phone,
    this.gender,
    this.birthdate,
    this.userName,
    this.profilePic,
    this.type
  });
}

enum Gender{
  male,
  female,
  other
}