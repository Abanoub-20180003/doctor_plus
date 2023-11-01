



import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Shop_app/cubit/cubit.dart';
import '../Shop_app/cubit/states.dart';

class Loading_screen extends StatelessWidget {
  const Loading_screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
    listener:(context,state){
        // if(state is ShopSuccessGoToMarketState) {
        //   if (state.Market_data.status) {
        //     navigateAndFinsih(context, home_layout());
        //   }
        // }
    } ,
    builder: (context,state){

    return Scaffold(
    body: Container(
    // color: defaultColor2,
    child: Stack(
    alignment: Alignment.bottomCenter,
    children: [
    Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    Center(child:Image(image: AssetImage('Assets/images/mar_logo.png'),)),

    ],
    ),
    // Image(image: AssetImage('Assets/images/logo3.png'), width: 200,height: 100,fit: BoxFit.fitWidth,),
    LinearProgressIndicator(),
    ],
    ),
    )

    );
    }
    );
  }
}
