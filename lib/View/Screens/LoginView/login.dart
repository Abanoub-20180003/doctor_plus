import 'dart:convert';

import 'package:doctor_plus/Controller/firestore_crud.dart';
import 'package:doctor_plus/Model/doctor.dart';
import 'package:doctor_plus/View/Layout/Shop_app/ShopLayout.dart';
import 'package:doctor_plus/View/Layout/colors.dart';
import 'package:doctor_plus/View/Layout/components/components.dart';
import 'package:doctor_plus/View/Layout/components/constants.dart';
import 'package:doctor_plus/network/Local/chaced_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:doctor_plus/Controller/authentication.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:motion_toast/motion_toast.dart';

import '../../Layout/Shop_app/cubit/cubit.dart';
import '../../Layout/Shop_app/cubit/states.dart';
import 'signup.dart';

class Login extends StatefulWidget {
  const Login({
    Key? key,
  }) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Authentication auth = Authentication();
  final GlobalKey<FormState> _formKey = GlobalKey();

  // login vars
  final FocusNode _focusNodePassword = FocusNode();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  firestroeCRUD db = firestroeCRUD();

  // local login
  bool _obscurePassword = true;

  //final Box _boxLogin = Hive.box("login");
  //final Box _boxAccounts = Hive.box("accounts");

  @override
  Widget build(BuildContext context) {
    // check if local storage connected
    // if (_boxLogin.get("loginStatus") ?? false) {
    //   return Home();
    // }


    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {

          if (state is AppSuccessLoginDataState || state is AppErrorLoginDataState )
          {
            context.loaderOverlay.hide();
            if(state is AppSuccessLoginDataState )
            {
              MotionToast.success(
                title:  Text(state.msg),
                description:  Text(""),
              ).show(context);
              navigateAndFinsih(context, ShopLayout());
            }
            else if(state is AppErrorLoginDataState)
            {
              MotionToast.error(
                title:  Text(state.msg),
                description:  Text(""),
              ).show(context);

            }

          }
        },
        builder: (context, state) {
          return Scaffold(
              body: LoaderOverlay(
                useDefaultLoading: false,
                overlayWidget: loading(context),
                overlayColor: Colors.black26,
                overlayOpacity: 0.3,

                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 30,),
                        Image(image: AssetImage("Assets/images/login.png"),
                          width: 250,
                          height: 200,),

                        // const SizedBox(height: 150),
                        Text(
                          "Welcome back",
                          style: Theme
                              .of(context)
                              .textTheme
                              .headlineLarge,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Login to your account",
                          style: Theme
                              .of(context)
                              .textTheme
                              .bodyMedium,
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _controllerEmail,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            labelText: "Email",
                            prefixIcon: const Icon(Icons.person_outline),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onEditingComplete: () =>
                              _focusNodePassword.requestFocus(),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter email.";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: _controllerPassword,
                          focusNode: _focusNodePassword,
                          obscureText: _obscurePassword,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            labelText: "Password",
                            prefixIcon: const Icon(Icons.password_outlined),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _obscurePassword = !_obscurePassword;
                                  });
                                },
                                icon: _obscurePassword
                                    ? const Icon(Icons.visibility_outlined)
                                    : const Icon(
                                    Icons.visibility_off_outlined)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter password.";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 60),
                        Column(
                          children: [
                            ElevatedButton(

                              style: ElevatedButton.styleFrom(
                                backgroundColor: defaultColor,
                                minimumSize: const Size.fromHeight(50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              onPressed: () async {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  // check login
                                  context.loaderOverlay.show();
                                  ShopCubit.get(context).login(
                                      email: _controllerEmail.text,
                                      password: _controllerPassword.text);


                                }
                              },
                              child: const Text("Login", style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Don't have an account?"),
                                TextButton(
                                  onPressed: () {
                                    _formKey.currentState?.reset();

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return const Signup();
                                        },
                                      ),
                                    );
                                  },
                                  child: const Text("Signup"),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),)
          );
        });
  }

}
