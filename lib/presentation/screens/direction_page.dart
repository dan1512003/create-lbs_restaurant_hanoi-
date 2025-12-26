import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/core/widgets/marker_location.dart';
import 'package:restaurant/data/model/restaurant.dart';
import 'package:restaurant/data/services/routing_service.dart';
import 'package:restaurant/presentation/screens/restaurent_page.dart';
import 'package:restaurant/presentation/state/provider/direction_provider.dart';
import 'package:restaurant/presentation/state/provider/geolocator_provider.dart';

class DirectionPage extends StatefulWidget {
  final Restaurant restaurant;
  const DirectionPage({super.key,required this.restaurant});

  @override
  State<DirectionPage> createState() => _DirectionPageState();
}

class _DirectionPageState extends State<DirectionPage>with SingleTickerProviderStateMixin {
 
   late AnimationController _controller;
  late Animation<double> _animation;
  final MapController _mapController = MapController();
  final TextEditingController _searchController = TextEditingController();
   Timer? _debounce;
  late double screenHeight;
  late double screenWidth;
  bool isClickMarker =true;
  double offsetY = 0;
   final List<Map<String, IconData>> typedirection = const[
  {'motorbike': Icons.motorcycle},
  {'car': Icons.directions_car},
];
  String directionselect = 'motorbike';
  StreamSubscription<LatLng>? _locationSub;
    @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _animation = Tween<double>(begin: 0, end: 0).animate(_controller);
      WidgetsBinding.instance.addPostFrameCallback((_) async {
           // ignore: avoid_print
      
    final provider =Provider.of<DirectionProvider >(context, listen: false);
    final geolocatorProvider =Provider.of<GeolocatorProvider>(context, listen: false);
        _searchController.text=widget.restaurant.name;
        await provider.updateRestaurant(widget.restaurant);
        
        await _locationSub?.cancel();

    if(provider.resultsrestaurnt==null){
        // ignore: avoid_print
     print("restaurant rỗng");
    }

     _mapController.move(LatLng(provider.resultsrestaurnt!.lat, provider.resultsrestaurnt!.lon), 10);
    
    _locationSub =  geolocatorProvider.getLocationStream().listen((pos) async {
           if (!mounted) return; 
     
   provider.updateCurrentLocation(pos);
         await provider.getRoute(provider.currentLocation!, 
        LatLng(provider.resultsrestaurnt!.lat, provider.resultsrestaurnt!.lon));
  });
    });
   
  }

  void animateTo(double target) {
    _animation = Tween<double>(begin: offsetY, end: target)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut))
      ..addListener(() {
        setState(() {
          offsetY = _animation.value;
        });
      });

    _controller.stop();
    _controller.reset();
    _controller.forward();
  }

  void handleDragEnd() {
   

  double bottomBarHeight = 90;

  double full = screenHeight-bottomBarHeight;


 
    if (offsetY < full / 2) {
      animateTo(0);
    } else if (offsetY < (full - 20) ) {
      animateTo(full-100);
    } else {
      animateTo(full);
    }
  }
//icon vị trí nhà hàng
Widget buildArriveIcon() {
  return const Icon(
    Icons.location_on,
    color: Colors.red,
    size: 24,
  );
}
//icon vị trí của bạn
Widget buildStartIcon() {
  return Container(
    width: 15,
    height: 15,
    margin: const EdgeInsets.only(left: 5, bottom: 15, top: 15),
    alignment: Alignment.center,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: Colors.blue.withValues(alpha: 0.2),
    ),
    child: Container(
      width: 10,
      height: 10,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      child: Container(
        width: 8,
        height: 8,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.blue,
        ),
      ),
    ),
  );
}

  //icon hướng dẽ
IconData getTurnIcon(String type, String modifier) {
  if (type == 'turn' || type == 'continue') {
    switch (modifier) {
      case 'right':
        return Icons.arrow_right_alt;
      case 'left':
        return Icons.arrow_left;
      case 'slight right':
        return Icons.north_east;
      case 'slight left':
        return Icons.north_west;
      case 'sharp right':
        return Icons.double_arrow;
      case 'sharp left':
        return Icons.keyboard_double_arrow_left;
      default:
        return Icons.arrow_upward;
    }
  }

  if (type == 'roundabout') return Icons.circle_outlined;
  if (type == 'merge') return Icons.merge_type;
  if (type == 'on ramp') return Icons.arrow_upward;
  if (type == 'off ramp') return Icons.exit_to_app;
  if (type == 'fork') return Icons.call_split;
  if (type == 'end of road') return Icons.stop;

  return Icons.directions;
}

//widget các phần chỉ hướng
Widget buildStepRow(RouteStep step, String restaurantName) {
  Widget icon;
  String text;

  if (step.type == 'depart') {
    icon = buildStartIcon();
    text = 'Vị trí của bạn';
  } else if (step.type == 'arrive') {
    icon = buildArriveIcon();
    text = restaurantName;
  } else {
    icon = Icon(
      getTurnIcon(step.type, step.modifier),
      color: Colors.black,
      size: 24,
    );
    text = step.instruction;
  }

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      children: [
        icon,
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 16),
          ),
        ),
        if (step.type != 'depart' && step.type != 'arrive')
          Text(
            step.distanceText,
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
      ],
    ),
  );
}


  @override
  void dispose() {
    _locationSub?.cancel();
  _controller.dispose();
  _searchController.dispose();
  _debounce?.cancel();

   
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
     screenHeight = MediaQuery.of(context).size.height;
     screenWidth=MediaQuery.of(context).size.width;
    return Scaffold(
       floatingActionButton: FloatingActionButton(
    onPressed: () {
      Navigator.pop(context); 
    },
    backgroundColor: Colors.transparent, 
    elevation: 0, 
     hoverElevation: 0, 
    focusElevation: 0, 
    highlightElevation: 0,
    splashColor: Colors.transparent, 
    hoverColor: Colors.transparent, 
    focusColor: Colors.transparent, 
    child: Container(
    
      alignment: Alignment.center,
      child: Icon(
        Icons.close,
        color: Colors.black,
        size: 30,
      ),
    ),
  ),
  floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: 
        Consumer<DirectionProvider>(

         builder: (context, provider, _) {
        
             final items = provider.results.take(5).toList();
          return Stack(
        children: [

Container(
  decoration: BoxDecoration(
    
  ),
  child: Stack(
    children: [

Container(
  width: double.infinity,
decoration: BoxDecoration(),
child:     FlutterMap(
  mapController: _mapController,
            options: MapOptions(
              initialCenter: LatLng(21.0278, 105.8342), 
              initialZoom: 14.0,
              interactionOptions: const InteractionOptions(
                flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
              ),
            ),
            children: [
              TileLayer(
                urlTemplate:
                    'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.restaurant_app',
              ),

          if(provider.routeResult !=null)
                  PolylineLayer(
        polylines: [
          Polyline(
            points: provider.routeResult!.points,
            strokeWidth: 6,
            color: const Color(0xFF1A73E8),
            borderColor: Colors.white,
            borderStrokeWidth: 3,
          ),
        ],
      ),
              MarkerLayer(markers: [

//vị trí hiện tại
if(provider.currentLocation!=null)
                Marker(
        point: provider.currentLocation!,
        width: 20,  
        height: 20,
      child:  Container(
          decoration: BoxDecoration(
            color: Colors.white,  
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Center(
            child: const MarkerLocation(),
          ),
        ),
      ),

      //vị trí đích
      if(provider.resultsrestaurnt != null)
                   Marker(
  width: 70,
  height: 40,
point: LatLng(provider.resultsrestaurnt!.lat, provider.resultsrestaurnt!.lon),
  child:GestureDetector(

    onTap: (){
      setState(() {
        isClickMarker =true;
      });
    },
    child: Icon(Icons.location_on)
  )
),

         
//                 Marker(
//   width: 70,
//   height: 40,
//   point: LatLng(21.0278, 105.8342),
//   child:GestureDetector(

//     onTap: (){
//       setState(() {
//         isClickMarker =true;
//       });
//     },
//     child: Icon(Icons.location_on)
//   )
// ),


              ])
            ],
          ),


),


     //location
  Positioned(
  right: 16,
  bottom: 100,
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
     
   GestureDetector(
  onTap: ()  {
 
   if(provider.currentLocation!=null){
    _mapController.move(provider.currentLocation!, 14);
   }
  },
  child: Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.white,
        shape: BoxShape.circle, 
      border: Border.all(
        color: Colors.grey.shade300, 
        width: 1.5,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: .15), 
          blurRadius: 8,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Icon(
      Icons.my_location,
      color: Colors.blueAccent, 
      size: 24,
    ),
  ),
),

     
   

    ],
  ),
),


Column(
  children: [
    SizedBox(height: 20,),

     isClickMarker?
     Expanded(child: Stack(
            
            children: [

              Positioned(
                bottom: 20,
                 left: 0,      
                 right: 0,  
                child: Container(
            width: double.infinity,
          
            decoration: BoxDecoration(

            ),
            child: Center(
            child:GestureDetector(
onTap: () {
  if (provider.resultsrestaurnt == null) return;

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => RestaurentPage(
        restaurant: provider.resultsrestaurnt!,
      ),
    ),
  );
},
              child:provider.resultsrestaurnt !=null? Container(
                              
                              width: min(max(MediaQuery.of(context).size.width * 0.9, 0), 650,),
                                decoration: BoxDecoration(
                                  color: Colors.red
                                ),
                                child:Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                
                                  children: [
                                     
                                Container(
                                  alignment: Alignment.topRight,
                                  width: min(max(MediaQuery.of(context).size.width * 0.9, 0), 650,),
                                  height: min(max(MediaQuery.of(context).size.width * 0.5,100), 150,),
                                  decoration: BoxDecoration(
                                      
                                   color: provider.resultsrestaurnt!.image.isNotEmpty ? null : Colors.grey, 
    image: provider.resultsrestaurnt!.image.isNotEmpty
        ? DecorationImage(
            image: NetworkImage(
             provider.resultsrestaurnt!.image,
            ),
            fit: BoxFit.cover,
          )
        : null, 
                                  ),
                                  child: GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        isClickMarker =false;
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(),
                                      child: Icon(Icons.close),
                                    ),
                                  ),
                                ),

                              Text(provider.resultsrestaurnt!.name),
                           Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children:  [
         
             ...List.generate(5, (index) {
          
  final double starFill =
    (((provider.resultsrestaurnt!.reviewCount == 0
            ? 0.0
            : provider.resultsrestaurnt!.overallRating / provider.resultsrestaurnt!.reviewCount) - index)
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
        child: Text("${provider.resultsrestaurnt!.reviewCount} reviews",
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
  child: Text(provider.resultsrestaurnt!.openingHour, style: TextStyle(
color: Colors.blue

  ),),
),
Center(
  child: Text('Tap to open page',style: TextStyle(
    color: Colors.black
  ),),
)


     

                                  ],
                                )
                              ):SizedBox.shrink()
            ),
            ),
            ))
            ],
          )):
     Expanded(
                child: GestureDetector(
                  onVerticalDragUpdate: (details) {
                    setState(() {
                    offsetY += details.delta.dy;
                    double maxOffset = screenHeight ;
                    if (offsetY < 0) offsetY = 0;
                    if (offsetY > maxOffset) offsetY = maxOffset;
                    });
                  },
                  onVerticalDragEnd: (details) => handleDragEnd(),
                  child: Transform.translate(
                    offset: Offset(0, offsetY),
                    child: Container(
                      width: screenWidth>800 ?350 :double.infinity ,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:  BorderRadius.vertical(top: Radius.circular(16)),
                           
                        
                      ),
                      child: SingleChildScrollView(child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
   Align(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Icon(
            Icons.remove,
            color: Colors.grey[600],
            size: 30,
          ),
        ),
      ), 

                         Row(
                          children: [
                            offsetY>= screenHeight-90  ? Icon(Icons.motorcycle,):SizedBox.shrink(),

 Container(
                            margin: const EdgeInsets.only(left: 16),
                            child: Text(
                           offsetY>= screenHeight-90  ?   'Khoảng cách: ${provider.routeResult?.distanceText ?? '--'} ${provider.routeResult?.durationText??'--'}':directionselect,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              
                              ),
                            ),
                          ),
                          ],
                         ),
                          const SizedBox(height: 8),

                          Row(
                        
                            children: [
                   
                      //         Container(
                      //     width: MediaQuery.of(context).size.width * 0.5,
                      //   decoration: BoxDecoration(),
                      //   child:  Icon(Icons.motorcycle,),
                      //  ),

                                ...List.generate(2, (index) {
                                  bool isSelected = directionselect == typedirection[index].keys.first;
      return   GestureDetector(
        onTap: (){
          setState(() {
            directionselect=typedirection[index].keys.first;
          });
        },
        child:  Column(
                        children: [
                           Container(
                        width:screenWidth>800? 350/2 : MediaQuery.of(context).size.width * 0.5,
                        decoration: BoxDecoration(

                          
                        ),
                        child:  Icon(typedirection[index].values.first),
                       ),
                           Container(
                         width:screenWidth>800? 350/2 : MediaQuery.of(context).size.width * 0.5,
                        margin: EdgeInsets.only(top: 10),
                        height: 1,
                        decoration: BoxDecoration(
                       color: isSelected?Colors.red:Colors.white
                        ),
                      
                       ),
                        ],
                      )
      );
    })
          
                               ],
                          ),

                           Container(
                            margin: const EdgeInsets.only(left: 16),
                            child: Text(
                              'Khoảng cách: ${provider.routeResult?.distanceText ?? '--'} ${provider.routeResult?.durationText??'--'}',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              
                              ),
                            ),
                          ),


                          Column(
                            children: [

      if (provider.routeResult != null)
    ...List.generate(
      provider.routeResult!.steps.length,
      (index) {
        final step = provider.routeResult!.steps[index];
        return buildStepRow(
          step,
          provider.resultsrestaurnt!.name,
        );
      },
    ),
                            ],
                          )
                        ],
                      ),)
                    ),
                  ),
                ),
              ),
  ],
)

    ],
  ),
),
offsetY<120?SizedBox.shrink():Align(
  alignment: screenWidth >800?Alignment.topLeft: Alignment.topCenter,
  child: Container(
  width: 350,
  
  decoration: BoxDecoration(
    color: Colors.white,
  borderRadius: BorderRadius.circular(8),
  ),
  child: Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      //Vị trí của bạn
      Row(
        children: [

          //container tạo icon vị trí của bạn
  buildStartIcon(),

Container(
  margin: EdgeInsets.only(left: 10),
  decoration: BoxDecoration(),
  child: Text('Vị trí của bạn',
  style: TextStyle(color: Colors.blue),),
)
        ],
      ),

// ĐƯỜNG BIÊN
Row(
  mainAxisAlignment: MainAxisAlignment.start,
  children: [
    Container(
      decoration: BoxDecoration(),
      child: Icon(Icons.more_vert),
    ),
   Expanded(child:
   Container(
    margin: EdgeInsets.only(right: 10),
    decoration: BoxDecoration(),
    child:  Divider(
  height: 10,        
  thickness: 1,      
  color: Colors.grey,
),
   )
)

  ],
),

//vị trí nhà hàng 
Row(
  mainAxisAlignment: MainAxisAlignment.start,
  children: [
    Container(
      decoration: BoxDecoration(),
      child: Icon(Icons.location_on,color: Colors.red,),
    ),
   Expanded(child:
  Container(
    
    decoration: BoxDecoration(),
    child:  TextField(
      controller: _searchController,
  maxLines: 1,
  decoration: InputDecoration(
    border: InputBorder.none, 
   
  ),
        onChanged: (value) {
  if (_debounce?.isActive ?? false) _debounce!.cancel();

  _debounce = Timer(const Duration(milliseconds: 600), () {
    if (value.isEmpty) {
      provider.clear();
    } else {
      provider.search(value);
    }
  });
},

onSubmitted: (value) {
          if (value.isNotEmpty) {
            provider.findbysearch(_mapController);
          } else {
            provider.clear();
          }
        },
textInputAction: TextInputAction.search,
)
   )
)

  ],
),
 provider.results.isEmpty ?
    const SizedBox.shrink()
    :
     Column(
      children: List.generate(items.length, (index) {
        final item = items[index];
        return GestureDetector(child: Container(
            height: 60,
            padding: const EdgeInsets.only(top: 12),
            decoration: BoxDecoration(
              border: Border()
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.location_on,
                 
                ),
                const SizedBox(width: 10),
                Expanded(
                  child:Container(

                    decoration: BoxDecoration(
                       border: Border(
            bottom: index != items.length - 1 
                ? const BorderSide(color: Colors.grey, width: 0.5)
                : BorderSide.none, 
          ),
                      
                    ),
                    child:  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        item.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
             Text(
                        item.displayName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.grey
                        ),
                      ),
                   
                    ],
                  ),

                  )
                ),
              ],
            ),
          ),
          onTap: () => {
            provider.findbypick(item, _searchController, _mapController)
          },
          );
      }),
    ),
 


    ],
  ),
),)



        ],
      );
         }),
      
      
      
    );
  }
}