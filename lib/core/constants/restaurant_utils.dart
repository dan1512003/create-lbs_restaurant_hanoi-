import 'package:intl/intl.dart';
import 'package:restaurant/data/model/restaurant.dart';
import 'package:restaurant/data/model/review.dart';
import 'package:restaurant/data/repositories/search_repository.dart';


bool checkSchedule(String schedule, String currentDay, DateTime now) {
  Map<String, int> dayOrder = {
    'Mo': 1,
    'Tu': 2,
    'We': 3,
    'Th': 4,
    'Fr': 5,
    'Sa': 6,
    'Su': 7,
  };

  // Tách từng phần cách nhau bởi ";"
  List<String> parts = schedule.split(';');

  for (var part in parts) {
    part = part.trim();
    if (part.isEmpty) continue;

    // Tách ngày và khung giờ
    RegExp dayReg = RegExp(r'^([A-Za-z]{2})(?:-([A-Za-z]{2}))?');
    var dayMatch = dayReg.firstMatch(part);
    if (dayMatch == null) continue;

    String startDay = dayMatch.group(1)!;
    String? endDay = dayMatch.group(2);
    
    // Lấy các ngày trong phần này
    List<String> days = [];
    if (endDay != null) {
      int startIndex = dayOrder[startDay]!;
      int endIndex = dayOrder[endDay]!;
      for (var i = startIndex; i <= endIndex; i++) {
        days.add(dayOrder.keys.firstWhere((k) => dayOrder[k] == i));
      }
    } else {
      days.add(startDay);
    }

    if (!days.contains(currentDay)) continue;

    // Lấy các khoảng giờ
    String timePart = part.substring(dayMatch.group(0)!.length).trim();
    List<String> ranges = timePart.split(',');
    for (var range in ranges) {
      range = range.trim();
      List<String> hm = range.split('-');
      if (hm.length != 2) continue;

      int startMinutes = _toMinutes(hm[0]);
      int endMinutes = _toMinutes(hm[1]);
      int nowMinutes = now.hour * 60 + now.minute;

      if (nowMinutes >= startMinutes && nowMinutes <= endMinutes) {
        return true;
      }
    }
  }
  return false;
}

int _toMinutes(String hm) {
  List<String> parts = hm.split(':');
  int h = int.parse(parts[0]);
  int m = int.parse(parts[1]);
  return h * 60 + m;
}

bool isDateInCurrentMonth(String dateStr) {
 
  DateTime date = DateFormat('dd/MM/yyyy').parse(dateStr);

  DateTime now = DateTime.now();

  return date.year == now.year && date.month == now.month;
}


Future<Map<String, Restaurant>> addReviewtoRestaurant( List<Restaurant> restaurant,SearchRepository  repository)async{
   List datareview= await repository.getreview();
   List<Review> review =datareview.map((d)=>Review.fromJson(d)).toList();


      final restaurantMap = {for (var r in restaurant) r.osmId: r};
    for (var r in review) {

     
      if (restaurantMap.containsKey(r.idRestaurant)) {
        final res = restaurantMap[r.idRestaurant]!;
        res.overallRating += r.overallrating ?? 0;
        res.ratefood += r.ratefood ?? 0;
        res.rateambience+= r.rateambience ?? 0;
        res.rateservice += r.rateservice ?? 0;
         res.reviewCount += 1;
      }
  }
return restaurantMap;
}