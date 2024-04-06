import 'dart:io';

class AppUser{
  String? uid;
  String? email;
  String? phone;
  Gender? gender;
  String? birthdate;
  String? userName;
  String? profilePicUrl;
  String? type;
  bool isAnonymous = false;

  AppUser({
    this.uid,
    this.email,
    this.phone,
    this.gender,
    this.birthdate,
    this.userName,
    this.profilePicUrl,
    this.type,
    this.isAnonymous = false
  });
}

enum Gender{
  male,
  female,
  other
}