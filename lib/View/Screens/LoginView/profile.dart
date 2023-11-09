import 'package:doctor_plus/View/Layout/Shop_app/cubit/cubit.dart';
import 'package:doctor_plus/View/Layout/colors.dart';
import 'package:doctor_plus/View/Layout/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:switcher_button/switcher_button.dart';

import '../../Layout/components/components.dart';
import '../../Style/color_manager.dart';
import '../Organization_Screen/Org_Screen.dart';
import 'info/setting_profile_screen.dart';




class profile extends StatelessWidget {
  late final String title;

  @override
  Widget build(BuildContext context) {
    var boxs = [
      {"title":"Info","icon":"info.png","fun":(){
        navigateTo(context, setting_profile_screen(),);
      }},
      {"title":"Organization","icon":"org.png","fun":()
      {
        navigateTo(context, org_screen(),);
      }},

      {"title":"Fav-Iems","icon":"fav.png","fun":(){
        // navigateTo(context, wishlist_screen(),);
      }},
      {"title":"Payments","icon":"pay_user.png","fun":(){
        // navigateTo(context, show_payment_screen(),);
      }},
      // {"title":"info","icon":"info3.png"},
    ];

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[

              Stack(
                alignment: AlignmentDirectional.topCenter,
                children: [

                  Container(
                    height: 100,
                   // width: MediaQuery.sizeOf(context).width,
                    decoration: BoxDecoration(

                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30.0), // Adjust the radius as needed
                        bottomRight: Radius.circular(30.0), // Adjust the radius as needed
                      ),
                      color:  ColorManager.primaryColor,
                    ),
                    width: MediaQuery.sizeOf(context).width,

                    child: SizedBox(width: 1,),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(0,40.0,0,0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(2), // Adjust the padding to control the border width
                          decoration: BoxDecoration(
                            color: Colors.white, // Border color
                            shape: BoxShape.circle, // Circular shape
                          ),
                          child: CircleAvatar(
                            radius: 55,
                            backgroundColor: thirdColor,
                            backgroundImage: AssetImage('Assets/images/${doctor_profile.image}'),
                          ),
                        )
                      ],
                    ),
                  ),

                ],
              ),

              Container(
                padding: EdgeInsets.all(1),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Text('Dr . ${doctor_profile.name}', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                        ),
                        Container(
                          child: Text('Doctor', style: TextStyle(color: Colors.blueGrey[400], fontSize: 14, fontWeight: FontWeight.w600),),
                        ),
                      ],
                    ),
                    // Row(
                    //   children: [
                    //     Container(
                    //       height: 40,
                    //       width: 40,
                    //       decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.circular(40),
                    //           border: Border.all(width: 1, color: Colors.grey),
                    //       ),
                    //       child: IconButton(
                    //         onPressed: () { print("Edit"); },
                    //         icon:  Icon(Icons.edit, color: Colors.blueGrey[400],)
                    //       ),
                    //     ),
                    //     // Container(
                    //     //   width: 100,
                    //     //   height: 40,
                    //     //   padding: EdgeInsets.only(left: 20),
                    //     //   child: MaterialButton(
                    //     //     shape: RoundedRectangleBorder(side: BorderSide(
                    //     //         color: Colors.blue,
                    //     //         width: 1,
                    //     //         style: BorderStyle.solid
                    //     //     ), borderRadius: BorderRadius.circular(50)),
                    //     //     disabledColor: Colors.blue,
                    //     //     color: Colors.blue,
                    //     //     onPressed: () {  },
                    //     //     child: Text('Follow', style: TextStyle(color: Colors.white),),
                    //     //   ),
                    //     // ),
                    //   ],
                    // )
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            child: Text('203', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),),
                          ),
                          Container(
                            child: Text('Patient', style: TextStyle(fontSize: 15, color: Colors.blueGrey),),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            child: Text('932', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),),
                          ),
                          Container(
                            child: Text('Medicial Test', style: TextStyle(fontSize: 15, color: Colors.blueGrey),),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            child: Text('30', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),),
                          ),
                          Container(
                            child: Text('Organization', style: TextStyle(fontSize: 15, color: Colors.blueGrey),),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10,),



              Container(
                padding: EdgeInsets.only(top: 0 , left: 15, right: 15),
                child: Divider(
                  thickness: 2,
                  color: Colors.blueGrey[200],
                ),
              ),
              SizedBox(height: 10,),
              Container(
                height: 120,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context,index)=> box(boxs[index]["title"],boxs[index]["icon"],boxs[index]["fun"],context),
                      separatorBuilder: (context,index)=> SizedBox(width: 10,),
                      itemCount: boxs.length),
                ),
              ),
              SizedBox(height: 10,),

              Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Container(
                        decoration: BoxDecoration(
                        //  color: defaultColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            children: [

                              TextButton(
                                style: ButtonStyle(padding:MaterialStateProperty.all<EdgeInsets>(
                                    EdgeInsets.all(0)), ),
                                onPressed: (){
                                 // navigateTo(context, change_password_screen());
                                  },
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                  ),

                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
                                    child: Row(
                                      children: [
                                        Icon(Icons.password_rounded, color:  Colors.grey, size: 20,),
                                        SizedBox(width: 10,),
                                        Text('Change Password' , style: TextStyle(color: Colors.grey, fontSize: 15, fontWeight: FontWeight.bold),),
                                        Spacer(),
                                        TextButton(onPressed: (){
                                          //navigateTo(context, change_password_screen());
                                          },
                                            child: Container(
                                            decoration: BoxDecoration(
                                              color: defaultColor,
                                              borderRadius: BorderRadius.all(Radius.circular(10)),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Icon(Icons.arrow_forward_rounded , color: Colors.white, size: 25,),
                                            ))
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10,),
                              TextButton(
                                style: ButtonStyle(padding:MaterialStateProperty.all<EdgeInsets>(
                                    EdgeInsets.all(0)), ),
                                onPressed: (){
                                 // ShopCubit.get(context).changeBottomNavbar(2);
                                  },
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                  ),

                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
                                    child: Row(
                                      children: [
                                        Icon(Icons.language, color: Colors.grey, size: 20,),
                                        SizedBox(width: 10,),
                                        Text('Dark Theme' , style: TextStyle(color:Colors.grey, fontSize: 15, fontWeight: FontWeight.bold),),
                                        Spacer(),
                                        Container(
                                            decoration: BoxDecoration(
                                            //  color: defaultColor,
                                              borderRadius: BorderRadius.all(Radius.circular(10)),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: SwitcherButton(
                                                offColor: thirdColor,
                                                onColor: defaultColor,
                                                value:  ShopCubit.get(context).Darktheme,
                                                onChange: (value) {
                                                  ShopCubit.get(context).changeTheme();
                                                },),
                                            ))


                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10,),

                              TextButton(
                                style: ButtonStyle(padding:MaterialStateProperty.all<EdgeInsets>(
                                    EdgeInsets.all(0)), ),
                                onPressed: (){ },
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                  ),

                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
                                    child: Row(
                                      children: [
                                        Icon(Icons.policy_sharp, color: Colors.grey, size: 20,),
                                        SizedBox(width: 10,),
                                        Text('Privacy Policy' , style: TextStyle(color:Colors.grey, fontSize: 15, fontWeight: FontWeight.bold),),
                                        Spacer(),
                                        TextButton(onPressed: (){},

                                          child: Container(
                                              decoration: BoxDecoration(
                                                color: defaultColor,
                                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(5.0),
                                                child: Icon(Icons.arrow_forward_rounded , color: Colors.white, size: 25,),
                                              ))
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10,),
                              TextButton(
                                style: ButtonStyle(padding:MaterialStateProperty.all<EdgeInsets>(
                                    EdgeInsets.all(0)), ),
                                onPressed: (){
                                 // navigateTo(context, setting_screen());
                                  },
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                  ),

                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
                                    child: Row(
                                      children: [
                                        Icon(Icons.info_outline, color: Colors.grey, size: 20,),
                                        SizedBox(width: 10,),
                                        Text('About' , style: TextStyle(color:Colors.grey, fontSize: 15, fontWeight: FontWeight.bold),),
                                        Spacer(),
                                        TextButton(onPressed: (){
                                          //navigateTo(context, setting_screen());
                                          },
                                            child: Container(
                                                decoration: BoxDecoration(
                                                  color: defaultColor,
                                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(5.0),
                                                  child: Icon(Icons.arrow_forward_rounded , color: Colors.white, size: 25,),
                                                ))
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                padding: EdgeInsets.only(top: 20),
                child: Divider(
                  thickness: 1,
                  color: Colors.blueGrey[200],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
