import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/core/widgets/column_scroll_viewall.dart';
import '../state/provider/restaurant_town_provider.dart';
import '../../core/widgets/column_scroolcuisine.dart';
import '../../core/widgets/column_scroolhighrate.dart';


class RestaurantTownPage extends StatefulWidget {
  final String town;
  final String osmId;

  const RestaurantTownPage({
    super.key,
    required this.town,
    required this.osmId,
    
  });

  @override
  State<RestaurantTownPage>  createState() => _RestaurantTownPageState();
}

class _RestaurantTownPageState extends State<RestaurantTownPage> {
    @override
  void initState() {
    super.initState();

    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<RestaurantTownProvider>(context, listen: false);
provider.restaurantNew(widget.osmId);
provider.restaurantAvail(widget.osmId);
provider.restaurantCuisine(widget.osmId);
provider.restaurantHightRate(widget.osmId);
    });
  }
 

  @override
 Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,


      body:Column(
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
  child: Text(
'Restaurant ${widget.town}',
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

Consumer<RestaurantTownProvider>(

         builder: (context, provider, _) {
return Expanded(child:    SingleChildScrollView(
        child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
        children: [
    SizedBox(height: 16),
  

SizedBox(height: 16),

//restaurant available
provider.restaurantavail.isEmpty?SizedBox.shrink():
ColumnScrollViewall(title: 'Available now in ${widget.town}', 
restaurant: provider.restaurantavail,
town: widget.town,

),



SizedBox(height: 16),
//restaurant hightate
provider.restauranthightrate.isEmpty?SizedBox.shrink():
ColumnScroolhighrate(restauranthightrate: provider.restauranthightrate,),
SizedBox(height: 16),
//Restaurant new
provider.restaurantnew.isEmpty?SizedBox.shrink():
ColumnScrollViewall(title: 'New restaurant ', 
restaurant: provider.restaurantnew,
town: widget.town,
),


SizedBox(height: 16),
//restauratn cuisine
provider.cuisine.isEmpty?SizedBox.shrink():
ColumnScroolcuisine( 
cuisine: provider.cuisine,
town: widget.town,
osmId: widget.osmId,
),

        ],
      ),
      ),
      );

})

       
        ],
      )
    );
 }
}
