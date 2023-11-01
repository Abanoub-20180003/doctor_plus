import 'package:doctor_plus/Model/doctor.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:doctor_plus/Model/patient.dart';
import 'package:doctor_plus/Controller/firestore_crud.dart';

enum ganderGroup { male, female }

class newPatientForm extends StatefulWidget {
  final Doctor doctor;
  const newPatientForm({Key? key, required this.doctor}) : super(key: key);

  @override
  _newPatientForm createState() => _newPatientForm();
}

class _newPatientForm extends State<newPatientForm> {
  int _activeStepIndex = 0;

  // from fildes
  // General info
  TextEditingController No = TextEditingController();
  TextEditingController Rank = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController birth_of_date = TextEditingController();
  TextEditingController marital_status = TextEditingController();
  var _gender = 'male'; // gender
  TextEditingController occupation = TextEditingController();
  TextEditingController special_habit = TextEditingController();

  // Address
  TextEditingController address = TextEditingController();
  TextEditingController tel_home = TextEditingController();
  TextEditingController cell_phone = TextEditingController();

  // Resason of visit
  List<String> _reasonsOfVisitItems = ['Referred by', 'Inpatient', 'Others'];
  String? selectedReasonsOfVisit;
  TextEditingController reasonOfVisitInputController = TextEditingController();
  bool isReasonOfVisitSelected = false;

  // History Of Illness
  // - GYN/OB History
  TextEditingController historyOfIllnessTextController =
      TextEditingController();
  String? selectedGYN_OB_History;
  List<String> _GYN_OB_items = [
    'Menarche',
    'Menopause',
    'Post-Partum',
    'Lactating (Yas/No)',
    'Regular (Duration / Cycle)',
    'Pregnant (LMP / / )',
    'Irregular',
    'Amenorrhea (1ry - 2ry)',
    'Contraceptive/Hormonal TT',
    'Gyn/Obs Surgeries'
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
  Map selectedMedicalHistory = new Map();
  // - Past Surgical History
  // - Family Medical History
  // - Immunization

  // Drug History
  // Current Drug

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
          content: Container(
            child: Column(
              children: [
                TextField(
                  // No
                  controller: No,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'No',
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
                    labelText: 'Rank',
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
                    labelText: 'Full Name',
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextField(
                  // Birth of date
                  controller: birth_of_date,
                  decoration: const InputDecoration(
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
                TextField(
                  // Marital status
                  controller: marital_status,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Marital Status',
                  ),
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
                TextField(
                  // occupation
                  controller: occupation,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Occupation',
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextField(
                  // special habit
                  controller: special_habit,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Special Habit',
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
              ],
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
            content: Container(
              child: Column(
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  TextField(
                    controller: address,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Present Address',
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextField(
                    controller: tel_home,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Home Phone',
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextField(
                    controller: cell_phone,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Cell Phone',
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                ],
              ),
            )),
        // Reasons of visit
        Step(
            state:
                _activeStepIndex <= 2 ? StepState.editing : StepState.complete,
            isActive: _activeStepIndex >= 2,
            title: const Text(
              'Reasons of visit',
              style: TextStyle(
                fontFamily: 'Bebas',
                letterSpacing: 2,
              ),
            ),
            content: Container(
              child: Column(
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  DropdownButtonFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                    hint: Text('Select Value'),
                    icon: const Icon(Icons.arrow_downward),
                    elevation: 16,
                    style: const TextStyle(color: Colors.black),
                    onChanged: (String? value) {
                      // This is called when the user selects an item.
                      setState(() {
                        selectedReasonsOfVisit = value!;
                        isReasonOfVisitSelected = true;
                      });
                    },
                    items: _reasonsOfVisitItems
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextField(
                    // reasons of visit
                    /* change this if read  only is set to false you can enter in text field or if it is set to true you cannot enter any text in TextField. */
                    readOnly: !isReasonOfVisitSelected,
                    controller: reasonOfVisitInputController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Reason Of Visit',
                    ),
                  ),
                ],
              ),
            )),
        // History of illness
        // - History Of present Illness
        // - GYN/OB History
        // - Medical History
        // - Past Surgical History
        // - Family Medical History
        // - Immunization
        Step(
          // step 3
          state: _activeStepIndex <= 3 ? StepState.editing : StepState.complete,
          isActive: _activeStepIndex >= 3,
          title: const Text(
            'History of illness',
            style: TextStyle(fontFamily: 'Bebas', letterSpacing: 2),
          ),
          content: Container(
            child: Column(
              children: [
                TextField(
                  // History of illness
                  controller: historyOfIllnessTextController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'History of illness',
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  "GYN/OB History",
                  style: TextStyle(fontSize: 14),
                ),
                Divider(),
                DropdownButtonFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                  hint: Text('Select Value'),
                  icon: const Icon(Icons.arrow_downward),
                  elevation: 16,
                  style: const TextStyle(color: Colors.black),
                  onChanged: (String? value) {
                    // This is called when the user selects an item.
                    setState(() {
                      selectedGYN_OB_History = value!;
                      isReasonOfVisitSelected = true;
                    });
                  },
                  items: _GYN_OB_items.map<DropdownMenuItem<String>>(
                      (String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  "Medical History",
                  style: TextStyle(fontSize: 14),
                ),
                Divider(),
                SingleChildScrollView(
                    child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: 100.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Container(
                        color: Colors.blueGrey[200],
                        padding: EdgeInsets.only(top: 20.0, bottom: 10.0),
                        alignment: FractionalOffset.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            //headers
                            new Container(
                              margin: EdgeInsets.all(0.0),
                              child: new Row(
                                  children: [
                                new Container(
                                  alignment: FractionalOffset.center,
                                  width: 140.0,
                                  margin: EdgeInsets.all(0.0),
                                  padding: const EdgeInsets.only(
                                      top: 5.0,
                                      bottom: 5.0,
                                      right: 3.0,
                                      left: 3.0),
                                  child: Text(
                                    //Leave an empty text in Row(0) and Column (0)
                                    "",
                                    style: TextStyle(color: Colors.grey[800]),
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              ]..addAll(columnHeaders
                                      .map((header) => new Container(
                                            alignment: FractionalOffset.center,
                                            //width: 120.0,
                                            margin: EdgeInsets.all(0.0),
                                            padding: const EdgeInsets.only(
                                                top: 5.0,
                                                bottom: 5.0,
                                                right: 3.0,
                                                left: 20.0),
                                            child: new Text(
                                              header,
                                              style: TextStyle(
                                                  color: Colors.grey[800]),
                                              textAlign: TextAlign.center,
                                            ),
                                          ))
                                      .toList())),
                            ),
                          ],
                        ),
                      )
                    ]..addAll(createMedicalHistoryTable()), //Create Rows
                  ),
                )),
                const SizedBox(
                  height: 8,
                ),
                const SizedBox(
                  height: 8,
                ),
              ],
            ),
          ),
        ),
        // Drug History
        // - Current Drug

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

  @override
  void initState() {
    super.initState();
  }

  // function to drow drag table
  // Input Form - Drag Table
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
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Creating a From',
          style: TextStyle(
            fontFamily: 'Bebas',
            letterSpacing: 1,
          ),
        ),
        centerTitle: true,
        //backgroundColor: Colors.blue,
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
            Patient p = new Patient();
            p.userId = widget.doctor.id;
            p.no = No.text;
            p.rank = Rank.text;
            p.name = name.text;
            p.birthOfDate = birth_of_date.text;
            p.maritalStatus = marital_status.text;
            // gender
            p.gander = _gender;
            p.occupation = occupation.text;
            p.specialHabit = special_habit.text;

            // add to firestore
            firestroeCRUD db = firestroeCRUD();
            db.addPatient(p);
            Navigator.pop(context, p);
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
}
