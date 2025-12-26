import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/data/model/ward.dart';
import 'package:restaurant/presentation/state/provider/home_provider.dart';
import 'restaurant_town_page.dart';
class TownPage extends StatefulWidget {
  const TownPage({super.key,  required this.countrestaurantward, });
final List<Map<Ward, String>> countrestaurantward;
  @override
  State<TownPage> createState() => _TownPageState();
}

class _TownPageState extends State<TownPage> with SingleTickerProviderStateMixin {

  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          backgroundColor: Colors.white,
      body: Consumer<HomeProvider>(

         builder: (context, provider, _) {
return Column(
      
        children: [
  //appbar
 Container(
              height: 50,
            
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

// Container(
//   width: double.infinity,
//    alignment: Alignment.centerLeft,
//   decoration: BoxDecoration(),
//   child:Text('Xuân Lãng',
//   style: TextStyle(
//  fontWeight: FontWeight.bold,
//     fontSize: 30,

//   ),
  
//   ) ,
// ),

     
...List.generate(widget.countrestaurantward.length, (index){

   final item = widget.countrestaurantward[index];
    final ward = item.keys.first;   
    final count = item.values.first;
return  GestureDetector(
   onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => RestaurantTownPage(town: ward.name,osmId: ward.osmId,),
    ),
  );
},
  child: Container(
 height: (MediaQuery.of(context).size.width * 0.1).clamp(100.0, 150.0)+10,
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
image: NetworkImage(   ward.image.isNotEmpty
                        ? ward.image
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
  child: Text(ward.name, style: TextStyle(
 fontWeight: FontWeight.bold,
    fontSize: 20,

  ),),
),
Container(
width: double.infinity,
  decoration: BoxDecoration(

  ),
  child: Text(  '$count Restaurant', style: TextStyle(


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
})



            ],
          ),
        ),
       ))


        ],
      );

})
    );
  }
}