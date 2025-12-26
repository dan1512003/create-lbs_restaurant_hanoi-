import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/core/widgets/column_scroll_viewall.dart';
import 'package:restaurant/core/widgets/column_scroolcuisine.dart';
import 'package:restaurant/core/widgets/column_scroolhighrate.dart';
import '../../core/widgets/column_scroll.dart';
import 'nearme_page.dart';
import '../state/provider/home_provider.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
    @override
  void initState() {
    super.initState();

    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<HomeProvider>(context, listen: false);
      provider.restaurantForWard(); 
      provider.restaurantNew();
      provider.restaurantCuisine();
      provider.restaurantHightRate();
    });
  }
  String _geetTimeMessage() {
     final hour = DateTime.now().hour;
    if (hour < 12) {
      return "Goood morning";
    } else if (hour < 18) {
      return "Good afternoon";
    } else {
      return "Good dining";
    }
  }
  @override
 Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
   appBar: AppBar(
  backgroundColor: Colors.red,
  automaticallyImplyLeading: false, 
  titleSpacing: 0, 
  title: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          _geetTimeMessage().toUpperCase(),
          style: const TextStyle(
            fontSize: 14,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
     
      ],
    ),
  ),
),

      body: Consumer<HomeProvider>(

         builder: (context, provider, _) {

return
     provider.countrestaurantward.isEmpty
                    ? const Center(
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: CircularProgressIndicator(),
                        ),
                      ):


 SingleChildScrollView(
        child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
        children: [
    SizedBox(height: 16),
GestureDetector(
  
    onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => NearmePage(),
    ),
  );
},
  child:    Container(
    margin: const EdgeInsets.only(left:10 ),
  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
  decoration: BoxDecoration(
    color: Colors.white, 
    borderRadius: BorderRadius.circular(8), 
    border: Border.all( 
      color: Colors.red, 
      width: 2,            
    ),
  ),
  child: Row(
    
    mainAxisSize: MainAxisSize.min,
    children: const [
      Icon(
        Icons.location_on,
        color: Colors.red,
        size: 20,
      ),
      SizedBox(width: 6),
      Text(
        'Near me',
        style: TextStyle(
          color: Colors.red,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    ],
  ),
),),

SizedBox(height: 16),

//restaurant ward
ColumSrcoll(title: 'A town within Phu Tho City',countrestaurantward: provider.countrestaurantward,),
SizedBox(height: 16),

//restaurant high rate
provider.restauranthightrate.isEmpty?SizedBox.shrink():
ColumnScroolhighrate(restauranthightrate: provider.restauranthightrate,),
SizedBox(height: 16),

//restaurant new
provider.restaurantnew.isEmpty?SizedBox.shrink():
ColumnScrollViewall(title: 'New restaurant ', 
restaurant: provider.restaurantnew,
town: '',
),

SizedBox(height: 16),
//restauratn cuisine
provider.cuisine.isEmpty?SizedBox.shrink():
ColumnScroolcuisine( 
cuisine: provider.cuisine,

),


        ],
      ),
      );

         })
    );
 }
}