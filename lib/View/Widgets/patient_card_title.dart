import 'package:doctor_plus/View/Screens/Drug_Screen/cubit/cubit.dart';
import 'package:flutter/material.dart';
import '../../Model/drug.dart';
import '../../Model/patient.dart';

import '../Screens/SearchView/patient_profile_page.dart';

class cardTitle extends ListTile {
  cardTitle(Patient _patient, BuildContext context)
      : super(
            title: Text(_patient.name!),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text(_patient.no!),
                new Text(_patient.gander!)
              ],
            ),
            leading: CircleAvatar(child: Image(image: AssetImage('Assets/images/profile.png'),)),
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




class DrugcardTitle extends ListTile {
  DrugcardTitle(Drug _drug, BuildContext context)
      : super(
      title: Text(_drug.name!),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Text(_drug.com_name!),
        ],
      ),
      leading: CircleAvatar(child: Image(image: AssetImage('Assets/images/med.png'),)),
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
      // onTap: () {
      //   // open profile page for more detials
      //   Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //           builder: (context) => patientProfile(_drug)));
      // });
  );
}