
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:plants_detection_app/SigninPage.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'MainPage.dart';


class OnBoarding1 extends StatefulWidget {
  @override
  _OnBoarding1State createState() => _OnBoarding1State();
}

class _OnBoarding1State extends State<OnBoarding1> {
  int _currentpage = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      Container(
        padding: EdgeInsets.fromLTRB(16, 56, 16, 69),
        width: double.infinity,
        color: Colors.white,
        child: Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                height: 400,
                child: Center(
                  child: Lottie.network(
                      'https://assets3.lottiefiles.com/packages/lf20_M9p23l.json'),
                ),
              ),
            ),
            Text('Welcome',
              style: GoogleFonts.sacramento(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 40,
                width: 200,
                alignment: Alignment.centerLeft,
                decoration: const BoxDecoration(
                  color: Colors.deepPurpleAccent,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0),

                  ),
                ),
                child: Center(
                  child: Text("Don't worry",
                    style: GoogleFonts.alegreya(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 40,
                width: 200,
                alignment: Alignment.bottomRight,
                decoration: const BoxDecoration(
                  color: Colors.deepPurpleAccent,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                      bottomLeft: Radius.circular(20.0)

                  ),
                ),
                child: Center(
                  child: Text("We'll take care",
                    style: GoogleFonts.alegreya(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),


      Container(
        //color: Color.fromRGBO(203,253,203,1.00),
          padding: EdgeInsets.fromLTRB(16, 56, 16, 69),
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/onboard1.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Container(
                margin: EdgeInsets.fromLTRB(0, 80, 52, 32),
                child: Text("Plant Life Matters Too",
                  textAlign: TextAlign.left,
                  style: GoogleFonts.alegreya(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),

              ),

              Container(
                margin: EdgeInsets.fromLTRB(15, 0, 9, 116),
                child: Text(
                  'Take a snap of plant you want to discover and understand',
                  style: GoogleFonts.abel(
                    fontSize: 19,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),


              Container(
                margin: const EdgeInsets.fromLTRB(14, 60, 14, 71),
                width: double.infinity,
                height: 200,

                child: Stack(
                  children: [
                    Positioned(
                      left: 30,
                      top: 3,
                      child: Container(
                        height: 50,
                        width: 160,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            'Scan it',
                            style: GoogleFonts.alexandria(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              color: Colors.green.shade500,
                            ),
                          ),
                        ),
                      ),),


                    Positioned(
                      left: 160,
                      top: 0,
                      child: Container(
                        height: 160,
                        width: 160,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(80),
                          border: Border.all(color: Colors.white),
                          image: const DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                'https://images.pexels.com/photos/2453551/pexels-photo-2453551.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'
                            ),
                          ),

                        ),
                      ),

                    ),

                    Positioned(
                      left: 140,
                      top: 0,
                      bottom: 40,
                      child: SizedBox(
                        height: 180,
                        width: 200,
                        child: Lottie.network(
                            'https://assets10.lottiefiles.com/packages/lf20_erqn5wz8.json'),
                      ),
                    ),
                  ],
                ),
              ),

            ],
          )
      ),

      Container(
        //  color: Colors.blue,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/onboard5.jpg'),
            fit: BoxFit.cover,
          ),
        ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Container(
                margin: EdgeInsets.fromLTRB(10, 140, 52, 32),
                child: Text("Preventing plant diseases",
                  textAlign: TextAlign.left,
                  style: GoogleFonts.alegreya(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),

              ),

              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 145, 116),
                child: Text(
                  'Learn to care for your plants',
                  style: GoogleFonts.abel(
                    fontSize: 19,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(14, 60, 14, 71),
                width: double.infinity,
                height: 200,

                child: Stack(
                  children: [
                    Positioned(
                      left: 35,
                      top: 0,
                      child: Container(
                        height: 60,
                        width: 150,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            'Identify Disease',
                            style: GoogleFonts.alexandria(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.green.shade500,
                            ),
                          ),
                        ),
                      ),),


                    Positioned(
                      left: 160,
                      top: 10,
                      child: Container(
                        height: 160,
                        width: 160,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(80),
                          border: Border.all(color: Colors.white),
                          image: const DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/disease.jpeg')
                          ),

                        ),
                      ),

                    ),

                    Positioned(
                      left: 140,
                      top: 0,
                      bottom: 40,
                      child: SizedBox(
                        height: 180,
                        width: 200,
                        child: Lottie.network(
                            'https://assets10.lottiefiles.com/packages/lf20_erqn5wz8.json'),
                      ),
                    ),
                ],
                ),
                  ),
              SizedBox(
                height: 40,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.green.shade600),

                  ),
                  child: Text('Login',style: GoogleFonts.alexandria(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),),
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        child: SignIn(),
                        type: PageTransitionType.rightToLeft,
                      ),
                    );
                  },
                ),
              ),

            ],
          ),
      ),

      Container(
        //  color: Colors.blue,
        padding: EdgeInsets.fromLTRB(16, 56, 16, 69),
        width: double.infinity,

        ),
    ];


    return Scaffold(
      body: Stack(
        children: [
          LiquidSwipe(
            pages: pages,
            enableSideReveal: true,
            waveType: WaveType.circularReveal,
            onPageChangeCallback: (int page) {
              setState(() {
                _currentpage = page;
              });
            },
          ),
          Positioned(
            top: 60,
            left: 310,
            child: TextButton(
              onPressed: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainPage()));
              },
              style: TextButton.styleFrom(padding: EdgeInsets.zero,
              ),
              child: Text(
                'Skip',
                style: GoogleFonts.alexandria(
                  fontWeight: FontWeight.w800,
                  fontSize: 17,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 60,
            left: 0,
            right: 0,
            child: Container(
              //  color: Colors.green,
              height: 60,
              width: 250,
              child:Transform.rotate(angle: 4.7,
                child: Lottie.network('https://assets10.lottiefiles.com/packages/lf20_7cdslvth.json'),
              ),
            ),
          ),
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Center(
              child: AnimatedSmoothIndicator(
                count: 3,
                activeIndex: _currentpage,
                effect: const WormEffect(
                  activeDotColor: Colors.blueAccent,
                  dotHeight: 6.0,
                ),
              ),
            ),
          ),
        ],

      ),
    );
  }
}