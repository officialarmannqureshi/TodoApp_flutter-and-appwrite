import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:notekeep/helpers/auth_helper.dart';
import 'package:notekeep/models/login_cred_model.dart';
import 'package:notekeep/screens/home_screen.dart';
import 'package:notekeep/screens/login_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  //form key
  final _formKey = GlobalKey<FormState>();
  final LoginCredModel _loginCredModel = LoginCredModel();
  bool isloggedin = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
              child: const Text(
            'To Do App',
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
          elevation: 0,
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                //email textfield
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Email',
                  ),
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w200),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                  onSaved: (newValue) => _loginCredModel.email = newValue,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Password',
                  ),
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w200),
                  onSaved: (newValue) => _loginCredModel.password = newValue,
                  validator: (value) => value!.length < 6
                      ? 'Password must be at least 6 characters'
                      : null,
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () async {
                    // Validate returns true if the form is valid, or false
                    // otherwise.
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('creating user...')));
                      try {
                        bool result = await AuthHelper.instance
                            .signUpEmailPassword(_loginCredModel.email!,
                                _loginCredModel.password!);
                        if (result) {
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('logged in')));
                          isloggedin = true;
                          isloggedin = await AuthHelper.instance.isLoggedIn();
                          if (isloggedin) {
                            Get.to(() => const HomeScreen());
                          } else {
                            Get.to(() => const LoginScreen());
                          }
                        }
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(e.toString())));
                      }
                    }
                  },
                  child: Text(
                    'Create account',
                    style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
