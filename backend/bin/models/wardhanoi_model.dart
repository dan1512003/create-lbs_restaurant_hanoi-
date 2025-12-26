class Ward {
  final String fullId;  
  final String osmId;    
  final String name;     
  final String nameEn;   

  Ward({
    required this.fullId,
    required this.osmId,
    required this.name,
    required this.nameEn,
  });

  
  factory Ward.fromMap(Map<String, dynamic> map) {
    return Ward(
      fullId: map['full_id'] ?? '',
      osmId: map['osm_id'] ?? '',
      name: map['name'] ?? '',
      nameEn: map['name_en'] ?? '',
    );
  }


  Map<String, dynamic> toMap() {
    return {
      'full_id': fullId,
      'osm_id': osmId,
      'name': name,
      'name_en': nameEn,
    };
  }
}
