import 'dart:math';

import 'package:flutter/material.dart';
import 'package:restaurant/data/model/restaurant.dart';
import 'package:restaurant/presentation/screens/restaurent_page.dart';

class RestaurantViewAllPage extends StatefulWidget {
final String title;
final String town;
final List<Restaurant> restaurant;
  const RestaurantViewAllPage({
    super.key,
    required this.title, 
    required this.town,
    required this.restaurant,
    });

  @override
  State<RestaurantViewAllPage> createState() => _RestaurantViewAllPageState();
}

class _RestaurantViewAllPageState extends State<RestaurantViewAllPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
     
          final double maxWidth = constraints.maxWidth;

       
          final bool isSmall = maxWidth < 400;
          final bool isMedium = maxWidth >= 400 && maxWidth < 800;
  
      
      
      
          double imageWidth = maxWidth * 0.1;
          double imageHeight = maxWidth * 0.1;

         
          if (imageWidth < 100) imageWidth = 100;
          if (imageWidth > 150) imageWidth  = 150;

          if (imageHeight < 100) imageHeight = 100;
          if (imageHeight > 150) imageHeight = 150;


     
               

          double nameFont = isSmall
              ? 10
              : isMedium
                  ? 15
                  : 20;

          // double subtitleFont = isSmall
          //     ? 10
          //     : isMedium
          //         ? 15
          //         : 20;

          return Column(
            children: [
              //appbar
              Container(
                height: 50,
          decoration: BoxDecoration(),
                child: Row(
                  children: [
                       GestureDetector(
                          onTap: (){
                          Navigator.pop(context);
                    },
                       child:    Icon(
                        Icons.chevron_left,
                          color:Color.fromARGB(192, 0, 0, 0),
                        size: 30,
                      ),
                      ),
                    const SizedBox(width: 4),
                    const Text(
                      'Back',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              //body
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      
                       ...List.generate(widget.restaurant.length, (index){
  final item = widget.restaurant[index];


  return  GestureDetector(

     onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RestaurentPage(restaurant: item,),
      ),
    );
  },
    child:  Container(
                            
                  
                            decoration: BoxDecoration(
                        
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                              
                                Container(
                                  width: imageWidth,
                                  height: imageHeight,
                           
                               
                                  decoration: BoxDecoration(
                                             
                                  color: item.image.isNotEmpty ? null : Colors.grey, 
    image: item.image.isNotEmpty
        ? DecorationImage(
            image: NetworkImage(
             item.image,
            ),
            fit: BoxFit.cover,
          )
        : null, 
                                  ),
                                ),

                          
                                Expanded(
                                  child: Container(
                             
                                  height: imageHeight + 10,
                                  decoration: BoxDecoration(

                                        border: Border(
                                bottom: BorderSide(
                                  color: Colors.grey.shade300,
                                  width: 1,
                                ),
                              ),
                                    ),
                                    child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                   Container(
                                     height: imageHeight,
                                    margin: EdgeInsets.only(left: 10),
                                    decoration: BoxDecoration(),
                                    child: Column(
                                   crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                         Container(
                                         
                                          decoration: BoxDecoration(),
                                          child: Column(
                                                crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                            children: [
                                                Text(
                                        item.name,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: nameFont,
                                        ),
                                      ),
                                             Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children:  [
         ...List.generate(5, (index) {
          
  final double starFill =
    (((item.reviewCount == 0
            ? 0.0
            : item.overallRating / item.reviewCount) - index)
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
             
           
        Container(
    
        decoration: BoxDecoration(),
        child: Text("${item.reviewCount}reviews",
        style: TextStyle(
          fontSize: 
        min(max( MediaQuery.of(context).size.width*0.03,7), 13)
        ),),
      ),
            ],
          ),

          Container(
width: double.infinity,
  decoration: BoxDecoration(

  ),
  child: Text(item.openingHour, style: TextStyle(
color: Colors.blue

  ),),
),
                                      // const SizedBox(height: 4),
                                      // Text(
                                      //   '179 Restaurant',
                                      //   style: TextStyle(
                                      //     fontSize: subtitleFont,
                                      //     color: Colors.black87,
                                      //   ),
                                      // ),
                                            ],
                                          ),
                                         ),
                             
                                   

                                    ],

                                    ),
                                   )
                                    ],
                                  ),
                                  )
                                ),
                              ],
                            ),
                          ),
  );
                       })

                       
                        
                        ],
                      ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
