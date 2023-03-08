import 'package:hive/hive.dart';

@HiveField(0)
class UserModel extends HiveObject{
  @HiveField(0)
  String? name;
  @HiveField(1)
  dynamic image;
  @HiveField(2)
  String? password;

  UserModel({
    this.name,

    this.image,
    this.password,
  });
  UserModel.fromJson(Map<dynamic, dynamic> json) {
    name = json['name'];
    image = json['image'];
    password = json['password'];
  }
}
