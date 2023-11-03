

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:doctor_plus/Model/doctor.dart';
import 'package:doctor_plus/View/Layout/Shop_app/cubit/cubit.dart';
import 'package:doctor_plus/View/Layout/colors.dart';
import 'package:doctor_plus/View/Layout/components/components.dart';
import 'package:doctor_plus/View/Layout/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';

import 'dart:io';
import 'package:toast/toast.dart';

import '../../../Layout/Shop_app/ShopLayout.dart';
import '../profile.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';



class setting_profile_screen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();
  var fname  = TextEditingController();
  var email   = TextEditingController();
  var phone = TextEditingController();
  late File file = File('');
  // var phone  = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    var cubit = ShopCubit.get(context);
    return BlocProvider (
      create: (BuildContext context)=> ProfileCubit() ,
      child: BlocConsumer<ProfileCubit, ProfileStates>(
        listener:(context,state){
          if(state is ProfileUpdateSuccessState)
          {
            context.loaderOverlay.hide();
            showToast(msg: state.msg , ToastStatus: ToastColor.SUCCESS);
            navigateAndFinsih(context, ShopLayout());
              // ChacheHelper.saveData(key: 'token', value: state.loginModel.data.token,).then((value) => navigateAndFinsih(context,ShopLayout()));
              // token = state.loginModel.data.token;

            }
          else if(state is ProfileUpdateErrorState)
            {
                context.loaderOverlay.hide();
                showToast(msg: state.msg , ToastStatus: ToastColor.ERROR);
            }
        } ,

        builder:(context,state){
          String? id =  doctor_profile.id;
          fname.text = doctor_profile.name!;
          email.text = doctor_profile.email!;

          return Scaffold(
            appBar: AppBar(
              elevation: 0,

              title:Text("Account Info"  , style: TextStyle(color:Colors.grey[300],fontWeight: FontWeight.bold,fontSize: 25 ),maxLines:  2, overflow: TextOverflow.ellipsis, ),
            ),

            body: LoaderOverlay(useDefaultLoading: false,
              overlayColor: Colors.black,
              overlayOpacity: 0.8,
              overlayWidget: loading(context),
              child:Center (
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical:20.0, horizontal: 30),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         // SizedBox(height: 15),
                         // SizedBox(height: 15),
                        //  Text(
                        //   'Pick Photo',
                        // ),
                        // Center(
                        //   child:  FormBuilderImagePicker(
                        //     onChanged: (value){
                        //       print(value);
                        //       if(value!.length > 0)
                        //       {
                        //         file = File(value[0].path);
                        //       }
                        //     },
                        //
                        //     name: 'singleAvatarPhoto',
                        //     displayCustomType: (obj) {
                        //       // obj is ApiImage ? obj.imageUrl : obj
                        //       // CarCubit.get(context).uploadFile(obj.imageUrl);
                        //     },
                        //     decoration: const InputDecoration(
                        //       labelText: 'Click To Change',
                        //     ),
                        //     transformImageWidget: (context, displayImage) => Container(
                        //       decoration: BoxDecoration(
                        //         borderRadius: BorderRadius.circular(10),
                        //         border: Border(
                        //           left: BorderSide(width: 1.0, color: defaultColor ),
                        //           top: BorderSide(width: 1.0, color: defaultColor ),
                        //           bottom: BorderSide(width: 1.0, color: defaultColor ),
                        //           right: BorderSide(width: 1.0, color: defaultColor ),
                        //         ),
                        //       ),
                        //       // shape: CircleBorder() ,
                        //       // clipBehavior: Clip.antiAliasWithSaveLayer,
                        //       child: SizedBox.expand(
                        //         child: displayImage,
                        //       ),
                        //     ),
                        //     showDecoration: false,
                        //     maxImages: 1,
                        //     previewAutoSizeWidth: false,
                        //     initialValue: [url_img_car+'users/images/'+User!.data.photo],
                        //
                        //   ),
                        // ),
                        SizedBox(height: 25),
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(vertical: 3.0),
                        //   child: Center(child:  CircleAvatar(
                        //       backgroundColor: Colors.white,
                        //
                        //     radius: 55.0,
                        //     backgroundImage: AssetImage('Assets/images/man2.jpg',)
                        //
                        //   ),),
                        // ),

               //          child: Center(child: Image(image:NetworkImage('https://logos-world.net/imageup/Jaguar/Jaguar_(8).png'), fit: BoxFit.contain,width: 120),
               // // AssetImage('Assets/images/man2.jpg',)
               //                ),
               //          ),

                        // 'Assets/images/logo.png'
                        SizedBox(height: 40,),
                        InputField (Controller:fname,
                                type: TextInputType.text,
                                validate:(value)
                                {
                                  if(value== null || value == "")
                                  {
                                    return "Name is required";
                                  }
                                  return null;
                                },
                                Suffixicon: Icon(Icons.email_outlined)  ,
                                Icon:Icon(Icons.email_outlined),
                                text: 'Name',
                              ),


                        SizedBox(height: 30,),
                        InputField (Controller:email,
                          readonly:true,
                          type: TextInputType.emailAddress,
                          validate:(value)
                          {
                            if(value== null || value == "")
                            {
                              return "Email Must Be Not Empty";
                            }
                            return null;
                          },
                          Suffixicon: Icon(Icons.email_outlined)  ,
                          Icon:Icon(Icons.email_outlined),
                          text: 'Email',
                        ),

                        SizedBox(height: 30,),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ConditionalBuilder(
                              condition: state is! ProfileLoadingUpdateDataState,
                              builder:(context)=> Center(child: Container(
                                  decoration: BoxDecoration(color: defaultColor,
                                      borderRadius: BorderRadius.circular(5)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: TextButton(onPressed: (){
                                      if(formKey.currentState!.validate())
                                      {
                                        context.loaderOverlay.show();
                                        Doctor doc = Doctor();
                                        doc.name = fname.text;
                                        ProfileCubit.get(context).update_doctor_profile(doctor: doc);
                                        }

                                    }, child: Text("Save Changes",style: TextStyle(color: Colors.white),)),
                                  ))),


                              // MainButton(function: (){
                              //
                              //   if(formKey.currentState!.validate())
                              //   {
                              //     // ProfileCubit.get(context).user_regisiter(name:nameCon.text,phone: phoneCon.text, email: emailCon.text, password: PassCon.text);
                              //     ProfileCubit.get(context).user_regisiter(email: emailCon.text);
                              //   }
                              // }, text: "Login" , color:defaultColor, ) ,
                              fallback:(context)=> Center(child: CircularProgressIndicator()),
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Center(child: Container(
                            decoration: BoxDecoration(color: Colors.red,
                                borderRadius: BorderRadius.circular(5)
                            ),
                            child:TextButton(onPressed: (){
                             // ProfileCubit.get(context).user__delete(id:id);
                              // navigateAndFinsih(context,Shop_login_screen());
                            }, child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 3.0,horizontal: 30),
                                child: Text("Delete Account ",style: TextStyle(color: Colors.white),),
                              )),
                            )),


                      ],),
                  ),
                ),
              ),
            ),


          ));
        } ,
      ),
    );
  }
}
