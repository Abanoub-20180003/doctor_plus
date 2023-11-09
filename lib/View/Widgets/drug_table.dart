// import 'package:doctor_plus/View/Layout/colors.dart';
// import 'package:flutter/material.dart';
//
// class DrugTable extends StatefulWidget {
//   @override
//   _DrugTableState createState() => _DrugTableState();
// }
//
// class _DrugTableState extends State<DrugTable> {
//   // List to store the drug names
//   List<String> drugNames = ['Drug A', 'Drug B', 'Drug C'];
//   List<TableRow> tableRows = [];
//   var count = 0 ;
//
//   // Initialize the table with one empty row
//   @override
//   void initState() {
//     super.initState();
//     // tableRows.add(createTableRow());
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         // Table(
//         // //  border: TableBorder.(),
//         //   children: tableRows,
//         // ),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 10),
//           child: ListView.separated(
//               shrinkWrap: true,
//               scrollDirection: Axis.vertical,
//               itemBuilder: (context,index)=>  Card(
//                 elevation: 0.0,
//                 child: Column(
//                   children: [
//                     // Text(Organization_details.doc_id.toString()),
//                     // Text(Organization_details.doctors[index].id),
//                     Container(
//                       child:add_drug_item(index),
//                       // child:Organization_Doctor_cardTitle(Organization_details.doctors[index], context,Org_detail_Screen()),
//                     ),
//                     SizedBox(height: 10,),
//
//                   ],
//                 ),
//                 ),
//               separatorBuilder: (context,index)=> SizedBox(height: 5,),
//               itemCount:count,
//        ),
//         ),
//         SizedBox(height: 10,),
//
//
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             MaterialButton(
//               color: Colors.red,
//               onPressed: () {
//                 setState(() {
//                   if(count != 0 )
//                     {
//                       count = count-1;
//                     }
//                   // Add a new empty row when the plus button is pressed
//                   tableRows.removeLast();
//                 });
//               },
//               child: Icon(Icons.remove,color: Colors.white,),
//             ),
//             SizedBox(width: 10,),
//             MaterialButton(
//               color: Colors.green,
//               onPressed: () {
//                 setState(() {
//                   count = count+1;
//                   // Add a new empty row when the plus button is pressed
//                   tableRows.add(createTableRow());
//                 });
//               },
//               child: Icon(Icons.add,color: Colors.white,),
//             ),
//           ],
//         ),
//
//
//       ],
//     );
//   }
//
//   Widget add_drug_item(num)=>Padding(
//     padding: const EdgeInsets.all(12.0),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Text("Drug ${num+1}"),
//         SizedBox(height: 5,),
//         DropdownButtonFormField<String>(
//           elevation: 0,
//           hint: Text("Name"),
//           items: drugNames.map((drugName) {
//             return DropdownMenuItem<String>(
//               value: drugName,
//               child: Text(drugName),
//             );
//           }).toList(),
//           onChanged: (String? selectedDrug) {
//             // Handle selected drug
//           },
//         ),
//         SizedBox(height: 5,),
//         Row(
//           children: [
//             Expanded(
//               child: TextFormField(
//                 controller: ,
//                 decoration: InputDecoration(labelText: 'Quantity'),
//               ),
//             ),
//             SizedBox(width: 10,),
//             Expanded(
//               child: TextFormField(
//                 decoration: InputDecoration(labelText: 'Notes'),
//               ),
//             ),
//           ],
//         ),
//         SizedBox(height: 5,),
//         TextFormField(
//           decoration: InputDecoration(labelText: 'Start_at'),
//         ),
//         SizedBox(height: 5,),
//         TextFormField(
//           decoration: InputDecoration(labelText: 'end_at'),
//         ),
//       ],
//     ),
//   );
//
//
//   // Create a new row with dropdown and input fields
//   TableRow createTableRow() {
//     return TableRow(
//       children: [
//
//         Row(
//           children: [
//             DropdownButtonFormField<String>(
//               elevation: 0,
//               hint: Text("Name"),
//               items: drugNames.map((drugName) {
//                 return DropdownMenuItem<String>(
//                   value: drugName,
//                   child: Text(drugName),
//                 );
//               }).toList(),
//               onChanged: (String? selectedDrug) {
//                 // Handle selected drug
//               },
//             ),
//
//
//           ],
//         ),
//         Row(
//           children: [
//             TextFormField(
//               decoration: InputDecoration(labelText: 'Start Date'),
//             ),
//
//           ],
//         ),
//
//
//       ],
//     );
//   }
// }
