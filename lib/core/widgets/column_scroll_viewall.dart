import 'dart:math';

import 'package:flutter/material.dart';
import 'package:restaurant/data/model/restaurant.dart';
import '../../presentation/screens/restaurent_page.dart';
import '../../presentation/screens/restaurant_view_all_page.dart';
class ColumnScrollViewall extends StatelessWidget {
  final String title;
final List<Restaurant> restaurant;
final String town;
  const ColumnScrollViewall({
   super.key,
    required this.title ,
    required this.restaurant, 
    required this.town
  });

  @override
  Widget build(BuildContext context) {

    int itemCount= 10;
  final screenWidth = MediaQuery.of(context).size.width;

        double itemWidth = screenWidth*0.7 ;
      double itemHeight = screenWidth*0.6 ;
        
        
        if (itemWidth > 320) itemWidth = 320; 
        if (itemHeight > 280) itemHeight = 240; 
   

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.red,
            fontWeight: FontWeight.w500,
          ),
        ),
       GestureDetector(
onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => RestaurantViewAllPage(title: title,town:town,restaurant: restaurant,),
    ),
  );
},
          child:   Text(
         restaurant.length>itemCount ? 'SEE All' :'',
          style: TextStyle(
            fontSize: 14,
            color: Colors.red[300],
            fontWeight: FontWeight.w500,
          ),
        ),)
      ],
    ),
  ),
        const SizedBox(height: 8),
        SizedBox(
          height: itemHeight+80, 
          child: ListView.separated(
  scrollDirection: Axis.horizontal,
  itemCount: restaurant.length < itemCount ?restaurant.length :itemCount =11,
  physics: const BouncingScrollPhysics(),
  separatorBuilder: (context, index) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
               final item = restaurant[index];

        if(restaurant.length< itemCount){
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
  height: itemHeight,
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
        : null, 
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
      ],
    )
  ),
);

        }else{
                if (itemCount -1 > index) {
               
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
  height: itemHeight,
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
        : null, 
  ),
),
Container(
width: double.infinity,
  decoration: BoxDecoration(

  ),
  child: Text( item.name, style: TextStyle(
 fontWeight: FontWeight.bold,
    fontSize: 20,

  ),),
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

              } else {
                
                return Container(
                  width: 120,
                  height: 100,
                  margin: const EdgeInsets.symmetric(horizontal: 6),
                  decoration: BoxDecoration(
                   shape: BoxShape.circle,
                   border: Border.all(color: Colors.grey, width: 2),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.chevron_right,
                      size: 48, 
                      color: Colors.grey,
                    ),
                  ),
                );
              }
        }
            },
          ),
        ),
      ],
    );
  }
}
