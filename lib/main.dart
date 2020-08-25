import 'package:flutter/material.dart';
import 'package:flutter_login_ui/SplashScreen.dart';
import 'package:flutter_login_ui/goodbye.dart';
import 'package:flutter_login_ui/screens/LoginPage.dart';
import 'package:flutter_login_ui/screens/student.dart';










void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MONTESSORI', 
      home: Scaffold(
        body: SplashScreen(),
      ),   
    );
  }
}



<<<<<<< HEAD
=======
    return Scaffold(
      body: SingleChildScrollView(
      child: Center(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 155.0,
                  child: Image.asset(
                    "assets/logo.png",
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 45.0),
                emailField,
                SizedBox(height: 25.0),
                passwordField,
                SizedBox(
                  height: 35.0,
                ),
                loginButon,
                SizedBox(
                  height: 15.0,
                ),
              ],
            ),
          ),
        ),
      ),
        )
    );
  }
}
>>>>>>> 1294d2fcd91c6e93af09bbda64b958aad5cb827a
