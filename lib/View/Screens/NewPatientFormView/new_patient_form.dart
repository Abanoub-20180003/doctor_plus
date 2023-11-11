import 'package:custom_searchable_dropdown/custom_searchable_dropdown.dart';
import 'package:doctor_plus/View/Layout/colors.dart';
import 'package:doctor_plus/View/Layout/components/components.dart';
import 'package:doctor_plus/View/Screens/Drug_Screen/cubit/cubit.dart';
import 'package:doctor_plus/View/Screens/NewPatientFormView/select_drugs.dart';
import 'package:doctor_plus/View/Screens/Organization_Screen/cubit/cubit.dart';
import 'package:doctor_plus/View/Widgets/dropdownListWithCheckbox.dart';

import 'package:doctor_plus/View/Widgets/patient_card_title.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:doctor_plus/Model/patient.dart';
import 'package:doctor_plus/Controller/firestore_crud.dart';
import 'package:motion_toast/motion_toast.dart';

import '../../Layout/components/constants.dart';

enum ganderGroup { male, female }

class newPatientForm extends StatefulWidget {
  const newPatientForm({Key? key}) : super(key: key);

  @override
  _newPatientForm createState() => _newPatientForm();
}

class _newPatientForm extends State<newPatientForm> {
  int _activeStepIndex = 0;
  List<String> selectedMedicaltests = [];
  // from fildes
  // General info
  TextEditingController No = TextEditingController();
  TextEditingController Rank = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController birth_of_date = TextEditingController();
  TextEditingController marital_status = TextEditingController();
  TextEditingController blood_group = TextEditingController();
  var _gender = 'male'; // gender
  TextEditingController occupation = TextEditingController();
  TextEditingController special_habit = TextEditingController();
  TextEditingController org_id = TextEditingController();
  // Address
  TextEditingController address = TextEditingController();
  TextEditingController tel_home = TextEditingController();
  TextEditingController cell_phone = TextEditingController();

  // Resason of visit
  List<String> _reasonsOfVisitItems = ['Referred by', 'Inpatient', 'Others'];
  String? selectedReasonsOfVisit;
  TextEditingController reasonOfVisitInputController = TextEditingController();
  bool isReasonOfVisitSelected = false;

  var Step1 = GlobalKey<FormState>();
  var Step2 = GlobalKey<FormState>();
  var Step3 = GlobalKey<FormState>();
  var Step4 = GlobalKey<FormState>();
  // History Of Illness
  // - GYN/OB History
  TextEditingController historyOfIllnessTextController =
      TextEditingController();
  String? selectedGYN_OB_History;


  List Matrial_Status = [
    {'label': 'Single', 'value': 'Single'},
    {'label': 'Married', 'value': 'Married'},
    {'label': 'Other', 'value': 'Other'},
  ];

  List Blood_Group = [
    {'label': 'A+', 'value': 'A+'},
    {'label': 'B+', 'value': 'B+'}, // label is required and unique
    {'label': 'O+', 'value': 'O+'},
    {'label': 'A-', 'value': 'A-'},
    {'label': 'B-', 'value': 'B-'},
    {'label': 'O-', 'value': 'O-'}, // label is required and unique
    {'label': 'AB', 'value': 'AB'},
  ];
  // - Medical History
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




  @override
  void initState() {
    super.initState();
    drugs_added_patient = [];
  }


  @override
Widget build(BuildContext context)  {

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Patient',
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

            if(_activeStepIndex == 0)
              {
                if(Step1.currentState!.validate()) {

                  if(marital_status.text == null || marital_status.text == '')
                  {
                    MotionToast.error(
                      title:  Text("Marital Status Required"),
                      description:  Text(""),
                    ).show(context);
                    return null;
                  }

                  if(blood_group.text == null || blood_group.text == '')
                  {
                    MotionToast.error(
                      title:  Text("Blood Group Required"),
                      description:  Text(""),
                    ).show(context);
                    return null;
                  }



                  if(birth_of_date.text == null || birth_of_date.text == '')
                  {
                    MotionToast.error(
                      title:  Text("Birth Date Required"),
                      description:  Text(""),
                    ).show(context);

                    return null;
                  }

                  setState(() {
                    _activeStepIndex += 1;
                  });
                }
              }
            else if(_activeStepIndex == 1)
              {
                if(Step2.currentState!.validate()) {
                  setState(() {
                    _activeStepIndex += 1;
                  });
                }
              }
            else if(_activeStepIndex == 2)
            {

                if(org_id.text == null || org_id.text == '')
                {
                  MotionToast.error(
                    title:  Text("Organization Required"),
                    description:  Text(""),
                  ).show(context);
                  return null;
                }

                setState(() {
                  _activeStepIndex += 1;
                });

            }
            else if(_activeStepIndex == 3)
            {

                setState(() {
                  _activeStepIndex += 1;
                });

            }




            setState(() {
              _activeStepIndex += 0;
            });


          } else {
            // print summary of the inpout values
            // store data in patient object

            if(Step2.currentState!.validate() && Step1.currentState!.validate()) {
              Patient p = new Patient();
              p.no = No.text;
              p.rank = Rank.text;
              p.name = name.text;
              p.birthOfDate = birth_of_date.text;
              p.maritalStatus = marital_status.text;
              p.blood = blood_group.text;
              p.gander = _gender;
              p.occupation = occupation.text;
              p.specialHabit = special_habit.text;
              p.organizationId = org_id.text;
              p.address = address.text;
              p.cellPhone = cell_phone.text;
              p.telHome = tel_home.text;
              p.drugs = drugs_added_patient;
              drugs_added_patient = [];
              p.doc_added_Id = doctor_profile.id;
              p.docId = doctor_profile.id;

              // add to firestore
              firestroeCRUD db = firestroeCRUD();
              db.addPatient(p);
              Navigator.pop(context, p);
            }
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
  }




  // form sections as steps
  List<Step> stepList() => [
    // General info
    Step(
      state: _activeStepIndex <= 0 ? StepState.editing : StepState.complete,
      isActive: _activeStepIndex >= 0,
      title: const Text(
        'General Info',
        style: TextStyle(fontFamily: 'Bebas', letterSpacing: 2),
      ),
      content: Form(
        key: Step1,
        child: Container(
          child: Column(
            children: [
              InputField(
                  Controller: name,
                  type: TextInputType.text,
                  text: "Full Name",
                  Icon: Icon(Icons.drive_file_rename_outline),
                  validate:(value)
                  {
                    if(value== null || value == "")
                    {
                      return "Name is required";
                    }
                    return null;
                  },
              ),
              SizedBox(height: 8,),
              InputField(
                Controller: Rank,
                type: TextInputType.text,
                text: "Rank",
                Icon: Icon(Icons.numbers),
                validate:(value)
                {
                  if(value== null || value == "")
                  {
                    return "Rank is required";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 8,
              ),
              CustomSearchableDropDown(
                items: Matrial_Status,
                label: 'Marital Status',
                showLabelInMenu: false,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: defaultColor,

                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
                prefixIcon:  Padding(
                  padding: const EdgeInsets.fromLTRB(0,0, 5.0,0),
                  child: Icon(Icons.man),
                ) ,

                dropDownMenuItems: Matrial_Status.map((item) {
                  return item['label'];
                })?.toList() ??
                    [],
                onChanged: (value){
                  if(value!=null)
                  {
                    print(value['value']);
                    marital_status.text = value['value'];
                  }
                },
              ),
              const SizedBox(
                height: 8,
              ),
              CustomSearchableDropDown(
                items: Blood_Group,
                label: 'Blood Group',
                showLabelInMenu: false,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: defaultColor,

                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
                prefixIcon:  Padding(
                  padding: const EdgeInsets.fromLTRB(0,0, 5.0,0),
                  child: Icon(Icons.bloodtype),
                ) ,

                dropDownMenuItems: Blood_Group.map((item) {
                  return item['label'];
                })?.toList() ??
                    [],
                onChanged: (value){
                  if(value!=null)
                  {
                    print(value['value']);
                    blood_group.text = value['value'];
                  }
                },
              ),
              const SizedBox(
                height: 8,
              ),
              TextField(
                // Birth of date
                controller: birth_of_date,
                decoration:  InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Select Birth Of Date',
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
                      birth_of_date.text =
                          formattedDate; //set output date to TextField value.
                    });
                  } else {}
                },
              ),

              const SizedBox(
                height: 8,
              ),
              Text(
                "Select Gender",
                style: TextStyle(fontSize: 14),
              ),
              Divider(),
              // gander
              // male
              RadioListTile(
                  title: Text("Male"),
                  value: 'male',
                  groupValue: _gender,
                  onChanged: (String? val) {
                    setState(() {
                      _gender = val!;
                    });
                  }),
              // female
              RadioListTile(
                  title: Text("Female"),
                  value: 'female',
                  groupValue: _gender,
                  onChanged: (String? val) {
                    setState(() {
                      _gender = val!;
                    });
                  }),

              const SizedBox(
                height: 8,
              ),
              InputField(
                Controller: occupation,
                type: TextInputType.text,
                text: "Occupation",
                Icon: Icon(Icons.sensor_occupied),
                validate:(value)
                {
                  if(value== null || value == "")
                  {
                    return "Occupation is required";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 8,
              ),
              InputField(
                Controller: special_habit,
                type: TextInputType.text,
                text: "Special Habit",
                Icon: Icon(Icons.person),
                validate:(value)
                {
                  if(value== null || value == "")
                  {
                    return "Special Habit is required";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 8,
              ),
            ],
          ),
        ),
      ),
    ),



    // Address
    Step(
        state:
        _activeStepIndex <= 1 ? StepState.editing : StepState.complete,
        isActive: _activeStepIndex >= 1,
        title: const Text(
          'Address',
          style: TextStyle(
            fontFamily: 'Bebas',
            letterSpacing: 2,
          ),
        ),
        content: Form(
          key: Step2,
          child: Container(
            child: Column(
              children: [
                const SizedBox(
                  height: 8,
                ),
                InputField(
                  Controller: address,
                  type: TextInputType.text,
                  text: "Present Address",
                  Icon: Icon(Icons.location_on),
                  validate:(value)
                  {
                    if(value== null || value == "")
                    {
                      return "Present Address is required";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                InputField(
                  Controller: tel_home,
                  type: TextInputType.number,
                  text: "Home Phone",
                  Icon: Icon(Icons.phone),
                  validate:(value)
                  {
                    if(value== null || value == "")
                    {
                      return "Home Phone is required";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                InputField(
                  Controller: cell_phone,
                  type: TextInputType.number,
                  text: "Cell Phone",
                  Icon: Icon(Icons.phone_in_talk_sharp),
                  validate:(value)
                  {
                    if(value== null || value == "")
                    {
                      return "Cell Phone is required";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
              ],
            ),
          ),
        )

    ),


    // Add Medical Test
    // Step(
    //     state:
    //     _activeStepIndex <= 2 ? StepState.editing : StepState.complete,
    //     isActive: _activeStepIndex >= 2,
    //     title: const Text(
    //       'Add Medical Test',
    //       style: TextStyle(
    //         fontFamily: 'Bebas',
    //         letterSpacing: 2,
    //       ),
    //     ),
    //     content: Container(
    //       child: Column(
    //         children: [
    //           const SizedBox(
    //             height: 8,
    //           ),
    //           DropdownListWithCheckbox(
    //               allOptions: ['p1', 'p2', 'p3'],
    //               selectedOptions: selectedMedicaltests),
    //           Text('Selected Options: ${selectedMedicaltests.join(', ')}'),
    //         ],
    //       ),
    //     )),
    // // Add Drugs

    Step(
      // step 3
      state: _activeStepIndex <= 3 ? StepState.editing : StepState.complete,
      isActive: _activeStepIndex >= 3,
      title: const Text(
        'Assign Organization',
        style: TextStyle(fontFamily: 'Bebas', letterSpacing: 2),
      ),
      content: Container(
        child: Column(
          children: [
            //Divider(),
            const SizedBox(
              height: 8,
            ),
            CustomSearchableDropDown(
              items: organizations_add_patient,
              label: 'Organization',
              showLabelInMenu: true,
              decoration: BoxDecoration(
                border: Border.all(
                  color: defaultColor,

                ),
                borderRadius: BorderRadius.circular(4),
              ),
              prefixIcon:  Padding(
                padding: const EdgeInsets.fromLTRB(0,0, 5.0,0),
                child: Icon(Icons.man),
              ) ,

              dropDownMenuItems: organizations_add_patient.map((item) {
                return item.name;
              })?.toList() ??
                  [],
              onChanged: (value){
                if(value!=null)
                {
                  print(value.Id);
                  org_id.text = value.Id;
                }
              },
            ),

            // DrugTable(),


            const SizedBox(
              height: 8,
            ),
          ],
        ),
      ),
    ),
    Step(
      // step 3
      state: _activeStepIndex <= 4 ? StepState.editing : StepState.complete,
      isActive: _activeStepIndex >= 4,
      title: const Text(
        'Add Drugs',
        style: TextStyle(fontFamily: 'Bebas', letterSpacing: 2),
      ),
      content: Container(
        child: Column(
          children: [
            //Divider(),
            const SizedBox(
              height: 8,
            ),

            MaterialButton(onPressed: (){
              navigateTo(context, SelecteService());
            },
              color: defaultColor,
            child: Text('Add Drugs',style: TextStyle(color: thirdColor),),),

            drugs_added_patient.length != 0 ?Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0,vertical: 20 ),
              child: ListView.separated(
                shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context,index)=> Card(
                    elevation: 0.0,
                    child: Column(
                      children: [
                        Container(
                          child: DrugcardTitle24(drugs_added_patient[index], context,index),
                        ),
                        SizedBox(height: 10,),
                      ],
                    ),
                  ),
                  separatorBuilder: (context,index)=> SizedBox(height: 5,),
                  itemCount:drugs_added_patient.length),
            ):Text("No Drugs Added"),
            // DrugTable(),


            const SizedBox(
              height: 8,
            ),
          ],
        ),
      ),
    ),
    // submit / save step
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
                Text('No: ${No.text}'),
                Text('Rank: ${Rank.text}'),
                Text('Name: ${name.text}'),
                Text('BOD: ${birth_of_date.text}'),
                Text('Marital Status: ${marital_status.text}'),
                Text('Gender: ${_gender}'),
                Text('Address : ${address.text}'),
                Text('Home Phone: ${tel_home.text}'),
                Text('Cell Phone: ${cell_phone.text}'),
              ],
            )))
  ];






}




