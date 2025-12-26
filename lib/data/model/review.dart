class Review {
  final int id; 
  final int? ratefood;
  final int? rateservice;
  final int? rateambience;
  final int? overallrating;
  final String? command;
  final String? idRestaurant;
  final String? email;
  final String? date;
  final String? like;

  Review({
    required this.id,
    this.ratefood,
    this.rateservice,
    this.rateambience,
    this.overallrating,
    this.command,
    this.idRestaurant,
    this.email,
    this.date,
    this.like,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'] as int,
      ratefood: json['ratefood'] != null ? json['ratefood'] as int : null,
      rateservice: json['rateservice'] != null ? json['rateservice'] as int : null,
      rateambience: json['rateambience'] != null ? json['rateambience'] as int : null,
      overallrating : json['overallrating'] != null ? json['overallrating'] as int : null,
      command: json['command'] as String?,
      idRestaurant: json['id_restaurant'] as String?,
      email: json['email'] as String?,
      date: json['date'] as String?,
      like: json['like'] as String?,
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
      'date': date,
      'like': like,
    };
  }
}
