// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:doctor_plus/View/Style/theme_manager.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import 'View/Layout/Shop_app/cubit/cubit.dart';
// import 'View/Layout/Shop_app/cubit/states.dart';
// import 'View/Layout/Shop_app/share_screen2.dart';
// import 'View/Screens/LoginView/login.dart';
//
//
//
//
// class MainApp extends StatelessWidget {
//   const MainApp({super.key});
//
//
//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//         providers: [
//
//           BlocProvider(
//
//               create: (context) => ShopCubit()
//
//           ),
//
//           //
//           // BlocProvider(
//           //
//           //     create: (context) => MarketCubit()..get_Categories_of_products()..Go_to_Market2()..get_user_orders_list()
//           //
//           // ),
//
//         ], child: BlocConsumer<ShopCubit,ShopStates>(
//         listener: (context, state){} ,
//     builder: (context, state){
//
//     return MaterialApp(
//     title: 'Doctor App',
//
//     debugShowCheckedModeBanner: false,
//
//     home:  StreamBuilder<bool>(
//     stream: _internetConnectionController.stream,
//     initialData: false,
//     builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
//     bool isConnected = snapshot.data!;
//     print(" Look At Connection H a -------------------------------------------------------- : "+isConnected.toString());
//     return Scaffold(
//     body: isConnected == true ? Login() : share_screen2(),
//     );
//     }
//     ));
//   }
//
//   ));
//   }
// }
// //