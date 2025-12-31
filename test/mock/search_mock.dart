import 'package:restaurant/data/model/user.dart';
import 'package:restaurant/data/repositories/search_repository.dart';

class SearchMock  implements  SearchRepository {

@override
  Future<Map<String, dynamic>> searchPlace(String query) async {
    
   final Map<String, dynamic> mockGeoJsonResponse = {
  "type": "FeatureCollection",
  "licence":
      "Data © OpenStreetMap contributors, ODbL 1.0. http://osm.org/copyright",
  "features": [
    {
      "type": "Feature",
      "properties": {
        "place_id": 219618703,
        "osm_type": "node",
        "osm_id": 773601261,
        "place_rank": 30,
        "category": "amenity",
        "type": "restaurant",
        "importance": 7.283054856179167e-05,
        "addresstype": "amenity",
        "name": "Pho 10 Ly Quoc Su",
        "display_name":
            "Pho 10 Ly Quoc Su, 10, Phố Lý Quốc Sư, Phường Hoàn Kiếm, Hà Nội, 11024, Việt Nam",
        "address": {
          "amenity": "Pho 10 Ly Quoc Su",
          "house_number": "10",
          "road": "Phố Lý Quốc Sư",
          "city_district": "Phường Hoàn Kiếm",
          "city": "Hà Nội",
          "ISO3166-2-lvl4": "VN-HN",
          "postcode": "11024",
          "country": "Việt Nam",
          "country_code": "vn",
        },
      },
      "bbox": [
        105.8487974,
        21.0304224,
        105.8488974,
        21.0305224,
      ],
      "geometry": {
        "type": "Point",
        "coordinates": [105.8488474, 21.0304724],
      },
    },
    {
      "type": "Feature",
      "properties": {
        "place_id": 220460190,
        "osm_type": "node",
        "osm_id": 6402581586,
        "place_rank": 30,
        "category": "amenity",
        "type": "restaurant",
        "importance": 7.283054856179167e-05,
        "addresstype": "amenity",
        "name": "Pho 10",
        "display_name":
            "Pho 10, Phố Chân Cầm, Phường Hoàn Kiếm, Hà Nội, 11024, Việt Nam",
        "address": {
          "amenity": "Pho 10",
          "road": "Phố Chân Cầm",
          "city_district": "Phường Hoàn Kiếm",
          "city": "Hà Nội",
          "ISO3166-2-lvl4": "VN-HN",
          "postcode": "11024",
          "country": "Việt Nam",
          "country_code": "vn",
        },
      },
      "bbox": [
        105.8486732,
        21.0305456,
        105.8487732,
        21.0306456,
      ],
      "geometry": {
        "type": "Point",
        "coordinates": [105.8487232, 21.0305956],
      },
    },
    {
      "type": "Feature",
      "properties": {
        "place_id": 219650495,
        "osm_type": "node",
        "osm_id": 4385152989,
        "place_rank": 30,
        "category": "amenity",
        "type": "restaurant",
        "importance": 7.283054856179167e-05,
        "addresstype": "amenity",
        "name": "Pho 10",
        "display_name":
            "Pho 10, Phố Hàng Vôi, Phường Hoàn Kiếm, Hà Nội, 11024, Việt Nam",
        "address": {
          "amenity": "Pho 10",
          "road": "Phố Hàng Vôi",
          "city_district": "Phường Hoàn Kiếm",
          "city": "Hà Nội",
          "ISO3166-2-lvl4": "VN-HN",
          "postcode": "11024",
          "country": "Việt Nam",
          "country_code": "vn",
        },
      },
      "bbox": [
        105.8565220,
        21.0299005,
        105.8566220,
        21.0300005,
      ],
      "geometry": {
        "type": "Point",
        "coordinates": [105.856572, 21.0299505],
      },
    },
    {
      "type": "Feature",
      "properties": {
        "place_id": 220106797,
        "osm_type": "way",
        "osm_id": 236991046,
        "place_rank": 26,
        "category": "highway",
        "type": "residential",
        "importance": 0.05338637140459293,
        "addresstype": "road",
        "name": "Phố 10",
        "display_name":
            "Phố 10, Vân Giang, Phường Hoa Lư, Tỉnh Ninh Bình, 08212, Việt Nam",
        "address": {
          "road": "Phố 10",
          "suburb": "Vân Giang",
          "city": "Phường Hoa Lư",
          "state": "Tỉnh Ninh Bình",
          "ISO3166-2-lvl4": "VN-18",
          "postcode": "08212",
          "country": "Việt Nam",
          "country_code": "vn",
        },
      },
      "bbox": [
        105.9741093,
        20.2541812,
        105.9770981,
        20.2552700,
      ],
      "geometry": {
        "type": "Point",
        "coordinates": [105.9756024, 20.254725],
      },
    },
  ],
};
return  mockGeoJsonResponse;
  }

  @override
  Future<String> getAddressFromLatLon(double lat, double lon) async {
 final Map<String, dynamic> mockPlaceDetailResponse = {
  "place_id": 221016324,
  "licence":
      "Data © OpenStreetMap contributors, ODbL 1.0. http://osm.org/copyright",
  "osm_type": "node",
  "osm_id": 773601261,
  "lat": "21.0304724",
  "lon": "105.8488474",
  "category": "amenity",
  "type": "restaurant",
  "place_rank": 30,
  "importance": 7.283054856179167e-05,
  "addresstype": "amenity",
  "name": "Pho 10 Ly Quoc Su",
  "display_name":
      "Pho 10 Ly Quoc Su, 10, Phố Lý Quốc Sư, Khu phố cổ, Phường Hoàn Kiếm, Hà Nội, 11024, Việt Nam",
  "address": {
    "amenity": "Pho 10 Ly Quoc Su",
    "house_number": "10",
    "road": "Phố Lý Quốc Sư",
    "quarter": "Khu phố cổ",
    "city_district": "Phường Hoàn Kiếm",
    "city": "Hà Nội",
    "ISO3166-2-lvl4": "VN-HN",
    "postcode": "11024",
    "country": "Việt Nam",
    "country_code": "vn",
  },
  "boundingbox": [
    "21.0304224",
    "21.0305224",
    "105.8487974",
    "105.8488974",
  ],
};




    
    final displayName = mockPlaceDetailResponse['display_name'];
 
 return displayName;
}

@override
  Future<Map<String, dynamic>> getrestaurant() async {
 final Map<String, dynamic> mockRestaurants = {
  "type": "FeatureCollection",
  "features": [
    {
      "type": "Feature",
      "geometry": {
        "type": "Point",
        "coordinates": [105.8434161, 21.0262611]
      },
      "properties": {
        "full_id": "n721836715",
        "osm_id": "721836715",
        "price": null,
        "kids_area": null,
        "baby_feeding": null,
        "self_service": null,
        "website_me": null,
        "image": null,
        "bar": null,
        "indoor": null,
        "contact_in": null,
        "air_conditioning": null,
        "outdoor": null,
        "email": null,
        "contact_fa": null,
        "delivery": null,
        "description": null,
        "phone": "+84439428162",
        "opening_hour": "Mo-Su 06:45-22:00",
        "cuisine": "vietnamese",
        "website": "https://ngonhanoi.com.vn/",
        "addr_street": "Phố Phan Bội Châu",
        "name": "Quán Ăn Ngon - Phan Bội Châu",
        "payment": null,
        "diet": null,
        "starttime": null
      }
    },
    {
      "type": "Feature",
      "geometry": {
        "type": "Point",
        "coordinates": [105.8488474, 21.0304724]
      },
      "properties": {
        "full_id": "n773601261",
        "osm_id": "773601261",
        "price": null,
        "kids_area": null,
        "baby_feeding": null,
        "self_service": null,
        "website_me": null,
        "image": null,
        "bar": null,
        "indoor": null,
        "contact_in": null,
        "air_conditioning": null,
        "outdoor": null,
        "email": null,
        "contact_fa": null,
        "delivery": null,
        "description": null,
        "phone": "+84438257338",
        "opening_hour": "Mo-Su 06:00-22:00",
        "cuisine": "vietnamese",
        "website": "http://www.pho10lyquocsu.com.vn",
        "addr_street": "Phố Lý Quốc Sư",
        "name": "Pho 10",
        "payment": null,
        "diet": null,
        "starttime": null
      }
    },
    {
      "type": "Feature",
      "geometry": {
        "type": "Point",
        "coordinates": [105.8092811, 21.029439]
      },
      "properties": {
        "full_id": "n2175084765",
        "osm_id": "2175084765",
        "price": null,
        "kids_area": null,
        "baby_feeding": null,
        "self_service": null,
        "website_me": null,
        "image": null,
        "bar": null,
        "indoor": null,
        "contact_in": null,
        "air_conditioning": null,
        "outdoor": null,
        "email": null,
        "contact_fa": null,
        "delivery": null,
        "description": null,
        "phone": "+84 243 771 6372",
        "opening_hour": "Mo-Su 08:00-23:00",
        "cuisine": "vietnamese",
        "website": null,
        "addr_street": "Ngõ 575 Kim Mã",
        "name": "Nhà Hàng Highway 4",
        "payment": null,
        "diet": null,
        "starttime": null
      }
    },
    {
      "type": "Feature",
      "geometry": {
        "type": "Point",
        "coordinates": [105.8535038, 21.0347487]
      },
      "properties": {
        "full_id": "n2256217990",
        "osm_id": "2256217990",
        "price": null,
        "kids_area": null,
        "baby_feeding": null,
        "self_service": null,
        "website_me": null,
        "image": null,
        "bar": null,
        "indoor": null,
        "contact_in": null,
        "air_conditioning": null,
        "outdoor": null,
        "email": null,
        "contact_fa": null,
        "delivery": null,
        "description": null,
        "phone": "+84 94 485 20 09",
        "opening_hour": "Mo-Su 09:00-23:00",
        "cuisine": "asian;international",
        "website": null,
        "addr_street": "Mã Mây",
        "name": "Nhà Hàng Blue Butterfly",
        "payment": null,
        "diet": "vegetarian",
        "starttime": null
      }
    },
    {
      "type": "Feature",
      "geometry": {
        "type": "Point",
        "coordinates": [105.8090898, 21.0294166]
      },
      "properties": {
        "full_id": "n2399194698",
        "osm_id": "2399194698",
        "price": null,
        "kids_area": null,
        "baby_feeding": null,
        "self_service": null,
        "website_me": null,
        "image": null,
        "bar": null,
        "indoor": null,
        "contact_in": null,
        "air_conditioning": null,
        "outdoor": null,
        "email": null,
        "contact_fa": null,
        "delivery": null,
        "description": null,
        "phone": "+84 243 7247 008",
        "opening_hour":
            "Mo 11:30-14:00,17:30-23:00; Tu-Su 11:30-14:00,17:30-22:00",
        "cuisine": "japanese",
        "website": null,
        "addr_street": "Phố Kim Mã",
        "name": "Izakaya Yancha",
        "payment": null,
        "diet": null,
        "starttime": null
      }
    },
    {
      "type": "Feature",
      "geometry": {
        "type": "Point",
        "coordinates": [105.8074289, 21.0292029]
      },
      "properties": {
        "full_id": "n2399239575",
        "osm_id": "2399239575",
        "price": null,
        "kids_area": null,
        "baby_feeding": null,
        "self_service": null,
        "website_me": null,
        "image": null,
        "bar": null,
        "indoor": null,
        "contact_in": null,
        "air_conditioning": null,
        "outdoor": null,
        "email": null,
        "contact_fa": null,
        "delivery": null,
        "description": null,
        "phone": "+84 243 766 3776",
        "opening_hour": "Mo-Su 10:00-22:30",
        "cuisine": "japanese",
        "website": null,
        "addr_street": "Phố Kim Mã",
        "name": "Kitaguni",
        "payment": null,
        "diet": null,
        "starttime": null
      }
    },
    {
      "type": "Feature",
      "geometry": {
        "type": "Point",
        "coordinates": [105.7960898, 21.0178536]
      },
      "properties": {
        "full_id": "n3541565714",
        "osm_id": "3541565714",
        "price": null,
        "kids_area": null,
        "baby_feeding": null,
        "self_service": null,
        "website_me": null,
        "image": null,
        "bar": null,
        "indoor": null,
        "contact_in": null,
        "air_conditioning": null,
        "outdoor": null,
        "email": null,
        "contact_fa": null,
        "delivery": null,
        "description": null,
        "phone": null,
        "opening_hour": "24/7",
        "cuisine": "vietnamese;noodles",
        "website": null,
        "addr_street": null,
        "name": "Phở 24",
        "payment": null,
        "diet": null,
        "starttime": null
      }
    },
    {
      "type": "Feature",
      "geometry": {
        "type": "Point",
        "coordinates": [105.8932462, 21.0504678]
      },
      "properties": {
        "full_id": "n4090305470",
        "osm_id": "4090305470",
        "price": null,
        "kids_area": null,
        "baby_feeding": null,
        "self_service": null,
        "website_me": null,
        "image": null,
        "bar": null,
        "indoor": null,
        "contact_in": null,
        "air_conditioning": null,
        "outdoor": null,
        "email": null,
        "contact_fa": null,
        "delivery": "yes",
        "description": null,
        "phone": null,
        "opening_hour": "Mo-Su 10:00-22:00",
        "cuisine": "pizza",
        "website": null,
        "addr_street": "Đường Nguyễn Văn Linh",
        "name": "Pizza Hut",
        "payment": null,
        "diet": null,
        "starttime": null
      }
    },
    {
      "type": "Feature",
      "geometry": {
        "type": "Point",
        "coordinates": [105.8291428, 21.0625869]
      },
      "properties": {
        "full_id": "n4164895890",
        "osm_id": "4164895890",
        "price": null,
        "kids_area": null,
        "baby_feeding": null,
        "self_service": null,
        "website_me": null,
        "image": null,
        "bar": null,
        "indoor": null,
        "contact_in": null,
        "air_conditioning": null,
        "outdoor": null,
        "email": null,
        "contact_fa": null,
        "delivery": null,
        "description": null,
        "phone": "+84 246 292 1044",
        "opening_hour": "Mo-Su 08:00-24:00",
        "cuisine": "american;burger",
        "website": "https://www.chops.vn/",
        "addr_street": "Phố Quảng An",
        "name": "Chops",
        "payment": null,
        "diet": null,
        "starttime": null
      }
    }
  ]
};
return mockRestaurants;
  }


     @override
  Future<Map<String, dynamic>> getrestaurantID(int id) async {



    final data =[[{
  "type": "FeatureCollection",
  "features": [
    {
      "type": "Feature",
      "geometry": {
        "type": "Point",
        "coordinates": [105.8291428, 21.0625869]
      },
      "properties": {
        "full_id": "n4164895890",
        "osm_id": "4164895890",
        "price": null,
        "kids_area": null,
        "baby_feeding": null,
        "self_service": null,
        "website_me": null,
        "image": null,
        "bar": null,
        "indoor": null,
        "contact_in": null,
        "air_conditioning": null,
        "outdoor": null,
        "email": null,
        "contact_fa": null,
        "delivery": null,
        "description": null,
        "phone": "+84 246 292 1044",
        "opening_hour": "Mo-Su 08:00-24:00",
        "cuisine": "american;burger",
        "website": "https://www.chops.vn/",
        "addr_street": "Phố Quảng An",
        "name": "Chops",
        "payment": null,
        "diet": null,
        "starttime": null
      }
    }
  ]
}]]

;
    final innerList = data[0] as List<dynamic>;
    return  innerList[0] as Map<String, dynamic>;
  
  }

  @override
  Future<Map<String, dynamic>> getrestaurantIDWARD(int id) async {

    final data = [[{
  "type": "FeatureCollection",
  "features": [
    {
      "type": "Feature",
      "geometry": { "type": "Point", "coordinates": [105.8488474, 21.0304724] },
      "properties": {
        "full_id": "n773601261",
        "osm_id": "773601261",
        "price": null,
        "kids_area": null,
        "baby_feeding": null,
        "self_service": null,
        "website_me": null,
        "image": null,
        "bar": null,
        "indoor": null,
        "contact_in": null,
        "air_conditioning": null,
        "outdoor": null,
        "email": null,
        "contact_fa": null,
        "delivery": null,
        "description": null,
        "phone": "+84438257338",
        "opening_hour": "Mo-Su 06:00-22:00",
        "cuisine": "vietnamese",
        "website": "http://www.pho10lyquocsu.com.vn",
        "addr_street": "Phố Lý Quốc Sư",
        "name": "Pho 10",
        "payment": null,
        "diet": null,
        "starttime": null
      }
    },
    {
      "type": "Feature",
      "geometry": { "type": "Point", "coordinates": [105.8535038, 21.0347487] },
      "properties": {
        "full_id": "n2256217990",
        "osm_id": "2256217990",
        "price": null,
        "kids_area": null,
        "baby_feeding": null,
        "self_service": null,
        "website_me": null,
        "image": null,
        "bar": null,
        "indoor": null,
        "contact_in": null,
        "air_conditioning": null,
        "outdoor": null,
        "email": null,
        "contact_fa": null,
        "delivery": null,
        "description": null,
        "phone": "+84 94 485 20 09",
        "opening_hour": "Mo-Su 09:00-23:00",
        "cuisine": "asian;international",
        "website": null,
        "addr_street": "Mã Mây",
        "name": "Nhà Hàng Blue Butterfly",
        "payment": null,
        "diet": "vegetarian",
        "starttime": null
      }
    },
    {
      "type": "Feature",
      "geometry": { "type": "Point", "coordinates": [105.8492754, 21.0297478] },
      "properties": {
        "full_id": "n4327534896",
        "osm_id": "4327534896",
        "price": null,
        "kids_area": null,
        "baby_feeding": null,
        "self_service": null,
        "website_me": null,
        "image": null,
        "bar": null,
        "indoor": null,
        "contact_in": null,
        "air_conditioning": null,
        "outdoor": null,
        "email": null,
        "contact_fa": null,
        "delivery": null,
        "description": null,
        "phone": null,
        "opening_hour": "Mo-Su 10:00-21:00",
        "cuisine": "vietnamese",
        "website": null,
        "addr_street": "Phố Lý Quốc Sư",
        "name": "Noodle & Roll",
        "payment": null,
        "diet": "vegetarian",
        "starttime": null
      }
    }
   
  ]
}]]
;  
    final innerList = data[0] as List<dynamic>;
    return  innerList[0] as Map<String, dynamic>;
    
  }

     @override
  Future<Map<String, dynamic>> getrestaurantbound(

       double minLon,
       double minLat,
       double maxLon,
       double maxLat
     ) async {

   
    return {
  "type": "FeatureCollection",
  "features": [
    {
      "type": "Feature",
      "geometry": {
        "type": "Point",
        "coordinates": [105.8434161, 21.0262611]
      },
      "properties": {
        "full_id": "n721836715",
        "osm_id": "721836715",
        "price": null,
        "kids_area": null,
        "baby_feeding": null,
        "self_service": null,
        "website_me": null,
        "image": null,
        "bar": null,
        "indoor": null,
        "contact_in": null,
        "air_conditioning": null,
        "outdoor": null,
        "email": null,
        "contact_fa": null,
        "delivery": null,
        "description": null,
        "phone": "+84439428162",
        "opening_hour": "Mo-Su 06:45-22:00",
        "cuisine": "vietnamese",
        "website": "https://ngonhanoi.com.vn/",
        "addr_street": "Phố Phan Bội Châu",
        "name": "Quán Ăn Ngon - Phan Bội Châu",
        "payment": null,
        "diet": null,
        "starttime": null
      }
    },
    {
      "type": "Feature",
      "geometry": {
        "type": "Point",
        "coordinates": [105.8488474, 21.0304724]
      },
      "properties": {
        "full_id": "n773601261",
        "osm_id": "773601261",
        "price": null,
        "kids_area": null,
        "baby_feeding": null,
        "self_service": null,
        "website_me": null,
        "image": null,
        "bar": null,
        "indoor": null,
        "contact_in": null,
        "air_conditioning": null,
        "outdoor": null,
        "email": null,
        "contact_fa": null,
        "delivery": null,
        "description": null,
        "phone": "+84438257338",
        "opening_hour": "Mo-Su 06:00-22:00",
        "cuisine": "vietnamese",
        "website": "http://www.pho10lyquocsu.com.vn",
        "addr_street": "Phố Lý Quốc Sư",
        "name": "Pho 10",
        "payment": null,
        "diet": null,
        "starttime": null
      }
    },
    {
      "type": "Feature",
      "geometry": {
        "type": "Point",
        "coordinates": [105.8535038, 21.0347487]
      },
      "properties": {
        "full_id": "n2256217990",
        "osm_id": "2256217990",
        "price": null,
        "kids_area": null,
        "baby_feeding": null,
        "self_service": null,
        "website_me": null,
        "image": null,
        "bar": null,
        "indoor": null,
        "contact_in": null,
        "air_conditioning": null,
        "outdoor": null,
        "email": null,
        "contact_fa": null,
        "delivery": null,
        "description": null,
        "phone": "+84 94 485 20 09",
        "opening_hour": "Mo-Su 09:00-23:00",
        "cuisine": "asian;international",
        "website": null,
        "addr_street": "Mã Mây",
        "name": "Nhà Hàng Blue Butterfly",
        "payment": null,
        "diet": "vegetarian",
        "starttime": null
      }
    }
  ]
}
 as Map<String, dynamic> ;
   
  }


 @override
  Future<Map<String, dynamic>> getward() async {


   
    final data =[
    [
        {
            "type": "FeatureCollection",
            "features":
            [ {
                    "type": "Feature",
                    "geometry": {
                        "type": "MultiPolygon",
                        "coordinates": [
                            
                              
                        ]
                    },
                    "properties": {
                        "full_id": "r19338089",
                        "osm_id": "19338089",
                        "name": "Xã Trung Giã",
                        "name_en": "Trung Gia Commune",
                        "image": "https://resource.kinhtedothi.vn/resources2025/1/users/49/soc-son-3-1755610860.jpeg"
                    }
                },
                {
                    "type": "Feature",
                    "geometry": {
                        "type": "MultiPolygon",
                        "coordinates": [
                            
                              
                        ]
                    },
                    "properties": {
                        "full_id": "r19338090",
                        "osm_id": "19338090",
                        "name": "Xã Kim Anh",
                        "name_en": "Kim Anh Commune",
                        "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcREnTUJmur1TSqOxK8_KG86dgOq51dtQYX6TQ&s"
                    }
                },
                {
                    "type": "Feature",
                    "geometry": {
                        "type": "MultiPolygon",
                        "coordinates": [
                           
                        ]
                    },
                    "properties": {
                        "full_id": "r19331655",
                        "osm_id": "19331655",
                        "name": "Phường Văn Miếu - Quốc Tử Giám",
                        "name_en": "Van Mieu - Quoc Tu Giam Ward",
                        "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ429EbnsvQbEOuhzXAxLc3a5x4FUYLt4ZVBQ&s"
                    }
                },
                {
                    "type": "Feature",
                    "geometry": {
                        "type": "MultiPolygon",
                        "coordinates": [
                          
                        ]
                    },
                    "properties": {
                        "full_id": "r19331657",
                        "osm_id": "19331657",
                        "name": "Phường Bạch Mai",
                        "name_en": "Bach Mai Ward",
                        "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR-pppBaOVZnkQxtVgwt0v5Jm8ju2QYE3iSUw&s"
                    }
                },
                {
                    "type": "Feature",
                    "geometry": {
                        "type": "MultiPolygon",
                        "coordinates": [
                            
                               
                        ]
                    },
                    "properties": {
                        "full_id": "r19331658",
                        "osm_id": "19331658",
                        "name": "Phường Ô Chợ Dừa",
                        "name_en": "O Cho Dua Ward",
                        "image": "https://global-uploads.webflow.com/60af8c708c6f35480d067652/6184d591a39ff12e498c701c_ubnd-o-cho-dua.png"
                    }
                },
                {
                    "type": "Feature",
                    "geometry": {
                        "type": "MultiPolygon",
                        "coordinates": [
                            
                        ]
                    },
                    "properties": {
                        "full_id": "r19331659",
                        "osm_id": "19331659",
                        "name": "Phường Đống Đa",
                        "name_en": "Dong Da Ward",
                        "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQmDA5B8l9IfTKw2SsiRmLCcF9aCqU7LobxnA&s"
                    }
                },
                {
                    "type": "Feature",
                    "geometry": {
                        "type": "MultiPolygon",
                        "coordinates": [
                           
                        ]
                    },
                    "properties": {
                        "full_id": "r19332318",
                        "osm_id": "19332318",
                        "name": "Phường Láng",
                        "name_en": "Lang Ward",
                        "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRPXLMMoiDD75C4jDg_aroq-tN5VK0tK73LWw&s"
                    }
                },
                {
                    "type": "Feature",
                    "geometry": {
                        "type": "MultiPolygon",
                        "coordinates": [
                          
                        ]
                    },
                    "properties": {
                        "full_id": "r19332319",
                        "osm_id": "19332319",
                        "name": "Phường Giảng Võ",
                        "name_en": "Giang Vo Ward",
                        "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcShibnD4Ec6IPX3jth49d4s_hDVWguNJ0NmvQ&s"
                    }
                },
                {
                    "type": "Feature",
                    "geometry": {
                        "type": "MultiPolygon",
                        "coordinates": [
                          
                        ]
                    },
                    "properties": {
                        "full_id": "r19301119",
                        "osm_id": "19301119",
                        "name": "Phường Long Biên",
                        "name_en": "Long Bien Ward",
                        "image": "https://cdn.xanhsm.com/2024/11/fd021095-cau-long-bien-3.jpg"
                    }
                },
                {
                    "type": "Feature",
                    "geometry": {
                        "type": "MultiPolygon",
                        "coordinates": [
                          
                        ]
                    },
                    "properties": {
                        "full_id": "r19411387",
                        "osm_id": "19411387",
                        "name": "Xã Ứng Hòa",
                        "name_en": "Ứng Hòa Commune",
                        "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRFwdoNcQO7uDeQs7OwfmikgiAPXg_LGCJyWA&s"
                    }
                },
                {
                    "type": "Feature",
                    "geometry": {
                        "type": "MultiPolygon",
                        "coordinates": [
                           
                        ]
                    },
                    "properties": {
                        "full_id": "r19334585",
                        "osm_id": "19334585",
                        "name": "Phường Phương Liệt",
                        "name_en": "Phuong Liet Ward",
                        "image": "https://meetup.vn/wp-content/uploads/2025/07/phuong-phuong-liet-ha-noi-68683b.jpg"
                    }
                },
                ]
        }
    ]
] ;
    final innerList = data[0] as List<dynamic>;
    return  innerList[0] as Map<String, dynamic>;
  
  }
  @override
  Future<Map<String, dynamic>> getwardID(int id) async {
  
    final data = [
    [
        {
            "type": "FeatureCollection",
            "features": [
                {
                    "type": "Feature",
                    "geometry": {
                        "type": "MultiPolygon",
                        "coordinates": [
                          
                        ]
                    },
                    "properties": {
                        "full_id": "r19331651",
                        "osm_id": "19331651",
                        "name": "Phường Hoàn Kiếm",
                        "name_en": "Hoan Kiem Ward",
                        "image": "https://lirp.cdn-website.com/9c039c04/dms3rep/multi/opt/ho-hoan-kiem-2-640w.jpg"
                    }
                }
            ]
        }
    ]
];  
    final innerList = data[0] as List<dynamic>;
    return  innerList[0] as Map<String, dynamic>;
   
  }
  @override
  Future<Map<String, dynamic>> getwardlatlon(double lat,double  lon) async {


    final data = [
    [
        {
            "type": "FeatureCollection",
            "features": [
                {
                    "type": "Feature",
                    "geometry": {
                        "type": "MultiPolygon",
                        "coordinates": [
                          
                        ]
                    },
                    "properties": {
                        "full_id": "r19331651",
                        "osm_id": "19331651",
                        "name": "Phường Hoàn Kiếm",
                        "name_en": "Hoan Kiem Ward"
                    }
                }
            ]
        }
    ]
];  
  
    final innerList = data[0] as List<dynamic>;
    return  innerList[0] as Map<String, dynamic>;
   

  }

//Kêt nối api diet
  @override
  Future<List<dynamic>> getdiet() async {
 
    final data = [
    {
        "id": 1,
        "diet": "vietnamese",
        "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSizTMOjDQBeDuaL3spDV01JRwjnCzm9wW3Ag&s"
    },
    {
        "id": 2,
        "diet": "asian",
        "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSuLL9kpq2FIopxXxLuKR3eVY8V-PKOxkn2-A&s"
    },
    {
        "id": 3,
        "diet": "international",
        "image": "https://cdn-ijnhp.nitrocdn.com/pywIAllcUPgoWDXtkiXtBgvTOSromKIg/assets/images/optimized/rev-5794eaa/www.jaypeehotels.com/blog/wp-content/uploads/2020/09/chinese-1.jpg"
    },
    {
        "id": 4,
        "diet": "pizza",
        "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRz9bV18R5_34GH7dRVh4MkpFU1mVEx33tOfA&s"
    },
    {
        "id": 5,
        "diet": "japanese",
        "image": "https://nakatojapanesesteakhouse.com/wp-content/uploads/2024/08/Nakto-Cover-Photo.jpg"
    },
    {
        "id": 6,
        "diet": "noodles",
        "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQa1ZdKzx5X3lyop9Nk79ZqTRN85Ic6uVvctA&s"
    },
    {
        "id": 7,
        "diet": "hotpot",
        "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSHBad_f-qvM9LJan0zzMHVpKU8UJmFQBZWBQ&s"
    },
    {
        "id": 8,
        "diet": "regional",
        "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTz_26NFN793LXBqiFa_mkRazfvNqJi3kClNw&s"
    },
    {
        "id": 9,
        "diet": "american",
        "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSJVej_MpOskwsn2_w0g0SohHBWjUqfz4blMA&s"
    },
    {
        "id": 10,
        "diet": "burger",
        "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR-7PKDrvRWHkOR6_aMj5YzHn4OzfwS4D3Veg&s"
    },
    {
        "id": 11,
        "diet": "korean",
        "image": "https://ik.imagekit.io/tvlk/blog/2024/07/Kimchi-Korean-Traditional-Food-1024x576.jpg?tr=q-70,c-at_max,w-1000,h-600"
    },
    {
        "id": 12,
        "diet": "steak_house",
        "image": "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/2b/6c/13/1a/black-rock-steaks-rib.jpg?w=800&h=500&s=1"
    },
    {
        "id": 13,
        "diet": "fish",
        "image": "https://thewoksoflife.com/wp-content/uploads/2025/11/kaoyu-recipe-15.jpg"
    },
    {
        "id": 14,
        "diet": "indian",
        "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSyK7iVD1XjH5Ko4C4KHHCkyOy4FGmVT-m29w&s"
    },
    {
        "id": 15,
        "diet": "fast_food",
        "image": "https://img.freepik.com/free-photo/top-view-fast-food-mix-mozzarella-sticks-club-sandwich-hamburger-mushroom-pizza-caesar-shrimp-salad-french-fries-ketchup-mayo-cheese-sauces-table_141793-3998.jpg?semt=ais_hybrid&w=740&q=80"
    },
    {
        "id": 16,
        "diet": "coffee_shop",
        "image": "https://www.luxcafeclub.com/cdn/shop/articles/Italian_Food_Pairings_Coffee_1100x.png?v=1714586900"
    },
    {
        "id": 17,
        "diet": "ice_cream",
        "image": "https://cdn.britannica.com/50/80550-050-5D392AC7/Scoops-kinds-ice-cream.jpg"
    },
    {
        "id": 18,
        "diet": "french",
        "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRa0hQHFuOE1Yw5thSJJ99ci_gpvNPm73_Siw&s"
    },
    {
        "id": 19,
        "diet": "grill",
        "image": "https://www.foodandwine.com/thmb/MO-hoMJlE9A69ZF6a6haP79NG34=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/Use-Your-Grill-to-Meal-Plan-FT-BLOG0723-6c2eebaaed8d419ba6864013bd8ffdfa.jpg"
    },
    {
        "id": 20,
        "diet": "barbecue",
        "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTYwFMerbTMmnAh3a7B4yDJPNaoUdN4kGJ_FA&s"
    },
    {
        "id": 21,
        "diet": "buffet",
        "image": "https://www.shutterstock.com/image-photo/cuisine-culinary-buffet-dinner-catering-260nw-1191247123.jpg"
    },
    {
        "id": 22,
        "diet": "italian",
        "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRgIcNvulwh_SdH_vSLCJQAD2TJPeNSsOY2Ew&s"
    },
    {
        "id": 23,
        "diet": "seafood",
        "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTr9rZfm7h0nXkG0LNxett3ygvH0WAuzCbR4Q&s"
    },
    {
        "id": 24,
        "diet": "dessert",
        "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRaJvXXehnAeh_qzrrOLMrq1eqkwL2cSNjh9A&s"
    },
    {
        "id": 25,
        "diet": "sushi",
        "image": "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/1b/5f/89/9e/sushi-set.jpg?w=900&h=500&s=1"
    },
    {
        "id": 26,
        "diet": "salad",
        "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRuGaoy634PfNv0B010m7jdX5Pgrdaybnp_0A&s"
    },
    {
        "id": 27,
        "diet": "diner",
        "image": "https://eddiesdiner.vn/wp-content/uploads/2024/07/Eddie_s-29-1.jpg"
    },
    {
        "id": 28,
        "diet": "chicken",
        "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRU1PwR5GGwcU6sBzFYso_XaewWXt1NnyPcUg&s"
    },
    {
        "id": 29,
        "diet": "sandwich",
        "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSQ2OKGj_nx7fdBExx9BGJgjO29uAEotwN-SA&s"
    },
    {
        "id": 30,
        "diet": "russian",
        "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ9g6OnnEYnkRWiweldC5VnomlgLo_rFf6uNA&s"
    },
    {
        "id": 31,
        "diet": "hot_dog",
        "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSrISy2ihJ91HLCtjB-cjPTJSPSgHMB2V9NrA&s"
    },
    {
        "id": 32,
        "diet": "tea",
        "image": "https://www.rippletea.com/cdn/shop/files/freepik__flat-lay-image-showing-cups-of-different-teas-oolo__91644.jpg?v=1748921500&width=360"
    },
    {
        "id": 33,
        "diet": "pancake",
        "image": "https://ichef.bbci.co.uk/food/ic/food_16x9_1600/recipes/fluffyamericanpancak_74828_16x9.jpg"
    },
    {
        "id": 34,
        "diet": "european",
        "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTPNFJkwsU4vQLjBX9LfhNJy3Wcos__EaEHVg&s"
    },
    {
        "id": 35,
        "diet": "thai",
        "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRYQwpcpoERLikvOsB8XVAcsUNxTOPMgXm-lg&s"
    },
    {
        "id": 36,
        "diet": "german",
        "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ4St1hNqdZyiQ2_actXL25nPNnif8NO7Gbig&s"
    },
    {
        "id": 37,
        "diet": "turkish",
        "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSJEgqinWvuqoYk51B7_szkhulOtes3hmZtAA&s"
    },
    {
        "id": 38,
        "diet": "chinese",
        "image": "https://static.wixstatic.com/media/e1af2b_9ec7c4c0196c4fde9a8fcb859b65ad13~mv2.jpg/v1/fill/w_568,h_378,al_c,q_80,usm_0.66_1.00_0.01,enc_avif,quality_auto/e1af2b_9ec7c4c0196c4fde9a8fcb859b65ad13~mv2.jpg"
    }
];  
   return data as List<dynamic>;
    
  
  }

   final datareview = [
    {
        "id": 1,
        "ratefood": 3,
        "rateservice": 3,
        "rateambience": 3,
        "overallrating": 3,
        "command": "good",
        "id_restaurant": "12230186584",
        "email": "test@example.com",
        "date": "01/12/2025 15:30:45",
        "like": null
    },
    {
        "id": 2,
        "ratefood": 4,
        "rateservice": 4,
        "rateambience": 3,
        "overallrating": 3,
        "command": "good food",
        "id_restaurant": "12372330757",
        "email": "test@example.com",
        "date": "02/12/2025 15:30:45",
        "like": null
    },
    {
        "id": 3,
        "ratefood": 3,
        "rateservice": 4,
        "rateambience": 2,
        "overallrating": 3,
        "command": "good",
        "id_restaurant": "5485791896",
        "email": "test@example.com",
        "date": "03/12/2025 15:30:45",
        "like": null
    },
    {
        "id": 4,
        "ratefood": 2,
        "rateservice": 2,
        "rateambience": 2,
        "overallrating": 2,
        "command": "bad ",
        "id_restaurant": "4090309926",
        "email": "test1@example.com",
        "date": "04/12/2025 15:30:45",
        "like": null
    },
    {
        "id": 5,
        "ratefood": 3,
        "rateservice": 2,
        "rateambience": 3,
        "overallrating": 2,
        "command": "bad",
        "id_restaurant": "4090305470",
        "email": "test2@example.com",
        "date": "05/12/2025 15:03:47",
        "like": null
    },
    {
        "id": 6,
        "ratefood": 3,
        "rateservice": 3,
        "rateambience": 3,
        "overallrating": 3,
        "command": "good",
        "id_restaurant": "11676661169",
        "email": "test3@example.com",
        "date": "06/12/2025 15:30:45",
        "like": null
    },
    {
        "id": 7,
        "ratefood": 4,
        "rateservice": 2,
        "rateambience": 3,
        "overallrating": 3,
        "command": "good",
        "id_restaurant": "5030033123",
        "email": "test2@example.com",
        "date": "07/12/2025 15:30:45",
        "like": null
    },
    {
        "id": 8,
        "ratefood": 3,
        "rateservice": 3,
        "rateambience": 3,
        "overallrating": 3,
        "command": "good",
        "id_restaurant": "4745160523",
        "email": "test2@example.com",
        "date": "08/12/2025 15:30:45",
        "like": null
    },
    {
        "id": 9,
        "ratefood": 4,
        "rateservice": 3,
        "rateambience": 2,
        "overallrating": 3,
        "command": "good",
        "id_restaurant": "4091985948",
        "email": "test1@example.com",
        "date": "09/12/2025 15:30:45",
        "like": null
    },
    {
        "id": 10,
        "ratefood": 4,
        "rateservice": 2,
        "rateambience": 1,
        "overallrating": 3,
        "command": "good",
        "id_restaurant": "7505130585",
        "email": "test@example.com",
        "date": "10/12/2025 15:30:45",
        "like": null
    },
    {
        "id": 11,
        "ratefood": 4,
        "rateservice": 3,
        "rateambience": 3,
        "overallrating": 2,
        "command": null,
        "id_restaurant": "10240244242",
        "email": "test3@example.com",
        "date": "11/12/2025 15:30:45",
        "like": null
    },
    {
        "id": 12,
        "ratefood": 3,
        "rateservice": 3,
        "rateambience": 3,
        "overallrating": 3,
        "command": null,
        "id_restaurant": "12372330757",
        "email": "test12@example.com",
        "date": "24/12/2025 15:30:45",
        "like": null
    },
    {
        "id": 13,
        "ratefood": 3,
        "rateservice": 3,
        "rateambience": 3,
        "overallrating": 3,
        "command": "Delicious food, fast service",
        "id_restaurant": "10240244242",
        "email": "test2@example.com",
        "date": "24/12/2025 15:30:45",
        "like": null
    },
    {
        "id": 14,
        "ratefood": 3,
        "rateservice": 3,
        "rateambience": 3,
        "overallrating": 3,
        "command": "",
        "id_restaurant": "4091985948",
        "email": "test@example.com",
        "date": "23/12/2025 15:30:45",
        "like": null
    },
    {
        "id": 15,
        "ratefood": 3,
        "rateservice": 3,
        "rateambience": 3,
        "overallrating": 3,
        "command": "good",
        "id_restaurant": "4745160523",
        "email": "test@example.com",
        "date": "25/12/2025 09:55:54",
        "like": null
    }
];  
 
  // Lấy tất cả review
@override
Future<List<dynamic>> getreview() async {

  return datareview;
}


@override
Future<List<dynamic>> getreviewID(int id) async {
  await Future.delayed(Duration(milliseconds: 100));
  return datareview.where((review) => review['id_restaurant'] == id.toString()).toList();
}


@override
Future<List<dynamic>> getReviewEmail(String email) async {
 
  return datareview.where((review) => review['email'] == email).toList();
}


@override
Future<List<dynamic>> getReviewEmailID(String email, int osmId) async {

  return datareview
      .where((review) =>
          review['email'] == email && review['id_restaurant'] == osmId.toString())
      .toList();
}


@override
Future<Map<String, dynamic>> addReview({
  required int rateFood,
  required int rateService,
  required int rateAmbience,
  required int overallRating,
  required String command,
  required String idRestaurant,
  required String email,
  required String date,
}) async {


  final newId = datareview.isNotEmpty
      ? datareview.map((e) => e['id'] as int).reduce((a, b) => a > b ? a : b) + 1
      : 1;

  final newReview = {
    "id": newId,
    "ratefood": rateFood,
    "rateservice": rateService,
    "rateambience": rateAmbience,
    "overallrating": overallRating,
    "command": command,
    "id_restaurant": idRestaurant,
    "email": email,
    "date": date,
    "like": null,
  };

  datareview.add(newReview);
  return newReview;
}

// Sửa review
@override
Future<Map<String, dynamic>> editReview({
  required int rateFood,
  required int rateService,
  required int rateAmbience,
  required int overallRating,
  required String command,
  required String idRestaurant,
  required String email,
  required String date,
}) async {


  final index = datareview.indexWhere((review) =>
      review['email'] == email && review['id_restaurant'] == idRestaurant);

  if (index == -1) {
    return {}; 
  }

  final review = datareview[index];

  review['ratefood'] = rateFood;
  review['rateservice'] = rateService;
  review['rateambience'] = rateAmbience;
  review['overallrating'] = overallRating;
  review['command'] = command;
  review['date'] = date;

  datareview[index] = review;
  return review;
}



final  dataUser = [
  {
    "email": "alice@example.com",
    "phone": "0912345678",
    "name": "Alice Nguyen",
    "image": "https://example.com/images/alice.png",
  },
  {
    "email": "bob@example.com",
    "phone": "0987654321",
    "name": "Bob Tran",
    "image": "https://example.com/images/bob.png",
  },
  {
    "email": "carol@example.com",
    "phone": "0901122334",
    "name": "Carol Le",
    "image": null, 
  },
  {
    "email": "david@example.com",
    "phone": "0933555777",
    "name": null, 
    "image": "https://example.com/images/david.png",
  },
  {
    "email": "emma@example.com",
    "phone": "0977888999",
    "name": "Emma Pham",
    "image": null,
  },
  {
    "email": "frank@example.com",
    "phone": "0966778899",
    "name": "Frank Vu",
    "image": "https://example.com/images/frank.png",
  },
  {
    "email": "grace@example.com",
    "phone": "0955443322",
    "name": null,
    "image": null,
  },
];

final List<Map<String, dynamic>> dataUserWithToken = [
  {
    "token": "token_alice_123",
    "user": User(
      email: "alice@example.com",
    phone: "0912345678",
    name: "Alice Nguyen",
    image: "https://example.com/images/alice.png",
    ),
  },
 
];

//kêt nối api user
 
@override
Future<List<dynamic>> checkPhone(String phone) async {
  try {
 
    final result = dataUser.where((user) => user['phone'] == phone).toList();
    return result;
  } catch (e) {
    // ignore: avoid_print
    print('Error checking phone: $e');
    return [];
  }
}

@override
Future<Map<String, dynamic>> checkEmail({
  String phone = "",
  required String email,
}) async {
  try {
    Map<String, dynamic>? rawUser;

    
    if (phone.isEmpty) {
      rawUser = dataUser.firstWhere(
        (u) => u['email'] == email,
        orElse: () => {},
      );
    } else {
      rawUser = dataUser.firstWhere(
        (u) => u['email'] == email && u['phone'] == phone,
        orElse: () => {},
      );
    }

  
    if (rawUser.isEmpty) {
      return {"token": ""};
    }

    
    final newUser = User(
      email: email,
      phone: phone.isNotEmpty ? phone : rawUser['phone'] ?? '',
      name: rawUser['name'], 
      image: null, 
    );

 
    final newToken =
        "token_${email.split('@').first}_${DateTime.now().millisecondsSinceEpoch}";

  
    dataUserWithToken.add({
      "token": newToken,
      "user": newUser,
    });


    return {"token": newToken};
  } catch (e) {
    // ignore: avoid_print
    print('Error checking email: $e');
    return {"token": ""};
  }
}


@override
Future<Map<String, dynamic>> checkToken(String token) async {
  try {
    // Tìm user có token trùng
    final userMap = dataUserWithToken.firstWhere(
      (u) => u['token'] == token,
      orElse: () => {},
    );

    if (userMap.isEmpty) {
      return {}; 
    }


    final user = userMap['user'] as User;
    return user.toJson();
  } catch (e) {
    // ignore: avoid_print
    print('Error checking token: $e');
    return {};
  }
}



// Mock saveUser
@override
Future<Map<String, dynamic>> saveUser(
    String email,
    String phone,
    String lastname, 
    String firstname
) async {
  try {
    final fullName = '$firstname $lastname'.trim();

  
    final exists = dataUserWithToken.any((u) => u['user'].email == email);
    if (exists) {
      return {"token": ""}; 
    }

   
    final newUser = User(
      email: email,
      phone: phone,
      name: fullName.isEmpty ? null : fullName,
      image: null,
    );

    
    final newToken = "token_${email.split('@').first}_${DateTime.now().millisecondsSinceEpoch}";

   
    dataUserWithToken.add({
      "token": newToken,
      "user": newUser,
    });

    
    dataUser.add({
      "email": email,
      "phone": phone,
      "name": fullName.isEmpty ? null : fullName,
      "image": null,
    });

    return {"token": newToken};
  } catch (e) {
    // ignore: avoid_print
    print('Error saving user: $e');
    return {"token": ""};
  }
}

@override
Future<Map<String, dynamic>> editUser(
    String email,
    String phone,
    String lastname, 
    String firstname,
    String oldemail
) async {
  try {
    final fullName = '$firstname $lastname'.trim();

    // Kiểm tra xem email mới có trùng với user khác không
    final emailExists = dataUserWithToken.any(
      (u) => u['user'].email == email && u['user'].email != oldemail,
    );
    if (emailExists) {
    
      return {"token": ""};
    }

    // Tìm user trong token list theo oldemail
    final indexToken = dataUserWithToken.indexWhere((u) => u['user'].email == oldemail);
    if (indexToken == -1) {
      return {"token": ""}; 
    }

    // Cập nhật user mới
    final updatedUser = User(
      email: email,
      phone: phone,
      name: fullName.isEmpty ? null : fullName,
      image: dataUserWithToken[indexToken]['user'].image, 
    );

    // Tạo token mới
    final newToken = "token_${email.split('@').first}_${DateTime.now().millisecondsSinceEpoch}";

    dataUserWithToken[indexToken] = {
      "token": newToken,
      "user": updatedUser,
    };

    // Cập nhật trong dataUser gốc
    final indexData = dataUser.indexWhere((u) => u['email'] == oldemail);
    if (indexData != -1) {
      dataUser[indexData] = {
        "email": email,
        "phone": phone,
        "name": fullName.isEmpty ? null : fullName,
        "image": dataUser[indexData]['image'], 
      };
    }

    return {"token": newToken};
  } catch (e) {
    // ignore: avoid_print
    print('Error editing user: $e');
    return {"token": ""};
  }
}



@override
Future<List<dynamic>> getUser(String email) async {
  try {
    final result = dataUser
        .where((u) => u['email'] == email)
        .toList();
    return result;
  } catch (e) {
    // ignore: avoid_print
    print('Error getting user: $e');
    return [];
  }
}
}