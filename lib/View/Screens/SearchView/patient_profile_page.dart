import 'dart:typed_data';

import 'package:doctor_plus/View/Layout/Shop_app/cubit/cubit.dart';
import 'package:doctor_plus/View/Layout/colors.dart';
import 'package:doctor_plus/View/Widgets/patient_card_title.dart';
import 'package:expandable_tree_menu/expandable_tree_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import '../../../Model/patient.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pdf;
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';


import '../HomeView/home.dart';

class patientProfile extends StatelessWidget {
  // patient varable
  Patient? _patient;
  final GlobalKey<ExpansionTileCardState> cardDrug = GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardMedicialTest = GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardContactInformation = GlobalKey();
  patientProfile(this._patient);



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Center(
          child: Text("Profile Details" ,style: TextStyle(color: Colors.black, fontSize: 20, ),),
        ),
        actions: [
          IconButton(onPressed: (){
            generatePDF(_patient, context);
          }, icon: Icon(Icons.picture_as_pdf))
        ],
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 10),
            child: Card(
              elevation: 8,
              child: Container(

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10),),
                  color: ShopCubit.get(context).Darktheme == true ?  Colors.black12:  defaultColor,
                ),

                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row (
                    children: [
                      Container(
                        color: Colors.transparent,
                          width: MediaQuery.sizeOf(context).width*.25,
                          child: CircleAvatar(
                            backgroundColor: Colors.transparent,
                        radius: 40,
                        child: Image(image: _patient!.gander == "male"? AssetImage('Assets/images/2.png') : AssetImage('Assets/images/profile.png'),),

                      )),
                      Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                    Text("${_patient!.name}", style: TextStyle( color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                                    SizedBox(height: 5,),
                                    Text("${_patient!.age} Years Old", style: TextStyle( color: thirdColor, fontSize: 15),),
                                    SizedBox(height: 5,),
                                    // Text("Dr . ${_patient!.doc!.name}",  style: TextStyle( color: thirdColor, fontSize: 12),),
                                    SizedBox(height: 5,),

                              ],

                            ),
                          ) ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 5,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Text("Report",style: TextStyle(fontSize: 15),),
          ),
          SizedBox(height: 15,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              children: [

                Row(
                  children: [
                    Expanded(child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 25,
                          child: Padding(
                            padding:  EdgeInsets.all(8.0),
                            child: Image(image: AssetImage('Assets/images/status.png'),),
                          ),
                        ),
                        SizedBox(width: 15,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${_patient!.maritalStatus!.toUpperCase()}",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                            Text("Marital Status",style: TextStyle(fontSize: 10,color: Colors.grey,fontWeight: FontWeight.bold),)
                          ],
                        ),
                      ],
                    )),
                    Expanded(child:Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 25,
                          child: Padding(
                            padding:  EdgeInsets.all(8.0),
                            child: Image(image: AssetImage('Assets/images/planner.png'),),
                          ),
                        ),
                        SizedBox(width: 15,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${_patient!.occupation!.toUpperCase()}",style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold),),
                            Text("Daily Detection",style: TextStyle(fontSize: 10,color: Colors.grey,fontWeight: FontWeight.bold),)
                          ],
                        ),
                      ],
                    )),
                  ],
                ),
                SizedBox(height: 15,),
                Row(
                  children: [
                    Expanded(child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 25,
                          child: Padding(
                            padding:  EdgeInsets.all(6.0),
                            child: Image(image: AssetImage('Assets/images/gender.png'),),
                          ),
                        ),
                        SizedBox(width: 15,),
                        Column(
                          children: [
                            Text("${_patient!.gander!.toUpperCase()}",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                            Text("Gender",style: TextStyle(fontSize: 10,color: Colors.grey,fontWeight: FontWeight.bold),)
                          ],
                        ),
                      ],
                    )),
                    Expanded(child:Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 25,
                          child: Padding(
                            padding:  EdgeInsets.all(6.0),
                            child: Padding(
                              padding:  EdgeInsets.all(3.0),
                              child: Image(image: AssetImage('Assets/images/blood.png'),),
                            ),
                          ),
                        ),
                        SizedBox(width: 15,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${_patient!.blood!.toUpperCase()}",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                            Text("Blood Group",style: TextStyle(fontSize: 10,color: Colors.grey,fontWeight: FontWeight.bold),)
                          ],
                        ),
                      ],
                    )),
                  ],
                ),





              ],
            ),
          ),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: ExpansionTileCard(
              key: cardContactInformation,
             // expandedColor: defaultColor,
              expandedTextColor: defaultColor,
              leading: const CircleAvatar(

                  backgroundColor: Colors.transparent,
                  child: Image(image:AssetImage('Assets/images/contact.png'),width: 50,height: 50,)),
              title: const Text('Contact'),
              subtitle: const Text('Contact Information !'),
              children: <Widget>[
                const Divider(
                  thickness: 1.0,
                  height: 1.0,
                ),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 25,
                                  child: Padding(
                                    padding:  EdgeInsets.all(6.0),
                                    child: Image(image: AssetImage('Assets/images/add.png'),),
                                  ),
                                ),
                                SizedBox(width: 15,),
                                Column(
                                  children: [
                                    Text("${_patient!.address!.toUpperCase()}",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                                    Text("Address",style: TextStyle(fontSize: 10,color: Colors.grey,fontWeight: FontWeight.bold),)
                                  ],
                                ),
                              ],
                            )),

                          ],
                        ),
                        SizedBox(height: 15,),
                        Row(
                          children: [
                            Expanded(child:Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 25,
                                  child: Padding(
                                    padding:  EdgeInsets.all(6.0),
                                    child: Padding(
                                      padding:  EdgeInsets.all(3.0),
                                      child: Image(image: AssetImage('Assets/images/phone.png'),),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 15,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("${_patient!.cellPhone!.toUpperCase()}",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                                    Text("Phone",style: TextStyle(fontSize: 10,color: Colors.grey,fontWeight: FontWeight.bold),)
                                  ],
                                ),
                              ],
                            )),

                          ],
                        ),
                        SizedBox(height: 15,),
                        Row(
                        children: [
                        Expanded(child:Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 25,
                              child: Padding(
                                padding:  EdgeInsets.all(6.0),
                                child: Padding(
                                  padding:  EdgeInsets.all(3.0),
                                  child: Image(image: AssetImage('Assets/images/tele_phone.png'),),
                                ),
                              ),
                            ),
                            SizedBox(width: 15,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${_patient!.telHome!.toUpperCase()}",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                                Text("Telephone Home",style: TextStyle(fontSize: 10,color: Colors.grey,fontWeight: FontWeight.bold),)
                              ],
                            ),
                          ],
                        )),
                          ]),
                      ],
                    )

//                     Text(
//                       """Hi there, I'm a drop-in replacement for Flutter's ExpansionTile.
//
// Use me any time you think your app could benefit from being just a bit more Material.
//
// These buttons control the card above!""",
//                       style: Theme.of(context)
//                           .textTheme
//                           .bodyMedium!
//                           .copyWith(fontSize: 16),
//                     ),
                  ),
                ),

              ],
            ),
          ),
          SizedBox(height: 10,),
          Container(
            padding: EdgeInsets.only(top: 0 , left: 15, right: 15),
            child: Divider(
              thickness: 2,
              color: Colors.blueGrey[150],
            ),
          ),

          SizedBox(height: 5,),
          Padding(
            padding:EdgeInsets.symmetric(horizontal: 25.0),
            child: Text("Drugs & Medicial Test",style: TextStyle(fontSize: 15),),
          ),

          SizedBox(height: 10,),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: ExpansionTileCard(
              key: cardDrug,
              expandedTextColor: defaultColor,
              leading:  CircleAvatar(
                backgroundColor: Colors.transparent,

                  child: Image(image: AssetImage('Assets/images/drug.png'))),
              title:  Text('${_patient!.drugs!.length} Drugs'),
              subtitle: const Text('Drugs Information'),
              children: <Widget>[
                const Divider(
                  thickness: 1.0,
                  height: 1.0,
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.spaceAround,
                  buttonHeight: 52.0,
                  buttonMinWidth: 90.0,
                  children: <Widget>[
                    TextButton(
                      // style: flatButtonStyle,
                      onPressed: () {
                        //openAddDrugDialog(_patient!.drugs,context);
                        cardContactInformation.currentState?.expand();
                      },
                      child: const Column(
                        children: <Widget>[
                          Icon(Icons.add),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 2.0),
                          ),
                          Text('Add Drug'),
                        ],
                      ),
                    ),
                    TextButton(
                      //style: Bu,
                      onPressed: () {
                        cardDrug.currentState?.collapse();
                      },
                      child: const Column(
                        children: <Widget>[
                          Icon(Icons.arrow_upward),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 2.0),
                          ),
                          Text('Close'),
                        ],
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    child: ListView.builder(
                    shrinkWrap: true, // Make the ListView take the minimum height needed
                    physics: NeverScrollableScrollPhysics(), // Disable scrolling
                    itemCount: _patient!.drugs!.length,
                    itemBuilder: (context, index) {
                      return DrugcardTitle2(_patient!.drugs![index], context);
                    },
                  ),




                    // Expanded(
                    //
                    //   child:GridView.builder(
                    //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    //       crossAxisCount: 1, // Number of columns in the grid
                    //     ),
                    //     itemCount: _patient!.drugs!.length,
                    //     itemBuilder: (context, index) {
                    //       return DrugcardTitle(_patient!.drugs![index], context);
                    //     },
                    //   ),
                    //    // ListView.separated(
                    //    //    scrollDirection: Axis.vertical,
                    //    //    itemBuilder: (context,index)=> Card(
                    //    //      color: Colors.grey,
                    //    //      elevation: 8.0,
                    //    //      child: Column(
                    //    //        children: [
                    //    //          Container(
                    //    //            child: DrugcardTitle(_patient!.drugs![index], context),
                    //    //          ),
                    //    //          SizedBox(height: 10,),
                    //    //        ],
                    //    //      ),
                    //    //    ),
                    //    //    separatorBuilder: (context,index)=> SizedBox(height: 15,),
                    //    //    itemCount:_patient!.drugs!.length),
                    // )

//                     Text(
//                       """Hi there, I'm a drop-in replacement for Flutter's ExpansionTile.
//
// Use me any time you think your app could benefit from being just a bit more Material.
//
// These buttons control the card above!""",
//                       style: Theme.of(context)
//                           .textTheme
//                           .bodyMedium!
//                           .copyWith(fontSize: 16),
//                     ),
                  ),
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.spaceAround,
                  buttonHeight: 52.0,
                  buttonMinWidth: 90.0,
                  children: <Widget>[
                    // TextButton(
                    //   // style: flatButtonStyle,
                    //   onPressed: () {
                    //     cardA.currentState?.expand();
                    //   },
                    //   child: const Column(
                    //     children: <Widget>[
                    //       Icon(Icons.arrow_downward),
                    //       Padding(
                    //         padding: EdgeInsets.symmetric(vertical: 2.0),
                    //       ),
                    //       Text('Open'),
                    //     ],
                    //   ),
                    // ),
                    // TextButton(
                    //   //style: Bu,
                    //   onPressed: () {
                    //     cardA.currentState?.collapse();
                    //   },
                    //   child: const Column(
                    //     children: <Widget>[
                    //       Icon(Icons.arrow_upward),
                    //       Padding(
                    //         padding: EdgeInsets.symmetric(vertical: 2.0),
                    //       ),
                    //       Text('Close'),
                    //     ],
                    //   ),
                    // ),
                    // TextButton(
                    //   //style: flatButtonStyle,
                    //   onPressed: () {
                    //     cardA.currentState?.toggleExpansion();
                    //   },
                    //   child: const Column(
                    //     children: <Widget>[
                    //       Icon(Icons.swap_vert),
                    //       Padding(
                    //         padding: EdgeInsets.symmetric(vertical: 2.0),
                    //       ),
                    //       Text('Toggle'),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 10,),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: ExpansionTileCard(
              key: cardMedicialTest,
              expandedTextColor: Colors.red,
              leading: const CircleAvatar(child: Text('B')),
              title: const Text('Medicial Tests'),
              subtitle: const Text('Medicial Tests Information'),
              children: <Widget>[
                const Divider(
                  thickness: 1.0,
                  height: 1.0,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    child: Text(
                      """Hi there, I'm a drop-in replacement for Flutter's ExpansionTile.

Use me any time you think your app could benefit from being just a bit more Material.

These buttons control the card above!""",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontSize: 16),
                    ),
                  ),
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.spaceAround,
                  buttonHeight: 52.0,
                  buttonMinWidth: 90.0,
                  children: <Widget>[
                    // TextButton(
                    //   // style: flatButtonStyle,
                    //   onPressed: () {
                    //     cardA.currentState?.expand();
                    //   },
                    //   child: const Column(
                    //     children: <Widget>[
                    //       Icon(Icons.arrow_downward),
                    //       Padding(
                    //         padding: EdgeInsets.symmetric(vertical: 2.0),
                    //       ),
                    //       Text('Open'),
                    //     ],
                    //   ),
                    // ),
                    // TextButton(
                    //   //style: Bu,
                    //   onPressed: () {
                    //     cardA.currentState?.collapse();
                    //   },
                    //   child: const Column(
                    //     children: <Widget>[
                    //       Icon(Icons.arrow_upward),
                    //       Padding(
                    //         padding: EdgeInsets.symmetric(vertical: 2.0),
                    //       ),
                    //       Text('Close'),
                    //     ],
                    //   ),
                    // ),
                    // TextButton(
                    //   //style: flatButtonStyle,
                    //   onPressed: () {
                    //     cardA.currentState?.toggleExpansion();
                    //   },
                    //   child: const Column(
                    //     children: <Widget>[
                    //       Icon(Icons.swap_vert),
                    //       Padding(
                    //         padding: EdgeInsets.symmetric(vertical: 2.0),
                    //       ),
                    //       Text('Toggle'),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 30,),

//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 12.0),
//             child: ExpansionTileCard(
//               key: cardB,
//               expandedTextColor: Colors.red,
//               leading: const CircleAvatar(child: Text('B')),
//               title: const Text('Tap me!'),
//               subtitle: const Text('I expand, too!'),
//               children: <Widget>[
//                 const Divider(
//                   thickness: 1.0,
//                   height: 1.0,
//                 ),
//                 Align(
//                   alignment: Alignment.centerLeft,
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 16.0,
//                       vertical: 8.0,
//                     ),
//                     child: Text(
//                       """Hi there, I'm a drop-in replacement for Flutter's ExpansionTile.
//
// Use me any time you think your app could benefit from being just a bit more Material.
//
// These buttons control the card above!""",
//                       style: Theme.of(context)
//                           .textTheme
//                           .bodyMedium!
//                           .copyWith(fontSize: 16),
//                     ),
//                   ),
//                 ),
//                 ButtonBar(
//                   alignment: MainAxisAlignment.spaceAround,
//                   buttonHeight: 52.0,
//                   buttonMinWidth: 90.0,
//                   children: <Widget>[
//                     TextButton(
//                       // style: flatButtonStyle,
//                       onPressed: () {
//                         cardA.currentState?.expand();
//                       },
//                       child: const Column(
//                         children: <Widget>[
//                           Icon(Icons.arrow_downward),
//                           Padding(
//                             padding: EdgeInsets.symmetric(vertical: 2.0),
//                           ),
//                           Text('Open'),
//                         ],
//                       ),
//                     ),
//                     TextButton(
//                       //style: Bu,
//                       onPressed: () {
//                         cardA.currentState?.collapse();
//                       },
//                       child: const Column(
//                         children: <Widget>[
//                           Icon(Icons.arrow_upward),
//                           Padding(
//                             padding: EdgeInsets.symmetric(vertical: 2.0),
//                           ),
//                           Text('Close'),
//                         ],
//                       ),
//                     ),
//                     TextButton(
//                       //style: flatButtonStyle,
//                       onPressed: () {
//                         cardA.currentState?.toggleExpansion();
//                       },
//                       child: const Column(
//                         children: <Widget>[
//                           Icon(Icons.swap_vert),
//                           Padding(
//                             padding: EdgeInsets.symmetric(vertical: 2.0),
//                           ),
//                           Text('Toggle'),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),

























          // Padding(
          //   padding:EdgeInsets.symmetric(horizontal: 15.0),
          //   child: ExpandableTree(
          //     closedTwistyColor: defaultColor,
          //     nodes: [
          //       TreeNode('Drugs',
          //         subNodes: [
          //           TreeNode('CatA first item'),
          //           TreeNode('CatA second item'),
          //         ],
          //       ),
          //       // TreeNode('Category B',
          //       //   subNodes: [
          //       //     TreeNode('Cat B first item'),
          //       //     TreeNode('Cat B sub-category 1',
          //       //       subNodes: [
          //       //         TreeNode('Cat B1 first item'),
          //       //         TreeNode('Cat B1 second item'),
          //       //         TreeNode('Cat B1 third item'),
          //       //         TreeNode('Cat B1 final item'),
          //       //       ],
          //       //     ),
          //       //   ],
          //       // ),
          //     ],
          //     nodeBuilder: (context, nodeValue) => Card(
          //      // color: defaultColor,
          //       child: Padding(
          //         padding: const EdgeInsets.all(8.0),
          //         child: Text(nodeValue.toString(),style: TextStyle(fontSize: 15),),
          //       ),
          //     ),
          //    // onSelect: (node) => _nodeSelected(context, node),
          //   ),
          // )





          // Container(
          //   height: 250,
          //   decoration: BoxDecoration(
          //     gradient: LinearGradient(
          //       colors: [Colors.blue, Colors.blue.shade300],
          //       begin: Alignment.centerLeft,
          //       end: Alignment.centerRight,
          //       stops: [0.5, 0.9],
          //     ),
          //   ),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: <Widget>[
          //       // pdf + image + ?
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceAround,
          //         children: <Widget>[
          //           // pdf icon
          //           MaterialButton(
          //             onPressed:(){
          //               generatePDF(_patient!,context);
          //           },
          //             child: CircleAvatar(
          //               backgroundColor: Colors.blueAccent[400],
          //               minRadius: 35.0,
          //               child: Icon(
          //                 Icons.picture_as_pdf,
          //                 size: 30.0,
          //                 color: Colors.white,
          //               ),
          //             ),
          //           ),
          //           // image
          //           CircleAvatar(
          //               // backgroundColor: Colors.white70,
          //               minRadius: 30.0,
          //               child: Image(image: AssetImage('Assets/images/profile.png'),)),
          //           // edit profile
          //           CircleAvatar(
          //             backgroundColor: Colors.blueAccent[400],
          //             minRadius: 35.0,
          //             child: Icon(
          //               Icons.edit,
          //               size: 30.0,
          //             ),
          //           ),
          //         ],
          //       ),
          //       SizedBox(
          //         height: 10,
          //       ),
          //       //  the main name viwer
          //       Text(
          //         _patient!.name.toString(),
          //         style: TextStyle(
          //           fontSize: 35,
          //           fontWeight: FontWeight.bold,
          //           color: Colors.white,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // Container(
          //   child: Column(
          //     children: <Widget>[
          //       // general info section
          //       ListTile(
          //           title: Text(
          //             'General Info',
          //             style: TextStyle(
          //               color: Colors.blue[800],
          //               fontSize: 20,
          //               fontWeight: FontWeight.bold,
          //             ),
          //           ),
          //           subtitle: Column(
          //             mainAxisAlignment: MainAxisAlignment.start,
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               Text(
          //                 'No: ${_patient!.no}',
          //                 style: TextStyle(
          //                   fontSize: 18,
          //                 ),
          //               ),
          //               Text(
          //                 'Rank: ${_patient!.rank}',
          //                 style: TextStyle(
          //                   fontSize: 18,
          //                 ),
          //               ),
          //               Text(
          //                 'Name: ${_patient!.name}',
          //                 style: TextStyle(
          //                   fontSize: 18,
          //                 ),
          //               ),
          //               Text(
          //                 'BOD: ${_patient!.birthOfDate}',
          //                 style: TextStyle(
          //                   fontSize: 18,
          //                 ),
          //               ),
          //               Text(
          //                 'Marital Status: ${_patient!.maritalStatus}',
          //                 style: TextStyle(
          //                   fontSize: 18,
          //                 ),
          //               ),
          //               Text(
          //                 'Gender: ${_patient!.gander}',
          //                 style: TextStyle(
          //                   fontSize: 18,
          //                 ),
          //               ),
          //             ],
          //           )),
          //       Divider(),
          //       // address section
          //       ListTile(
          //           title: Text(
          //             'Address',
          //             style: TextStyle(
          //               color: Colors.blue[800],
          //               fontSize: 20,
          //               fontWeight: FontWeight.bold,
          //             ),
          //           ),
          //           subtitle: Column(
          //             mainAxisAlignment: MainAxisAlignment.start,
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               Text(
          //                 'Address : ${_patient!.address}',
          //                 style: TextStyle(
          //                   fontSize: 18,
          //                 ),
          //               ),
          //               Text(
          //                 'Home Phone: ${_patient!.telHome}',
          //                 style: TextStyle(
          //                   fontSize: 18,
          //                 ),
          //               ),
          //               Text(
          //                 'Cell Phone: ${_patient!.cellPhone}',
          //                 style: TextStyle(
          //                   fontSize: 18,
          //                 ),
          //               ),
          //             ],
          //           )),
          //       Divider(),
          //     ],
          //   ),
          // )

        ],
      ),
    );
  }
}



void _nodeSelected(context, nodeValue) {
  final route =
  MaterialPageRoute(builder: (context) =>Home());
 // DetailPage(value: nodeValue));
  Navigator.of(context).push(route);
}

/// Build the Node widget at a specific node in the tree
Widget _nodeBuilder(context, nodeValue) {
  return Card(
      margin: EdgeInsets.symmetric(vertical: 1),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(nodeValue.toString()),
      ));
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

