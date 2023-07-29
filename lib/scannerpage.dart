import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:plants_detection_app/planthealth.dart';

class ScannerPage extends StatefulWidget {
  @override
  _ScannerPageState createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  File? _image;
  final picker = ImagePicker();
  final plantIdController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future uploadImage() async {
    if (_image == null) {
      return;
    }


    final plantId = plantIdController.text;

    if (plantId.isEmpty) {
      setState(() {
        _errorMessage = 'Please enter a plant ID.';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final uri = Uri.parse('https://api.plant.id/v2/health_assessment');

    final request = http.MultipartRequest('POST', uri)
      ..files.add(await http.MultipartFile.fromPath('image', _image!.path))
      ..fields['data'] = json.encode({'plant_id': plantIdController.text});


    final response = await http.Response.fromStream(await request.send());
    setState(() {
      _isLoading = false;
    });
    if (response.statusCode == 200) {
     final jsonResponse = json.decode(response.body);

      if (response.statusCode == 200) {
        final String plantId = plantIdController.text;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                PlantHealthPage(
                  image: Image.file(_image!),
                  plantId: plantId,
                ),
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (context) =>
              AlertDialog(
                title: Text('Error'),
                content: Text(jsonResponse['message']),
                actions: <Widget>[
                  TextButton(
                    child: Text('OK'),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(
              title: Text('Error'),
              content: Text('Failed to upload image.'),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scanner'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          :  Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: plantIdController,
              decoration: InputDecoration(
                labelText: 'Plant ID',
              ),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: Center(
                child: _image == null
                    ? Text('No image selected.')
                    : Image(image: FileImage(_image!)),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: getImage,
            tooltip: 'Take a photo',
            child: Icon(Icons.add_a_photo),
          ),
          SizedBox(height: 16.0),
          FloatingActionButton(
            onPressed: uploadImage,
            tooltip: 'Upload image',
            child: Icon(Icons.cloud_upload),
          ),
        ],
      ),
    );
  }
}



















//
// import 'package:flutter/material.dart';
// import 'dart:io';
// import 'package:camera/camera.dart';
// import 'package:flutter/rendering.dart';
// import 'package:lottie/lottie.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:plants_detection_app/planthealth.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
//
//
//
//
//
//
// class ScannerPage extends StatefulWidget {
//   final CameraController cameraController;
//
//
//   const ScannerPage({Key? key, required this.cameraController}) : super(key: key);
//
//   @override
//   _ScannerPageState createState() => _ScannerPageState();
// }
//
// class _ScannerPageState extends State<ScannerPage> {
//   late Future<void> _initializecontrollerFuture;
//   File? _image;
//   String? _plantId;
//
//   @override
//   void initState(){
//     super.initState();
//     _initializecontrollerFuture =  widget.cameraController.initialize();
//     _checkCameraPermission();
//   }
//
//   Future<void> _checkCameraPermission() async {
//     final status = await Permission.camera.request();
//     if (!status.isGranted) {
//       final result = await Permission.camera.request();
//       if (result.isDenied || result.isPermanentlyDenied) {
//         throw Exception('Camera Permission Not Granted');
//       }
//     }
//   }
//
//   @override
//   void dispose(){
//     widget.cameraController.dispose();
//     super.dispose();
//   }
//
//   Future<void> _getImage() async {
//     try {
//       // Ensuring
//       await _initializecontrollerFuture;
//
//       //taking picture
//       final XFile image = await widget.cameraController.takePicture();
//
//       //Saving
//       setState(() {
//         _image = File(image.path);
//       });
//     } catch (e) {
//       print(e);
//     }
//   }
//
//   void _retakeImage(){
//     setState(() {
//       _image = null;
//     });
//   }
//
//
//   void _confirmImage() async {
//     if (_image == null) {
//       return;
//     }
//     try {
//       final bytes = await _image?.readAsBytes();
//       final response = await http.post(
//         Uri.parse('https://api.plant.id/v2/identify'),
//         headers: {
//           'Content-Type': 'multipart/form-data',
//           'Api-Key': '[NWF5qIDaYCqvWLTAUwPtVQF2TF3wj9UZNwZ2TfOEdGUx7UNMRu]',
//         },
//         body: {
//           'images': base64Encode(bytes as List<int>),
//           'organs': 'leaf',
//           'organs_details': 'true',
//         },
//       );
//       final data = jsonDecode(response.body);
//       final plantId = data['suggestions'][0]['plant_name'];
//       setState(() {
//         _plantId = plantId;
//       });
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => PlantHealthPage(
//             image: Image(image: FileImage(_image!)),
//             plantId: plantId,
//           ),
//         ),
//       );
//     } catch (e) {
//       print(e);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       child: Scaffold(
//           body: _image == null ?
//           FutureBuilder<void>(
//             future: _initializecontrollerFuture,
//             builder: (context,snapshot) {
//               if(snapshot.connectionState == ConnectionState.done && widget.cameraController.value.isInitialized) {
//                 if(snapshot.hasError){
//                   return Center(
//                     child: Text(
//                       'Error: ${snapshot.error}',
//                       style: TextStyle(fontSize: 16.0),
//                     ),
//                   );
//                 }
//                 return Stack(
//                   children: [
//                     Container(
//                       width: double.infinity,
//                       height: double.infinity,
//
//                       child: CameraPreview(widget.cameraController),
//
//                     ),
//
//                     Positioned(
//                             top: 200,
//                             bottom: 200,
//                             left: 20,
//                             right: 20,
//                             child: GestureDetector(
//                               onTap: _getImage,
//                               child: Container(
//                                 width: double.infinity,
//                                 height: double.infinity,
//                                 child: Lottie.network('https://assets9.lottiefiles.com/packages/lf20_yNs1ztbO06.json'),
//                                 decoration: BoxDecoration(
//                                   color: Colors.black12,
//                                   borderRadius: BorderRadius.all(
//                                     Radius.circular(50),
//                                   ),
//                                   border: Border.all(
//                                     color: Colors.green.shade600,
//                                     width: 4.0,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       );
//               } else {
//                   return Center(child: CircularProgressIndicator());
//                  }
//             },
//               ) : Stack(
//             children: [
//               Image.file(_image! , fit: BoxFit.cover),
//               Positioned(
//                 bottom: 24,
//                   left: 24,
//                   right: 24,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       IconButton(onPressed: _retakeImage,
//                           icon: Icon(Icons.restart_alt_rounded),
//                     color: Colors.white,
//                      ),
//                 IconButton(onPressed: _confirmImage,
//                   icon: Icon(Icons.check),
//                   color: Colors.white,
//                 ),
//                     ],
//                   ),
//               ),
//             ],
//           ),
//               ),
//       );
//   }
// }


