import 'package:doctor_plus/Model/drug.dart';
import 'package:doctor_plus/Model/organization.dart';
import 'package:doctor_plus/View/Layout/Shop_app/ShopLayout.dart';
import 'package:doctor_plus/View/Layout/colors.dart';
import 'package:doctor_plus/View/Layout/components/components.dart';
import 'package:doctor_plus/View/Screens/Drug_Screen/cubit/cubit.dart';
import 'package:doctor_plus/View/Screens/Organization_Screen/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:doctor_plus/Model/patient.dart';
import 'package:doctor_plus/Controller/firestore_crud.dart';
import 'package:toast/toast.dart';

import 'cubit/states.dart';



class newOrganizationForm extends StatefulWidget {
  const newOrganizationForm({Key? key}) : super(key: key);

  @override
  _new_Organization_Form createState() => _new_Organization_Form();
}

class _new_Organization_Form extends State<newOrganizationForm> {
  int _activeStepIndex = 0;
  var formKey = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();
  TextEditingController location = TextEditingController();

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
                    Controller: name,
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
                  Controller: location,
                  type: TextInputType.name,
                  text: 'Location Of Organization',
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
                Text('Location : ${location.text}'),
             //   Text('Description: ${name.text}'),

              ],
            )))
      ];

  @override
  void initState() {
    super.initState();
  }
    Organization p = new Organization();

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return BlocProvider (
        create: (BuildContext context)=> OrganizationCubit() ,
        child:  BlocConsumer<OrganizationCubit, OrgStates>(
        listener: (context, state) {

       if (state is OrganizationSuccessAddState || state is OrganizationErrorAddState )
        {
          if(state is OrganizationSuccessAddState )
            {
              showToast(msg: state.msg,
                  ToastStatus: ToastColor.SUCCESS);
              navigateAndFinsih(context,ShopLayout());
            }
          else if(state is OrganizationErrorAddState)
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
    'Add New Organization',
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

        p.name = name.text;
        p.location = location.text;
        setState(() {
          _activeStepIndex += 1;
        });

      }

    } else {

      OrganizationCubit.get(context).Add_New_Organization(org: p);

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
