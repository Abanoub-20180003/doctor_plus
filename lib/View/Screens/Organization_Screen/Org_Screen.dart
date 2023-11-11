



import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:doctor_plus/View/Layout/Loading_Screen/loading_screen.dart';
import 'package:doctor_plus/View/Layout/components/components.dart';
import 'package:doctor_plus/View/Screens/Drug_Screen/cubit/cubit.dart';
import 'package:doctor_plus/View/Screens/Drug_Screen/new_drug_form.dart';
import 'package:doctor_plus/View/Screens/Organization_Screen/Org_detail_Screen.dart';
import 'package:doctor_plus/View/Screens/Organization_Screen/cubit/cubit.dart';
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
import 'cubit/states.dart';
import 'package:doctor_plus/View/Layout/components/components.dart';

import 'new_organization_form.dart';

class org_screen extends StatelessWidget {

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

          if(state is OrgLoadingSuccessState)
            {
              context.loaderOverlay.hide();
              navigateTo(context, Org_detail_Screen());
            }

          if(state is OrgLoadingGetDataState)
          {
            context.loaderOverlay.show();
          }


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
          var DrugCubits = OrganizationCubit.get(context);

          return Scaffold(

            appBar: AppBar(
              backgroundColor: defaultColor,
              //title: Text('Organizations'),
            ),
            body:
            LoaderOverlay(
                useDefaultLoading: false,
                overlayWidget:  loading(context),
                overlayColor: Colors.black26,
                overlayOpacity: 0.3,
            child :

            SingleChildScrollView(
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
                            padding: const EdgeInsets.fromLTRB(0,0.0,0,0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    Text("Organizations", style: TextStyle(color: Colors.white,fontSize: 20,),),
                                    SizedBox(height: 10,),
                                    Container(
                                      padding: EdgeInsets.all(2), // Adjust the padding to control the border width
                                      decoration: BoxDecoration(
                                        color: Colors.white, // Border color
                                        shape: BoxShape.circle, // Circular shape
                                      ),
                                      child: CircleAvatar(
                                        radius: 60,
                                        backgroundColor: thirdColor,
                                        child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Image(image: AssetImage("Assets/images/hos.png"),),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),

                        ],
                      ),

                      // CircleAvatar(
                      //   radius: 60,
                      //   child: Image(image: NetworkImage(url_img_car+'users/images/'+ User!.data.photo),),),


                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ConditionalBuilder(
                            condition: state is DrugLoadingSuccessState ||  OrganizationCubit.get(context).organizations.length != 0 ,
                            builder: (context) =>
                            OrganizationCubit.get(context).organizations.length != 0 ?   Container(
                              width:  MediaQuery.of(context).size.width,
                              height: 600,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 5.0,vertical: 20 ),
                                child: ListView.separated(
                                    scrollDirection: Axis.vertical,
                                    itemBuilder: (context,index)=> Card(
                                      elevation: 0.0,
                                      child: Column(
                                        children: [
                                          Container(
                                            child: MaterialButton(
                                                onPressed:(){
                                                  OrganizationCubit.get(context).Get_organizations_with_patients_doctors(OrganizationCubit.get(context).organizations[index]);
                                                },
                                                child: OrganizationcardTitle(OrganizationCubit.get(context).organizations[index], context,Org_detail_Screen())),
                                          ),
                                          SizedBox(height: 10,),
                                        ],
                                      ),
                                    ),
                                    separatorBuilder: (context,index)=> SizedBox(height: 5,),
                                    itemCount:OrganizationCubit.get(context).organizations.length),
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
                                  Text("Not Found Medinice" , style: TextStyle(color:defaultColor,fontSize: 25),),

                                ],
                              ),

                            ),
                            fallback: (context) =>  Center(child: loading(context)),
                          ),
                        ],
                      ),


                    ],
                  ),


                ),


            ),


             ),


            floatingActionButton: Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                // backgroundColor: defaultColor,
                  child: Icon(
                    Icons.add,
                    // color: Colors.white,
                  ),
                  onPressed: () async{

                    final newPatient = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => newOrganizationForm()));

                  }

              ),),






          );
        },
      ));
  }



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

