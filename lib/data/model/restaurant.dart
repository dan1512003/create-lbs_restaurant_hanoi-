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
  final double lat;
  final double lon;

  final String? starttime;
  double overallRating = 0;
  double ratefood = 0;
  double rateservice = 0;
  double rateambience = 0;
  int reviewCount = 0;

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
    required this.lat,
    required this.lon,
    this.starttime,
  });

  factory Restaurant.fromFeature(Map<String, dynamic> feature) {
    final properties = feature['properties'] ?? {};
    final geometry = feature['geometry'];
    final coordinates = geometry?['coordinates'];

    return Restaurant(
      fullId: properties['full_id'] ?? '',
      osmId: properties['osm_id'] ?? '',
      price: properties['price'] ?? '',
      kidsArea: properties['kids_area'] ?? '',
      babyFeeding: properties['baby_feeding'] ?? '',
      selfService: properties['self_service'] ?? '',
      websiteMe: properties['website_me'] ?? '',
      image: properties['image'] ?? '',
      bar: properties['bar'] ?? '',
      indoor: properties['indoor'] ?? '',
      contactIn: properties['contact_in'] ?? '',
      airConditioning: properties['air_conditioning'] ?? '',
      outdoor: properties['outdoor'] ?? '',
      email: properties['email'] ?? '',
      contactFa: properties['contact_fa'] ?? '',
      delivery: properties['delivery'] ?? '',
      description: properties['description'] ?? '',
      phone: properties['phone'] ?? '',
      openingHour: properties['opening_hour'] ?? '',
      cuisine: properties['cuisine'] ?? '',
      website: properties['website'] ?? '',
      addrStreet: properties['addr_street'] ?? '',
      name: properties['name'] ?? '',
      payment: properties['payment'] ?? '',
      diet: properties['diet'] ?? '',
      starttime: properties['starttime'], 
      lon: coordinates != null ? (coordinates[0] as num).toDouble() : 0.0,
      lat: coordinates != null ? (coordinates[1] as num).toDouble() : 0.0,
    );
  }
}
