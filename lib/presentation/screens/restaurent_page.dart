
import 'dart:math';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:restaurant/data/model/restaurant.dart';
import 'package:restaurant/data/model/review.dart';
import 'package:restaurant/data/model/user.dart';
import 'package:restaurant/presentation/state/provider/geolocator_provider.dart';
import 'package:restaurant/presentation/state/provider/restaurant_provider.dart';
import 'package:restaurant/presentation/state/provider/user_provider.dart';

import 'review_restaurant.dart';
import 'direction_page.dart';
import 'rate_page.dart';

class RestaurentPage extends StatefulWidget {
  final Restaurant restaurant;
  const RestaurentPage({super.key,required this.restaurant});

  @override
  State<RestaurentPage> createState() => _RestaurentPageState();
}

class _RestaurentPageState extends State<RestaurentPage> {


  double offsetY = 0;
  String address ='';
  final ScrollController _scrollController =ScrollController();
  int _activeIndex = 0;
  List<Review> review =[];
  final List<String> menus = ["Direction", "Menu", "Reviews", "Detail"];
  final List<GlobalKey> _keys = List.generate(4, (_) => GlobalKey());
  Map<String, Future<User?>> userFutures = {};

@override
void initState() {
  super.initState();
  _scrollController.addListener(_onScroll);

  WidgetsBinding.instance.addPostFrameCallback((_) async {
    final provider =
        Provider.of<RestaurantProvider>(context, listen: false);
      address=  await provider.getAddress(widget.restaurant.lat, widget.restaurant.lon);
    provider.getReview(widget.restaurant.osmId);
  });
}

 @override
 void dispose(){
_scrollController.dispose(); 
    super.dispose();
 }

//hàm scroll
void _onScroll(){
  for(int i =0 ; i< _keys.length;i++){
final context =_keys[i].currentContext;
if(context !=null){

  final box = context.findRenderObject() as RenderBox;
  final pos = box.localToGlobal(Offset.zero).dy;
    if (pos <=280 && pos >= -box.size.height+81) {
          if (_activeIndex != i) {
            setState(() => _activeIndex = i);
          }
          break;
        }
}
  }
  }

//hàm scrolltoindex
void _scrollToIndex(int index) {
  final context = _keys[index].currentContext;
  if (context != null) {
    final box = context.findRenderObject() as RenderBox;

    final pos = box.localToGlobal(Offset.zero).dy;

    final targetOffset = _scrollController.offset + pos - 80;

   
    final clamped = targetOffset.clamp(
      _scrollController.position.minScrollExtent,
      _scrollController.position.maxScrollExtent,
    );

    _scrollController.animateTo(
      clamped,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}

//Widget infodetail
Widget widgetInfoDetail({
  required IconData icon,
  required String title,
  required String content,
  Color iconColor = Colors.black,
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Icon(icon, color: iconColor),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 15),
              child: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 15, top: 5),
              child: Text(content),
            ),
          ],
        ),
      ),
    ],
  );
}
//widget builrateitem
Widget buildRateItem({
  required String value,
  required String title,
}) {
  return Container(
    margin: const EdgeInsets.only(top: 20),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(),
       
          child: Text(
            value,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        const SizedBox(height: 4),

        Container(
          decoration: BoxDecoration(),
          
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
        ),
      ],
    ),
  );
}

void showErrorDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    barrierDismissible: false,
    useRootNavigator: true,
    builder: (dialogContext) => AlertDialog(
      title: const Text(
        "Lỗi",
        style: TextStyle(color: Colors.red),
      ),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(dialogContext),
          child: const Text("Đóng"),
        ),
      ],
    ),
  );
}


//hàm tính phần trăm số sao

double widthFactorOfStar(int star, Map<int, int> starCount) {
  int fiveStarCount = starCount[5] ?? 0;

  int totalReviews = starCount.values.fold(0, (sum, v) => sum + v);

  if (fiveStarCount > 0) {
  
    return starCount[star]! / fiveStarCount;
  } else if (totalReviews > 0) {
    
    return starCount[star]! / totalReviews;
  } else {
    
    return 0.0;
  }
}
  
   //hàm lấy màu ngẫu nhiên

Map<String, Color> userColors = {};


Color getUserColor(String email) {
  if (!userColors.containsKey(email)) {
    final random = Random();
    userColors[email] = Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }
  return userColors[email]!;
}

Future<void> openDirectionPage() async {
    // ignore: avoid_print
     print("dãvao day1");
  final geo =context.read<GeolocatorProvider>();

    await geo.getLocationPermission(); 
 
    if(geo.locationpermission==true){
        // ignore: avoid_print
     print("dãvao day2");
     if (!mounted) return;
      // ignore: avoid_print
      print("dãvao day2");
Navigator.of(context, rootNavigator: true).push(
          MaterialPageRoute(builder: (context) => DirectionPage(restaurant: widget.restaurant,)),
        );
    }
        
}

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
   User? user = userProvider.user;
    // ignore: avoid_print
print("${user?.name}");
    return Scaffold(
          backgroundColor: Colors.white,
      body: 
      Consumer<RestaurantProvider>(

         builder: (context, provider, _) {

          return  NotificationListener<ScrollNotification>(
        onNotification: (scroll) {
          setState(() {
            offsetY = scroll.metrics.pixels;
    
          });
// ignore: avoid_print
print("offsetY = $offsetY");
          return true;
        },
        child: Stack(
          children: [
         
            SingleChildScrollView(
             controller: _scrollController,
              child: Column(
                children: [
               
                  Container(
                    decoration: const BoxDecoration(),
                    child: Column(
                      children: [
                        const SizedBox(height: 50),
                        Container(
                          height: 250,
                          decoration: BoxDecoration(
                            color: Colors.grey
                          ),

                        ),
                        Padding(
  padding: const EdgeInsets.all(16),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment:MainAxisAlignment.start,
    children: [
      Container(
    width: double.infinity,
    alignment: Alignment.centerLeft,
     decoration: BoxDecoration(),
     child: Text(widget.restaurant.name),
      ),
        Container(

  decoration: const BoxDecoration(),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
    
    Expanded(
      child:   
    Container(
       
        decoration: BoxDecoration(
        
        ),
        alignment: Alignment.centerLeft,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children:  [
                Container(
    
        decoration: BoxDecoration(),
        child:  Text( widget.restaurant.reviewCount == 0
            ? "0.0 "
            : "${widget.restaurant.overallRating / widget.restaurant.reviewCount}",style: 
        TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 
        min(max( MediaQuery.of(context).size.width*0.03,16), 20)
        ,
         ),),
      ),
                 ...List.generate(5, (index) {
          
  final double starFill =
    (((widget.restaurant.reviewCount == 0
            ? 0.0
            : widget.restaurant.overallRating / widget.restaurant.reviewCount) - index)
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
              //Icon Reviews
              Container(
             margin: const EdgeInsets.only(left: 8,top:5),

              child: Icon(Icons.comment_outlined,size:  
               min(max( MediaQuery.of(context).size.width*0.03,16), 20)),
        ),
        Container(
    
        decoration: BoxDecoration(),
        child: Text("${widget.restaurant.reviewCount} reviews",
        style: TextStyle(fontWeight: FontWeight.bold,
          fontSize: 
        min(max( MediaQuery.of(context).size.width*0.03,7), 13)
        ),),
      ),
            ],
          ),
      ),),
 
    ],
  ),
),
//Location
Container(

  decoration: BoxDecoration(),

  child: Row(
    mainAxisAlignment: MainAxisAlignment.start,
children: [

  Icon(Icons.location_on, color: Colors.black),
      Expanded(
        child: Container(
              margin: const EdgeInsets.only(left: 5),
              child: Text(
                address,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
      ),
],

  ),
)
    ],
  ),
)

                      ],
                    ),
                  ),
  Container(
                      height: 50 ,
                      decoration: BoxDecoration(
                          border: Border(

               
              ),
                      ),
                      child: Column(
                          children: [
                          
                       Container(
                            height: 50,
                            color: offsetY >=311 ?Colors.white.withValues(alpha: 0.0):Colors.amber,
                         
                              child: offsetY >=311 ?const SizedBox.shrink():
                            LayoutBuilder(
  builder: (context, constraints) {
    final itemWidth = constraints.maxWidth / 4; 
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: menus.length,
      itemBuilder: (context, index) {
        bool active = index == _activeIndex;
        return GestureDetector(
          onTap: () => _scrollToIndex(index),
          child: Container(
            width: itemWidth,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.red,
              border: Border(
              right: BorderSide(
                color:   index==3? Colors.red:Colors.white
              ),
                bottom: BorderSide(
                  color: active ? Colors.amber : Colors.transparent,
                  width: 5,
                 
                ),
              ),
            ),
            child: Text(
              menus[index],
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontWeight: active ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        );
      },
    );
  },
)

                           
                          ),
                           
                     
                          ],
                      ),
                      ),


Container(
      key: _keys[0],
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        
          const SizedBox(height: 8),
      Center(
  child: SizedBox(
    height: MediaQuery.of(context).size.height * 0.05,
    width: min(max( MediaQuery.of(context).size.width*0.3,150), 200),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
      ),
      onPressed: () async {
       await openDirectionPage();
        
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.directions, color: Colors.black),
          SizedBox(width: 5),
          Text(
            "Direction",
            style: TextStyle(
              color: Colors.black,
              fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ),
  ),
)

        ],
      ),
    ),


//MENU CONTAINER
Container(
      key: _keys[1],
      
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(menus[1],
              style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),


     GestureDetector(
      
  child: 
  Container(
  height: 50,
  decoration: BoxDecoration(
color: Colors.red
    
  ),
  child:  Center(child: Text('VIEW FULL MENU'),),
)
     )

    
        ],
      ),
    ),

//REVIEW CONTAINER
        Container(
      key: _keys[2],
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(menus[2],
              style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
         GestureDetector(
                
  onTap: () {
       if(user==null){
      showErrorDialog(context, 'Bạn cần phải đăng nhập để có thể đánh giá');
          }else{

              showModalBottomSheet(
    context: context,
    isScrollControlled: true, 
    useRootNavigator: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return FractionallySizedBox(
        heightFactor: 1.0, 
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(16),
            ),
          ),
          child: RatePage(restaurant: widget.restaurant,), 
        ),
      );
    },
  );
          }

},

                child:  Text('Thêm bài đánh giá',
              style:
                  const TextStyle(color: Colors.blue)),)
            ],
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(),
            child: Column(

              children: [
Row(
crossAxisAlignment: CrossAxisAlignment.start,
  children: [
   Container(
 
  decoration: const BoxDecoration(


  ),
  child: Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        decoration: BoxDecoration(),
        child: Text("Overall rating",
        style: TextStyle(
          fontSize:  min(max( MediaQuery.of(context).size.width*0.03,16), 20)
        ),
        ),
      ),
      Container(
       alignment: Alignment.centerLeft,
        decoration: BoxDecoration(),
        child: Text(
          widget.restaurant.reviewCount == 0
            ? "0.0 "
            : "${widget.restaurant.overallRating / widget.restaurant.reviewCount}",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize:  min(max( MediaQuery.of(context).size.width*0.03,16), 20)
        ),
        ),
      ),
      Container(
        
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
        ),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
               ...List.generate(5, (index) {
          
  final double starFill =
    (((widget.restaurant.reviewCount == 0
            ? 0.0
            : widget.restaurant.overallRating / widget.restaurant.reviewCount) - index)
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
       
            ],
          ),
      ),
    ],
  ),
)
,
Expanded(child:   Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [

       ...List.generate(5, (index) {
  int star = 5 - index; 
 double factor = (star == 5) 
    ? 1.0 
    : widthFactorOfStar(star, provider.starCount);


  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      SizedBox(
        width: 20,
        child: Text("$star"),
      ),

      Container(
        width: min(
            max(MediaQuery.of(context).size.width * 0.3, 250), 350),
        height: min(
            max(MediaQuery.of(context).size.width * 0.03, 7), 13),
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(100),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: factor, 
            child: Container(
              color: Colors.red,
            ),
          ),
        ),
      ),

      // const SizedBox(width: 8),
      // Text("${(factor * 100).toStringAsFixed(0)}%"),
    ],
  );
}),

      ],
    ),
    )

  ],
),
 Container(
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        border: Border(
      top: BorderSide(
        color: Colors.grey,   
        width: 0.5,           
      ),
    ),
      ),
      height: 70,
      child:               
     Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [

buildRateItem(value: "Food", title: widget.restaurant.reviewCount==0?
"0.0":"${widget.restaurant.ratefood/widget.restaurant.reviewCount}"),
buildRateItem(value: "Service", title: widget.restaurant.reviewCount==0?
"0.0":"${widget.restaurant.rateservice/widget.restaurant.reviewCount}"),
buildRateItem(value: "Ambience", title: widget.restaurant.reviewCount==0?
"0.0":"${widget.restaurant.rateambience/widget.restaurant.reviewCount}")
     ],)
    ),

    SizedBox(height: 10,),
...List.generate(
  provider.command.length >= 2 ? 2 : provider.command.length,
  (index) {
    final item = provider.command[index];

  
    userFutures[item.email!] ??= provider.getUser(item.email!);

    return FutureBuilder<User?>(
      future: userFutures[item.email!],
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        if (!snapshot.hasData) {
          return const SizedBox.shrink();
        }

        final user = snapshot.data;
        if (user == null) return const SizedBox.shrink();

        final initial = user.name![0].toUpperCase();
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: min(max(MediaQuery.of(context).size.width * 0.05, 50), 70),
                    height: min(max(MediaQuery.of(context).size.width * 0.05, 50), 70),
                    alignment: Alignment.center,
                    child: CircleAvatar(
                      radius: 35,
                      backgroundColor:
                          (user.image == null || user.image!.isEmpty)
                              ? getUserColor(user.email)
                              : Colors.transparent,
                      backgroundImage: (user.image != null && user.image!.isNotEmpty)
                          ? NetworkImage(user.image!)
                          : null,
                      child: (user.image == null || user.image!.isEmpty)
                          ? Text(
                              initial,
                              style: const TextStyle(fontSize: 40, color: Colors.white),
                            )
                          : null,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(user.name ?? ""),
                  ),
                ],
              ),
              // Rate
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: List.generate(5, (i) {
                  return Icon(
                    i < item.overallrating! ? Icons.star : Icons.star_border,
                    color: i < item.overallrating! ? Colors.amber : Colors.grey,
                    size: min(max(MediaQuery.of(context).size.width * 0.03, 16), 20),
                  );
                }),
              ),
              // Command
              Text(item.command ?? ""),
            ],
          ),
        );
      },
    );
  },
),

   SizedBox(height: 10,),
  GestureDetector(
            onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReviewRestaurant(restaurant: widget.restaurant,),
      ),
    );
  },
  child: Container(
  height: 50,
  decoration: BoxDecoration(
    color: Colors.red
  ),
  child:  Center(child: Text('VIEW FULL REVIEW'),),
)
     )

              ],
            )
          )
        ],
      ),
    ),



//DETAIL CONTAINER
               Container(
      key: _keys[3],
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(menus[3],
              style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
       Container(
      
        decoration: BoxDecoration(
      
        ),
       child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        
        children: [
 widgetInfoDetail(
  icon: Icons.location_on, 
  title: 'Address', 
  content: address),

  widget.restaurant.description !=""?
 widgetInfoDetail(
  icon: Icons.description, 
  title: 'Description', 
  content: widget.restaurant.description ):SizedBox.shrink(),

  widget.restaurant.phone !=""?
 widgetInfoDetail(
  icon: Icons.phone, 
  title: 'Phone', 
  content: widget.restaurant.phone):SizedBox.shrink(),
  widget.restaurant.email!=""?
   widgetInfoDetail(
  icon:Icons.email, 
  title: 'Email', 
  content: widget.restaurant.email):SizedBox.shrink(),
  widget.restaurant.cuisine !=""?
widgetInfoDetail(
  icon: Icons.restaurant_menu, 
  title: 'Cuisine', 
  content:  widget.restaurant.cuisine):SizedBox.shrink(),
 widget.restaurant.payment !=""?
 widgetInfoDetail(
  icon: Icons.payment, 
  title: 'Payment', 
  content: widget.restaurant.payment):SizedBox.shrink(),
   widget.restaurant.website !=""?
   widgetInfoDetail(
  icon:Icons.language, 
  title: 'Wedsite', 
  content: widget.restaurant.website):SizedBox.shrink(),
         
        ],
       )
       )
        ],
      ),
    ),


                 
                ],
              ),
            ),

            //appbar
          Column(
            children: [
                Container(
              height: 50,
      
              decoration:  BoxDecoration(
                color: Colors.red
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
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
                  const Icon(
                    Icons.bookmark,
                    color: Colors.black,
                    size: 30,
                  ),
                ],
              ),
            ),
            Container(
              height: 100,
              decoration: BoxDecoration(),
              child: Column(
                children: [
            
                  Container(
                            height: 50,
                            color: offsetY <=311 ?Colors.white.withValues(alpha: 0.0):Colors.amber,
                            
                              child: offsetY <=311 ?const SizedBox.shrink(): 
                           LayoutBuilder(
  builder: (context, constraints) {
    final itemWidth = constraints.maxWidth / 4; 
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: menus.length,
      itemBuilder: (context, index) {
        bool active = index == _activeIndex;
        return GestureDetector(
          onTap: () => _scrollToIndex(index),
          child: Container(
            width: itemWidth,
            alignment: Alignment.center,
            decoration: BoxDecoration(
               color: Colors.red,
              border: Border(
                  right: BorderSide(
                color:   index==3? Colors.red:Colors.white
              ),
                bottom: BorderSide(
                  color: active ? Colors.amber : Colors.transparent,
                  width: 5,
                ),
              ),
            ),
            child: Text(
              menus[index],
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontWeight: active ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        );
      },
    );
  },
)

                            
                          ),
                          
                ],
              ),
            )
            ],
          )
          ],
        ),
      );
         })
      
      
     
    );
  }
}
