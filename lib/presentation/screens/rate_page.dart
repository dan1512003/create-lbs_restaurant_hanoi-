// ignore_for_file: avoid_print

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/data/model/restaurant.dart';
import 'package:restaurant/data/model/review.dart';
import 'package:restaurant/data/model/user.dart';
import 'package:restaurant/presentation/state/provider/restaurant_provider.dart';
import 'package:restaurant/presentation/state/provider/user_provider.dart';

class RatePage extends StatefulWidget {
  const RatePage({super.key,required this.restaurant});
 final Restaurant restaurant;
  @override
  State<RatePage> createState() => _RatePageState();
}

class _RatePageState extends State<RatePage> {
  final List<String> namerate = ['FOOD', 'SERVICE', 'AMBIENCE'];

 
  List<int> categoryRatings = [0, 0, 0];

  
  int overallRating = 0;
   Review? review;
   late User user;
 
  final TextEditingController descriptionController = TextEditingController();
@override
void initState() {
  super.initState();


  WidgetsBinding.instance.addPostFrameCallback((_) async {
 
    final provider =
        Provider.of<RestaurantProvider>(context, listen: false);
       final userProvider = Provider.of<UserProvider>(context, listen: false);
  user = userProvider.user!;
 final data =await provider.getReviewEmailID(user.email, widget.restaurant.osmId);
  print("lengh ${data.length}");
  if(data.isNotEmpty){
 review = data.first;

      
      setState(() {
        overallRating = review!.overallrating ?? 0;
        categoryRatings[0] = review!.ratefood ?? 0;
        categoryRatings[1] = review!.rateservice ?? 0;
        categoryRatings[2] = review!.rateambience ?? 0;
       
      });
  }
  });
}
  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }

  /// Hàm build các ngôi sao có thể bấm
  Widget buildStars({
    required int currentRating,
    required void Function(int) onTapStar,
    required double size,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        return GestureDetector(
          onTap: () {
            onTapStar(index + 1); 
          },
          child: Icon(
            Icons.star,
            size: size,
            color: index < currentRating ? Colors.amber : Colors.grey[300],
          ),
        );
      }),
    );
  }
String getCurrentTime() {
  DateTime now = DateTime.now(); 
  DateFormat formatter = DateFormat('dd/MM/yyyy HH:mm:ss'); 
  return formatter.format(now);
}
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body:   Consumer<RestaurantProvider>(

         builder: (context, provider, _) {
          return   Column(
        children: [
          // AppBar
          Container(
            height: min(max(screenHeight * 0.1, 30.0), 50),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w500,
                      fontSize: (screenWidth * 0.04).clamp(12.0, 20.0),
                    ),
                  ),
                ),
                const Text(
                  'Tên nhà hàng',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 40),
              ],
            ),
          ),

          // Body
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    const SizedBox(height: 10),

                    // Overall Rating
                    Container(
                      width: screenWidth,
                      height: min(max(screenHeight * 0.1, 100.0), 150.0),
                      color: Colors.red,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Overall Rate',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 10),
                          buildStars(
                            currentRating: overallRating,
                            size: min(max(screenWidth * 0.15, 20.0), 50),
                            onTapStar: (rating) {
                              setState(() {
                                overallRating = rating;
                              });
                            },
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Individual Ratings
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: namerate.length,
                      itemBuilder: (context, index) {
                        final name = namerate[index];
                        return Container(
                          width: screenWidth,
                          height: min(max(screenHeight * 0.12, 80.0), 160.0),
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                name,
                                style: TextStyle(
                                  fontSize: (screenWidth * 0.04).clamp(12.0, 20.0),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              buildStars(
                                currentRating: categoryRatings[index],
                                size: min(max(screenWidth * 0.12, 15.0), 40),
                                onTapStar: (rating) {
                                  setState(() {
                                    categoryRatings[index] = rating;
                                  });
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 20),

                    // Description (Command)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Describe your experience:",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          decoration: BoxDecoration(),
                          height: min(max(screenHeight * 0.1, 100), 150),
                          child: TextField(
                            controller: descriptionController,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            expands: true,
                            decoration: InputDecoration(
                              alignLabelWithHint: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),

          // Submit Button
          SizedBox(
            width: screenWidth,
            height: min(max(screenHeight * 0.1, 50), 60),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
              ),
              onPressed: () {
                if(review !=null){
                provider.editReview(rateFood: categoryRatings[0], 
                rateService: categoryRatings[1],
                 rateAmbience: categoryRatings[2],
                overallRating: overallRating,
                 command: descriptionController.text, 
                  idRestaurant: widget.restaurant.osmId, 
                  email: user.email, date: getCurrentTime());
                }else{
                  provider.addReview(rateFood: categoryRatings[0], 
                rateService: categoryRatings[1],
                 rateAmbience: categoryRatings[2],
                overallRating: overallRating,
                 command: descriptionController.text, 
                  idRestaurant: widget.restaurant.osmId, 
                  email: user.email, date: getCurrentTime());
                }
                
                print("Overall Rating: $overallRating");
                print("Category Ratings: $categoryRatings");
                print("Description: ${descriptionController.text}");
                Navigator.pop(context);
              },
              child: const Text(
                "Submit",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      );
         }),
      
      
     
    );
  }
}
