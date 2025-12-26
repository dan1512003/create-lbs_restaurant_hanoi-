import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/data/model/restaurant.dart';
import 'package:restaurant/data/model/review.dart';
import 'package:restaurant/data/model/user.dart';
import 'package:restaurant/presentation/state/provider/restaurant_provider.dart';


import '../../core/widgets/sort_bottom_sheet.dart';
class ReviewRestaurant extends StatefulWidget {
    final Restaurant restaurant;
  
  const ReviewRestaurant({super.key,required this.restaurant});

  @override
  State<ReviewRestaurant> createState() => _ReviewRestaurantState();
}

class _ReviewRestaurantState extends State<ReviewRestaurant> {
  String? selectedValue;
   
  String selectedSort = 'Most recent';
    Map<String, Future<User?>> userFutures = {};
  List<Review> reviews=[];
//widget builrateitem
Widget buildRateItem({
  required String value,
  required String title,
}) {
  return Container(
    margin: const EdgeInsets.only(top: 20),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(),
       
          child: Text(
            value,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        const SizedBox(height: 4),

        Container(
          decoration: BoxDecoration(),
          
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
        ),
      ],
    ),
  );
}
//hàm tính phần trăm số sao

double widthFactorOfStar(int star, Map<int, int> starCount) {
  int fiveStarCount = starCount[5] ?? 0;

  int totalReviews = starCount.values.fold(0, (sum, v) => sum + v);

  if (fiveStarCount > 0) {
  
    return starCount[star]! / fiveStarCount;
  } else if (totalReviews > 0) {
    
    return starCount[star]! / totalReviews;
  } else {
    
    return 0.0;
  }
}
  
   //hàm lấy màu ngẫu nhiên

Map<String, Color> userColors = {};


Color getUserColor(String email) {
  if (!userColors.containsKey(email)) {
    final random = Random();
    userColors[email] = Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }
  return userColors[email]!;
}

// sắp xếp review
void sortReviewsInPlace(String selectedSort) {

 
  switch (selectedSort) {
    case 'Most recent':
   
      reviews.sort((a, b) => b.id.compareTo(a.id));
      break;

    case 'Highest rating':
      
      reviews.sort((a, b) {
        int ratingA = a.overallrating ?? 0;
        int ratingB = b.overallrating ?? 0;
        return ratingB.compareTo(ratingA);
      });
      break;

    case 'Lowest rating':
     
      reviews.sort((a, b) {
        int ratingA = a.overallrating ?? 0;
        int ratingB = b.overallrating ?? 0;
        return ratingA.compareTo(ratingB);
      });
      break;

    default:
      break; 
  }
}



  @override
  Widget build(BuildContext context) {
  //    final userProvider = context.watch<UserProvider>();
  //  User? user = userProvider.user;
    return Scaffold(
          backgroundColor: Colors.white,
      body: Consumer<RestaurantProvider>(

         builder: (context, provider, _) {
          reviews=provider.command;


return  Column(

        children: [
          //appbar
 Container(
              height: 50,
            
              decoration: const BoxDecoration(),
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                        GestureDetector(
                          onTap: (){
                          Navigator.pop(context);
                    },
                       child:  Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                        
                        Icon(
                        Icons.chevron_left,
                         color:Color.fromARGB(192, 0, 0, 0),
                        size: 30,
                      ),
                 Container(
  margin: const EdgeInsets.only(top: 5), 
  child: const Text(
    'Back',
    style: TextStyle(
      fontSize: 14,
      color: Colors.black,
      fontWeight: FontWeight.w500,
    ),
  ),
)

                       ],)
                      ),
                                   Container(
     width: MediaQuery.of(context).size.width * 0.4,
  margin: const EdgeInsets.only(top: 5), 
  child:  Text(
  widget.restaurant.name,
  style: const TextStyle(
    fontSize: 14,
    color: Colors.black,
    fontWeight: FontWeight.w500,
  ),
  maxLines: 1,
  overflow: TextOverflow.ellipsis, 
),

),
  const SizedBox(width: 4),
    
                    ],
                  ),
            ),

          //BODDY
SingleChildScrollView(
  child: Container(
    decoration: BoxDecoration(),
    child: Column(

      children: [
Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  
  children: [
                Container(
  margin: const EdgeInsets.only(top: 5), 
  child: const Text(
    'Review',
    style: TextStyle(
      fontSize: 14,
      color: Colors.black,
      fontWeight: FontWeight.w500,
    ),
  ),
),
Container(
  decoration: BoxDecoration(
    border: Border.all(
      width: 0.5,
      color: Colors.grey
    ),
  borderRadius: BorderRadius.all(
  Radius.circular(6),
),
  ),
  child:GestureDetector(
  onTap: () async {
            final result = await Navigator.of(context).push<String>(
              PageRouteBuilder(
                opaque: false, 
                  barrierColor: Colors.black.withValues(alpha: 0.5), 
                pageBuilder: (context, animation, secondaryAnimation) {
                  return SortBottomSheet(
                    selected: selectedSort,
                  );
                },
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  final tween = Tween(begin: const Offset(0, 1), end: Offset.zero);
                  return SlideTransition(
                    position: animation.drive(tween),
                    child: child,
                  );
                },
              ),
            );

            if (result != null) {
              setState(() {
                selectedSort = result;
                sortReviewsInPlace( selectedSort);
              });
            }
          },
    child: Row(
    children: [
       Text(selectedSort),
      Icon(Icons.keyboard_arrow_down)
    ],
  ),
  )
)


],),
//Rate
Container(
  margin: EdgeInsets.only(top: 10,bottom: 20),
    decoration:BoxDecoration(
    border: Border(
      bottom: BorderSide(
        width: 0.5,
        color: Colors.grey
      )
    )
  ),
  child:Row(
crossAxisAlignment: CrossAxisAlignment.start,
  children: [
   Container(
  
  decoration: const BoxDecoration(


  ),
  child: Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        decoration: BoxDecoration(),
        child: Text("Overall rating",
        style: TextStyle(
          fontSize:  min(max( MediaQuery.of(context).size.width*0.03,16), 20)
        ),
        ),
      ),
      Container(
       alignment: Alignment.centerLeft,
        decoration: BoxDecoration(),
        child: Text(
          widget.restaurant.reviewCount == 0
            ? "0.0 "
            : "${widget.restaurant.overallRating / widget.restaurant.reviewCount}",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize:  min(max( MediaQuery.of(context).size.width*0.03,16), 20)
        ),
        ),
      ),
      Container(
        
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
        ),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
               ...List.generate(5, (index) {
          
  final double starFill =
    (((widget.restaurant.reviewCount == 0
            ? 0.0
            : widget.restaurant.overallRating / widget.restaurant.reviewCount) - index)
    .clamp(0.0, 1.0))
    .toDouble();
    return Stack(
      children: [
        Icon(
          Icons.star_border,
          color: Colors.grey,
            size:   min(max( MediaQuery.of(context).size.width*0.03,16), 20)
        ),
        ClipRect(
          child: Align(
            alignment: Alignment.centerLeft,
            widthFactor: starFill, 
            child: Icon(
              Icons.star,
              color: Colors.amber,
                size:   min(max( MediaQuery.of(context).size.width*0.03,16), 20)
            ),
          ),
        ),
      ],
    );
  }),
       
            ],
          ),
      ),
    ],
  ),
)
,
Expanded(child:   Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [

       ...List.generate(5, (index) {
  int star = 5 - index; 
 double factor = (star == 5) 
    ? 1.0 
    : widthFactorOfStar(star, provider.starCount);


  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      SizedBox(
        width: 20,
        child: Text("$star"),
      ),

      Container(
        width: min(
            max(MediaQuery.of(context).size.width * 0.3, 250), 350),
        height: min(
            max(MediaQuery.of(context).size.width * 0.03, 7), 13),
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(100),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: factor, 
            child: Container(
              color: Colors.red,
            ),
          ),
        ),
      ),

    ],
  );
}),

      ],
    ),
    )

  ],
),
),

//danh sách avartar
...List.generate(
 reviews.length,
  (index) {
    final item = reviews[index];

  
    userFutures[item.email!] ??= provider.getUser(item.email!);

    return FutureBuilder<User?>(
      future: userFutures[item.email!],
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
        
return const SizedBox.shrink();
        }

        if (!snapshot.hasData) {
          return const SizedBox.shrink();
        }

        final user = snapshot.data;
        if (user == null) return const SizedBox.shrink();

        final initial = user.name![0].toUpperCase();
        return Container(
        
         margin: EdgeInsets.only(left: 10),
     decoration:BoxDecoration(
    border: Border(
      bottom: BorderSide(
        width: 0.3,
        color: Colors.grey
      )
    )
  ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: min(max(MediaQuery.of(context).size.width * 0.05, 50), 70),
                    height: min(max(MediaQuery.of(context).size.width * 0.05, 50), 70),
                    alignment: Alignment.center,
                    child: CircleAvatar(
                      radius: 35,
                      backgroundColor:
                          (user.image == null || user.image!.isEmpty)
                              ? getUserColor(user.email)
                              : Colors.transparent,
                      backgroundImage: (user.image != null && user.image!.isNotEmpty)
                          ? NetworkImage(user.image!)
                          : null,
                      child: (user.image == null || user.image!.isEmpty)
                          ? Text(
                              initial,
                              style: const TextStyle(fontSize: 40, color: Colors.white),
                            )
                          : null,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(user.name ?? ""),
                  ),
                ],
              ),
              // Rate
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: List.generate(5, (i) {
                  return Icon(
                    i < item.overallrating! ? Icons.star : Icons.star_border,
                    color: i < item.overallrating! ? Colors.amber : Colors.grey,
                    size: min(max(MediaQuery.of(context).size.width * 0.03, 16), 20),
                  );
                }),
              ),
              // Command
              Text(item.command ?? ""),
            ],
          ),
        );
      },
    );
  },
),


  


      ],
    ),
  ),
)


        ],
      );
         }),
      
    );
  }
}