class NominatimPlace {
  final String displayName;
  final double lat;
  final double lon;
  final String name;
  final String osmId;
  final String category;

  NominatimPlace({
    required this.displayName,
    required this.lat,
    required this.lon,
    required this.name,
    required this.osmId,
    required this.category,
  });

  factory NominatimPlace.fromJson(Map<String, dynamic> feature) {
    final properties = feature['properties'] ?? {};
    final geometry = feature['geometry'];
    final coordinates = geometry?['coordinates'];

    return NominatimPlace(
      displayName: properties['display_name'] ?? '',
      name: properties['name'] ?? '',
      osmId: (properties['osm_id'] ?? '').toString(),
      category: properties['category'] ?? '',
      lon: coordinates != null ? (coordinates[0] as num).toDouble() : 0.0,
      lat: coordinates != null ? (coordinates[1] as num).toDouble() : 0.0,
    );
  }
}
