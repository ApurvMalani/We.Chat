import 'dart:core';

// 1
class UserModel {
  String? id;
  String? name;
  String? email;
  String? profilepic;

  UserModel({this.id, this.name, this.email, this.profilepic});

  // 2                                          // 3
  UserModel.this_User_Map(Map<String, dynamic> mapuser) {
    id = mapuser['ids'];
    name = mapuser['names'];
    email = mapuser['emails'];
    profilepic = mapuser['profilepics'];
  }

  // 4
  Map<String, dynamic> tooMaps() {
    return {
      'ids': id,
      'names': name,
      'email': email,
      'profilepics': profilepic
    };
  }
}
