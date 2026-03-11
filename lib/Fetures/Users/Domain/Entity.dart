class UserEntity {
  UserEntity({
    
    required this.name,
    required this.address,
    required this.Content,
    required this.phone,
    required this.CreateAt, 
    required this.id,
  });

  final String id;
  final String name;
  final String address;
  final List<String> Content;
  final String phone;
  final String CreateAt;

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "address": address,
      "content": Content,
      "phone": phone,
      "CreateAt": CreateAt,
    };
  }
}
