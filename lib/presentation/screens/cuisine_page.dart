import 'package:flutter/material.dart';
import 'package:restaurant/data/model/diet.dart';
import 'restaurant_cuisine_page.dart';
class CuisinePage extends StatefulWidget {

final List<Diet> cuisine;
  final String town;
  final String osmId;
  const CuisinePage({super.key,
   this.town='',
   this.osmId='',
  required this.cuisine
  });

  @override
  State<CuisinePage> createState() => _CuisinePageState();
}

class _CuisinePageState extends State<CuisinePage> with SingleTickerProviderStateMixin {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
      
        children: [
  //appbar


 Container(
              height: 20,
            
              decoration: const BoxDecoration(),
              child:  Row(
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

                    ],
                  ),
            ),

        //body
       Expanded(child: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(),
          child: Column(

            children: [

Container(
  width: double.infinity,
   alignment: Alignment.centerLeft,
  decoration: BoxDecoration(),
  child:Text('Cuisine',
  style: TextStyle(
 fontWeight: FontWeight.bold,
    fontSize: 30,

  ),
  
  ) ,
),


...List.generate(widget.cuisine.length, (index){

  final item = widget.cuisine[index];
return   GestureDetector(
   onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => 
      RestaurantCuisinePage(town:widget.town, 
      cuisine: item.diet,
      osmId: widget.osmId),
    ),
  );
},
  child: Container(
   height: (MediaQuery.of(context).size.width * 0.1).clamp(100.0, 150.0) +10, 
    decoration: BoxDecoration(
    
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
Container(
  width: (MediaQuery.of(context).size.width * 0.1).clamp(100.0, 150.0), 
  height: (MediaQuery.of(context).size.width * 0.1).clamp(100.0, 150.0),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(12),
     image: DecorationImage(
      image: NetworkImage( item.image.isNotEmpty
                        ? item.image
                        : 'https://via.placeholder.com/150',),
      fit: BoxFit.cover,
    ),
  ),
),
Expanded(child: 
Container(
   
  height: (MediaQuery.of(context).size.width * 0.1).clamp(100.0, 150.0)+10, 
  decoration: BoxDecoration(
 border: Border(
      bottom: BorderSide(
        color: Colors.grey, 
        width: 1,          
      ),
    ),

  ),
  child: Column(

    children: [

Container(
width: double.infinity,
  decoration: BoxDecoration(

  ),
  child: Text(item.diet, style: TextStyle(
 fontWeight: FontWeight.bold,
    fontSize: 20,

  ),),
),
Container(
width: double.infinity,
  decoration: BoxDecoration(

  ),
  child: Text( item.count.toString(), style: TextStyle(


  ),),
),


    ],
  ),
)
)

      ],
    )
  ),
);


}),




       


            ],
          ),
        ),
       ))


        ],
      ),
    );
  }
}