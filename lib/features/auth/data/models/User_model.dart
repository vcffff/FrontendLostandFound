import 'package:firebase_auth/firebase_auth.dart';
import 'package:solaifrontend/features/auth/domain/entities/User_entity.dart';

class UserModel extends UserEntity{
  const UserModel({
    required super.name,
    required super.email,
    required super.id
  });
  factory UserModel.fromJson(Map<String,dynamic> json){
    return UserModel(name: json['name'], email: json['email'], id: json['id']);
  }
  Map<String,dynamic>toJson(){
    return {
      'id':id,
      'name':name,
      'email':email
    };
  }
      factory UserModel.fromFirebase(User user) {
    return UserModel(
      id: user.uid,
      email: user.email ?? '',
      name: user.displayName ?? '', 
    );
  }

}
