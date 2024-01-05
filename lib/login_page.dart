import 'package:flutter/material.dart';
import 'package:todo/my/my_button.dart';
import 'package:todo/my/my_textfield.dart';
import 'main.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key});

  // Todo: text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  // Todo: log user in method
  void logUserIn(BuildContext context) {
    // Add your log-in logic here
    // For now, let's just navigate to the main page when the log-in button is pressed
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MyApp()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              // todo logo
              Container(
                width: 97,
                height: 97,
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Container(
                        width: 97,
                        height: 97,
                        decoration: ShapeDecoration(
                          gradient: LinearGradient(
                            begin: Alignment(0.00, -1.00),
                            end: Alignment(0, 1),
                            colors: [
                              Color(0xFFFFE5C6),
                              Color(0xFFFFE5C6),
                              Color(0xD4D08522),
                              Color(0xAFD8973E),
                              Color(0x00CDB796),
                            ],
                          ),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(width: 1, color: Color(0xFF9C6626)),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 60),

              Text(
                'Toast - It',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF494949),
                  fontSize: 34,
                  fontFamily: 'Abel',
                  fontWeight: FontWeight.w400,
                  height: 0.03,
                ),
              ),

              const SizedBox(height: 25),
              // Todo: username textfield
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 280.0),
                    child: Text(
                      "아이디",
                      style: TextStyle(color: Colors.grey), // 회색으로 변경
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              MyTextField(
                controller: usernameController,
                hintText: "아이디를 입력해주세요",
                obscureText: false,
                width: 327,
                borderRadius: 40,
              ),

              const SizedBox(height: 10),
              // Todo: password textfield
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 268.0),
                    child: Text(
                      "비밀번호",
                      style: TextStyle(color: Colors.grey), // 회색으로 변경
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              MyTextField(
                controller: passwordController,
                hintText: "비밀번호를 입력해주세요",
                obscureText: true,
                width: 327,
                borderRadius: 40,
              ),
              const SizedBox(height: 50),

              // Todo: log in button
              GestureDetector(
                onTap: () => logUserIn(context),
                child: Container(
                  width: 327,
                  height: 52,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  decoration: ShapeDecoration(
                    color: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Log In',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'Abel',
                          fontWeight: FontWeight.w400,
                          height: 1,
                          letterSpacing: -0.41,
                        ),
                      ),
                    ],
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
