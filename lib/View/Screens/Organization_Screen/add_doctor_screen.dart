



import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:doctor_plus/Model/doctor.dart';
import 'package:doctor_plus/View/Layout/components/components.dart';
import 'package:doctor_plus/View/Screens/Organization_Screen/cubit/cubit.dart';
import 'package:doctor_plus/View/Screens/Organization_Screen/cubit/states.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:toast/toast.dart';
import 'package:bottom_sheet/bottom_sheet.dart';

import '../../../Model/organization.dart';
import '../../Layout/colors.dart';
import '../../Layout/components/constants.dart';

class add_doctor_screen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();
  var person_email = TextEditingController();
  Doctor? user_search = null;
  bool? unique = null;
  // Color otherColor = Color(user_car!.data.car.paint_color);
  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return BlocConsumer<OrganizationCubit, OrgStates>(

      listener: (context, state) async {

    if (state is GetDoctorSuccessDataState) {
          context.loaderOverlay.hide();
          unique = state.unique;
          if(state.unique == false)
          {
            showToast(msg: state.msg, ToastStatus: ToastColor.ERROR);
          }
          else
            {
              user_search = state.doc;
            }
    }

      },
      builder: (context, state) {

        return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: defaultColor,
              elevation: 0,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(
                       doctor_profile!.name!,
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight
                              .bold,
                        ),
                      ),
                      Text(
                        'Add Doctor To Organization',
                        style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.normal,
                            color: thirdColor
                        ),
                      ),
                      SizedBox(height: 10,)
                    ],
                  ),
                ],
              ),

            ),

            body: SafeArea(
              child: LoaderOverlay(useDefaultLoading: false,
                  overlayColor: Colors.black,
                  overlayOpacity: 0.8,
                  overlayWidget: loading(context),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0.0, horizontal: 0),
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 15,),
                                                Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                                                  child: Column(
                                                    children: [
                                                      Image(image: AssetImage('Assets/images/add_doctor.png',),height: 200,),
                                                      SizedBox(height: 15,),
                                                      InputField(

                                                        Controller: person_email,
                                                        text: "email",
                                                        type: TextInputType.emailAddress,
                                                        validate: (value){
                                                          if(value== null || value == "")
                                                          {
                                                            return "email is required";
                                                          }
                                                          return null;
                                                        },
                                                        Icon: Icon(Icons.email_outlined),
                                                        functionSuffix: ()async{
                                                          if(formKey.currentState!.validate())
                                                              {
                                                                if(org_id != null)
                                                                  {
                                                                    context.loaderOverlay.show();
                                                                    print("search");
                                                                    user_search = await  OrganizationCubit.get(context).Get_Doctor_and_check(email: person_email.text,Org_id:org_id!);

                                                                  }

                                                         }
                                                        },
                                                        Suffixicon:Icon(Icons.search),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                            ConditionalBuilder(
                              condition: user_search != null,
                              builder: (context) =>Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: SafeArea(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 10),
                                        child: Column(

                                          children: [
                                           CircleAvatar(
                                             backgroundColor: Colors.transparent,
                                             radius: 60,
                                             child: Image(image: AssetImage("Assets/images/2.png"), fit: BoxFit.cover,),
                                           ),
                                            SizedBox(height: 10,),
                                            Text(user_search!.name!),
                                            SizedBox(height: 15,),
                                            unique ==true ? MainButton(text: "Add", function: (){
                                              if(formKey.currentState!.validate())
                                              {
                                                // context.loaderOverlay.show();
                                                // PersonCubit.get(context).add_user_to_car(user_id:User!.data.id, new_user_id: User_search!.data.id,car_id: user_car!.data.car.id);

                                                }

                                            },color: defaultColor): Container(
                                                color: Colors.red,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text("User Already Added On Organization", style: TextStyle(color: Colors.white,fontSize: 14),),
                                                )),
                                          ],
                                        ),
                                      ),



                                    ),

                                  ),
                              fallback: (context) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(child: Text('No User Found'),),
                              ),
                            ),


                          ],),
                      ),
                    ),


                  )),
            )
        );
      },
    );
  }
}
