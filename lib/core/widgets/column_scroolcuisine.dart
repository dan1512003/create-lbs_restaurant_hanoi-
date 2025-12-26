import 'package:flutter/material.dart';
import 'package:restaurant/data/model/diet.dart';
import '../../presentation/screens/cuisine_page.dart';
import '../../presentation/screens/restaurant_cuisine_page.dart';
class ColumnScroolcuisine extends StatelessWidget {
final List<Diet> cuisine;
  final String town;
  final String osmId;

  const ColumnScroolcuisine({
    super.key,
  required this.cuisine,
  this.town='',
  this.osmId=''
  });

  @override
  Widget build(BuildContext context) {
    return Padding(padding:
    const EdgeInsets.symmetric(vertical: 8.0),
child: LayoutBuilder(builder: 
(context,constraints){
int itemCount= 10;
  final screenWidth = MediaQuery.of(context).size.width;

        double itemWidth = screenWidth * 0.3;

        
        if (itemWidth < 150) itemWidth = 100; 
        if (itemWidth > 260) itemWidth = 150; 

   

        double titleFont = itemWidth / 20; 




return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
      'Cuisine',
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
      builder: (context) => CuisinePage(cuisine: cuisine,town: town,osmId: osmId,),
    ),
  );
},
          child:   Text(
        cuisine.length>itemCount ? 'SEE All' :'',
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
          height: itemWidth+30, 
          child: ListView.separated(
  scrollDirection: Axis.horizontal,
  itemCount: cuisine.length < itemCount ?cuisine.length :itemCount =11,
  physics: const BouncingScrollPhysics(),
  separatorBuilder: (context, index) => const SizedBox(width: 12),
            itemBuilder: (context, index) {

               final item = cuisine[index];
              if ( cuisine.length< itemCount) {
               
                return GestureDetector(
  onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => RestaurantCuisinePage(town: town, cuisine: item.diet,osmId: osmId,),
    ),
  );
},
  
  
  child: Container(
    height: itemWidth+30,
   width: itemWidth+10,
    decoration: BoxDecoration(
   
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
Container(
  width: itemWidth,
  height: itemWidth,
  decoration: BoxDecoration(
    color: Colors.amber,
    shape: BoxShape.circle, // hình tròn
    image: DecorationImage(
      image: NetworkImage( item.image.isNotEmpty
                        ? item.image
                        : 'https://via.placeholder.com/150',),
      fit: BoxFit.cover,
    ),
  ),
),
Container(
  width: double.infinity,
  height: 30,
  alignment: Alignment.center,
  decoration: BoxDecoration(

  ),
  child: Text(item.diet, style: TextStyle(
 fontWeight: FontWeight.bold,
    fontSize: titleFont.clamp(16, 22),

  ),),
),



      ],
    )
  ),
);

              } else {
                if(itemCount-1>index){
          return GestureDetector(
  onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context) => RestaurantCuisinePage(town: town, cuisine: item.diet,osmId: osmId,),
    ),
  );
},
  
  
  child: Container(
    height: itemWidth+30,
   width: itemWidth+10,
    decoration: BoxDecoration(
   
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
Container(
  width: itemWidth,
  height: itemWidth,
  decoration: BoxDecoration(
    color: Colors.amber,
    shape: BoxShape.circle, 
    image: DecorationImage(
      image: NetworkImage( item.image.isNotEmpty
                        ? item.image
                        : 'https://via.placeholder.com/150',),
      fit: BoxFit.cover,
    ),
  ),
),
Container(
  width: double.infinity,
  height: 30,
  alignment: Alignment.center,
  decoration: BoxDecoration(

  ),
  child: Text(item.diet, style: TextStyle(
 fontWeight: FontWeight.bold,
    fontSize: titleFont.clamp(16, 22),

  ),),
),



      ],
    )
  ),
);

                }else{

                  return Container(
                  width: 130,
                  height:150,
                  margin: const EdgeInsets.symmetric(horizontal: 6),
                  decoration: BoxDecoration(
                    color: Colors.amber,
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
),
     );
  }
}
