import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'onboarding1.dart';





class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});



  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.push(context , _createRoute());
    });
  }


  Route _createRoute() {
    //Animation of page transition
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => OnBoarding1(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = const Offset(1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.fastOutSlowIn;

        var tween = Tween(begin: begin, end: end).chain(
            CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
    Positioned.fill(
    child: Image.asset(
    'assets/newback.jpg',
    fit: BoxFit.cover,
    ),
    ),
            Container(
              margin: const EdgeInsets.only(top: 400),
              padding: const EdgeInsets.only(top: 10),
              height: 400,
              width: 400,

              child: Center(
                  child: Lottie.network(
                      'https://assets6.lottiefiles.com/packages/lf20_EY6Lg2udYI.json',
                ),
              ),
            ),
    ],
    );
  }
}


//https://assets8.lottiefiles.com/packages/lf20_dW4EWA.json