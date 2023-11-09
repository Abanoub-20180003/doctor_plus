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
//import 'package:hive_flutter/hive_flutter.dart';
import 'package:doctor_plus/View/Screens/HomeView/home.dart';
import 'package:doctor_plus/Controller/authentication.dart';

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

    return Scaffold(
      //backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(image: AssetImage("Assets/images/login.png"), width: 250, height: 200,),

              // const SizedBox(height: 150),
              Text(
                "Welcome back",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 10),
              Text(
                "Login to your account",
                style: Theme.of(context).textTheme.bodyMedium,
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
                onEditingComplete: () => _focusNodePassword.requestFocus(),
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
                          : const Icon(Icons.visibility_off_outlined)),
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
                      if (_formKey.currentState?.validate() ?? false) {
                        // check login
                        UserCredential loginResult;
                        loginResult = await auth.signInEmail(
                            _controllerEmail.text, _controllerPassword.text);
                        if (loginResult != null) {

                          print("${loginResult.user!.uid.toString()}");
                          print("===============ngma==============================");
                          await db.getDocById(doctorId: loginResult.user!.uid.toString());
                          print("===============ngma==============================");


                          Doctor doctor = Doctor();
                          doctor.id = loginResult.user!.uid;
                          doctor.name = loginResult.user!.displayName;
                          doctor.email = _controllerEmail.text;
                          doctor.password = _controllerPassword.text;
                          doctor_con = doctor;

                         doctor_profile.id =  loginResult.user!.uid;
                          final doctorJson = jsonEncode(doctor.toJson());
                          final doctor_data_Json = jsonEncode(doctor_profile.toJson());

                          ChacheHelper.saveData(key: 'Id',
                            value: loginResult.user!.uid,);

                          ChacheHelper.saveData(key: 'profile',
                            value: doctor_data_Json,);

                          ChacheHelper.saveData(key: 'token',
                            value: doctorJson,)
                              .then((value) =>
                              navigateAndFinsih(context, ShopLayout()));

                        } else {
                          // print massage to the user to change pass or email
                        }
                      }
                    },
                    child: const Text("Login" , style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),),
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
      ),
    );
  }

  @override
  void dispose() {
    _focusNodePassword.dispose();
    _controllerEmail.dispose();
    _controllerPassword.dispose();
    super.dispose();
  }
}
