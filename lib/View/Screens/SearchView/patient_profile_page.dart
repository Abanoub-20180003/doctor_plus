import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_share/flutter_share.dart';

import '../../../Model/patient.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pdf;
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

import 'package:image/image.dart' as img;
import 'dart:typed_data';

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
                    MaterialButton(
                      onPressed:(){
                        generatePDF(_patient!,context);
                    },
                      child: CircleAvatar(
                        backgroundColor: Colors.blueAccent[400],
                        minRadius: 35.0,
                        child: Icon(
                          Icons.picture_as_pdf,
                          size: 30.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    // image
                    CircleAvatar(
                        // backgroundColor: Colors.white70,
                        minRadius: 30.0,
                        child: Image(image: AssetImage('Assets/images/profile.png'),)),
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



Future<Uint8List> loadAssetImage(path) async {
  final ByteData data = await rootBundle.load(path);
  return data.buffer.asUint8List();
}




Future<void> generatePDF(patient,contexts) async {
  final pdf.Document doc = pdf.Document(
    pageMode: PdfPageMode.fullscreen,
  );

  // Load the custom font (Noto Sans in this example)
  pdf.Font notoSans = pdf.Font.ttf(await rootBundle.load("Assets/fonts/OpenSans-Regular.ttf"));
  // Load an image from assets

  final image = pdf.MemoryImage(await loadAssetImage('Assets/images/body.png'));
  final image2 = pdf.MemoryImage(await loadAssetImage('Assets/images/report.png'));

  final double screenWidthInPoints = MediaQuery.of(contexts).size.width * 1.5;

  final double Full_Screen = MediaQuery.of(contexts).size.width*2;
  double screenWidthInPoints2 = MediaQuery.of(contexts).size.width * PdfPageFormat.cm - 200;

  pdf.Widget buildTransparentImageWatermark() {
    return pdf.Expanded(

        child: pdf.Stack(
      children: [
        pdf.Center(child: pdf.Opacity(
          opacity: 1, // Set the opacity (0.0 - 1.0)
          child: pdf.Image(image),
        ),),


      ],
    ));
  }

  doc.addPage(
    pdf.Page(
      pageFormat: PdfPageFormat(
        8.0 * PdfPageFormat.inch,
        12.0 * PdfPageFormat.inch,
      ),
      build: (context) {
        return  pdf.Stack(
          children: [
            // pdf.Container(
            //
            //     child: pdf.Image(image),
            //
            // ),
        pdf.Container(

        child: pdf.Column(
            mainAxisAlignment: pdf.MainAxisAlignment.start,
            crossAxisAlignment: pdf.CrossAxisAlignment.center,
            children: [
              pdf.Row(
                  children:[
                    pdf.Expanded(
                        child: pdf.Container(
                          padding : pdf.EdgeInsets.all(10),
                          decoration: pdf.BoxDecoration(
                            color: PdfColor.fromRYB(.18, .131, .71),
                          ),
                          child: pdf.Center(child: pdf.Text("Report Patient",
                            style: pdf.TextStyle(
                              font: notoSans,
                              fontSize: 30,
                              color: PdfColors.white,
                            ),
                          ),),

                        )
                    ),
                  ]
              ),
              pdf.Row(
                  mainAxisAlignment: pdf.MainAxisAlignment.start,
                  crossAxisAlignment: pdf.CrossAxisAlignment.start,
                  children:[

                    pdf.Expanded(
                      child:   pdf.Column(children: [

                        pdf.Container(
                          width: screenWidthInPoints,
                          padding : pdf.EdgeInsets.all(5),
                          decoration: pdf.BoxDecoration(
                            color: PdfColor.fromRYB(.18, .131, .71),
                          ),
                          child: pdf.Center(child: pdf.Text("General Information",
                            style: pdf.TextStyle(
                              font: notoSans,
                              fontSize: 20,
                              color: PdfColors.white,
                            ),
                          ),),),


                        pdf.SizedBox(width: 10),
                        pdf.Row(
                            children:[

                              pdf.Expanded(
                                  child: pdf.Container(
                                    padding : pdf.EdgeInsets.all(10),

                                    child: pdf.Column(children:[
                                      pdf.Text("No",
                                        style: pdf.TextStyle(
                                            font: notoSans,
                                            fontSize: 17,
                                            // color: PdfColors.white,
                                            fontBold: pdf.Font.courierBold()
                                        ),
                                      ),
                                      pdf.Text(" ${patient!.no.toString()}",
                                        style: pdf.TextStyle(
                                          font: notoSans,
                                          fontSize: 13,
                                          // color: PdfColors.white,
                                        ),
                                      ),
                                    ]

                                    ),

                                  )
                              ),
                              pdf.Expanded(
                                  child: pdf.Container(
                                    padding : pdf.EdgeInsets.all(10),

                                    child: pdf.Column(children:[
                                      pdf.Text("Name",
                                        style: pdf.TextStyle(
                                            font: notoSans,
                                            fontSize: 17,
                                            // color: PdfColors.white,
                                            fontBold: pdf.Font.courierBold()
                                        ),
                                      ),
                                      pdf.Text(" ${patient!.name.toString()}",
                                        style: pdf.TextStyle(
                                          font: notoSans,
                                          fontSize: 13,
                                          // color: PdfColors.white,
                                        ),
                                      ),
                                    ]

                                    ),

                                  )
                              ),






                            ]
                        ),
                        pdf.SizedBox(height: 10,),
                        pdf.Row(
                            children: [
                              pdf.Expanded(
                                  child: pdf.Container(
                                    padding : pdf.EdgeInsets.all(10),
                                    child: pdf.Column(
                                        children:[
                                          pdf.Text("Gender",
                                            style: pdf.TextStyle(
                                                font: notoSans,
                                                fontSize: 17,
                                                // color: PdfColors.white,
                                                fontBold: pdf.Font.courierBold()
                                            ),
                                          ),
                                          pdf.Text(" ${patient!.gander.toString()}",
                                            style: pdf.TextStyle(
                                              font: notoSans,
                                              fontSize: 13,
                                              // color: PdfColors.white,
                                            ),
                                          ),
                                        ]
                                    ),
                                  )
                              ),
                              pdf.Expanded(
                                  child: pdf.Container(
                                    padding : pdf.EdgeInsets.all(10),
                                    child: pdf.Column(
                                        children:[
                                          pdf.Text("Rank",
                                            style: pdf.TextStyle(
                                                font: notoSans,
                                                fontSize: 17,
                                                // color: PdfColors.white,
                                                fontBold: pdf.Font.courierBold()
                                            ),
                                          ),
                                          patient!.rank == 1  ? pdf.Text(" Captian",
                                            style: pdf.TextStyle(
                                              font: notoSans,
                                              fontSize: 13,
                                              // color: PdfColors.white,
                                            ),
                                          ) : pdf.Text("Solider",
                                            style: pdf.TextStyle(
                                              font: notoSans,
                                              fontSize: 15,
                                              // color: PdfColors.white,
                                            ),
                                          ),
                                        ]
                                    ),
                                  )
                              ),


                            ]
                        ),
                        pdf.SizedBox(height: 10,),
                        pdf.Row(
                            children: [


                              pdf.Expanded(
                                  child: pdf.Container(
                                    padding : pdf.EdgeInsets.all(10),
                                    child: pdf.Column(
                                        children:[
                                          pdf.Text("Birth Date",
                                            style: pdf.TextStyle(
                                                font: notoSans,
                                                fontSize: 17,
                                                // color: PdfColors.white,
                                                fontBold: pdf.Font.courierBold()
                                            ),
                                          ),
                                          pdf.Text(" ${patient!.birthOfDate.toString()}",
                                            style: pdf.TextStyle(
                                              font: notoSans,
                                              fontSize: 13,
                                              // color: PdfColors.white,
                                            ),
                                          ),
                                        ]
                                    ),
                                  )
                              ),

                              pdf.Expanded(
                                  child: pdf.Container(
                                    padding : pdf.EdgeInsets.all(10),
                                    child: pdf.Column(
                                        children:[
                                          pdf.Text("Marital Status",
                                            style: pdf.TextStyle(
                                                font: notoSans,
                                                fontSize: 17,
                                                // color: PdfColors.white,
                                                fontBold: pdf.Font.courierBold()
                                            ),
                                          ),
                                          pdf.Text(" ${patient!.maritalStatus.toString()}",
                                            style: pdf.TextStyle(
                                              font: notoSans,
                                              fontSize: 13,
                                              // color: PdfColors.white,
                                            ),
                                          ),
                                        ]
                                    ),
                                  )
                              ),
                            ]
                        ),

                      ]),
                    ),

                    pdf.Expanded(
                        child:
                        pdf.Column(

                            mainAxisAlignment: pdf.MainAxisAlignment.start,
                            crossAxisAlignment: pdf.CrossAxisAlignment.start
                            ,
                            children: [
                          pdf.Container(
                            width: screenWidthInPoints,
                            padding : pdf.EdgeInsets.all(5),
                            decoration: pdf.BoxDecoration(
                              color: PdfColor.fromRYB(.18, .131, .71),
                            ),
                            child: pdf.Center(child: pdf.Text("Contact Information",
                              style: pdf.TextStyle(
                                font: notoSans,
                                fontSize: 20,
                                color: PdfColors.white,
                              ),
                            ),),),
                          pdf.Container(
                            padding: pdf.EdgeInsets.symmetric(horizontal: 20),
                            child: pdf.Column(
                                mainAxisAlignment: pdf.MainAxisAlignment.start,
                                crossAxisAlignment: pdf.CrossAxisAlignment.start,
                                children: [

                                  pdf.SizedBox(height: 10,),
                                  pdf.Container(
                                    padding : pdf.EdgeInsets.all(10),

                                    child: pdf.Row(children:[
                                      pdf.Text("Address :",
                                        style: pdf.TextStyle(
                                            font: notoSans,
                                            fontSize: 17,
                                            // color: PdfColors.white,
                                            fontBold: pdf.Font.courierBold()
                                        ),
                                      ),
                                      pdf.SizedBox(width: 10),
                                      pdf.Text(" ${patient!.address.toString()}",
                                        style: pdf.TextStyle(
                                          font: notoSans,
                                          fontSize: 13,
                                          // color: PdfColors.white,
                                        ),
                                      ),
                                    ]

                                    ),

                                  ),
                                  pdf.SizedBox(width: 10),
                                  pdf.Container(
                                    padding : pdf.EdgeInsets.all(10),

                                    child: pdf.Row(children:[
                                      pdf.Text("telHome :",
                                        style: pdf.TextStyle(
                                            font: notoSans,
                                            fontSize: 17,
                                            // color: PdfColors.white,
                                            fontBold: pdf.Font.courierBold()
                                        ),
                                      ),
                                      pdf.SizedBox(width: 10),
                                      pdf.Text(" ${patient!.telHome.toString()}",
                                        style: pdf.TextStyle(
                                          font: notoSans,
                                          fontSize: 13,
                                          // color: PdfColors.white,
                                        ),
                                      ),
                                    ]

                                    ),

                                  ),
                                  pdf.SizedBox(width: 10),
                                  pdf.Container(
                                    padding : pdf.EdgeInsets.all(10),
                                    child: pdf.Row(
                                        children:[
                                          pdf.Text("cellPhone :",
                                            style: pdf.TextStyle(
                                                font: notoSans,
                                                fontSize: 17,
                                                // color: PdfColors.white,
                                                fontBold: pdf.Font.courierBold()
                                            ),
                                          ),
                                          pdf.SizedBox(width: 10),
                                          pdf.Text(" ${patient!.cellPhone.toString()}",
                                            style: pdf.TextStyle(
                                              font: notoSans,
                                              fontSize: 13,
                                              // color: PdfColors.white,
                                            ),
                                          ),
                                        ]
                                    ),
                                  ),
                                  pdf.SizedBox(width: 10),
                                  pdf.Container(
                                    padding : pdf.EdgeInsets.all(10),
                                    child: pdf.Row(
                                        children:[
                                          pdf.Text("DocName :",
                                            style: pdf.TextStyle(
                                                font: notoSans,
                                                fontSize: 17,
                                                // color: PdfColors.white,
                                                fontBold: pdf.Font.courierBold()
                                            ),
                                          ),
                                          pdf.SizedBox(width: 10),
                                          pdf.Text(" ${patient!.specialHabit.toString()}",
                                            style: pdf.TextStyle(
                                              font: notoSans,
                                              fontSize: 13,
                                              // color: PdfColors.white,
                                            ),
                                          ),
                                        ]
                                    ),
                                  )

                                ]
                            ),
                          ),
                      ] ),

                    ),

                  ]
              ),
              pdf.SizedBox(height: 10,),
              pdf.Row(
                  mainAxisAlignment: pdf.MainAxisAlignment.center,
                  crossAxisAlignment: pdf.CrossAxisAlignment.center,
                children: [
                  pdf.Container(
                    padding: pdf.EdgeInsets.symmetric(horizontal: 200),
                    height: 1.3, // Adjust the height of the line as needed
                    color: PdfColors.black,
                  ),
                ]
              ),
              pdf.Image(image2, width: 400,height: 600),

              pdf.SizedBox(height: 10,),
              pdf.Text(
                'This is Patient Report From Doctor App',
                style: pdf.TextStyle(font: notoSans, fontSize: 17),
              ),
              pdf.SizedBox(height: 5,),
              pdf.Text(
                'Doctor App',
                style: pdf.TextStyle(font: notoSans, fontSize: 13),
              ),
            ]

        )

        ),

          ]
        );

      },
    ),
  );

  final directory = await getExternalStorageDirectory(); // Get the "Downloads" directory
  if (directory != null) {
    final filePath = '${directory.path}/${patient!.no.toString()+"_"+patient!.name.toString()}.pdf'; // Specify the file path in "Downloads"
    final file = File(filePath);

    try {
      await file.writeAsBytes(await doc.save());
      print('PDF saved in $filePath');

      final result = await OpenFile.open(filePath);
      if (result.type == ResultType.done) {
        print('Opened successfully');
      } else {
        print('Error opening the PDF: ${result.message}');
      }
    } catch (e) {
      print('Error saving PDF: $e');
    }
  } else {
    print('Could not access the "Downloads" directory.');
  }

}


// Future<void> generatePDF2() async {
//   final pdf.Document doc = pdf.Document();
//
//   doc.addPage(
//     pdf.Page(
//       build: (pdf.Context context) {
//         return pdf.Center(
//           child: pdf.Text('Hello, PDF!', style: pdf.TextStyle(fontSize: 30)),
//         );
//       },
//     ),
//   );
//
//   // Save the PDF to a file
//   final file = File('example.pdf');
//   await file.writeAsBytes(await doc.save());
//
//   // Close the PDF document
//   doc.save();
// }