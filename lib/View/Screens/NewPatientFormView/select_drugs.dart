
import 'package:doctor_plus/Model/drug.dart';
import 'package:doctor_plus/View/Layout/Shop_app/cubit/cubit.dart';
import 'package:doctor_plus/View/Layout/colors.dart';
import 'package:doctor_plus/View/Layout/components/components.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../Layout/components/constants.dart';


class SelecteService  extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<SelecteService > {

  //Get polyline with Location (latitude and longitude)
  _MyAppState()  {

    for (var i = 0; i < drugs_add_patient.length; i++) {
      isChecked.add(false);
      service.add(TextEditingController());
      start_at.add(TextEditingController());
      end_at.add(TextEditingController());
    };


  }


  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  List<TextEditingController> service = [];
  List<TextEditingController> start_at = [];
  List<TextEditingController> end_at = [];
  List<bool> isChecked = [];
  List<Object> services_types_add= [];


  Widget buildSelect(list, serv, start_at,end_at, che) =>
      StatefulBuilder(builder: (context, setState) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5),
          child: Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 45.0,
                    child: Checkbox(
                        checkColor: defaultColor ,
                        activeColor:secondColor ,

                        value: isChecked[che],
                        onChanged: (val) {
                          setState(() {
                            isChecked[che] = val!;
                          });
                        }),
                  ),
                  Container(
                      width: 100.0,
                      child: Text(list.name)),
                  Spacer(),
                  isChecked[che] == true ? Container(
                    width: 70.0,
                    child: TextFormField(
                      controller: serv,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        return value!.isNotEmpty ? null : 'Invalid';
                      },
                      decoration:  InputDecoration(
                        labelText: "Quantity",
                        labelStyle: TextStyle(fontSize: 15,color: defaultColor),
                        border: UnderlineInputBorder(),
                      ),
                    ),
                  ) : Text(''),
                ],
              ),
              isChecked[che] == true ?  SizedBox(height: 15,) : SizedBox(height: 0,),
              isChecked[che] == true ?  Padding(
                padding: const EdgeInsets.symmetric(horizontal:20.0),
                child:   TextField(
                // Birth of date
                controller: start_at,
                decoration:  InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Start Date',
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
                      start_at.text =
                          formattedDate; //set output date to TextField value.
                    });
                  } else {}
                },
              ),
              ) :  SizedBox(height: 0,),
              isChecked[che] == true ? SizedBox(height: 5,) : SizedBox(height: 0,),
              isChecked[che] == true ?  Padding(
                padding: const EdgeInsets.symmetric(horizontal:20.0),
                child:   TextField(
                  // Birth of date
                  controller: end_at,
                  decoration:  InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'End Date',
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
                        end_at.text =
                            formattedDate; //set output date to TextField value.
                      });
                    } else {}
                  },
                ),
              ):  SizedBox(height: 0,),
              //isChecked[che] == true ?
            ],
          ),
        );
      });



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: defaultColor,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }
          ),
          title: Text('Add Drugs'),
          actions:
          [
            IconButton(
              icon:  Icon(Icons.save_outlined , color: Colors.white,),
              onPressed: () {
                if(formkey.currentState!.validate())
                  {
                    drugs_added_patient = [];

                    for (var i = 0; i < isChecked.length; i++) {
                      if(isChecked[i] == true)
                        {
                          Drug input = Drug();
                          input.Id = drugs_add_patient[i].Id;
                          input.name = drugs_add_patient[i].name;
                          input.doc_id = doctor_profile.id;
                          input.Start_at = convert_string_to_time(start_at[i].text);
                          input.end_at =convert_string_to_time(end_at[i].text);
                          input.quantity= int.parse(service[i].text);

                          drugs_added_patient.add(input);
                        }
                    };
                    print(drugs_added_patient);
                    ShopCubit.get(context).Add_Person_Drugs();
                    Navigator.pop(context);

                  }

              },
            ),
          ],
        ),
        body: Form(
          key: formkey,
          child: ListView.separated(
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) =>
                buildSelect(
                    drugs_add_patient[index], service[index],start_at[index],end_at[index], index),
            separatorBuilder: (context, index) => SizedBox(height: 5.0,),
            itemCount: drugs_add_patient.length,

          ),
        ),
      );

  }
}