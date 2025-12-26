import 'dart:math';

import 'package:flutter/material.dart';
import 'package:restaurant/data/model/restaurant.dart';
import '../../presentation/screens/restaurent_page.dart';
class ColumnScroolhighrate extends StatelessWidget {
 
  final List<Restaurant> restauranthightrate;
  const ColumnScroolhighrate({
    super.key,
    required this.restauranthightrate
  });

  @override
  Widget build(BuildContext context) {

 
  final screenWidth = MediaQuery.of(context).size.width;

        double itemWidth = screenWidth ;

        
        
        if (itemWidth > 400) itemWidth = 400; 

   

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'High rate',
          style: const TextStyle(
            fontSize: 14,
            color: Colors.red,
            fontWeight: FontWeight.w500,
          ),
        ),
      //  Text(
      //     'SEE All',
      //     style: TextStyle(
      //       fontSize: 14,
      //       color: Colors.red[300],
      //       fontWeight: FontWeight.w500,
      //     ),
      //   ),
      ],
    ),
  ),
        const SizedBox(height: 8),
        SizedBox(
          height: 300, 
          child: ListView.separated(
  scrollDirection: Axis.horizontal,
  itemCount:restauranthightrate.length,
  physics: const BouncingScrollPhysics(),
  separatorBuilder: (context, index) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
             final item = restauranthightrate[index];
   
                return GestureDetector(
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RestaurentPage(restaurant: item,),
      ),
    );
  },
  child: Container(
   width: itemWidth,
    decoration: BoxDecoration(
   
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
Container(
  width: itemWidth,
  height: 200,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(12),
    
    color: item.image.isNotEmpty ? null : Colors.grey, 
    image: item.image.isNotEmpty
        ? DecorationImage(
            image: NetworkImage(
             item.image,
            ),
            fit: BoxFit.cover,
          )
        : null, // nếu rỗng thì không có ảnh
  ),
),
Container(
width: double.infinity,
  decoration: BoxDecoration(

  ),
  child: Text(
  item.name,
  style: TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 20,
  ),
  maxLines: 1, 
  overflow: TextOverflow.ellipsis, 
)
),
// Container(
// width: double.infinity,
//   decoration: BoxDecoration(

//   ),
//   child: Text('179 Restaurant', style: TextStyle(


//   ),),
// ),
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
            widthFactor: starFill, // 0.0 → 1.0
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
      ],
    )
  ),
);

            },
          ),
        ),
      ],
    );
  }
}
