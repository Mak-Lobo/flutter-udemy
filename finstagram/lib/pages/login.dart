import 'package:finstagram/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  double? width, height;
  String? email, password;
  bool hidePassword = true;
  FirebaseService? _firebaseService;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _firebaseService = GetIt.instance.get<FirebaseService>();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: width! * 0.1),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text(
                  "Finstagram",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                loginForm(),
                loginButton(),
                registerLink(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // login button
  Widget loginButton() {
    return TextButton(
      onPressed: loginUser,
      child: const Text("Login to account"),
    );
  }

  // form
  Widget loginForm() {
    return Container(
      height: height! * 0.1875,
      padding: EdgeInsets.symmetric(horizontal: width! * 0.05),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                hintText: "Enter your email",
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(),
              ),
              onSaved: (emailData) {
                setState(() {
                  email = emailData;
                });
              },
              validator: (emailValue) {
                RegExp emailRegExp =
                    RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                // Check if the email field is empty or doesn't match the email pattern
                if (emailValue!.isEmpty || !emailRegExp.hasMatch(emailValue)) {
                  return 'Please enter a valid email address';
                }
                return null;
              },
            ),
            TextFormField(
              obscureText: hidePassword,
              decoration: InputDecoration(
                hintText: "Enter your password",
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        hidePassword = !hidePassword;
                      });
                    },
                    icon: (hidePassword)
                        ? const Icon(Icons.visibility_off)
                        : const Icon(Icons.visibility)),
                border: const OutlineInputBorder(),
              ),
              onSaved: (passData) {
                setState(() {
                  password = passData;
                });
              },
              validator: (passValue) {
                // Check if the password field is empty or doesn't match the password pattern
                if (passValue!.isEmpty || passValue.length < 5) {
                  return 'Please enter a valid password';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  // validation function
  void loginUser() async {
    print(formKey.currentState!.validate());
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      bool _submitLogin =
          await _firebaseService!.loginUser(email: email!, password: password!);
      if (_submitLogin) Navigator.popAndPushNamed(context, "/");
    }
  }

//register link
  Widget registerLink() {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/register');
      },
      child: const Text(
        "Don't have an account? Click here to register",
        style: TextStyle(
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
