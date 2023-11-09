

import 'package:doctor_plus/Model/doctor.dart';
import 'package:doctor_plus/View/Layout/Shop_app/cubit/cubit.dart';
import 'package:doctor_plus/View/Layout/colors.dart';
import 'package:doctor_plus/View/Layout/components/constants.dart';
import 'package:doctor_plus/View/Screens/Organization_Screen/Org_Screen.dart';
import 'package:doctor_plus/View/Screens/Organization_Screen/cubit/cubit.dart';
import 'package:flutter/material.dart';

import 'package:doctor_plus/View/Screens/LoginView/login.dart';
import 'package:doctor_plus/View/Screens/NewPatientFormView/new_patient_form.dart';
import 'package:doctor_plus/Model/patient.dart';
import 'package:doctor_plus/View/Screens/SearchView/view_search_patinets.dart';
import 'package:doctor_plus/View/Style/color_manager.dart';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';

import '../../Layout/components/components.dart';
import '../Drug_Screen/cubit/cubit.dart';
import '../SearchView/search_screen.dart';

class Home extends StatelessWidget {


  final _pageController = PageController(initialPage: 0);

  /// Controller to handle bottom nav bar and also handles initial page
  final _controller = NotchBottomBarController(index: 0);

  int maxCount = 5;



  /// widget list
  final List<Widget> bottomBarPages = [
    // home_page(context),

  ];


  Home({super.key});
  final List<Patient> patientList = [];
  final ButtonStyle homeButtonsStyle = ElevatedButton.styleFrom(
      backgroundColor: defaultColor,
      textStyle: const TextStyle(fontSize: 20),
      fixedSize: const Size(320, 60),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap);

  // local storage
  //final Box _boxLogin = Hive.box("login");

  @override
  Widget build(BuildContext context) {
    var boxs_home = [
      {"title":"Daily \nPatient","icon":"daily_tasks.png","fun":(){
        // navigateTo(context, setting_profile_screen(),);
      }},
      {"title":"Search \nPatient","icon":"search_patient.png","fun":()
      {
        Navigator.push(context,MaterialPageRoute(builder: (context) => searchScreen()));
      }},

      {"title":"Add \nPatient","icon":"add_p.png","fun":() async{


                    drugs_add_patient =  await DrugCubit.get(context).Get_Drugs_for_add();

                    organizations_add_patient = await OrganizationCubit.get(context).Get_organizations_to_add();

                    Navigator.push( context, MaterialPageRoute(builder: (context) => newPatientForm()));

        // navigateTo(context, wishlist_screen(),);
      }},

      // {"title":"info","icon":"info3.png"},
    ];
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("DoctorP+"),
      //   actions: [
      //     // log out button
      //     Padding(
      //       padding: const EdgeInsets.all(8.0),
      //       child: DecoratedBox(
      //         decoration: BoxDecoration(
      //           shape: BoxShape.circle,
      //           border: Border.all(color: Colors.white),
      //         ),
      //         child: IconButton(
      //           onPressed: () {
      //             // local storage
      //             //_boxLogin.clear();
      //             //_boxLogin.put("loginStatus", false);
      //
      //             Navigator.pushReplacement(
      //               context,
      //               MaterialPageRoute(
      //                 builder: (context) {
      //                   return const Login();
      //                 },
      //               ),
      //             );
      //           },
      //           icon: const Icon(Icons.logout_rounded),
      //         ),
      //       ),
      //     )
      //   ],
      // ),
      body:   SingleChildScrollView(
        child: Container(
          color: Colors.transparent,
          height: MediaQuery.sizeOf(context).height,
          width: MediaQuery.sizeOf(context).width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                Padding(
                  padding:  EdgeInsets.fromLTRB(0,0,0,65),
                  child: Container(
                    height: 180,
                    width: MediaQuery.sizeOf(context).width,
                    decoration: BoxDecoration(
                      color: defaultColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30.0), // Adjust the radius as needed
                        bottomRight: Radius.circular(30.0), // Adjust the radius as needed
                      ),
                    ),
                    child: Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 18.0,vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                padding: EdgeInsets.all(2), // Adjust the padding to control the border width
                                decoration: BoxDecoration(
                                  color: Colors.white, // Border color
                                  shape: BoxShape.circle, // Circular shape
                                ),
                                child: CircleAvatar(
                                  radius: 35,
                                  backgroundColor: thirdColor,
                                  backgroundImage: AssetImage('Assets/images/${doctor_profile.image}'),
                                ),
                              ),
                              SizedBox(width: 13,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Welcome 🎉",
                                    style: TextStyle(fontSize: 15,color: thirdColor),
                                  ),
                                  SizedBox(height: 3),
                                  Text(
                                    //local storage
                                    //_boxLogin.get("userName"),
                                    "Dr . ${doctor_profile.name}",
                                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: thirdColor),

                                  ),
                                ],
                              ),
                            ],
                          ),



                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                width: MediaQuery.sizeOf(context).width,
                    height: 140,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Center(
                          child: ListView.separated(
                            shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context,index)=> box(boxs_home[index]["title"],boxs_home[index]["icon"],boxs_home[index]["fun"],context),
                              separatorBuilder: (context,index)=> SizedBox(width: 10,),
                              itemCount: boxs_home.length
                          ),



                      ),
                ),
                  ),

              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 15),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Our Services", style: TextStyle(fontSize: 20, fontWeight:FontWeight.bold),),
                    SizedBox(height: 15,),
                    MaterialButton(
                      padding: EdgeInsets.zero,
                      onPressed: (){navigateTo(context, org_screen(),);},
                      child: Center(
                        child: Container(
                          height: 120,
                          width: MediaQuery.sizeOf(context).width-50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            shape: BoxShape.rectangle,
                            gradient: LinearGradient(
                              colors:
                              [
                                ShopCubit.get(context).Darktheme != true ? defaultColor :ColorManager.grey ,
                                secondColor
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              stops: [0.7, 1.0],
                            ),
                          ),
                          child: Padding(
                            padding:  EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("Organizations", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white),),
                                Row(
                                  children: [
                                    Spacer(),
                                    Image(image: AssetImage("Assets/images/hos.png"),width: 100, height: 71,)

                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      height: 120,
                      child: Row(
                        children: [
                          Expanded(
                            child: MaterialButton(
                              padding: EdgeInsets.zero,
                              onPressed: (){},
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    shape: BoxShape.rectangle,
                                    gradient: LinearGradient(
                                      colors: [
                                       ShopCubit.get(context).Darktheme != true ? defaultColor :ColorManager.grey ,
                                        secondColor
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      stops: [0.6, 1.0],
                                    ),
                                  ),
                                  child: Padding(
                                    padding:  EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text("Add Drug", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white),),
                                        Row(
                                          children: [
                                            Spacer(),
                                            Image(image: AssetImage("Assets/images/add_drug.png"),width: 70, height: 71,)

                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                            ),
                          ),
                          SizedBox(width: 15,),
                          Expanded(
                              child: MaterialButton(
                                padding: EdgeInsets.zero,
                                onPressed: (){},
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    shape: BoxShape.rectangle,
                                    gradient: LinearGradient(
                                      colors: [
                                        ShopCubit.get(context).Darktheme != true ? defaultColor :ColorManager.grey ,
                                        secondColor
                                      ]
                                      ,
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      stops: [0.6, 1.0],
                                    ),
                                  ),
                                  child: Padding(
                                    padding:  EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text("Medicial Test", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white),),
                                        Row(
                                          children: [
                                            Spacer(),
                                            Image(image: AssetImage("Assets/images/add_test.png"),width: 70, height: 71,)

                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),

                        ],
                      ),
                    ),


                  ],
                ),
              ),
            )
            // Center(
            //
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       Text(
            //         "Welcome 🎉",
            //         style: Theme.of(context).textTheme.bodyLarge,
            //       ),
            //       const SizedBox(height: 3),
            //       Text(
            //         //local storage
            //         //_boxLogin.get("userName"),
            //         "${doctor_profile.name}",
            //         style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            //
            //       ),
            //       const SizedBox(height: 15),
            //       // Search Button
            //       ElevatedButton(
            //           style: homeButtonsStyle,
            //           child: Text('Search...',style: TextStyle(color:thirdColor),),
            //           onPressed: () {
            //             Navigator.push(context,
            //                 MaterialPageRoute(builder: (context) => searchScreen()));
            //           },
            //           ),
            //       const SizedBox(height: 10),
            //       // new patinet button
            //       ElevatedButton(
            //           child: Text('Add New Patient',style: TextStyle(color:thirdColor),),
            //           style: homeButtonsStyle,
            //           onPressed: () async {
            //             // stroe retrun patient form the form
            //             newPatient = await Navigator.push(
            //                 context,
            //                 MaterialPageRoute(
            //                     builder: (context) => newPatientForm()));
            //             // store the new pafinal tient in the list of patients
            //             patientList.add(newPatient);
            //             print(patientList.length);
            //           }),
            //       const SizedBox(height: 10),
            //     ],
            //   ),
            // ),
          ],
        ),
            ),
      )
    );
  }
}
