import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //to manage what is inside our text field we define controllers
  final GlobalKey<FormState> _signInKey = GlobalKey();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final RegExp emailValid = RegExp(
      r"^([0-9a-zA-Z]([-.\w]*[0-9a-zA-Z])*@(([0-9a-zA-Z])+([-\w]*[0-9a-zA-Z])*\.)+[a-zA-Z]{2,9})$");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Twitter Clone")),
      body: Form(
        //alows us to validate both text fields instade of doing it indivisually
        //to find this specific form we us key
        key: _signInKey,
        child: Column(
          children: [
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(hintText: "Enter an Email"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter an email";
                } else if (!emailValid.hasMatch(value)) {
                  return "Please enter a valid email";
                }
                 //Regular Expresstion
                return null;
              },
            ),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(hintText: "Enter a Password"),
              //define what is valid for password (value) -what is currently in text field
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter a password";
                } else if (value.length < 6) {
                  return "Pssword must be at least 6 characters";
                }
                return null;
              },
            ),
            ElevatedButton(
                onPressed: () {
                  if (_signInKey.currentState!.validate()) {
                    debugPrint("Email: $_emailController");
                    debugPrint("Password: $_passwordController");
                  }
                },
                child: Text("Submit"))
          ],
        ),
      ),
    );
  }
}
