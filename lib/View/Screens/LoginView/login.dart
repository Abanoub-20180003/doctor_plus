import 'package:doctor_plus/View/Layout/colors.dart';
import 'package:flutter/material.dart';
//import 'package:hive_flutter/hive_flutter.dart';
import 'package:doctor_plus/View/Screens/HomeView/home.dart';

import '../../Layout/Shop_app/ShopLayout.dart';
import 'signup.dart';

class Login extends StatefulWidget {
  const Login({
    Key? key,
  }) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  // login vars
  final FocusNode _focusNodePassword = FocusNode();
  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

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
      appBar: AppBar(
        backgroundColor:defaultColor,
        title: Text("DoctorP+",style: TextStyle(color: Colors.white),),
        centerTitle: true,elevation: 0,
      ),
      body: Form(
        key: _formKey,
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Container(
              height: MediaQuery.sizeOf(context).height,
              width: MediaQuery.sizeOf(context).width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center ,
                children: [
                  Image(image: AssetImage('Assets/images/2.png'),width:200 ,height: 200,),
                  Text(
                    "Welcome back",
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                   SizedBox(height: 10),
                  Text(
                    "Login to your account",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                   SizedBox(height: 10),
                  TextFormField(
                    controller: _controllerUsername,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      labelText: "Username",
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
                      // if (value == null || value.isEmpty) {
                      //   return "Please enter username.";
                      // } else if (!_boxAccounts.containsKey(value)) {
                      //   return "Username is not registered.";
                      // }
                        
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
                      // if (value == null || value.isEmpty) {
                      //   return "Please enter password.";
                      // } else if (value !=
                      //     _boxAccounts.get(_controllerUsername.text)) {
                      //   return "Wrong password.";
                      // }
                        
                      return null;
                    },
                  ),
                  const SizedBox(height: 25),
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
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            // _boxLogin.put("loginStatus", true);
                            // _boxLogin.put("userName", _controllerUsername.text);
                        
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return ShopLayout();
                                },
                              ),
                            );
                          }
                        },
                        child: Text("Login", style: TextStyle(color:Colors.white),),
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
                                    return  Signup();
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
        ),
      ),
    );
  }

  @override
  void dispose() {
    _focusNodePassword.dispose();
    _controllerUsername.dispose();
    _controllerPassword.dispose();
    super.dispose();
  }
}
