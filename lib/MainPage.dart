
import 'package:camera/camera.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:plants_detection_app/scannerpage.dart';


class MainPage extends StatefulWidget{

  @override
  _MainPageState createState() => _MainPageState ();
}


class _MainPageState  extends State<MainPage>  {
  int _selectedTabIndex = 0;
  late CameraController _cameraController;

  void _onTabbed(int index) async {
    if (index == 1) {
      try {
        final cameras = await availableCameras();
        final firstCamera = cameras.first;
        _cameraController = CameraController(
          firstCamera,
          ResolutionPreset.medium,
        );
        await _cameraController.initialize();
      } catch (e) {
        print(e);
      }
    }

    setState(() {
      _selectedTabIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        backgroundColor: Colors.white70,
        child: ListView(
          children: [
            DrawerHeader(
              child: Container(
                color: Colors.green.shade900,
               // margin:  EdgeInsets.only(top: 40),
                height: double.infinity ,
                child: const ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.white24,
                    child: Icon(
                      CupertinoIcons.person,
                      color: Colors.white,
                    ),
                  ),
                  title: Text('Profile',
                    style: TextStyle(
                        color: Colors.white),
                  ),
                ),
              ),
            ),
             Divider(
              height: 20,
              color: Colors.black,
              thickness: 5,
            ),

            Column(
              children: [

                InkWell(
                  onTap: () {
                    setState(() {});
                  },
                  splashColor: Colors.lightGreenAccent.shade400,
                  child: Container(
                    width: 260,
                    decoration:  BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.all(Radius.circular(10)
                      ),
                    ),
                    child: ListTile(
                      leading:  Icon(Icons.home_outlined, size: 30,
                        color: Colors.black,),
                      title: Text(
                        'Home',
                        style: GoogleFonts.asar(
                          fontWeight: FontWeight.normal,
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),


                  ),
                ),


                const Divider(
                  height: 20,
                  indent: 20,
                  endIndent: 20,
                  color: Colors.black,
                ),

                InkWell(
                  onTap: () {
                    setState(() {
                      // _Selected = 1;
                    });
                  },
                  splashColor: Colors.lightGreenAccent.shade400,
                  child: Container(
                    width: 260,
                    decoration: const BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.all(Radius.circular(10)
                      ),
                    ),
                    child: ListTile(
                      // tileColor: _Selected == 1 ? Colors.green : Colors.green.shade900,
                      leading: const Icon(
                        Icons.history, size: 30, color: Colors.black,),
                      title: Text(
                        'History',
                        style: GoogleFonts.asar(
                          fontWeight: FontWeight.normal,
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),


                  ),
                ),

                const Divider(
                  height: 20,
                  indent: 20,
                  endIndent: 20,
                  color: Colors.black,
                ),

                InkWell(
                  onTap: () {
                    setState(() {});
                  },
                  splashColor: Colors.lightGreenAccent.shade400,
                  child: Container(
                    width: 260,
                    decoration: const BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.all(Radius.circular(10)
                      ),
                    ),
                    child: ListTile(
                      //  tileColor: _Selected == 1 ? Colors.green : Colors.green.shade900,
                      leading: const Icon(
                        Icons.save_alt, size: 30, color: Colors.black,),
                      title: Text(
                        'Saved',
                        style: GoogleFonts.asar(
                          fontWeight: FontWeight.normal,
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),


                  ),
                ),

                const Divider(
                  height: 20,
                  indent: 20,
                  endIndent: 20,
                  color: Colors.black54,
                ),

                InkWell(
                  onTap: () {
                    setState(() {

                    });
                  },
                  splashColor: Colors.lightGreenAccent.shade400,
                  child: Container(
                    width: 260,
                    decoration: const BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.all(Radius.circular(10)
                      ),
                    ),
                    child: ListTile(
                      //  tileColor: _Selected == 1 ? Colors.green : Colors.green.shade900,
                      leading: const Icon(
                        Icons.settings, size: 30, color: Colors.black,),
                      title: Text(
                        'Settings',
                        style: GoogleFonts.asar(
                          fontWeight: FontWeight.normal,
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),


                  ),
                ),

                const Divider(
                  height: 20,
                  indent: 20,
                  endIndent: 20,
                  color: Colors.black54,
                ),

                InkWell(
                  onTap: () {
                    setState(() {});
                  },
                  splashColor: Colors.lightGreenAccent.shade400,
                  child: Container(
                    width: 260,
                    decoration: const BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.all(Radius.circular(10)
                      ),
                    ),
                    child: ListTile(
                      //   tileColor: _Selected == 1 ? Colors.green : Colors.green.shade900,
                      leading: const Icon(
                        Icons.help_center, size: 30, color: Colors.black,),
                      title: Text(
                        'Help',
                        style: GoogleFonts.asar(
                          fontWeight: FontWeight.normal,
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),


                  ),
                ),

              ],
            )


          ],
        ),
      ),


      body: _getBody(_selectedTabIndex),
      bottomNavigationBar: CurvedNavigationBar(
        color: Colors.green.shade900,
        backgroundColor: Colors.white60,
        items: const [
          Icon(Icons.home_outlined, size: 30, color: Colors.white),
          Icon(Icons.camera_alt, size: 50, color: Colors.white),
          Icon(Icons.medical_information, size: 30, color: Colors.white)
        ],

        onTap: _onTabbed,
        index: _selectedTabIndex,
      ),
    );

  }

  Widget _getBody(int selectedindex) {
    switch (selectedindex) {
      case 0:
        return  SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 300,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30)),
                        // color: Colors.lightBlueAccent,
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.lightBlue.shade50, Colors.blue.shade600],
                        )
                    ),

                  ),
                  Positioned(
                    top: 100,
                    right: 10,
                    left: 40,
                    child:  SizedBox(
                      height: 200,
                      width: 100,
                      child: Lottie.network('https://assets1.lottiefiles.com/packages/lf20_kwodod4a.json'),
                    ),
                  ),

                  Positioned(
                    top: 240,
                    left: 20,
                    right: 20,
                    child: Container(
                      height: 50,
                      width: 70,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        color: Colors.white70,
                      ),
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Icon(Icons.search_rounded,size: 40,color: Colors.grey),
                      ),
                    ),
                  ),

                ],
              ),

              Padding(
                padding: const EdgeInsets.only(left: 8.0,top: 8.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: Text(
                    'Popular plants',
                    style: GoogleFonts.akayaKanadaka(
                      fontSize: 27,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,

                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 250,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 200,
                        decoration:  BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(80)),
                          border: Border.all(
                            color: Colors.green.shade100,
                            width: 8.0,
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.green,
                              blurRadius: 6.0,
                              spreadRadius: 2.0,
                            ),
                          ],
                          image: const DecorationImage(image: NetworkImage('https://www.thespruce.com/thmb/hbOpfi52WDj_MR3bTfLNSlACsIk=/750x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/GettyImages-912168376-fb70bef6e7db4af59a02f5b0f69b9366.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),

                              ),

                        ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: (){},
                        child: Container(
                          width: 200,
                          decoration:  BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(80)),
                            border: Border.all(
                              color: Colors.green.shade100,
                              width: 8.0,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.green,
                                blurRadius: 6.0,
                                spreadRadius: 2.0,
                              ),
                            ],
                            image: const DecorationImage(image: NetworkImage('https://images.pexels.com/photos/13620794/pexels-photo-13620794.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'),
                              fit: BoxFit.cover,
                            ),
                          ),

                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: (){},
                        child: Container(
                          width: 200,
                        decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(80)),
                        border: Border.all(
                        color: Colors.green.shade100,
                        width: 8.0,
                        ),
                        boxShadow: const [
                        BoxShadow(
                        color: Colors.green,
                        blurRadius: 6.0,
                        spreadRadius: 2.0,
                        ),
                        ],
                        image:  const DecorationImage(image: NetworkImage('https://m.media-amazon.com/images/I/71X0hMWUCbL._SX466_.jpg'),
                        fit: BoxFit.cover,
                        ),
                        ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: (){},
                        child: Container(
                          width: 200,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(80)),
                            border: Border.all(
                              color: Colors.green.shade100,
                              width: 8.0,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.green,
                                blurRadius: 6.0,
                                spreadRadius: 2.0,
                              ),
                            ],
                            image:  const DecorationImage(image: NetworkImage('https://img.freepik.com/free-photo/monstera-deliciosa-plant-pot_53876-133119.jpg?w=740&t=st=1682146731~exp=1682147331~hmac=2ec4665334d9021d8be4706386865410e9953efb51171b8d2dfe3e7301999c9a'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: (){},
                        child: Container(
                          width: 200,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(80)),
                            border: Border.all(
                              color: Colors.green.shade100,
                              width: 8.0,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.green,
                                blurRadius: 6.0,
                                spreadRadius: 2.0,
                              ),
                            ],
                            image:  const DecorationImage(image: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRJjEtFfdFT_ZPb_SlOTZC-D-ZEsSqLvc5doNm9awlV0g&usqp=CAU&ec=48665698'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),


                    ],
                ),
               ),



              Padding(
                padding: const EdgeInsets.only(left: 8.0,top: 8.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: Text(
                    'Seasons',
                    style: GoogleFonts.akayaKanadaka(
                      fontSize: 27,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,

                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 200,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: (){},
                        child: Container(
                          width: 180,
                          decoration:  BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(20)),
                            border: Border.all(
                              color: Colors.green.shade100,
                              width: 8.0,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.green,
                                blurRadius: 6.0,
                                spreadRadius: 2.0,
                              ),
                            ],
                            image: const DecorationImage(image: NetworkImage('https://images.immediate.co.uk/production/volatile/sites/22/2020/10/Winter-aconite-Eranthis-hyemalis-6a549eb.jpg?quality=90&resize=980,654'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: (){},
                        child: Container(
                          width: 180,
                          decoration:  BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(20)),
                            border: Border.all(
                              color: Colors.green.shade100,
                              width: 8.0,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.green,
                                blurRadius: 6.0,
                                spreadRadius: 2.0,
                              ),
                            ],
                            image: const DecorationImage(image: NetworkImage('https://floweraura-blog-img.s3.ap-south-1.amazonaws.com/flower-blogs-21/cosmos-as-summer-flowers.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: (){},
                        child: Container(
                          width: 180,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(20)),
                            border: Border.all(
                              color: Colors.green.shade100,
                              width: 8.0,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.green,
                                blurRadius: 6.0,
                                spreadRadius: 2.0,
                              ),
                            ],
                            image: const DecorationImage(image: NetworkImage('https://i.pinimg.com/564x/3b/03/c4/3b03c49b8f2d7ab2df05a72acb92695c.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: (){},
                        child: Container(
                          width: 180,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(20)),
                            border: Border.all(
                              color: Colors.green.shade100,
                              width: 8.0,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.green,
                                blurRadius: 6.0,
                                spreadRadius: 2.0,
                              ),
                            ],
                            image: const DecorationImage(image: NetworkImage('https://www.thegardenglove.com/wp-content/uploads/2016/10/Fall-garden-plants-feature.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),



              Stack(
                children: [
                  Container(
                    height: 190,
                    width: double.infinity,
                  ),
                  Positioned(
                    top: 20,
                    child: SizedBox(
                        height: 120,
                        width: 200,
                        child: Lottie.network('https://assets10.lottiefiles.com/packages/lf20_481CGPdkl2.json')),
                  ),

                  Positioned(
                    top: 60,
                    child: SizedBox(
                        height: 190,
                        width: 400,
                        child:
                        Lottie.network('https://assets9.lottiefiles.com/packages/lf20_srcvuh0h.json')),
                  ),

                ],

              ),

            ],
          ),
        );

      case 1:
        return ScannerPage(
         // cameraController: _cameraController,
        );

     /* case 2:
        return DiagnosePage(); */
      default :
        return Container();
    }
  }



  }














