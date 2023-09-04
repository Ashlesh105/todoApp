import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:login/task_list_page.dart';

void main() {
  runApp(MaterialApp(
    home: AnimatedSplashScreen(
        splash: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 10,
                width: 10,
                color: Colors.amber,
              ),
              const Text(
                'TodoApp',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        nextScreen: LoginPage(),
        duration: 3000,
        splashTransition: SplashTransition.fadeTransition),
    debugShowCheckedModeBanner: false,
  ));
}

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        centerTitle: true,
        title: const Text(
          'LoginPage',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Form(
          key: _formKey,
          child: Column(
        children: [
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.person),
                  labelText: 'UserName',
                  labelStyle: const TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.amber))),
              validator: (value) {
                if (value!.isEmpty || value != 'Admin') {
                  return 'Please enter Username';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              obscureText: true,
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.password_sharp),
                  labelText: 'Password',
                  labelStyle: const TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.amber))),
              validator: (value) {
                if (value!.isEmpty || value != 'admin') {
                  return 'Please enter password';
                }
                return null;
              },
            ),
          ),
          ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const TaskList()),
                  );
                }
              },
              child: const Text('SignIn'))
        ],
      )),
    );
  }
}
