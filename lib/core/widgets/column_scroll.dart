import 'package:flutter/material.dart';
import '../../presentation/screens/town_page.dart';
import '../../presentation/screens/restaurant_town_page.dart';
import '../../data/model/ward.dart';
class ColumSrcoll extends StatelessWidget {


  const ColumSrcoll({
    super.key,
    this.title = 'A town within Ha Noi',
    required this.countrestaurantward, 
  });

  final String title;

 
  final List<Map<Ward, String>> countrestaurantward;
  @override
  Widget build(BuildContext context) {
      int itemcount =10;
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: LayoutBuilder(
      builder: (context, constraints) {
        
        final screenWidth = MediaQuery.of(context).size.width;

        double itemWidth = screenWidth * 0.3;

        
        if (itemWidth < 150) itemWidth = 150; // điện thoại nhỏ
        if (itemWidth > 260) itemWidth = 250; // iPad hoặc màn hình lớn
      
        // Chiều cao ảnh: tỉ lệ 4:3
        double imageHeight = itemWidth * 0.8;

        
        double titleFont = itemWidth / 10; 
        double subtitleFont = itemWidth / 13; 
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Popular Towns",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.red,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TownPage(countrestaurantward: countrestaurantward,)),
                      );
                    },
                    child: Text(
                         countrestaurantward.length>itemcount ? 'SEE All' :'',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.red[300],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: imageHeight + 100, 
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: countrestaurantward.length < itemcount ?countrestaurantward.length :itemcount =11,
                physics: const BouncingScrollPhysics(),
                separatorBuilder: (context, index) =>
                    const SizedBox(width: 12),
                itemBuilder: (context, index) {

    final item = countrestaurantward[index];
    final ward = item.keys.first;   
    final count = item.values.first;
                  if ( countrestaurantward.length< itemcount) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                              RestaurantTownPage(town: ward.name,osmId: ward.osmId,),
    
                          ),
                        );
                      },
                      child: Container(
                        width: itemWidth,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: itemWidth,
                              height: imageHeight,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image:  DecorationImage(
                                  image: NetworkImage(
                                         ward.image.isNotEmpty
                        ? ward.image
                        : 'https://via.placeholder.com/150',),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                                ward.name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: titleFont.clamp(16, 22),
                              ),
                                 maxLines: 1,          
                             overflow: TextOverflow.ellipsis, 
                             softWrap: false,
                            ),
                            Text(
                              '$count Restaurant',
                              style: TextStyle(
                                fontSize: subtitleFont.clamp(12, 16),
                                color: Colors.black,
                              ),
                      
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                 if(itemcount-1>index){
 return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                             RestaurantTownPage(town: ward.name,osmId: ward.osmId,),
                          ),
                        );
                      },
                      child: Container(
                        width: itemWidth,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: itemWidth,
                              height: imageHeight,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: DecorationImage(
                                  image: NetworkImage(
                                               ward.image.isNotEmpty
                        ? ward.image
                        : 'https://via.placeholder.com/150',),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                               ward.name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: titleFont.clamp(16, 22),
                              ),
                                 maxLines: 1,          
                             overflow: TextOverflow.ellipsis, 
                             softWrap: false,
                            ),
                            Text(
                              '$count Restaurant',
                              style: TextStyle(
                                fontSize: subtitleFont.clamp(12, 16),
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );

                 }else{
                     return Align(
  alignment: Alignment.center,
  child: Container(
    width: 70,
    height: 70,
    margin: EdgeInsets.only(bottom: 50),
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
  ),
);
                 }
                  }
                },
              ),
            ),
          ],
        );
      },
    ),
  );
}

}
