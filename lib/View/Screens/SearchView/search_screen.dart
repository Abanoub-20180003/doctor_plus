import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:doctor_plus/View/Layout/colors.dart';
import 'package:doctor_plus/View/Layout/components/components.dart';
import 'package:doctor_plus/View/Style/filter_dialog_botton.dart';
import 'package:doctor_plus/View/Widgets/patient_card_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';

import '../../../Model/patient.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class searchScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    var formkey = GlobalKey<FormState>();
    var searchCon = TextEditingController();

    return BlocProvider(
        create: (BuildContext context) => SearchCubit()..get_patients(),
        child: BlocConsumer<SearchCubit, SearchStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = SearchCubit.get(context);
            return ConditionalBuilder(
                condition: true,
                builder: (context) {
                  return Scaffold(
                    appBar: AppBar(
                      backgroundColor: defaultColor,
                      title: Text(
                        'Patients',
                        style: TextStyle(
                            color: thirdColor,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    body: Container(
                      width: MediaQuery.sizeOf(context).width,
                      height: MediaQuery.sizeOf(context).height,

                      child: Form(
                        key: formkey,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Expanded(
                            child: Column(children: [
                              SizedBox(
                                height: 15,
                              ),
                              searchInputField(searchCon, cubit),
                              if (state is ShopLoadingGetPatientsState || cubit.get_data == false)
                                LinearProgressIndicator(),
                              if (state is ShopLoadingSearchProductState &&
                                  cubit.get_data == true)
                                LinearProgressIndicator(),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Filters",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  Spacer(),
                                  FilterDialogBotton()
                                ],
                              ),

                              SizedBox(
                                height: 10,
                              ),
                              if ((state is ShopSuccessSearchProductState &&
                                      cubit.search_List.length != 0 &&
                                      cubit.get_data == true) ||
                                  state is ShopSuccessGetPatientsState ||
                                  state is ShopSuccessemptySearchProductState)
                                Expanded(
                                  child: ListView.separated(
                                      itemCount: cubit.search_List.length,
                                      separatorBuilder:
                                          (BuildContext context, int index) =>
                                              SizedBox(
                                                height: 5,
                                              ),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        Patient data = cubit.search_List[index];
                                        return Card(
                                         // color: Colors.w,
                                          elevation: 0.0,
                                          child: Column(
                                            children: [
                                              Container(
                                                child: cardTitle(data, context),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                            ],
                                          ),
                                        );
                                      }),
                                ),
                              if (state is ShopSuccessSearchProductState &&
                                  cubit.search_List.length == 0 &&
                                  cubit.get_data == true)
                                Expanded(
                                  child: Center(
                                      child: Image(
                                    image: AssetImage('Assets/images/404.gif'),
                                  )),
                                ),


                            ]),
                          ),
                        ),
                      ),
                    ),
                  );
                },
                fallback: (context) =>
                    Center(child: CircularProgressIndicator()));
          },
        ));
  }

  Widget searchInputField(TextEditingController searchCon, SearchCubit cubit) {
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
