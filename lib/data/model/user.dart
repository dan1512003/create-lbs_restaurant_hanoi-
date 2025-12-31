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
      image: json['image']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
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

 

  String get firstName {
    if (name == null || name!.trim().isEmpty) return '';
    return name!.trim().split(' ').first;
  }

  String get lastName {
    if (name == null || name!.trim().isEmpty) return '';
    final parts = name!.trim().split(' ');
    if (parts.length <= 1) return '';
    return parts.sublist(1).join(' ');
  }


}
