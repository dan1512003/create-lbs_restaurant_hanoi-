class Diet{
  final int id;
  final String diet;
  final String image;

  Diet({
    required this.id,
    required this.diet,
    required this.image,
  });


  factory Diet.fromJson(Map<String, dynamic> json) {
    return Diet(
      id: json['id'] as int,
      diet: json['diet'] as String,
      image: json['image'] as String,
    );
  }

 
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'diet': diet,
      'image': image,
    };
  }
}
