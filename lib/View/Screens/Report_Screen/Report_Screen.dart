



import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:doctor_plus/View/Layout/components/components.dart';
import 'package:doctor_plus/View/Screens/Drug_Screen/cubit/cubit.dart';
import 'package:doctor_plus/View/Screens/Drug_Screen/new_drug_form.dart';
import 'package:doctor_plus/View/Screens/Report_Screen/cubit/cubit.dart';
import 'package:doctor_plus/View/Widgets/patient_card_title.dart';
import 'package:flutter/cupertino.dart';

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:toast/toast.dart';

import '../../Layout/colors.dart';
import 'cubit/states.dart';
import 'package:doctor_plus/View/Layout/components/components.dart';

import 'new_report_form.dart';


class report_screen extends StatelessWidget {

  TextEditingController _fullNameTextEditingController = TextEditingController();


  var scaffold_Key = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var name = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();
  var searchCon = TextEditingController();
  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return BlocProvider (
        create: (BuildContext context)=> ReportCubit()..Get_Medical_Tests_Types(),

    child:  BlocConsumer<ReportCubit, ReportStates>(
        listener: (context, state) {

          // if(state is DrugLoadingSuccessState)
          //   {
          //     showToast(msg: "Get Medicines Success",
          //         ToastStatus: ToastColor.SUCCESS);
          //   }


          if (state is Test_Type_DeleteSuccessState || state is Test_Type_DeleteErrorState )
          {
            if(state is Test_Type_DeleteSuccessState )
            {
              showToast(msg: state.msg,ToastStatus: ToastColor.SUCCESS);

            }
            else if(state is Test_Type_DeleteErrorState)
            {
              showToast(msg: state.msg,
                  ToastStatus: ToastColor.ERROR);

            }

          }

        },
        builder: (context, state) {
          var ReportCubits = ReportCubit.get(context);
          return Scaffold(

            body:SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 0.0, horizontal: 0),
                  child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0 ,horizontal: 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              width: MediaQuery.sizeOf(context).width-30,
                              child: searchInputField(searchCon, ReportCubits)),
                          if (state is ReportLoadingHomeDataState)
                            LinearProgressIndicator(),

                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ConditionalBuilder(
                                condition: state is ReportSuccessHomeDataState || state is ShopSuccessSearchMedicalTestState|| state is ShopSuccessemptySearchMedicalTestState,
                                builder: (context) =>
                                    ReportCubits.reports.length != 0 ?  Container(
                                      width:  MediaQuery.of(context).size.width,
                                      height: 600,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 15.0,vertical: 20 ),
                                        child: ListView.separated(
                                            scrollDirection: Axis.vertical,
                                            itemBuilder: (context,index)=> Card(
                                              elevation: 0.0,
                                              child: Column(
                                                children: [
                                                  Container(
                                                    child: Test_Type_cardTitle(ReportCubits.reports[index], context),
                                                  ),
                                                  SizedBox(height: 10,),
                                                ],
                                              ),
                                            ),
                                            separatorBuilder: (context,index)=> SizedBox(height: 5,),
                                            itemCount:ReportCubits.reports.length),
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
                                        Text("Not Found Medical Test Types" , style: TextStyle(color:defaultColor,fontSize: 25),),

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
                              builder: (context) => new_report_form()));

                  }

              ),),


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


  Widget searchInputField(TextEditingController searchCon, ReportCubit cubit) {
    return InputField(
      Controller: searchCon,
      onchange: (String text) {
        print(text.length);
        if (text != null && text.length != 0) {
          cubit.search_Medical_Test(search_text: searchCon.text);
        } else if (text.length == 0) {
          cubit.empty_search_Medical_Test();
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

