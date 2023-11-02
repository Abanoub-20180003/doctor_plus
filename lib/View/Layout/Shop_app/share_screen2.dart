

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:doctor_plus/View/Layout/Shop_app/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'package:toast/toast.dart';

import 'cubit/cubit.dart';


class share_screen2 extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    var cubit = ShopCubit.get(context);
    return BlocProvider (
      create: (BuildContext context)=> ShopCubit() ,
      child: BlocConsumer<ShopCubit, ShopStates>(
        listener:(context,state){

        } ,

        builder:(context,state){

          return Scaffold(
              appBar: AppBar(
                  backgroundColor: Colors.white,
                  elevation: .8,
                  title: Row(
                    children: [
                      // Expanded(child: Image(image:AssetImage('Assets/images/logy2.png'),fit: BoxFit.cover,)),
                       Text('Welcome' , style: TextStyle(color: Colors.indigo,fontSize: 30,fontWeight: FontWeight.bold),),

                    ],
                  ),

              ),

            body: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage("Assets/images/no_con.png"),
                    width: MediaQuery.of(context).size.width*.9,

                  ),

                  Text('No Internet Connection'),
                ],
              ),
            ));
        } ,
      ),
    );
  }
}
