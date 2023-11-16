


import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:doctor_plus/View/Layout/Shop_app/cubit/cubit.dart';
import 'package:doctor_plus/View/Layout/components/components.dart';
import 'package:doctor_plus/View/Screens/Drug_Screen/cubit/cubit.dart';
import 'package:doctor_plus/View/Screens/Drug_Screen/new_drug_form.dart';
import 'package:doctor_plus/View/Screens/NewPatientFormView/new_patient_form.dart';
import 'package:doctor_plus/View/Screens/Organization_Screen/cubit/cubit.dart';
import 'package:doctor_plus/View/Screens/SearchView/patient_profile_page.dart';
import 'package:doctor_plus/View/Widgets/patient_card_title.dart';
import 'package:flutter/cupertino.dart';

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';

import 'package:toast/toast.dart';

import '../../Layout/colors.dart';
import '../../Layout/components/constants.dart';
import '../../Style/color_manager.dart';
import 'add_doctor_screen.dart';
import 'cubit/states.dart';
import 'package:doctor_plus/View/Layout/components/components.dart';

class Org_detail_Screen2 extends StatelessWidget {

  TextEditingController _fullNameTextEditingController = TextEditingController();


  var scaffold_Key = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var name = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();
  var boxs = [
    {"title": "info", "icon": "info3.png", "fun": () {}},
    {"title": "cars", "icon": "carrr.png", "fun": () {}},
    {"title": "orders", "icon": "order2.png", "fun": () {}},

  ];
  var searchCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return BlocProvider(
        create: (BuildContext context) =>
        OrganizationCubit()
          ..Get_organizations(),
        //   () {
        // if(Brands_car == null)
        //   {
        //     CarCubit()..Get_Cars_user()..Get_Car_Brands();
        //   }

        // },
        child: BlocConsumer<OrganizationCubit, OrgStates>(
          listener: (context, state) {
            // if(state is DrugLoadingSuccessState)
            //   {
            //     showToast(msg: "Get Medicines Success",
            //         ToastStatus: ToastColor.SUCCESS);
            //   }

            // if (state is DrugProfilePatientSuccessState || state is DrugProfilePatientErrorState )
            // {
            //   context.loaderOverlay.hide();
            //   if(state is DrugProfilePatientSuccessState )
            //   {
            //     //print(state.patient_detail!.blood.toString());
            //     navigateTo(context, patientProfile(state.patient_detail));
            //
            //   }
            //   else if(state is DrugProfilePatientErrorState)
            //   {
            //     showToast(msg: state.msg,
            //         ToastStatus: ToastColor.ERROR);
            //
            //   }
            //
            // }
            //
            // if (state is DrugDeleteSuccessState || state is DrugDeleteErrorState )
            // {
            //   if(state is DrugDeleteSuccessState )
            //   {
            //     showToast(msg: state.msg,ToastStatus: ToastColor.SUCCESS);
            //
            //   }
            //   else if(state is DrugDeleteErrorState)
            //   {
            //     showToast(msg: state.msg,
            //         ToastStatus: ToastColor.ERROR);
            //
            //   }
            //
            // }

          },
          builder: (context, state) {
            var orgCubits = OrganizationCubit.get(context);

            return Scaffold(
              appBar: AppBar(
                backgroundColor: thirdColor,
                title: Text(
                  'Organization', style: TextStyle(color: defaultColor2),),
              ),
              body: LoaderOverlay(
                  useDefaultLoading: false,
                  overlayWidget: loading(context),
                  overlayColor: Colors.black26,
                  overlayOpacity: 0.3,
                  child:
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0.0, horizontal: 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            // width: MediaQuery.sizeOf(context).width,
                            decoration: BoxDecoration(

                              // borderRadius: BorderRadius.only(
                              //   bottomLeft: Radius.circular(30.0), // Adjust the radius as needed
                              //   bottomRight: Radius.circular(30.0), // Adjust the radius as needed
                              // ),
                              //  color:  ColorManager.primaryColor,
                            ),


                            width: MediaQuery
                                .sizeOf(context)
                                .width,

                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 25.0, vertical: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(10),),
                                      color: ShopCubit.get(context).Darktheme == true ?  Colors.black12:  defaultColor,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Row (
                                        children: [
                                          Container(
                                              color: Colors.transparent,
                                              width: MediaQuery.sizeOf(context).width*.25,
                                              child: CircleAvatar(
                                                backgroundColor: Colors.transparent,
                                                radius: 40,
                                                child: Image(image: AssetImage('Assets/images/h1.png'),),

                                              )),
                                          Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text("${Organization_details.name}", style: TextStyle( color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                                                    SizedBox(height: 5,),
                                                    Text("${Organization_details.location}", style: TextStyle( color: thirdColor, fontSize: 15),),
                                                    SizedBox(height: 5,),
                                                    // Text("Dr . ${_patient!.doc!.name}",  style: TextStyle( color: thirdColor, fontSize: 12),),
                                                    SizedBox(height: 5,),

                                                  ],

                                                ),
                                              ) ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 13,),
                                  Padding(
                                    padding:  EdgeInsets.symmetric(horizontal: 8.0,vertical: 18),
                                    child: Row(
                                      children: [
                                        Image(image: AssetImage("Assets/images/services.png"),width: 30,),
                                        SizedBox(width: 10,),
                                        Text("Services",style: TextStyle( fontSize: 20),),
                                      ],
                                    ),
                                  ),
                                 Container(
                                   height: MediaQuery.sizeOf(context).height,
                                   child: GridView.builder(
                                         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                         crossAxisSpacing: 2, // adjust as needed
                                            mainAxisSpacing: 2,  // adjust as needed
                                        ),
                                   itemCount: 6, // replace with your actual item count
                                      itemBuilder: (context, index) {
                                               return MaterialButton(
                                                 padding: EdgeInsets.zero,
                                                 onPressed: (){},
                                                 child: Card(
                                                   elevation: 2,
                                                   child: Container(
                                                   child: Center(
                                                   child: Column(
                                                     children: [
                                                       Image(image: AssetImage('Assets/images/h.png'),width: 140,),
                                                       Text('Item $index'),
                                                     ],
                                                   ),
                                                   ),
                                                   ),
                                                 ),
                                               );
                                             },
                                           ),
                                 ),
                                ],
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                  )),
            );
          },
        ));
  }
}






















//
//   Widget searchInputField(TextEditingController searchCon, DrugCubit cubit) {
//     return InputField(
//       Controller: searchCon,
//       onchange: (String text) {
//         print(text.length);
//         if (text != null && text.length != 0) {
//           cubit.search_product(search_text: searchCon.text);
//         } else if (text.length == 0) {
//           cubit.empty_search_product();
//           print('aho');
//         }
//       },
//       // onsumbit: (String text)
//       // {
//       //   // cubit.SearchProduct(text: text);
//       // },
//       type: TextInputType.text,
//       validate: (value) {
//         if (value == null || value == "") {
//           return "Search Value Must Be Not Empty";
//         }
//         return null;
//       },
//       Suffixicon: Icon(Icons.search),
//       functionSuffix: () {
//         // cubit.SearchProduct(text: searchCon.text);
//       },
//       Icon: Icon(Icons.data_usage),
//       text: 'Search',
//     );
//   }
//
//
// }
//
// class ApiImage {
//   final String imageUrl;
//   final String id;
//   ApiImage({
//     required this.imageUrl,
//     required this.id,
//   });
// }
