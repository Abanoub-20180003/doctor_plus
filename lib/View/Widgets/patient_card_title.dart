import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_plus/Model/medical_test_type.dart';
import 'package:doctor_plus/Model/organization.dart';
import 'package:doctor_plus/View/Layout/Shop_app/cubit/cubit.dart';
import 'package:doctor_plus/View/Layout/components/components.dart';
import 'package:doctor_plus/View/Layout/components/constants.dart';
import 'package:doctor_plus/View/Screens/Drug_Screen/cubit/cubit.dart';
import 'package:doctor_plus/View/Screens/Organization_Screen/Org_detail_Screen.dart';
import 'package:doctor_plus/View/Screens/Organization_Screen/cubit/cubit.dart';
import 'package:doctor_plus/View/Screens/Report_Screen/cubit/cubit.dart';
import 'package:flutter/material.dart';
import '../../Model/drug.dart';
import '../../Model/patient.dart';

import '../Screens/SearchView/patient_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';



String convert_stamp_to_Date({
  required Timestamp timestamp
})
{
  return  DateFormat('yyyy-MM-dd : HH:mm').format(timestamp.toDate()).toString();
}


class cardTitle extends ListTile {
  cardTitle(Patient _patient, BuildContext context)
      : super(
            tileColor: ShopCubit.get(context).Darktheme == false ? Colors.white: Colors.black38 ,
            title: Text(_patient.name!),
            leading: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Image(image: AssetImage('Assets/images/profile.png'),)),
            dense: false,
            trailing: Icon(
              Icons.arrow_forward,
              size: 24.0,
              color: Colors.blue,
            ),
            onTap: () {
              // open profile page for more detials
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => patientProfile(_patient)));
            });
}




class DrugcardTitle2 extends ListTile {
  DrugcardTitle2(Drug _drug, BuildContext context)
      : super(
    title: Text(_drug.name!),
    subtitle: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
          Text("Dr . ${_drug.doctor!.name!}"),
         Text("From : ${convert_stamp_to_Date(timestamp:_drug!.Start_at!)} "),
        _drug!.end_at != null ? Text("To : ${convert_stamp_to_Date(timestamp:_drug!.end_at!)} ") : Text("Until Now"),

      ],
    ),
    leading: CircleAvatar(radius: 30, backgroundColor: Colors.white, child: Image(image: AssetImage('Assets/images/med.png'),)),
    dense: false,
    trailing: _drug!.doctor!.id == doctor_profile.id ?IconButton(
      onPressed: ()
      {
          DrugCubit.get(context).Delete_Drugs(Id:_drug.Id!);
      },
      icon: Icon(
        Icons.delete_forever,
        size: 30.0,
        color: Colors.redAccent,
      ),
    ): Text(''),



  );
}



class DrugcardTitle extends ListTile {
  DrugcardTitle(Drug _drug, BuildContext context)
      : super(
      tileColor: ShopCubit.get(context).Darktheme == false ? Colors.white: Colors.black38 ,
      selectedTileColor :ShopCubit.get(context).Darktheme == false ? Colors.white: Colors.black38 ,

      title: Text(_drug.name!),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Text(_drug.com_name!),
        ],
      ),
      leading: CircleAvatar(
          backgroundColor: Colors.transparent,
          child: Image(image: AssetImage('Assets/images/med.png'),)),
      dense: false,
      trailing: IconButton(
        onPressed: (){
          DrugCubit.get(context).Delete_Drugs(Id:_drug.Id!);
        },
        icon: Icon(
          Icons.delete_forever,
          size: 30.0,
          color: Colors.redAccent,
        ),
      ),
  );
}

class Test_Type_cardTitle extends ListTile {
  Test_Type_cardTitle(Medical_Test_type _test_type, BuildContext context)
      : super(
    tileColor: ShopCubit.get(context).Darktheme == false ? Colors.white: Colors.black38 ,
    selectedTileColor :ShopCubit.get(context).Darktheme == false ? Colors.white: Colors.black38 ,

    title: Text(_test_type.name!),
    subtitle: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Text(_test_type.description!),
      ],
    ),
    leading: CircleAvatar(
        backgroundColor: Colors.transparent,
        child: Image(image: AssetImage('Assets/images/med.png'),)),
    dense: false,
    trailing: IconButton(
      onPressed: (){
        ReportCubit.get(context).Delete_Test_Type(Id:_test_type.id!);
      },
      icon: Icon(
        Icons.delete_forever,
        size: 30.0,
        color: Colors.redAccent,
      ),
    ),
  );
}



class DrugcardTitle24 extends ListTile {
  DrugcardTitle24(Drug _drug, BuildContext context,int index)
      : super(
    tileColor: ShopCubit.get(context).Darktheme == false ? Colors.white: Colors.black38 ,
    selectedTileColor :ShopCubit.get(context).Darktheme == false ? Colors.white: Colors.black38 ,

    title: Text(_drug.name!),
    subtitle: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      // children: <Widget>[
      //   new Text(_drug.com_name!),
      // ],
    ),
    leading: CircleAvatar(
        backgroundColor: Colors.transparent,
        child: Image(image: AssetImage('Assets/images/med.png'),)),
    dense: false,
    trailing: IconButton(
      onPressed: (){
        ShopCubit.get(context).Remove_drug(index);
      },
      icon: Icon(
        Icons.delete_forever,
        size: 30.0,
        color: Colors.redAccent,
      ),
    ),

  );
}


class OrganizationcardTitle extends ListTile {
  OrganizationcardTitle(Organization _org, BuildContext context,Widget screen)
      : super(
    tileColor: ShopCubit.get(context).Darktheme == false ? Colors.white: Colors.black38 ,
    selectedTileColor :ShopCubit.get(context).Darktheme == false ? Colors.white: Colors.black38 ,
    title: Text(_org.name!),
    leading: CircleAvatar(
        backgroundColor: Colors.transparent,
        child: Image(image: AssetImage('Assets/images/hos.png'),)),
    dense: false,
    trailing:Icon(Icons.arrow_forward,
        size: 24.0,
        color: Colors.blue,),
  );
}


class Organization_Patient_cardTitle extends ListTile {
  Organization_Patient_cardTitle(Patient_org _patient, BuildContext context,Widget screen)
      : super(
    tileColor: ShopCubit.get(context).Darktheme == false ? Colors.white: Colors.black38 ,
    selectedTileColor :ShopCubit.get(context).Darktheme == false ? Colors.white: Colors.black38 ,

   // title: Text(_patient.name!),
    title:Text(_patient.name),
    leading: CircleAvatar(
        backgroundColor: Colors.transparent,
        child: Image(image: AssetImage('Assets/images/profile.png'),)),
    dense: false,
    trailing:Icon(Icons.arrow_forward,
        size: 24.0,
        color: Colors.blue,)
  );
}


class Organization_Doctor_cardTitle extends ListTile {
  Organization_Doctor_cardTitle(Doctor_org _doctor, BuildContext context,Widget screen)
      : super(
    tileColor: ShopCubit.get(context).Darktheme == false ? Colors.white: Colors.black38 ,
    selectedTileColor :ShopCubit.get(context).Darktheme == false ? Colors.white: Colors.black38 ,

    // title: Text(_patient.name!),
    subtitle: MaterialButton(
      onPressed: (){
        // OrganizationCubit.get(context).Get_organizations_with_patients_doctors(_org);

      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(_doctor.name!),
        ],
      ),
    ),
    leading: CircleAvatar(
        backgroundColor: Colors.transparent,
        child: Image(image: AssetImage('Assets/images/doctor.png'),)),
    dense: false,

  );
}
