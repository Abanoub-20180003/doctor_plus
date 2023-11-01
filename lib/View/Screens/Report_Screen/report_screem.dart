



import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:doctor_plus/View/Layout/components/components.dart';
import 'package:doctor_plus/View/Screens/Drug_Screen/cubit/cubit.dart';
import 'package:doctor_plus/View/Screens/Drug_Screen/new_drug_form.dart';
import 'package:doctor_plus/View/Widgets/patient_card_title.dart';
import 'package:flutter/cupertino.dart';

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:toast/toast.dart';

import '../../Layout/colors.dart';
import 'cubit/states.dart';


List<String> CarsImage = [
  "https://i.pinimg.com/564x/0e/f6/f6/0ef6f6913a32bc22259f8644cac6832b.jpg"
      'https://logos-world.net/wp-content/uploads/2020/10/Tesla-Logo-700x394.png',
  'https://logos-world.net/wp-content/uploads/2021/11/Tata-Logo-500x281.png',
  'https://logos-world.net/imageup/Suzuki/Suzuki%20(4).png',
  'https://logos-world.net/wp-content/uploads/2020/10/Tesla-Logo-700x394.png',
  'https://logos-world.net/wp-content/uploads/2021/11/Tata-Logo-500x281.png',
  'https://logos-world.net/imageup/Suzuki/Suzuki%20(4).png',
];

class report_screem extends StatelessWidget {

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
    {"title":"Fav-Iems","icon":"fav.png","fun":(){}},
    {"title":"groups","icon":"group.png","fun":(){}},
    // {"title":"info","icon":"info3.png"},
  ];
  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return BlocProvider (
        create: (BuildContext context)=> DrugCubit().drugs != null ? DrugCubit() :DrugCubit()..Get_Drugs(),
          //   () {
          // if(Brands_car == null)
          //   {
          //     CarCubit()..Get_Cars_user()..Get_Car_Brands();
          //   }

        // },
    child:  BlocConsumer<DrugCubit, DrugStates>(
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
          var DrugCubits = DrugCubit.get(context);

          return Scaffold(

            body:SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 0.0, horizontal: 0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        // CircleAvatar(
                        //   radius: 60,
                        //   child: Image(image: NetworkImage(url_img_car+'users/images/'+ User!.data.photo),),),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ConditionalBuilder(
                              condition: state is DrugLoadingSuccessState,
                              builder: (context) =>
                                  DrugCubit.get(context).drugs.length != 0 ?  Container(
                                    width:  MediaQuery.of(context).size.width,
                                    height: 600,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 15.0,vertical: 20 ),
                                      child: ListView.separated(
                                          scrollDirection: Axis.vertical,
                                          itemBuilder: (context,index)=> Card(
                                            elevation: 8.0,
                                            child: Column(
                                              children: [
                                                Container(
                                                  child: DrugcardTitle(DrugCubit.get(context).drugs[index], context),
                                                ),
                                                SizedBox(height: 10,),
                                              ],
                                            ),
                                          ),
                                          separatorBuilder: (context,index)=> SizedBox(height: 15,),
                                          itemCount:DrugCubit.get(context).drugs.length),
                                    ),
                                  ): Container(
                                width:  MediaQuery.of(context).size.width,

                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [

                                      Center(
                                        child: Image(
                                          image: AssetImage('Assets/images/med.png'),
                                          width: MediaQuery.of(context).size.width,
                                          height: 400,
                                        ),

                                      ),
                                      Text("Add Some Medinice" , style: TextStyle(color:defaultColor,fontSize: 25),),

                                    ],
                                  ),

                              ),
                              fallback: (context) =>  Center(child: loading(context)),
                            ),
                          ],
                        ),

                      ],),
                  ),
                ),


            ),


            // Container(
            //   //padding: EdgeInsets.all(10.0),
            //   margin: EdgeInsets.all(20.0),
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(15.0),
            //     color: Colors.grey.shade300,
            //   ),
            //   height: 290.0,
            //   width: double.infinity,
            //   child: Stack(
            //     alignment: Alignment.topRight,
            //     children: [
            //       Container(
            //         child: ClipRRect(
            //           borderRadius: const BorderRadius.only(
            //             topRight: Radius.circular(15.0),
            //             topLeft: Radius.circular(15.0),
            //             bottomRight: Radius.circular(15.0),
            //           ),
            //           child: Image.network(
            //             "https://i.pinimg.com/564x/0e/f6/f6/0ef6f6913a32bc22259f8644cac6832b.jpg",
            //             height: 200.0,
            //             width: double.infinity,
            //             fit: BoxFit.cover,
            //           ),
            //         ),
            //       ),
            //       Stack(
            //         children:
            //         [
            //           Positioned(
            //             bottom: 0.0,
            //             left: 0.0,
            //             child: Container(
            //               padding: const EdgeInsets.only(left: 20.0, top: 20.0, right: 0.0, bottom: 10.0),
            //               decoration: BoxDecoration(
            //                 // borderRadius: const BorderRadius.only(
            //                 //   //topRight: Radius.circular(15.0),
            //                 //   bottomLeft: Radius.circular(15.0),
            //                 //   bottomRight: Radius.circular(15.0),
            //                 // ),
            //                 // border: Border.all(
            //                 //   color: Colors.white,
            //                 //   width: 5.0,
            //                 // )       ,
            //                 color: defaultColor,
            //               ),
            //               width: 350.0,
            //               child: Column(
            //                 mainAxisAlignment: MainAxisAlignment.start,
            //                 crossAxisAlignment: CrossAxisAlignment.start,
            //                 children: [
            //                   Text(
            //                     "Tesla",
            //                     style: TextStyle(
            //                       fontSize: 20.0,
            //                       fontWeight: FontWeight.w700,
            //                       color: Colors.black,
            //                     ),
            //                   ),
            //                   const SizedBox(
            //                     height: 5.0,
            //                   ),
            //                   Text(
            //                     "Model XC680 ",
            //                     style: TextStyle(
            //                       fontSize: 15.0,
            //                       fontWeight: FontWeight.normal,
            //                       color: Colors.black,
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //             ),
            //           ),
            //           Positioned(
            //             bottom: 0.0,
            //             right: 0.0,
            //             child: Stack(
            //               alignment: AlignmentDirectional.bottomEnd,
            //               children: [
            //                 Container(
            //                   height: 90.0,
            //                   width: 80.0,
            //                   decoration: BoxDecoration(
            //                     borderRadius: BorderRadius.only(
            //                       topLeft: Radius.circular(15.0),
            //                       bottomRight:  Radius.circular(15.0),
            //                     ),
            //                     // borderRadius: BorderRadius.circular(40),
            //                     color: Colors.white,
            //                   ),
            //
            //                 ),
            //                 Container(
            //                   decoration: BoxDecoration(
            //                     borderRadius: BorderRadius.circular(55.0),
            //
            //                     color: Colors.indigo,
            //                   ),
            //                   height: 60.0,
            //                   width: 60.0,
            //                   child: IconButton(
            //                     onPressed: () {},
            //                     icon: const Icon(
            //                       Icons.double_arrow,
            //                       color: Colors.white,
            //                     ),
            //                   ),
            //                 ),
            //
            //               ],
            //             ),
            //           ),
            //         ],
            //       )
            //
            //     ],
            //   ),
            // ),

            floatingActionButton: Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                backgroundColor: defaultColor,
                  child: Icon(
                      Icons.add,
                    color: Colors.white,
                  ),
                  onPressed: () async{

                      final newPatient = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => newDrugForm()));

                    //
                    // showFlexibleBottomSheet(
                    //   minHeight: .26,
                    //   initHeight: 0.28,
                    //   maxHeight: 1,
                    //   context: context,
                    //   builder: _buildBottomSheet,
                    //   anchors: [0, 0.5, 1],
                    //   isSafeArea: true,
                    // );
                  }

              ),),


          );
        },
      ));
  }

  Widget _buildBottomSheet(BuildContext context,
      ScrollController scrollController,
      double bottomSheetOffset,) {
    return BlocConsumer<DrugCubit, DrugStates>(
          listener: (context, state) {

          },
          builder: (context, state) {
            return Material(
              child: Container(
                child: Column(
                    children: [


                      SizedBox(height: 30,),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Column(
                            children: [
                              AppTextField(
                                textEditingController: _fullNameTextEditingController,
                                title: "Brand",
                                hint: _fullNameTextEditingController.text == ''
                                    ? "Choose Your Car Brand"
                                    : _fullNameTextEditingController.text,
                                isCitySelected: true,
                                cities: [],

                              ),

                            ],
                          ),
                        ),
                      ),


                      Stack(
                        children:[
                          MainButton(
                            text: "Next", function: ()  {
                          // if(formKey.currentState!.validate())
                          // {
                          //   if(brand_id_get_model == null || brand_id_get_model == 0)
                          //   {
                          //     MotionToast.error(
                          //       title:  Text("Select Brand"),
                          //       description:  Text(""),
                          //     ).show(context);
                          //     return null;
                          //   }
                            // DrugCubit.get(context).Get_Car_Brand_Models(brand_id: brand_id_get_model);
                            // navigateTo(context,complete_add_car_screen());
                         // }


                        }, color: defaultColor),
                ]
                      ),


                    ]),

              ),

            );

          }
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
