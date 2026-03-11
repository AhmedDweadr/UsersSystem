import 'package:my_app/Fetures/Users/Domain/Entity.dart';

class Usermodel extends UserEntity {
  Usermodel({
    required super.name,
    required super.address,
    required super.Content,
    required super.phone,
    required super.CreateAt,
     required super.id,
  });

  factory Usermodel.fromJson(Map<String, dynamic> map) {
    return Usermodel(
      name: map["name"],
      address: map["address"],
      Content:[],// map["content"],
      phone: map["phone"],
      CreateAt: map["created_at"], 
      id: map['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "address": address,
      "content": Content,
      "phone": phone,
      "CreateAt": CreateAt,
    };
  }

  UserEntity toEntity() {
    return UserEntity(
      name: name,
      address: address,
      Content: Content,
      phone: phone,
      CreateAt: CreateAt, 
      id: id,
    );
  }
}
