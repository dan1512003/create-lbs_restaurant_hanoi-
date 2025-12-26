class Ward {
  final String fullId;  
  final String osmId;    
  final String name;     
  final String nameEn;   
  final String image;
  Ward({
    required this.fullId,
    required this.osmId,
    required this.name,
    required this.nameEn,
    required this.image
  });

  
  factory Ward.fromMap(Map<String, dynamic> map) {
    return Ward(
      fullId: map['full_id'] ?? '',
      osmId: map['osm_id'] ?? '',
      name: map['name'] ?? '',
      nameEn: map['name_en'] ?? '',
      image: map['image'] ?? '',
    );
  }


  Map<String, dynamic> toMap() {
    return {
      'full_id': fullId,
      'osm_id': osmId,
      'name': name,
      'name_en': nameEn,
      'image':image
    };
  }
}
