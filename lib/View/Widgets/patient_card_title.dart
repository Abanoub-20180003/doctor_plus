import 'package:flutter/material.dart';
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
            leading: CircleAvatar(child: Text(_patient.name![0])),
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
