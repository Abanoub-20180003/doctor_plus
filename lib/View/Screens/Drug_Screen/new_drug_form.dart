import 'package:doctor_plus/Model/drug.dart';
import 'package:doctor_plus/View/Layout/Shop_app/ShopLayout.dart';
import 'package:doctor_plus/View/Layout/colors.dart';
import 'package:doctor_plus/View/Layout/components/components.dart';
import 'package:doctor_plus/View/Screens/Drug_Screen/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:doctor_plus/Model/patient.dart';
import 'package:doctor_plus/Controller/firestore_crud.dart';
import 'package:toast/toast.dart';

import 'cubit/states.dart';

enum ganderGroup { male, female }

class newDrugForm extends StatefulWidget {
  const newDrugForm({Key? key}) : super(key: key);

  @override
  _newPatientForm createState() => _newPatientForm();
}

class _newPatientForm extends State<newDrugForm> {
  int _activeStepIndex = 0;
  var formKey = GlobalKey<FormState>();

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

                InputField (
                    Controller: No,
                    type: TextInputType.name,
                    text: 'Name',
                    Icon: Icon(Icons.person),
                    validate:(value)
                  {
                    if(value== null || value == "")
                    {
                      return "Name is required";
                    }
                    return null;
                  },
                    ),

                 SizedBox(
                  height: 8,
                ),
                InputField (
                  Controller: Rank,
                  type: TextInputType.name,
                  text: 'Company Name',
                  Icon: Icon(Icons.home),
                  validate:(value)
                  {
                    if(value== null || value == "")
                    {
                      return "Company Name is required";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 8,
                ),
                InputField (
                  Controller: name,
                  type: TextInputType.name,
                  text: 'Description',
                  Icon: Icon(Icons.description),
                  validate:(value)
                  {
                    if(value== null || value == "")
                    {
                      return "Description is required";
                    }
                    return null;
                  },
                ),

                 SizedBox(
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
  Drug p = new Drug();


  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return BlocProvider (
        create: (BuildContext context)=> DrugCubit() ,
        child:  BlocConsumer<DrugCubit, DrugStates>(
        listener: (context, state) {

       if (state is DrugSuccessAddState || state is DrugErrorAddState )
        {
          if(state is DrugSuccessAddState )
            {
              showToast(msg: state.msg,
                  ToastStatus: ToastColor.SUCCESS);
              navigateAndFinsih(context,ShopLayout());
            }
          else if(state is DrugErrorAddState)
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
    body:Form(
           key: formKey,
    child :Stepper(
    type: StepperType.vertical,
    currentStep: _activeStepIndex,
    steps: stepList(),
    onStepContinue: () {
    if (_activeStepIndex < (stepList().length - 1)) {
      if(formKey.currentState!.validate()) {

        p.name = No.text;
        p.com_name = Rank.text;
        p.description = name.text;
        setState(() {
          _activeStepIndex += 1;
        });

      }

    } else {
    // print summary of the inpout values
    // store data in patient object
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

    ),)
    );
    }));
  }
}
