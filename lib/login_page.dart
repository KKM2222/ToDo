import 'package:flutter/material.dart';
import 'package:todo/my/my_button.dart';
import 'package:todo/my/my_textfield.dart';
import 'package:todo/square_title.dart';
import 'calendar_page.dart';
import 'main.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key});

  // Todo: text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  // Todo: sign user in method
  void signUserIn(BuildContext context) {
    // Add your sign-in logic here
    // For now, let's just navigate to the main page when the sign-in button is pressed
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MyApp()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              // todo logo
              const Icon(
                Icons.lock,
                size: 100,
              ),

              const SizedBox(height: 50),

              Text(
                "Welcome back you've been missed",
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 25),
              // Todo: username textfield
              MyTextField(
                controller: usernameController,
                hintText: "Username",
                obscureText: false,
              ),

              const SizedBox(height: 10),
              // Todo: password textfield
              MyTextField(
                controller: passwordController,
                hintText: "Password",
                obscureText: true,
              ),

              const SizedBox(height: 10),

              // Todo: forgot password?
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Forgot Password?",
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // Todo: sign in button
              MyButton(
                onTap: () => signUserIn(context),
              ),

              const SizedBox(height: 50),

              // Todo: or continue with
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        "Or continue with",
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 50),

              // Todo: google + apple sign in button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Image.asset('lib/images/google.png'),
                    iconSize: 60,
                    onPressed: () {
                      //todo 구글 로그인 동작 추가
                    },
                  ),
                  SizedBox(width: 25),
                  IconButton(
                    icon: Image.asset('lib/images/apple.png'),
                    iconSize: 60,
                    onPressed: () {
                      //todo 애플 로그인 동작 추가
                    },
                  ),
                ],
              ),

              const SizedBox(height: 50),

              // Todo: not a member? register now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Not a member?",
                    style: TextStyle(color : Colors.grey[200]),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    "Register now",
                    style: TextStyle(
                        color : Colors.blue, fontWeight: FontWeight.bold),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
