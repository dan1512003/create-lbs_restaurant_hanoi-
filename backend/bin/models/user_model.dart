class User {

  final String email;
  final String phone;
  final String? image;
  final String? name;

  User({

    required this.email,
    required this.phone,
    this.image,
    this.name,
  });

  
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
   
      email: json['email']?.toString() ?? '',
      phone: json['phone']?.toString() ?? '',
      image: json['image']?.toString(),
      name: json['name']?.toString(),
    );
  }

 
  Map<String, dynamic> toJson() {
    return {
   
      'email': email,
      'phone': phone,
      'image': image,
      'name': name,
    };
  }
}
