class UserModel {
  String? id;
  String? email;
  String? name;
  String? phoneNumber;
  String? photoUrl;
  
  UserModel({this.id, this.email, this.name, this.phoneNumber, this.photoUrl});

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      email: map['email'],
      phoneNumber: map['phoneNumber'],
      name: map['name'],
      photoUrl: map['photoUrl'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'phoneNumber': phoneNumber,
      'photoUrl': photoUrl,
    };
  }
}
