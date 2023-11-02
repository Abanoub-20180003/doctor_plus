import 'dart:async';

import 'package:doctor_plus/View/Layout/colors.dart';
import 'package:doctor_plus/View/Screens/Drug_Screen/cubit/cubit.dart';
import 'package:doctor_plus/View/Screens/HomeView/home.dart';
import 'package:doctor_plus/View/Screens/LoginView/login.dart';
import 'package:doctor_plus/View/Screens/Report_Screen/cubit/cubit.dart';
import 'package:doctor_plus/main_app.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'View/Layout/Shop_app/cubit/cubit.dart';
import 'View/Layout/Shop_app/cubit/states.dart';
import 'View/Layout/Shop_app/share_screen2.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

StreamController<bool> _internetConnectionController = StreamController<bool>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  InternetConnectionChecker().onStatusChange.listen((status) {
    _internetConnectionController.add(status == InternetConnectionStatus.connected);
  });

  runApp(MyApp(share_screen: share_screen2()));
}

class MyApp extends StatelessWidget {

  final Widget share_screen ;

  MyApp({required  this.share_screen});

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
        providers: [

          BlocProvider(

              create: (context) => ShopCubit()

          ),

          BlocProvider(

              create: (context) => ReportCubit(),

          ),

          BlocProvider(

              create: (context) => DrugCubit()..Get_Drugs()

          ),
        ], child: BlocConsumer<ShopCubit,ShopStates>(
        listener: (context, state){} ,
        builder: (context, state){
          return MaterialApp(
              title: 'Doctor App',
              color: defaultColor,

              debugShowCheckedModeBanner: false,

              home:  StreamBuilder<bool>(
                  stream: _internetConnectionController.stream,
                  initialData: false,
                  builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                    bool isConnected = snapshot.data!;
                    print(" Look At Connection H a -------------------------------------------------------- : "+isConnected.toString());
                    return Scaffold(
                      body: isConnected == true ? Login() : share_screen2(),
                    );
                  }
              ));
        }

    ));
  }
}
