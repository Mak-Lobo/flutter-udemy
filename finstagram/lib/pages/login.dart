import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  double? width, height;
  String? email, password;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
                Text(
                  "Finstagram",
                  style: TextStyle(
                    fontSize: width! * 0.1,
                    fontWeight: FontWeight.bold,
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
      height: height! * 0.175,
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
              obscureText: true,
              decoration: const InputDecoration(
                hintText: "Enter your password",
                prefixIcon: Icon(Icons.lock),
                border: OutlineInputBorder(),
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
  void loginUser() {
    print(formKey.currentState!.validate());
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
    }
  }

//register link
  Widget registerLink() {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/register');
      },
      child: Text(
        "Don't have an account? Click here to register",
        style: TextStyle(
          decoration: TextDecoration.underline,
          color: Colors.blue[600],
        ),
      ),
    );
  }
}
