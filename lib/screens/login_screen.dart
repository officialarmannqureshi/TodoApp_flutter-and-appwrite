import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notekeep/helpers/auth_helper.dart';
import 'package:notekeep/models/login_cred_model.dart';
import 'package:notekeep/screens/home_screen.dart';
import 'package:notekeep/screens/signup_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //form key
  final _formKey = GlobalKey<FormState>();
  final LoginCredModel _loginCredModel = LoginCredModel();

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
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w300),
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
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w300),
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
                          const SnackBar(content: Text('logging in...')));
                      try {
                        bool result = await AuthHelper.instance
                            .loginEmailPassword(_loginCredModel.email!,
                                _loginCredModel.password!);
                        if (result) {
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('logged in')));
                          Get.to(() => const HomeScreen());
                        }
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(e.toString())));
                      }
                    }
                  },
                  child: Text(
                    'SignIn',
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w300),
                  ),
                )

                // Row(
                //   children: [
                //     const SizedBox(
                //       height: 16,
                //     Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //       children: [
                //         ElevatedButton(
                //           ElevatedButton(style: ElevatedButton.styleFrom(
                //             backgroundColor: Colors.black,

                //           ),
                //           onPressed: (){
                //             Navigator.of(context).push(MaterialPageRoute(builder: (context)=>PhoneLoginPage(),);

                //         },
                //         child: const Text('Login with phone'),
                //           )
                //         )
                //       ],
                //     )),
                //   ],
                // ),
                ,
                Container(
                  margin: EdgeInsets.all(30),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignupScreen(),
                          ));
                    },
                    child: Text(
                      "Don't have an account? Sign up",
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w300),
                    ),
                  ),
                ),
                // Image.asset(
                //   'assets/images/appwrite.svg',
                //   height: 15,
                //   width: 20,
                // ),
                Center(
                  child: Text(
                    'Built with',
                    // style: TextStyle(
                    //   fontSize: 12,
                    //   fontWeight: FontWeight.w600,
                    //   color: Colors.pink.shade400,
                    // ),
                    style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.pink),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.asset(
                      '/images/appwrite.png',
                      height: 100,
                      width: 170,
                    ),
                    Image.asset(
                      '/images/flutter.png',
                      height: 100,
                      width: 170,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
