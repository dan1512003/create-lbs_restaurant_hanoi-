class Restaurant {
  final String fullId;
  final String osmId;
  final String price;
  final String kidsArea;
  final String babyFeeding;
  final String selfService;
  final String websiteMe;
  final String image;
  final String bar;
  final String indoor;
  final String contactIn;
  final String airConditioning;
  final String outdoor;
  final String email;
  final String contactFa;
  final String delivery;
  final String description;
  final String phone;
  final String openingHour;
  final String cuisine;
  final String website;
  final String addrStreet;
  final String name;
  final String payment;
  final String diet;
 final String starttime;
  Restaurant({
    required this.fullId,
    required this.osmId,
    required this.price,
    required this.kidsArea,
    required this.babyFeeding,
    required this.selfService,
    required this.websiteMe,
    required this.image,
    required this.bar,
    required this.indoor,
    required this.contactIn,
    required this.airConditioning,
    required this.outdoor,
    required this.email,
    required this.contactFa,
    required this.delivery,
    required this.description,
    required this.phone,
    required this.openingHour,
    required this.cuisine,
    required this.website,
    required this.addrStreet,
    required this.name,
    required this.payment,
    required this.diet,
    required this.starttime
  });

  // Factory constructor để tạo từ Map (ví dụ từ JSON)
  factory Restaurant.fromMap(Map<String, dynamic> map) {
    return Restaurant(
      fullId: map['full_id'] ?? '',
      osmId: map['osm_id'] ?? '',
      price: map['price'] ?? '',
      kidsArea: map['kids_area'] ?? '',
      babyFeeding: map['baby_feeding'] ?? '',
      selfService: map['self_service'] ?? '',
      websiteMe: map['website_me'] ?? '',
      image: map['image'] ?? '',
      bar: map['bar'] ?? '',
      indoor: map['indoor'] ?? '',
      contactIn: map['contact_in'] ?? '',
      airConditioning: map['air_conditioning'] ?? '',
      outdoor: map['outdoor'] ?? '',
      email: map['email'] ?? '',
      contactFa: map['contact_fa'] ?? '',
      delivery: map['delivery'] ?? '',
      description: map['description'] ?? '',
      phone: map['phone'] ?? '',
      openingHour: map['opening_hour'] ?? '',
      cuisine: map['cuisine'] ?? '',
      website: map['website'] ?? '',
      addrStreet: map['addr_street'] ?? '',
      name: map['name'] ?? '',
      payment: map['payment'] ?? '',
      diet: map['diet'] ?? '',
      starttime: map['starttime']?? '',
    );
  }

  // Chuyển sang Map (ví dụ lưu vào DB hoặc gửi API)
  Map<String, dynamic> toMap() {
    return {
      'full_id': fullId,
      'osm_id': osmId,
      'price': price,
      'kids_area': kidsArea,
      'baby_feeding': babyFeeding,
      'self_service': selfService,
      'website_me': websiteMe,
      'image': image,
      'bar': bar,
      'indoor': indoor,
      'contact_in': contactIn,
      'air_conditioning': airConditioning,
      'outdoor': outdoor,
      'email': email,
      'contact_fa': contactFa,
      'delivery': delivery,
      'description': description,
      'phone': phone,
      'opening_hour': openingHour,
      'cuisine': cuisine,
      'website': website,
      'addr_street': addrStreet,
      'name': name,
      'payment': payment,
      'diet': diet,
      'starttime':starttime
    };
  }
}
