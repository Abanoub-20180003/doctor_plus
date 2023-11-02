
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:doctor_plus/View/Layout/colors.dart';
import 'package:doctor_plus/View/Layout/components/constants.dart';
import 'package:doctor_plus/View/Screens/LoginView/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../Loading_Screen/loading_screen.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';


class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {

    return BlocConsumer<ShopCubit,ShopStates>(
      listener:(context,state){
        // if(state is ShopSuccessGoToMarketState)
        // {
        //   if(product_details != Product())
        //     {
        //
        //   if(product_details.in_cart == true)
        //   {
        //     product_details.in_cart= false;
        //   }
        //   else
        //   {
        //     product_details.in_cart = true;
        //   }
        //
        //   print(product_details.in_cart);
        //   print('h-------------------------------------------------');
        // }
        //
        // }
      } ,
      builder: (context,state){
        var shopCubit = ShopCubit.get(context);
        int _bottomNavIndex;
        return ConditionalBuilder(
          condition: true,
          builder: (context)=>Scaffold(
            appBar: AppBar(
              backgroundColor: defaultColor,
              title: const Text("DoctorP+" , style: TextStyle(color: Colors.white),),
              actions: [
                // log out button
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white),
                    ),
                    child: IconButton(
                      color: Colors.white,
                      onPressed: () {
                        // local storage
                        //_boxLogin.clear();
                        //_boxLogin.put("loginStatus", false);
                        signOut(context);
                        // Navigator.pushReplacement(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) {
                        //       return const Login();
                        //     },
                        //   ),
                        // );
                      },
                      icon: const Icon(Icons.logout_rounded),
                    ),
                  ),
                )
              ],
            ),
            body:shopCubit.Screens[shopCubit.current_index],




            bottomNavigationBar: BottomNavigationBar(
              fixedColor:secondColor,
              currentIndex: shopCubit.current_index,
              onTap: (index){
                shopCubit.changeBottomNavbar(index);
              },
              unselectedItemColor: defaultColor,
              items: [
                BottomNavigationBarItem(icon:Icon(Icons.home ,),label: 'Home' ),
                BottomNavigationBarItem(icon:Icon(Icons.medical_information),label: 'Drug' ),
                BottomNavigationBarItem(icon:Icon(Icons.analytics_outlined),label: 'Reports' ),
                BottomNavigationBarItem(icon:Icon(Icons.settings),label: 'You' ),
              ],
            ),
            //

        ),
          fallback: (context)=> Loading_screen());


      },
    );
  }
}






