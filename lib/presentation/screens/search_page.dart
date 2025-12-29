import 'dart:math';


import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/data/model/restaurant.dart';
import 'package:restaurant/presentation/screens/restaurent_page.dart';
import 'package:restaurant/presentation/state/provider/geolocator_provider.dart';

import 'dart:async';
import '../state/provider/search_provider.dart';
import '../../core/widgets/trianglerclipper.dart';
import '../../core/widgets/marker_location.dart';
class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with SingleTickerProviderStateMixin {
  late double screenHeight;
  late AnimationController _controller;
  late Animation<double> _animation;
  
   final MapController _mapController = MapController();
   final TextEditingController _searchController = TextEditingController();
Timer? _debounce;

  double offsetY = 0;
  bool isClickMarker =false;
 Restaurant? _restaurant ;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _animation = Tween<double>(begin: 0, end: 0).animate(_controller);
  
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
   

  double bottomBarHeight = 200;

  double full = screenHeight- bottomBarHeight;
    double half = full * 0.5;
    if (offsetY < half / 2) {
      animateTo(0);
    } else if (offsetY < (full + half) / 2) {
      animateTo(half);
    } else {
      animateTo(full);
    }
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    _mapController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    

    screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body:  Consumer<SearchProvider>(

         builder: (context, provider, _) {
           final items = provider.results.take(5).toList();
return  Stack(
        children: [
          /// --- Bản đồ nền ---
          FlutterMap(
              mapController: _mapController, 
            options: MapOptions(
              initialCenter: LatLng(21.0278, 105.8342), 
              initialZoom: 14.0,
              interactionOptions: const InteractionOptions(
              flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
              ),
              onTap: (tapPosition, point) {
             provider.findbyclick(point.latitude, point.longitude,_mapController,searchController: _searchController);
},
   onPositionChanged: (MapCamera position, bool hasGesture) {
  final bounds = position.visibleBounds;
  final sw = bounds.southWest;  
  final ne = bounds.northEast;  

  final minLon = sw.longitude;  
  final minLat = sw.latitude;   
  final maxLon = ne.longitude;  
  final maxLat = ne.latitude;   

           provider.findbymove(minLon, minLat, maxLon, maxLat,position.center,searchController: _searchController);
          },

            ),
            children: [
              TileLayer(
                urlTemplate:
                    'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.restaurant_app',
              ),
  MarkerClusterLayerWidget(
  options: MarkerClusterLayerOptions(
    markers: [
      ...provider.resultsrestaurnt.map((r) => Marker(
        width: 70,
        height: 40,
        point: LatLng(r.lat, r.lon),
        child: GestureDetector(
          onTap: () {
            setState(() {
              isClickMarker = true;
              _restaurant = r;
            });
          },
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.restaurant, color: Colors.red, size: 15),
                    const SizedBox(width: 10),
                    Text(
                      r.reviewCount == 0
                          ? '-- ★'
                          : '${(r.overallRating / r.reviewCount).toStringAsFixed(1)} ★',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 8,
                height: 5,
                child: ClipPath(
                  clipper: Trianglerclipper(),
                  child: Container(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      )),
    ],
    maxClusterRadius: 45,
    size: const Size(70, 40), 
    builder: (context, markers) {
      
      final firstMarker = markers.first;
      return firstMarker.child;
    },
  ),
),

              MarkerLayer(
      markers: [
    


if (provider.location != null)
      Marker(
        point: provider.location!,
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


      ],
      )
            ],
          ),

       //location
  Positioned(
  right: 16,
  bottom: 100,
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
     
   GestureDetector(
  onTap: () async {
     final geo =context.read<GeolocatorProvider>();

    final LatLng? location =
        await geo.getCurrentLocation();
if(location!=null){
      await provider.findLocation(_mapController,location,searchController: _searchController);
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

     
     provider.error == ""
    ? SizedBox.shrink()
    : Center(
        child: Container(
          width: min(
        max(MediaQuery.of(context).size.width * 0.9, 0),
        650,
      ),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.red.shade700,
            border: Border.all(color: Colors.red.shade900, width: 2), 
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            provider.error,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white, 
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      )

    ],
  ),
),





       //Find and Result Find
          Column(
            children: [
    DecoratedBox(
  decoration: BoxDecoration(
    color: offsetY == 0 ? Colors.white : Colors.white.withValues(alpha: 0.0)
  ),
  child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child:Column(
        children: [
         Container(
          height: 50,
          decoration: BoxDecoration(),
          child:   Row(
        children:  [
          Icon(Icons.search, color: Colors.grey),
          SizedBox(width: 8),
          Expanded(
            child: TextField(
                controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search for restaurant',
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
            provider.findbysearch(_searchController,_mapController);
          } else {
            provider.clear();
          }
        },
textInputAction: TextInputAction.search,

            ),

          ),
        ],
      ),
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
      )
    ),
  ),
),

      
//hiển thị nhà hàng

          isClickMarker?Expanded(
            child: Stack(
            
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
  if (_restaurant == null) return;

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => RestaurentPage(
        restaurant: _restaurant!,
      ),
    ),
  );
},
              child: _restaurant !=null? Container(
                              
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
                                      
                                   color: _restaurant!.image.isNotEmpty ? null : Colors.grey, 
    image: _restaurant!.image.isNotEmpty
        ? DecorationImage(
            image: NetworkImage(
             _restaurant!.image,
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

                              Text(_restaurant!.name),
                           Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children:  [
         
             ...List.generate(5, (index) {
          
  final double starFill =
    (((_restaurant!.reviewCount == 0
            ? 0.0
            : _restaurant!.overallRating / _restaurant!.reviewCount) - index)
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
        child: Text("${_restaurant!.reviewCount} reviews",
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
  child: Text(_restaurant!.openingHour, style: TextStyle(
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
            )
            ),
            )
            )
            ],
          ))
            : Expanded(
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
                    offset: Offset(0, offsetY-(items.length*60)),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: offsetY==0 ? null:
                            const BorderRadius.vertical(top: Radius.circular(16)),
                        boxShadow:  offsetY==0 ? null: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4,
                            offset: Offset(0, -2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          offsetY != 0
    ? Align(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Icon(
            Icons.remove,
            color: Colors.grey[600],
            size: 30,
          ),
        ),
      )
    : SizedBox.shrink(), 

                          Container(
                            margin: const EdgeInsets.only(left: 16),
                            child: Text(
                              '${provider.resultsrestaurnt.length} restaurants',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.red[400],
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Expanded(
                            child: ListView.builder(
                              padding: const EdgeInsets.only(top: 8),
                              itemCount: provider.resultsrestaurnt.length,
                              itemBuilder: (context, index) {
                            final   item= provider.resultsrestaurnt[index];
                                return GestureDetector(
                                  onTap: () {


  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => RestaurentPage(
        restaurant: item,
      ),
    ),
  );
},
                                  child:  Container(
                                height: min(max(MediaQuery.of(context).size.width * 0.1, 80), 120,),
                                margin: const EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 8),
                                decoration: BoxDecoration(
                                  
                                ),
                                child:Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                     
                                Container(
                                  width: min(max(MediaQuery.of(context).size.width * 0.1, 80), 120,),
                                  height: min(max(MediaQuery.of(context).size.width * 0.1, 80), 120,),
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

                              Expanded(child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                
                                   Text(item.name),

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
        child: Text("${item.reviewCount} reviews",
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
                              ))
                                  ],
                                )
                              ),
                                );
                              }
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

             
             
            ],
          ),
        ],
      );

         }
      ),
    );
  }
}
