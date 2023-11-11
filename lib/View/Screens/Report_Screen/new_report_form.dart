import 'package:doctor_plus/Model/drug.dart';
import 'package:doctor_plus/Model/medical_test_type.dart';
import 'package:doctor_plus/View/Layout/Shop_app/ShopLayout.dart';
import 'package:doctor_plus/View/Layout/colors.dart';
import 'package:doctor_plus/View/Layout/components/components.dart';
import 'package:doctor_plus/View/Screens/Drug_Screen/cubit/cubit.dart';
import 'package:doctor_plus/View/Screens/Report_Screen/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:doctor_plus/Model/patient.dart';
import 'package:doctor_plus/Controller/firestore_crud.dart';
import 'package:toast/toast.dart';

import 'cubit/states.dart';

enum ganderGroup { male, female }

class new_report_form extends StatefulWidget {
  const new_report_form({Key? key}) : super(key: key);

  @override
  _newPatientForm createState() => _newPatientForm();
}

class _newPatientForm extends State<new_report_form> {
  int _activeStepIndex = 0;

  // from fildes
  // General info
  TextEditingController name = TextEditingController();
  TextEditingController desciption = TextEditingController();
  TextEditingController normal_low = TextEditingController();
  TextEditingController normal_high = TextEditingController();
  TextEditingController waiting_date = TextEditingController();




  List<Step> stepList() => [
        // General info
        Step(
          state: _activeStepIndex <= 0 ? StepState.editing : StepState.complete,
          isActive: _activeStepIndex >= 0,
          title: const Text(
            'General Info',
            style: TextStyle(fontFamily: 'Bebas', letterSpacing: 2),
          ),
          content: Container(
            child: Column(
              children: [
                TextField(
                  // No
                  controller: name,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Name of Test',
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextField(
                  // Rank
                  controller: desciption,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Description Test',
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextField(
                  // Name
                  controller: normal_low,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Low Normal Result',
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextField(
                  // Name
                  controller: normal_high,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'High Normal Result',
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextField(
                  // Birth of date
                  controller: waiting_date,
                  decoration:  InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Result will Appear at',
                  ),
                  readOnly: true,
                  //set it true, so that user will not able to edit text
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1950),
                        //DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime(2100));

                    if (pickedDate != null) {
                      print(
                          pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                      String formattedDate =
                      DateFormat('yyyy-MM-dd').format(pickedDate);
                      print(
                          formattedDate); //formatted date output using intl package =>  2021-03-16
                      setState(() {
                        waiting_date.text =
                            formattedDate; //set output date to TextField value.
                      });
                    } else {}
                  },
                ),
              ],
            ),
          ),
        ),

        Step(
            state: StepState.complete,
            isActive: _activeStepIndex >= 4,
            title: const Text(
              'Confirm Details',
              style: TextStyle(
                fontFamily: 'Bebas',
                letterSpacing: 2,
              ),
            ),
            content: Container(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Name: ${name.text}'),
                Text('Description: ${desciption.text}'),
                Text('Low Result: ${normal_low.text}'),
                Text('High Result: ${normal_high.text}'),
                Text('Result Appear At : ${waiting_date.text}'),


              ],
            )))
      ];

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return BlocProvider (
        create: (BuildContext context)=> ReportCubit() ,
        //   () {
        // if(Brands_car == null)
        //   {
        //     CarCubit()..Get_Cars_user()..Get_Car_Brands();
        //   }

        // },
        child:  BlocConsumer<ReportCubit, ReportStates>(
        listener: (context, state) {
          if (state is Test_Type_AddSuccessState || state is Test_Type_AddErrorState )
          {
            if(state is Test_Type_AddSuccessState )
            {
              showToast(msg: state.msg,
                  ToastStatus: ToastColor.SUCCESS);
              navigateAndFinsih(context,ShopLayout());
            }
            else if(state is Test_Type_AddErrorState)
            {
              showToast(msg: state.msg,
                  ToastStatus: ToastColor.ERROR);
              navigateAndFinsih(context,ShopLayout());
            }

          }
    },
    builder: (context, state) {
    return Scaffold(
    appBar: AppBar(
    title: const Text(
    'Add New Type Test',
    style: TextStyle(
    fontFamily: 'Bebas',
    letterSpacing: 1,
    ),
    ),
    centerTitle: true,
    backgroundColor: defaultColor,
    foregroundColor: Colors.white,
    ),
    body: Stepper(
    type: StepperType.vertical,
    currentStep: _activeStepIndex,
    steps: stepList(),
    onStepContinue: () {
    if (_activeStepIndex < (stepList().length - 1)) {
    setState(() {
    _activeStepIndex += 1;
    });
    } else {

    Medical_Test_type p = new Medical_Test_type.no_data();
    p.name = name.text;
    p.description = desciption.text;
    p.normal_result_low = normal_low.text;
    p.normal_result_high = normal_high.text;
    p.waiting_date =convert_string_to_time(waiting_date.text);

    // add to firestore
    ReportCubit.get(context).Add_Medical_Tests_Type(test_type: p);
    }
    },
    onStepCancel: () {
    if (_activeStepIndex == 0) {
    return;
    }
    setState(() {
    _activeStepIndex -= 1;
    });
    },
    onStepTapped: (int index) {
    setState(() {
    _activeStepIndex = index;
    });
    },
    // controlsBuilder: (context,
    //   {onStepContinue, onStepCancel, onStepTapped}) {
    //   final isLastStep = _activeStepIndex == stepList().length - 1;
    //   return Container(
    //     child: Row(
    //       children: [
    //         Expanded(
    //           child: ElevatedButton(
    //             onPressed: onStepContinue,
    //             child: (isLastStep)
    //                 ? const Text('Submit')
    //                 : const Text('Next'),
    //           ),
    //         ),
    //         const SizedBox(
    //           width: 10,
    //         ),
    //         if (_activeStepIndex > 0)
    //           Expanded(
    //             child: ElevatedButton(
    //               onPressed: onStepCancel,
    //               child: const Text('Back'),
    //             ),
    //           )
    //       ],
    //       ),
    //     );
    // },
    ),
    );
    }));
  }
}
