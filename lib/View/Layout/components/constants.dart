// //
// // import 'package:car_comminty/Models/car_app/Address/address_model.dart';
// // import 'package:car_comminty/Models/car_app/Market_Home/get_orders_model.dart';
// // import 'package:car_comminty/Models/car_app/Market_Home/main_sub_category_model.dart';
// // import 'package:car_comminty/Models/car_app/Market_Home/market_model.dart';
// // import 'package:car_comminty/Models/car_app/Market_Home/search_products_model.dart';
// // import 'package:car_comminty/Models/car_app/cars/get_services_car_model.dart';
// // import 'package:car_comminty/Models/car_app/cars/get_services_types_model.dart';
// // import 'package:car_comminty/Models/car_app/payments/get_payments_model.dart';
// // import 'package:car_comminty/Models/car_app/payments/get_user_payments_model.dart';
// // import 'package:car_comminty/Models/car_app/reminder/get_reminders_model.dart';
// // import 'package:car_comminty/Models/car_app/routes/get_route_car_model.dart';
// // import 'package:car_comminty/Models/car_app/routes/get_routes_car_model.dart';
// // import 'package:geolocator/geolocator.dart';
// // import 'package:car_comminty/Models/car_app/Cart_all_model.dart';
// // import 'package:car_comminty/Models/car_app/cars/get_car_user_model.dart';
// // import 'package:car_comminty/Models/car_app/cars/get_cars_user_model.dart';
// // import 'package:car_comminty/Models/car_app/fav_model.dart';
// // import 'package:car_comminty/Models/car_app/user_car_model.dart';
// // import 'package:car_comminty/Models/car_app/user_model.dart';
// // import 'package:car_comminty/Modules/Car_Com_app/Login_Screen/shop_login_screen.dart';
// // import 'package:car_comminty/Shared/network/Local/chaced_helper.dart';
// // import 'package:flutter/cupertino.dart';
// //
// // import '../../Models/car_app/Brands/brand_model.dart';
// // import 'package:car_comminty/Models/car_app/product/product_model.dart';
// import 'components.dart';
// //
// // import 'package:maps_toolkit/maps_toolkit.dart';import 'dart:math';
//
// // void signOut(context)async
// // {
// //   ChacheHelper.RemoveData(key:'token').then((value) => {
// //     if(value)
// //       {
// //         token='',
// //         email_in='',
// //         code = 0 ,
// //         Brands_car = null,
// //         user_cars =null,
// //         user_car = null,
// //         User = null,
// //         User_search=null,
// //         users_on_car=null,
// //
// //
// //
// //
// //       services_types = null,
// //       payments = get_payments_model(),
// //       Market_Data = market_model(),
// //       Brands_car = brand_model(),
// //       user_cars= get_cars_user_model(),
// //       user_payments = get_user_payments_model(),
// //        user_addresses = Address_Model(),
// //       user_car = get_car_user_model(),
// //         brand_id_get_model = 0,
// //        User_search =UserModel(),
// //       users_on_car = user_car_model(),
// //       Services_users = get_services_car_model(),
// //       services_types_reminder_id =get_services_types_model(),
// //       reminders_car = get_reminders_model(),
// //       total_price_services =0,
// //       routes_cars = get_routes_car_model(),
// //       route_car = get_route_car_model(),
// //        services_types_add_regisiter= [],
// //        product_details  = Product(),
// //       category_list = main_sub_category_model(),
// //    search_productss = search_products_model(),
// //    user_orders = order_model(),
// //     order_data_user = order_data(),
// //    product_details_search  = Product_search_get(),
// //
// //
// //         navigateAndFinsih(context, Shop_login_screen(),)
// //       }
// //   });
// // }
//
//
// void printFullText(String text)
// {
//   final pattern = RegExp('.{1,800}');
//   pattern.allMatches(text).forEach((element) {print(element.group(0));});
// }
//
// String totalDistance = '';
//
//
//
// String token = '';
// String email_in = '';
// int code = 0 ;
//
//
// final url_img_car = 'https://carcommintyu.s3.us-east-2.amazonaws.com/';
// // final img_default_car = '1680003853_default.png';
// // const String apiKey = "AIzaSyCxjKWosczdKu0RCZKsioYqNmyUjm0Q6pg";
// const String apiKey = "AIzaSyAt3R42dS23lg1wXWXOhID1Inwl_a0tApw";
//
// List<String> banners = ['ban1.png','ban2.png','banner3.png'];
//
//
// late var my_location = null;
// late var search_location = null;
// late var search_add_services_location = null;
// late double distanceInMeters = 0;
// late Widget Screen_Regisiter;
// var location_string = '';
//
//
// // Services - Expense Pages
// var type_id_pub =0;
// var name_pub = TextEditingController();
// var service_pub = TextEditingController();
// var date_pub = TextEditingController();
// var time_pub = TextEditingController();
// var odometer_pub = TextEditingController();
// var location_pub = TextEditingController();
// var note_pub = TextEditingController();
// var reason_pub = TextEditingController();
// int payment_pub = 0;
// var mileage_Orgin_pub = TextEditingController();
// int car_id_pub = 0;
// // Services - Expense Pages
//
//
//
//
//
//
//
//
//
// // Calculate distance between two locations
// Future<double> calculateDistance2(double startLatitude, double startLongitude,
//     double endLatitude, double endLongitude) async {
//   double distanceInMeters = await Geolocator.distanceBetween(
//       startLatitude, startLongitude, endLatitude, endLongitude);
//
//   return distanceInMeters / 1000; // convert to kilometers
// }
//
// double calculateDistance(lat1, lon1, lat2, lon2) {
//   var p = 0.017453292519943295;
//   var c = cos;
//   var a = 0.5 - c((lat2 - lat1) * p) / 2 +
//       c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
//   return 12742 * asin(sqrt(a));
// }
//
//
// void Distance_Between_two_points(org_lan,org_lou,dis_lan,dis_lou) {
//   final cityLondon = LatLng(org_lan, org_lou);
//   final cityParis = LatLng(dis_lan, dis_lou);
//
//   final distance =
//       SphericalUtil.computeDistanceBetween(cityLondon, cityParis) / 1000.0;
//
//   print('-----------------------------------------------------------Distance between London and Paris is $distance km.----------------------------------------------------------------');
// }
// // Map <int,bool> cart = {};
// // Map <int,bool> favirutes = {};
// //
// // FavModel2? FavModel;
// //
// // all_Cart_Model? Cart_items_model;
//
//
// List dropdownItemList = [
//   {'label': 'Sedan', 'value': 'Sedan'}, // label is required and unique
//   {'label': 'Sports ', 'value': 'Sports '},
//   {'label': 'Station wagon', 'value': 'Station wagon'},
//   {'label': 'Coupe', 'value': 'Coupe'},
//   {'label': 'Hatchback', 'value': 'Hatchback'},
//   {'label': 'Utility ', 'value': 'Utility '},
//   {'label': 'Convertible', 'value': 'Convertible'},
//   {'label': 'Minivan', 'value': 'Minivan'},
//   {'label': 'Pickup truck', 'value': 'Pickup truck'},
//   {'label': 'Off-road', 'value': 'Off-road'},
//   {'label': 'Luxury', 'value': 'Luxury'},
//   {'label': 'Hybrid', 'value': 'Hybrid'},
//   {'label': 'Limousine', 'value': 'Limousine'},
//   {'label': 'Self-driving', 'value': 'Self-driving'},
//   {'label': 'Pony ', 'value': 'Pony '},
//   {'label': 'Electric ', 'value': 'Electric '},
//   {'label': 'Crossover', 'value': 'Crossover'},
//   {'label': 'Truck', 'value': 'Truck'},
//   {'label': 'Microcar', 'value': 'Microcar'},
//
// ];
//
//
//
// List Cylinders = [
//   {'label': '4-Cylinder', 'value': '4-Cylinder'}, // label is required and unique
//   {'label': '6-Cylinder ', 'value': '6-Cylinder '},
//   {'label': '8-Cylinder', 'value': '8-Cylinder'},
//   {'label': 'Others', 'value': 'Others'},
// ];
//
// List FuelList = [
//   {'label': 'Gas', 'value': 'Gas'}, // label is required and unique
//   {'label': 'Diesel ', 'value': 'Diesel '},
//   {'label': 'Petrol', 'value': 'Petrol'},
//   {'label': 'Others', 'value': 'Others'},
//
//
// ];
//
//
// List seats = [
//   {'label': '2', 'value': '2'},
//   {'label': '5', 'value': '5'}, // label is required and unique
//   {'label': '7', 'value': '7'},
//   {'label': '9', 'value': '9'},
//   {'label': 'Others', 'value': 'Others'},
// ];
//
//
// List doors = [
//   {'label': '4', 'value': '4'}, // label is required and unique
//   {'label': '2 ', 'value': '6 '},
//   {'label': 'Others', 'value': 'Others'},
// ];
//
//
//
// List transmission = [
//   {'label': 'Manual', 'value': 'Manual'}, // label is required and unique
//   {'label': 'Automatic ', 'value': 'Automatic '},
// ];
//
//
//
//
// String add_route_my_location = '';
// String add_route_des_location = '';
// double distance_route = 0.0;
// var my_location_route;
// var destination_route;