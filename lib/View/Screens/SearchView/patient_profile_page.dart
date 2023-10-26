import 'package:flutter/material.dart';
import '../../../Model/patient.dart';

class patientProfile extends StatelessWidget {
  // patient varable
  Patient? _patient;

  patientProfile(this._patient);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Center(
          child: Text(_patient!.name.toString()),
        ),
      ),
      body: ListView(
        children: <Widget>[
          // top info
          Container(
            height: 250,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue, Colors.blue.shade300],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                stops: [0.5, 0.9],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // pdf + image + ?
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    // pdf icon
                    CircleAvatar(
                      backgroundColor: Colors.blueAccent[400],
                      minRadius: 35.0,
                      child: Icon(
                        Icons.picture_as_pdf,
                        size: 30.0,
                      ),
                    ),
                    // image
                    CircleAvatar(
                        backgroundColor: Colors.white70,
                        minRadius: 60.0,
                        child: Text(_patient!.name![0])),
                    // edit profile
                    CircleAvatar(
                      backgroundColor: Colors.blueAccent[400],
                      minRadius: 35.0,
                      child: Icon(
                        Icons.edit,
                        size: 30.0,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                //  the main name viwer
                Text(
                  _patient!.name.toString(),
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          // body patient detailed info
          Container(
            child: Column(
              children: <Widget>[
                // general info section
                ListTile(
                    title: Text(
                      'General Info',
                      style: TextStyle(
                        color: Colors.blue[800],
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'No: ${_patient!.no}',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          'Rank: ${_patient!.rank}',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          'Name: ${_patient!.name}',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          'BOD: ${_patient!.birthOfDate}',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          'Marital Status: ${_patient!.maritalStatus}',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          'Gender: ${_patient!.gander}',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    )),
                Divider(),
                // address section
                ListTile(
                    title: Text(
                      'Address',
                      style: TextStyle(
                        color: Colors.blue[800],
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Address : ${_patient!.address}',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          'Home Phone: ${_patient!.telHome}',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          'Cell Phone: ${_patient!.cellPhone}',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    )),
                Divider(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
