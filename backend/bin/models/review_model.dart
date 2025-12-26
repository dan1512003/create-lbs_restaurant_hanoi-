class Review {
  final int id;
  final int ratefood;
  final int rateservice;
  final int rateambience;
  final double overallrating;
  final String command;
  final String idRestaurant;
  final int email;
  final DateTime date;
  final bool like;

  Review({
    required this.id,
    required this.ratefood,
    required this.rateservice,
    required this.rateambience,
    required this.overallrating,
    required this.command,
    required this.idRestaurant,
    required this.email,
    required this.date,
    required this.like,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'] as int,
      ratefood: json['ratefood'] as int,
      rateservice: json['rateservice'] as int,
      rateambience: json['rateambience'] as int,
      overallrating: (json['overallrating'] as num).toDouble(),
      command: json['command'] as String,
      idRestaurant: json['id_restaurant'] as String,
      email: json['email'] as int,
      date: DateTime.parse(json['date']),
      like: json['like'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ratefood': ratefood,
      'rateservice': rateservice,
      'rateambience': rateambience,
      'overallrating': overallrating,
      'command': command,
      'id_restaurant': idRestaurant,
      'email': email,
      'date': date.toIso8601String(),
      'like': like,
    };
  }
}
