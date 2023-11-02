import 'package:doctor_plus/Model/drug.dart';
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
  TextEditingController No = TextEditingController();
  TextEditingController Rank = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController birth_of_date = TextEditingController();
  TextEditingController marital_status = TextEditingController();
  var _gender = 'male'; // gender

  List columnHeaders = ['YES', 'NO'];
  List rowHeaders = [
    'Diabetes',
    'DM',
    'Complication',
    'Endo Pancrease',
    'Pit / Hypothalm',
    'Thyroid',
    'Parathroid',
    'Adrenal',
    'Genitourinary',
    'Bone Disease',
    'Dyslipidemia',
    'Hypertension',
    'CVS / CNS',
    'Liver / GIT',
    'Cancer',
    'Psych / eating',
    'Other'
  ];
  Map selectedMedicalHistory = new Map();


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
                  controller: No,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Name',
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextField(
                  // Rank
                  controller: Rank,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Company Name',
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextField(
                  // Name
                  controller: name,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Description',
                  ),
                ),
                const SizedBox(
                  height: 8,
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
                Text('Name: ${No.text}'),
                Text('Company Name: ${Rank.text}'),
                Text('Description: ${name.text}'),

              ],
            )))
      ];

  @override
  void initState() {
    super.initState();
  }



  List<Widget> createMedicalHistoryTable() {
    List<Widget> allRows = []; //For Saving all Created Rows

    for (int i = 0; i < rowHeaders.length; i++) {
      List<Widget> singleRow = []; //For creating a single row
      for (int j = 0; j < columnHeaders.length; j++) {
        singleRow.add(Container(
            alignment: FractionalOffset.center,
            //width: 120.0,
            padding: const EdgeInsets.only(
                //top: 6.0, bottom: 6.0,
                right: 3.0,
                left: 3.0),
            child: Radio(
              value: j, //Index of created Radio Button
              groupValue: selectedMedicalHistory[rowHeaders[i]] !=
                      null //If groupValue is equal to value, the radioButton will be selected
                  ? selectedMedicalHistory[rowHeaders[i]]
                  : "",
              onChanged: (value) {
                this.setState(() {
                  selectedMedicalHistory[rowHeaders[i]] =
                      value; //Adding selected rowName with its Index in a Map tagged "selected"
                  print("${rowHeaders[i]} ==> $value");
                });
              },
            )));
      }
      //Adding single Row to allRows widget
      allRows.add(new Container(
          child: new Row(
        children: [
          new Container(
            alignment: FractionalOffset.centerLeft,
            width: 140.0,
            padding: const EdgeInsets.only(
                //top: 6.0, bottom: 6.0,
                right: 3.0,
                left: 10.0),
            child:
                Text(rowHeaders[i], style: TextStyle(color: Colors.grey[800])),
          )
        ]..addAll(singleRow), //Add single row here
      )));
    }
    return allRows; //Return all single rows
  }

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return BlocProvider (
        create: (BuildContext context)=> DrugCubit() ,
        //   () {
        // if(Brands_car == null)
        //   {
        //     CarCubit()..Get_Cars_user()..Get_Car_Brands();
        //   }

        // },
        child:  BlocConsumer<ReportCubit, ReportStates>(
        listener: (context, state) {

    },
    builder: (context, state) {
    return Scaffold(
    appBar: AppBar(
    title: const Text(
    'Add New Medicine',
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
    // print summary of the inpout values
    // store data in patient object
    Drug p = new Drug();
    p.name = No.text;
    p.com_name = Rank.text;
    p.description = name.text;


    // add to firestore
    DrugCubit.get(context).Add_Drug(drug: p);
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
