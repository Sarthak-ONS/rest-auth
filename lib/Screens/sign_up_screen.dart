import 'package:flutter/material.dart';
import 'package:rest_auth/Screens/home_screen.dart';

import '../widgets/custom_text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController? _name;
  TextEditingController? _lastName;
  TextEditingController? _email;
  TextEditingController? _password;

  @override
  void initState() {
    _name = TextEditingController();
    _lastName = TextEditingController();
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff5DA3FA),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.blueAccent.withOpacity(0.5),
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: const [
              BoxShadow(
                color: Colors.white,
                blurRadius: 5.0,
                blurStyle: BlurStyle.solid,
                offset: Offset(0, 0),
              ),
            ],
          ),
          height: 500,
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          width: 500,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Create a Account',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.orangeAccent,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              CustomTextField(
                textEditingController: _name,
                label: 'Name',
              ),
              const SizedBox(
                height: 30,
              ),
              CustomTextField(
                textEditingController: _lastName,
                label: 'Last Name',
              ),
              const SizedBox(
                height: 30,
              ),
              CustomTextField(
                textEditingController: _email,
                label: 'Email',
              ),
              const SizedBox(
                height: 30,
              ),
              CustomTextField(
                textEditingController: _password,
                label: 'Password',
                isObscure: true,
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () {
                  print("Signup the user");
                },
                child: const Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                    ),
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.orangeAccent),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const HomeScreen())),
                      (route) => false);
                },
                child: const Text(
                  "Already have an account? Log In",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                    color: Colors.blueAccent,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
