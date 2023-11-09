


import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:doctor_plus/View/Layout/components/components.dart';
import 'package:doctor_plus/View/Screens/Drug_Screen/cubit/cubit.dart';
import 'package:doctor_plus/View/Screens/Drug_Screen/new_drug_form.dart';
import 'package:doctor_plus/View/Screens/Organization_Screen/cubit/cubit.dart';
import 'package:doctor_plus/View/Widgets/patient_card_title.dart';
import 'package:flutter/cupertino.dart';

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:toast/toast.dart';

import '../../Layout/colors.dart';
import '../../Layout/components/constants.dart';
import '../../Style/color_manager.dart';
import 'cubit/states.dart';
import 'package:doctor_plus/View/Layout/components/components.dart';

class Org_detail_Screen extends StatelessWidget {

  TextEditingController _fullNameTextEditingController = TextEditingController();


  var scaffold_Key = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var name = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();
  var boxs = [
    {"title":"info","icon":"info3.png","fun":(){}},
    {"title":"cars","icon":"carrr.png","fun":(){ }},
    {"title":"orders","icon":"order2.png","fun":(){}},

  ];
  var searchCon = TextEditingController();
  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return BlocProvider (
        create: (BuildContext context)=> OrganizationCubit()..Get_organizations(),
          //   () {
          // if(Brands_car == null)
          //   {
          //     CarCubit()..Get_Cars_user()..Get_Car_Brands();
          //   }

        // },
    child:  BlocConsumer<OrganizationCubit, OrgStates>(
        listener: (context, state) {

          // if(state is DrugLoadingSuccessState)
          //   {
          //     showToast(msg: "Get Medicines Success",
          //         ToastStatus: ToastColor.SUCCESS);
          //   }


          if (state is DrugDeleteSuccessState || state is DrugDeleteErrorState )
          {
            if(state is DrugDeleteSuccessState )
            {
              showToast(msg: state.msg,ToastStatus: ToastColor.SUCCESS);

            }
            else if(state is DrugDeleteErrorState)
            {
              showToast(msg: state.msg,
                  ToastStatus: ToastColor.ERROR);

            }

          }

        },
        builder: (context, state) {
          var orgCubits = OrganizationCubit.get(context);

          return Scaffold(
            appBar: AppBar(
              backgroundColor: defaultColor,
              title: Text('Organization',style: TextStyle(color: Colors.white),),
            ),
            body:SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 0.0, horizontal: 0),
                  child:  Column(
                    children: [
                      Stack(
                        alignment: AlignmentDirectional.topCenter,
                        children: [

                          Container(
                            height: 100,
                            // width: MediaQuery.sizeOf(context).width,
                            decoration: BoxDecoration(

                              // borderRadius: BorderRadius.only(
                              //   bottomLeft: Radius.circular(30.0), // Adjust the radius as needed
                              //   bottomRight: Radius.circular(30.0), // Adjust the radius as needed
                              // ),
                              color:  ColorManager.primaryColor,
                            ),
                            width: MediaQuery.sizeOf(context).width,

                            child:   Padding(
                              padding:  EdgeInsets.symmetric(horizontal: 10),
                              child: Container(
                                height: 180,
                                width: MediaQuery.sizeOf(context).width,
                                decoration: BoxDecoration(
                                  color: defaultColor,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(30.0), // Adjust the radius as needed
                                    bottomRight: Radius.circular(30.0), // Adjust the radius as needed
                                  ),
                                ),
                                child: Padding(
                                  padding:  EdgeInsets.symmetric(horizontal: 18.0,vertical: 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: 60,
                                            height: 60,
                                            padding: EdgeInsets.all(2), // Adjust the padding to control the border width
                                            decoration: BoxDecoration(
                                              color: Colors.white, // Border color
                                              shape: BoxShape.circle, // Circular shape
                                            ),
                                            child: CircleAvatar(
                                              radius: 35,
                                              backgroundColor: thirdColor,
                                              backgroundImage: AssetImage('Assets/images/${doctor_profile.image}'),
                                            ),
                                          ),
                                          SizedBox(width: 13,),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${Organization_details.name.toString()}",
                                                style: TextStyle(fontSize: 15,color: thirdColor),
                                              ),
                                              SizedBox(height: 3),
                                              Text(
                                                //local storage
                                                //_boxLogin.get("userName"),
                                                "${Organization_details.location.toString()}",
                                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: thirdColor),

                                              ),
                                            ],
                                          ),
                                        ],
                                      ),



                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),

                          // Padding(
                          //   padding: const EdgeInsets.fromLTRB(0,0.0,0,0),
                          //   child: Row(
                          //     crossAxisAlignment: CrossAxisAlignment.center,
                          //     mainAxisAlignment: MainAxisAlignment.center,
                          //     children: [
                          //       Column(
                          //         children: [
                          //           Text("Organizations", style: TextStyle(color: Colors.white,fontSize: 20,),),
                          //           SizedBox(height: 10,),
                          //           Container(
                          //             padding: EdgeInsets.all(2), // Adjust the padding to control the border width
                          //             decoration: BoxDecoration(
                          //               color: Colors.white, // Border color
                          //               shape: BoxShape.circle, // Circular shape
                          //             ),
                          //             child: CircleAvatar(
                          //               radius: 60,
                          //               backgroundColor: thirdColor,
                          //               backgroundImage: AssetImage('Assets/images/hos.png'),
                          //             ),
                          //           ),
                          //         ],
                          //       )
                          //     ],
                          //   ),
                          // ),

                        ],
                      ),


                Container(
                padding:  EdgeInsets.all(0.0),
              color: defaultColor,
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height,
              child: ContainedTabBarView(
                tabBarProperties:TabBarProperties(
                  unselectedLabelColor:ColorManager.grey,
                  labelColor: Colors.white,
                  labelStyle: TextStyle(fontSize: 15,color: Colors.white),

                ),
                tabs: [
                  Text('${Organization_details.patients.length.toString()} Patients',),
                  Text('${Organization_details.doctors.length + 1} Doctors'),
                ],
                views: [
                  Container(
                      color:thirdColor,
                      child:  Column(

                        children: [
                          Padding(
                            padding:  EdgeInsets.symmetric(horizontal: 13.0,vertical: 2),
                            child: MaterialButton(onPressed: (){},child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(Icons.add),
                                SizedBox(width: 5,),
                                Text(" Patient"),
                              ],
                            )),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 10),
                            child: ListView.separated(
                              shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context,index)=> Card(
                                  elevation: 0.0,
                                  child: Column(
                                    children: [
                                      Container(
                                        child: Organization_Patient_cardTitle(Organization_details.patients[index], context,Org_detail_Screen()),
                                      ),
                                      SizedBox(height: 10,),
                                    ],
                                  ),
                                ),
                                separatorBuilder: (context,index)=> SizedBox(height: 5,),
                                itemCount:Organization_details.patients.length),
                          ),
                        ],
                      ),


                      ),

                  Container(
                    color:thirdColor,
                    child:  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Padding(
                        //   padding:  EdgeInsets.symmetric(horizontal: 13.0,vertical: 2),
                        //   child: MaterialButton(onPressed: (){},child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.end,
                        //     children: [
                        //       Icon(Icons.add),
                        //       SizedBox(width: 5,),
                        //       Text(" Patient"),
                        //     ],
                        //   )),
                        // ),
                        SizedBox(height: 10,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0),
                          child: Text("1 Admin"),
                        ),
                        Card(
                          elevation: 0.0,
                          child: Column(
                            children: [
                              // Text(Organization_details.doc_id.toString()),
                              // Text(Organization_details.doctors[index].id),
                              Container(
                                child:Organization_Doctor_cardTitle(Organization_details.Main_Doctor, context,Org_detail_Screen()),
                              ),
                              SizedBox(height: 10,),
                            ],
                          ),
                        ),
                        SizedBox(height: 10,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0),
                          child: Row(
                            children: [
                              Text("${Organization_details.doctors.length} Membars"),
                              Spacer(),
                              MaterialButton(onPressed: (){}, child: Row(
                                children: [
                                  Icon(Icons.add),
                                  SizedBox(width: 5,),
                                  Text('Assign Doctor'),
                                ],
                              ),),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 10),
                          child: ListView.separated(
                            shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context,index)=> Organization_details.doctors[index].id != Organization_details.doc_id ? Card(
                                elevation: 0.0,
                                child: Column(
                                  children: [
                                    // Text(Organization_details.doc_id.toString()),
                                    // Text(Organization_details.doctors[index].id),
                                    Container(
                                      child:Organization_Doctor_cardTitle(Organization_details.doctors[index], context,Org_detail_Screen()),
                                    ),
                                    SizedBox(height: 10,),
                                  ],
                                ),
                              ): SizedBox(width: 0,height: 0),
                              separatorBuilder: (context,index)=> SizedBox(height: 5,),
                              itemCount:Organization_details.doctors.length),
                        ),
                      ],
                    ),


                  ),
                ],
                onChange: (index) => print(index),
              ),
            ),
                    ],
                  ),

                ),

            ),



            // floatingActionButton: Align(
            //   alignment: Alignment.bottomRight,
            //   child: FloatingActionButton(
            //    // backgroundColor: defaultColor,
            //       child: Icon(
            //           Icons.add,
            //        // color: Colors.white,
            //       ),
            //       onPressed: () async{
            //
            //           final newPatient = await Navigator.push(
            //               context,
            //               MaterialPageRoute(
            //                   builder: (context) => newDrugForm()));
            //
            //         //
            //         // showFlexibleBottomSheet(
            //         //   minHeight: .26,
            //         //   initHeight: 0.28,
            //         //   maxHeight: 1,
            //         //   context: context,
            //         //   builder: _buildBottomSheet,
            //         //   anchors: [0, 0.5, 1],
            //         //   isSafeArea: true,
            //         // );
            //       }
            //
            //   ),),


          );
        },
      ));
  }

  // Widget _buildBottomSheet(BuildContext context,
  //     ScrollController scrollController,
  //     double bottomSheetOffset,) {
  //   return BlocConsumer<DrugCubit, DrugStates>(
  //         listener: (context, state) {
  //
  //         },
  //         builder: (context, state) {
  //           return Material(
  //             child: Container(
  //               child: Column(
  //                   children: [
  //
  //
  //                     SizedBox(height: 30,),
  //                     Expanded(
  //                       child: Padding(
  //                         padding: const EdgeInsets.symmetric(horizontal: 25.0),
  //                         child: Column(
  //                           children: [
  //                             AppTextField(
  //                               textEditingController: _fullNameTextEditingController,
  //                               title: "Brand",
  //                               hint: _fullNameTextEditingController.text == ''
  //                                   ? "Choose Your Car Brand"
  //                                   : _fullNameTextEditingController.text,
  //                               isCitySelected: true,
  //                               cities: [],
  //
  //                             ),
  //
  //                           ],
  //                         ),
  //                       ),
  //                     ),
  //
  //
  //                     Stack(
  //                       children:[
  //                         MainButton(
  //                           text: "Next", function: ()  {
  //                         // if(formKey.currentState!.validate())
  //                         // {
  //                         //   if(brand_id_get_model == null || brand_id_get_model == 0)
  //                         //   {
  //                         //     MotionToast.error(
  //                         //       title:  Text("Select Brand"),
  //                         //       description:  Text(""),
  //                         //     ).show(context);
  //                         //     return null;
  //                         //   }
  //                           // DrugCubit.get(context).Get_Car_Brand_Models(brand_id: brand_id_get_model);
  //                           // navigateTo(context,complete_add_car_screen());
  //                        // }
  //
  //
  //                       }, color: defaultColor),
  //               ]
  //                     ),
  //
  //
  //                   ]),
  //
  //             ),
  //
  //           );
  //
  //         }
  //     );
  // }


  Widget searchInputField(TextEditingController searchCon, DrugCubit cubit) {
    return InputField(
      Controller: searchCon,
      onchange: (String text) {
        print(text.length);
        if (text != null && text.length != 0) {
          cubit.search_product(search_text: searchCon.text);
        } else if (text.length == 0) {
          cubit.empty_search_product();
          print('aho');
        }
      },
      // onsumbit: (String text)
      // {
      //   // cubit.SearchProduct(text: text);
      // },
      type: TextInputType.text,
      validate: (value) {
        if (value == null || value == "") {
          return "Search Value Must Be Not Empty";
        }
        return null;
      },
      Suffixicon: Icon(Icons.search),
      functionSuffix: () {
        // cubit.SearchProduct(text: searchCon.text);
      },
      Icon: Icon(Icons.data_usage),
      text: 'Search',
    );
  }


}

class ApiImage {
  final String imageUrl;
  final String id;
  ApiImage({
    required this.imageUrl,
    required this.id,
  });
}
