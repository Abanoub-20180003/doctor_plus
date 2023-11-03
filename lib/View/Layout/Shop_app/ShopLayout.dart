
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:doctor_plus/View/Layout/colors.dart';
import 'package:doctor_plus/View/Layout/components/constants.dart';
import 'package:doctor_plus/View/Screens/LoginView/login.dart';

import 'package:flutter/gestures.dart';
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





            //
            // bottomNavigationBar: FloatingNavbar(
            //     iconSize: 20,
            //     backgroundColor: defaultColor,
            //     selectedBackgroundColor: secondColor,
            //     selectedItemColor: thirdColor,
            //     borderRadius: 15,
            //     onTap: (index){
            //       shopCubit.changeBottomNavbar(index);
            //     },
            //     currentIndex: shopCubit.current_index,
            //     items: [
            //      // FloatingNavbarItem(icon: Icons.home, title: 'Home'),
            //       FloatingNavbarItem(icon:Icons.home ,title: 'Home' ),
            //       FloatingNavbarItem(icon:Icons.medical_information,title: 'Drug' ),
            //       FloatingNavbarItem(icon:Icons.analytics_outlined,title: 'Reports' ),
            //       FloatingNavbarItem(icon:Icons.settings,title: 'You' ),
            //     ],
            //   ),



            // BottomBarInspiredInside(
            //   items: items,
            //   backgroundColor: defaultColor,
            //   color: secondColor,
            //   colorSelected: Colors.white,
            //   indexSelected: shopCubit.current_index,
            //   onTap: (int index) => setState(() {
            //     visit = index;
            //   }),
            //   animated: false,
            //   chipStyle:const ChipStyle(isHexagon: true, convexBridge: true),
            //   itemStyle: ItemStyle.hexagon,
            // ),

             // bottomNavigationBar:Stack(
             //   children: [
             //
             //     Container(
             //       color: Colors.transparent,
             //       padding:const EdgeInsets.only(bottom: 10, right: 32, left: 32),
             //       child:
             //       BottomBarFloating(
             //         paddingVertical: 15,
             //         borderRadius: BorderRadius.circular(20),
             //         items: items,
             //         backgroundColor: defaultColor,
             //         color: secondColor,
             //         colorSelected: Colors.white,
             //         indexSelected: shopCubit.current_index,
             //         onTap: (index){
             //           shopCubit.changeBottomNavbar(index);
             //         },
             //       ),),
             //   ],
             // )
            // BottomBarInspiredOutside(
            //   items: items,
            //   backgroundColor: defaultColor,
            //   color: secondColor,
            //   colorSelected: Colors.white,
            //   indexSelected: shopCubit.current_index,
            //   onTap: (index){
            //     shopCubit.changeBottomNavbar(index);
            //   },
            //   top: -28,
            //   animated: false,
            //   itemStyle: ItemStyle.hexagon,
            //   chipStyle:const ChipStyle(notchSmoothness: NotchSmoothness.verySmoothEdge),
            // ),




            bottomNavigationBar: BottomNavigationBar(

              fixedColor:secondColor,
              currentIndex: shopCubit.current_index,
              onTap: (index){
                shopCubit.changeBottomNavbar(index);
              },

              items: [
                BottomNavigationBarItem(icon:Icon(Icons.home ,),label: 'Home' ),
                BottomNavigationBarItem(icon:Icon(Icons.medical_information),label: 'Drug' ),
                BottomNavigationBarItem(icon:Icon(Icons.analytics_outlined),label: 'Reports' ),
                BottomNavigationBarItem(icon:Icon(Icons.settings),label: 'You' ),
              ],
            ),


        ),
          fallback: (context)=> Loading_screen());


      },
    );
  }
}






