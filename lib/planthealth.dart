
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class PlantHealthInfo {
  final String plantName;
  final String cause;
  final List<String> commonNames;
  // final List<String> classification;
  // final String description;
  // final String language;
  // final String localName;
  // final TreatmentInfo? treatment;
  // final String url;

  PlantHealthInfo({
    required this.plantName,
    required this.cause,
    required this.commonNames,
    // required this.classification,
    // required this.description,
    // required this.language,
    // required this.localName,
    // required this.treatment,
    // required this.url,
  });
}


class PlantHealthPageService {
  final String _plantId;
  final String _apiKey = 'NWF5qIDaYCqvWLTAUwPtVQF2TF3wj9UZNwZ2TfOEdGUx7UNMRu';

  PlantHealthPageService(this._plantId);

  Future<String> fetchPlantName() async {
    final response = await http.get(Uri.parse(
        'https://plant.id/api/v2/plant/$_plantId&apikey=$_apiKey'));
    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);
      return jsonBody['scientific_name'];
    } else {
      throw Exception('Failed to fetch plant name.');
    }
  }

  Future<String> fetchCause() async {
    final response = await http.get(Uri.parse(
        'https://plant.id/api/v2/cause?plant=$_plantId&apiKey=$_apiKey'));
    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);
      return jsonBody['cause'];
    } else {
      throw Exception('Failed to fetch disease cause.');
    }
  }

  Future<List<String>> fetchCommonNames() async {
    final response = await http.get(Uri.parse(
        'https://plant.id/api/v2/common_names?plant=$_plantId&apiKey=$_apiKey'));
    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);
      return List<String>.from(jsonBody['common_names']);
    } else {
      throw Exception('Failed to fetch disease common names.');
    }
  }


}


class PlantHealthPage extends StatefulWidget {
  final Image image;
  final String plantId;

  const PlantHealthPage({Key? key, required this.image, required this.plantId})
      : super(key: key);

  @override
  _PlantHealthPageState createState() => _PlantHealthPageState();
}

class _PlantHealthPageState extends State<PlantHealthPage> {
  late final _plantHealthPageService = PlantHealthPageService(widget.plantId);
   late File imageFile;
  Future<PlantHealthInfo> fetchData() async {
    final plantName = await _plantHealthPageService.fetchPlantName();
    final cause = await _plantHealthPageService.fetchCause();
    final commonNames = await _plantHealthPageService.fetchCommonNames();

    return PlantHealthInfo(
      plantName: plantName,
      cause: cause,
      commonNames: commonNames,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PlantHealthInfo>(
      future: fetchData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final plantHealthInfo = snapshot.data as PlantHealthInfo?;

            if (plantHealthInfo == null) {
              return Text('No plant health information available.');
            }

            return SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image(
                      image: FileImage(imageFile),
                      width: double.infinity,
                      height: 200.0,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'Plant name: ${plantHealthInfo.plantName}',
                      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Cause: ${plantHealthInfo.cause}',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Common names: ${plantHealthInfo.commonNames.join(", ")}',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    SizedBox(height: 8.0),
                    // Add additional widgets here to display more information
                  ],
                ),
              ),
            );
          }
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}

























































//
// class PlantHealthInfo {
//   final String plantName;
//   final String cause;
//   final List<String> commonNames;
//   // final List<String> classification;
//   // final String description;
//   // final String language;
//   // final String localName;
//   // final TreatmentInfo? treatment;
//   // final String url;
//
//   PlantHealthInfo({
//     required this.plantName,
//     required this.cause,
//     required this.commonNames,
//     // required this.classification,
//     // required this.description,
//     // required this.language,
//     // required this.localName,
//     // required this.treatment,
//     // required this.url,
//   });
// }
//
// class TreatmentInfo {
//   final String? description;
//   final List<String>? methods;
//
//   TreatmentInfo({this.description, this.methods});
//
//   factory TreatmentInfo.fromJson(Map<String, dynamic> json) {
//     return TreatmentInfo(
//       description: json['description'],
//       methods: List<String>.from(json['methods']),
//     );
//   }
// }
//
// class PlantHealthPage extends StatefulWidget {
//   final Image image;
//   final String plantId;
//
//   const PlantHealthPage({super.key, required this.image, required this.plantId});
//
//   @override
//   _PlantHealthPageState createState() => _PlantHealthPageState();
// }
//
// class _PlantHealthPageState extends State<PlantHealthPage> {
//   late final _plantHealthPageService = PlantHealthPageService();
//
//   Future<PlantHealthInfo> fetchData() async {
//     final plantName = await _plantHealthPageService.fetchPlantName();
//     final cause = await _plantHealthPageService.fetchCause();
//     final commonNames = await _plantHealthPageService.fetchCommonNames();
//
//     return PlantHealthInfo(
//       plantName: plantName,
//       cause: cause,
//       commonNames: commonNames,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<PlantHealthInfo>(
//       future: fetchData(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.done) {
//           if (snapshot.hasError) {
//             return Text('Error: ${snapshot.error}');
//           } else {
//             final plantHealthInfo = snapshot.data as PlantHealthInfo?;
//
//             if (plantHealthInfo == null) {
//               return Text('No plant health information available.');
//             }
//
//             return SingleChildScrollView(
//               child: Container(
//                 padding: EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Image.file(
//                       widget.image.file,
//                       width: double.infinity,
//                       height: 200.0,
//                       fit: BoxFit.cover,
//                     ),
//                     SizedBox(height: 16.0),
//                     Text(
//                       'Plant name: ${plantHealthInfo.plantName}',
//                       style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
//                     ),
//                     SizedBox(height: 8.0),
//                     Text(
//                       'Cause: ${plantHealthInfo.cause}',
//                       style: TextStyle(fontSize: 16.0),
//                     ),
//                     SizedBox(height: 8.0),
//                     Text(
//                       'Common names: ${plantHealthInfo.commonNames.join(", ")}',
//                       style: TextStyle(fontSize: 16.0),
//                     ),
//                     SizedBox(height: 8.0),
//                     Text(
//                       'Additional information:',
//                       style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
//                     ),
//                     SizedBox(height: 8.0),
//                     Text(
//                       'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed euismod, sapien vel bibendum bibendum, velit sapien luctus sapien, vel bibendum sapien sapien vel bibendum bibendum.',
//                       style: TextStyle(fontSize: 16.0),
//                     ),
//                     SizedBox(height: 8.0),
//                     Text(
//                       'Nulla facilisi. Sed euismod, sapien vel bibendum bibendum, velit sapien luctus sapien, vel bibendum sapien sapien vel bibendum bibendum.',
//                       style: TextStyle(fontSize: 16.0),
//                     ),
//                     SizedBox(height: 8.0),
//                     // Add additional widgets here to display more information
//                   ],
//                 ),
//               ),
//             );
//           }
//         } else {
//           return CircularProgressIndicator();
//         }
//       },
//     );
//   }
// }
//
//
// class PlantHealthPageService {
//   final String _plantId;
//   final String _apiKey = 'NWF5qIDaYCqvWLTAUwPtVQF2TF3wj9UZNwZ2TfOEdGUx7UNMRu';
//
//   PlantHealthPageService(this._plantId);
//
//   Future<String> fetchPlantName() async {
//     final response = await http.get(Uri.parse(
//         'https://plant.id/api/v2/plant/$_plantId?key=$_apiKey'));
//     if (response.statusCode == 200) {
//       final jsonBody = json.decode(response.body);
//       return jsonBody['scientific_name'];
//     } else {
//       throw Exception('Failed to fetch plant name.');
//     }
//   }
//
//   Future<String> fetchCause() async {
//     final response = await http.get(Uri.parse(
//         'https://plant.id/api/v2/disease/cause/$_plantId?key=$_apiKey'));
//     if (response.statusCode == 200) {
//       final jsonBody = json.decode(response.body);
//       return jsonBody['cause'];
//     } else {
//       throw Exception('Failed to fetch disease cause.');
//     }
//   }
//
//   Future<List<String>> fetchCommonNames() async {
//     final response = await http.get(Uri.parse(
//         'https://plant.id/api/v2/disease/common_names/$_plantId?key=$_apiKey'));
//     if (response.statusCode == 200) {
//       final jsonBody = json.decode(response.body);
//       return List<String>.from(jsonBody['common_names']);
//     } else {
//       throw Exception('Failed to fetch disease common names.');
//     }
//   }
      /*
  Future<List<String>> fetchClassification() async {
    final response = await http.get(Uri.parse(
        'https://plant.id/api/v2/disease/classification/$_plantId?key=NWF5qIDaYCqvWLTAUwPtVQF2TF3wj9UZNwZ2TfOEdGUx7UNMRu'));
    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);
      return List<String>.from(jsonBody['classification']);
    } else {
      throw Exception('Failed to fetch disease classification.');
    }
  }

  Future<String> fetchDescription() async {
    final response = await http.get(Uri.parse(
        'https://plant.id/api/v2/disease/description/$_plantId?key=NWF5qIDaYCqvWLTAUwPtVQF2TF3wj9UZNwZ2TfOEdGUx7UNMRu'));
    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);
      return jsonBody['description'];
    } else {
      throw Exception('Failed to fetch disease description.');
    }
  }

  Future<String> fetchLanguage() async {
    final response = await http.get(Uri.parse(
        'https://plant.id/api/v2/disease/language/$_plantId?keyNWF5qIDaYCqvWLTAUwPtVQF2TF3wj9UZNwZ2TfOEdGUx7UNMRu'));
    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);
      return jsonBody['language'];
    } else {
      throw Exception('Failed to fetch disease language.');
    }
  }

  Future<String> fetchLocalName() async {
    final response = await http.get(Uri.parse(
        'https://plant.id/api/v2/disease/local_name/$_plantId?key=NWF5qIDaYCqvWLTAUwPtVQF2TF3wj9UZNwZ2TfOEdGUx7UNMRu'));
    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);
      return jsonBody['local_name'];
    } else {
      throw Exception('Failed to fetch disease local name.');
    }
  }

  Future<Map<String, dynamic>?> fetchTreatment() async {
    final response = await http.get(Uri.parse(
        'https://plant.id/api/v2/disease/treatment/$_plantId?key=NWF5qIDaYCqvWLTAUwPtVQF2TF3wj9UZNwZ2TfOEdGUx7UNMRu'));
    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);
      return jsonBody;
    } else {
      return null;
    }
  }

  Future<String> fetchURL() async {
    final response = await http.get(Uri.parse(
        'https://plant.id/api/v2/disease/url/$_plantId?key=NWF5qIDaYCqvWLTAUwPtVQF2TF3wj9UZNwZ2TfOEdGUx7UNMRu'));
    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);
      return jsonBody['url'];
    } else {
      throw Exception('Failed to fetch plant health page URL.');
    }
  }

       */



















//   final String _plantId;
//
//   PlantHealthPage(this._plantId);
//
//   Future<String> fetchPlantName() async {
//     final response = await http.get(Uri.parse('https://plant.id/api/plant/$plantId'));
//     if (response.statusCode == 200) {
//       final jsonBody = json.decode(response.body);
//       return jsonBody['scientific_name'];
//     } else {
//       throw Exception('Failed to fetch plant name.');
//     }
//   }
//
//   Future<String> fetchCause() async {
//     final response = await http.get(Uri.parse('https://plant.id/api/disease/cause/$_plantId'));
//     if (response.statusCode == 200) {
//       final jsonBody = json.decode(response.body);
//       return jsonBody['cause'];
//     } else {
//       throw Exception('Failed to fetch disease cause.');
//     }
//   }
//
//   Future<List<String>> fetchCommonNames() async {
//     final response = await http.get(Uri.parse('https://plant.id/api/disease/common_names/$_plantId'));
//     if (response.statusCode == 200) {
//       final jsonBody = json.decode(response.body);
//       return List<String>.from(jsonBody['common_names']);
//     } else {
//       throw Exception('Failed to fetch disease common names.');
//     }
//   }
//
//   Future<List<String>> fetchClassification() async {
//     final response = await http.get(Uri.parse('https://plant.id/api/disease/classification/$_plantId'));
//     if (response.statusCode == 200) {
//       final jsonBody = json.decode(response.body);
//       return List<String>.from(jsonBody['classification']);
//     } else {
//       throw Exception('Failed to fetch disease classification.');
//     }
//   }
//
//   Future<String> fetchDescription() async {
//     final response = await http.get(Uri.parse('https://plant.id/api/disease/description/$_plantId'));
//     if (response.statusCode == 200) {
//       final jsonBody = json.decode(response.body);
//       return jsonBody['description'];
//     } else {
//       throw Exception('Failed to fetch disease description.');
//     }
//   }
//
//   Future<String> fetchLanguage() async {
//     final response = await http.get(Uri.parse('https://plant.id/api/disease/language/$_plantId'));
//     if (response.statusCode == 200) {
//       final jsonBody = json.decode(response.body);
//       return jsonBody['language'];
//     } else {
//       throw Exception('Failed to fetch disease language.');
//     }
//   }
//
//   Future<String> fetchLocalName() async {
//     final response = await http.get(Uri.parse('https://plant.id/api/disease/local_name/$_plantId'));
//     if (response.statusCode == 200) {
//       final jsonBody = json.decode(response.body);
//       return jsonBody['local_name'];
//     } else {
//       throw Exception('Failed to fetch disease local name.');
//     }
//   }
//
//   Future<Map<String, dynamic>> fetchTreatment() async {
//     final response = await http.get(Uri.parse('https://plant.id/api/disease/treatment/$_plantId'));
//     if (response.statusCode == 200) {
//       final jsonBody = json.decode(response.body);
//       return jsonBody['treatment'];
//     } else {
//       throw Exception('Failed to fetch disease treatment.');
//     }
//   }
//
//   Future<String> fetchURL() async {
//     final response = await http.get(Uri.parse('https://plant.id/api/disease/url/$_plantId'));
//     if (response.statusCode == 200) {
//       final jsonBody = json.decode(response.body);
//       return jsonBody['url'];
//     } else {
//       throw Exception('Failed to fetch plant health page URL.');
//     }
//   }
// }























//
//
// class PlantHealthPage {
//   final String plantId;
//   final String baseUrl = 'https://trefle.io/api/v1/diseases/';
//
//   PlantHealthPage(this.plantId);
//
//   Future<Map<String, dynamic>> fetchPlantHealthPage() async {
//     final response = await http.get(Uri.parse('$baseUrl$plantId'));
//
//     if (response.statusCode == 200) {
//       return json.decode(response.body);
//     } else {
//       throw Exception('Failed to load plant health page');
//     }
//   }
//
//   Future<String> fetchPlantName() async {
//     final response = await fetchPlantHealthPage();
//
//     return response['plant']['common_name'];
//   }
//
//   Future<String> fetchCause() async {
//     final response = await fetchPlantHealthPage();
//
//     return response['disease_details']['cause'];
//   }
//
//   Future<List<String>> fetchCommonNames() async {
//     final response = await fetchPlantHealthPage();
//
//     return List<String>.from(response['disease_details']['common_names']);
//   }
//
//   Future<List<String>> fetchClassification() async {
//     final response = await fetchPlantHealthPage();
//
//     return List<String>.from(response['disease_details']['classification']);
//   }
//
//   Future<String> fetchDescription() async {
//     final response = await fetchPlantHealthPage();
//
//     return response['disease_details']['description'];
//   }
//
//   Future<String> fetchLanguage() async {
//     final response = await fetchPlantHealthPage();
//
//     return response['disease_details']['language'];
//   }
//
//   Future<String> fetchLocalName() async {
//     final response = await fetchPlantHealthPage();
//
//     return response['disease_details']['local_name'];
//   }
//
//   Future<Map<String, dynamic>> fetchTreatment() async {
//     final response = await fetchPlantHealthPage();
//
//     return response['disease_details']['treatment'];
//   }
//
//   Future<String> fetchURL() async {
//     final response = await fetchPlantHealthPage();
//
//     return response['disease_details']['url'];
//   }
// }
//
//
//
//
//
//
//
//
//
//
//
//
























// import 'dart:io';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
//
// import 'package:flutter/material.dart';
//
// class PlantIdResponse {
//   final String name;
//   final String imageUrl;
//   final String description;
//   final List<String> commonNames;
//   final String wikiData;
//   final PlantTaxonomy taxonomy;
//
//   PlantIdResponse({
//     required this.name,
//     required this.imageUrl,
//     required this.description,
//     required this.commonNames,
//     required this.wikiData,
//     required this.taxonomy,
//   });
//
//   factory PlantIdResponse.fromJson(Map<String, dynamic> json) {
//     return PlantIdResponse(
//       name: json['species_name'],
//       imageUrl: json['plant_image'],
//       description: json['species_description'],
//       commonNames: json['Common_names'],
//       wikiData: json['Wikidata'],
//       taxonomy: PlantTaxonomy(
//         kingdom: json['Taxanomy']['Kingdom'],
//         orders: json['Taxanomy']['Order'],
//         family: json['Taxanomy']['Family'],
//         genus: json['Taxanomy']['Genus'],
//         species: json['Taxanomy']['Species'],
//       ),
//     );
//   }
// }
//
// class PlantTaxonomy {
//   final String kingdom;
//   final String orders;
//   final String family;
//   final String genus;
//   final String species;
//
//   PlantTaxonomy({
//     required this.kingdom,
//     required this.orders,
//     required this.family,
//     required this.genus,
//     required this.species,
//   });
// }
//
// class CapturedImagePage extends StatefulWidget {
//   final File? image;
//   const CapturedImagePage({required this.image});
//
//   @override
//   _CapturedImagePageState createState() => _CapturedImagePageState();
// }
//
// class _CapturedImagePageState extends State<CapturedImagePage> {
//   File? _image;
//   bool _isLoading = false;
//   PlantIdResponse? _plantIdResponse;
//
//   @override
//   void initState() {
//     super.initState();
//     _image = widget.image;
//     _analyzeImage();
//   }
//
//   void _analyzeImage() async {
//     setState(() {
//       _isLoading = true;
//     });
//     if (_image != null) {
//       final apiUrl = 'https://plant.id/api/v2';
//       final request = http.MultipartRequest('POST', Uri.parse(apiUrl))
//         ..files.add(await http.MultipartFile.fromPath('images', _image!.path))
//         ..fields['organs'] = 'leaf';
//
//       final response = await request.send();
//
//       if (response.statusCode == 200) {
//         final String responseString =
//         await response.stream.transform(utf8.decoder).join();
//         final jsonRes = json.decode(responseString);
//         final jsonPlant = jsonRes['Suggestions'][0]['Plant_name'];
//
//         if (jsonPlant != null) {
//           final plantResponse = await _getPlantDet(jsonPlant);
//           setState(() {
//             _plantIdResponse = plantResponse;
//             _isLoading = false;
//           });
//         }
//       } else {
//         setState(() {
//           _isLoading = false;
//         });
//         print(response.statusCode);
//       }
//     } else {
//       setState(() {
//         _isLoading = false;
//       });
//       print('Image file is null');
//     }
//   }
//
//
//
//   void main() async {
//     final String apiKey = 'NWF5qIDaYCqvWLTAUwPtVQF2TF3wj9UZNwZ2TfOEdGUx7UNMRu';
//     final String apiUrl = 'https://plant.id/api/v2/identify';
//
//     var response = await http.post(Uri.parse(apiUrl), headers: {
//       'Content-Type': 'application/json',
//       'Api-Key': apiKey,
//     }, body: json.encode({
//       'organs': ['leaf', 'flower'],
//       'images': [
//         {
//           'data': base64Encode(await http.readBytes(Uri.parse(
//               'https://www.gardeningknowhow.com/wp-content/uploads/2019/02/leaf2.jpg'))),
//         },
//       ],
//     }));
//
//     print(response.statusCode);
//     print(response.body);
//   }
//
//   Future<PlantIdResponse> _getPlantDet(String plantName) async {
//     try {
//       final apiKey = 'NWF5qIDaYCqvWLTAUwPtVQF2TF3wj9UZNwZ2TfOEdGUx7UNMRu';
//       final apiUrl =
//           'https://plant.id/api/v2/species/search?q=$plantName&token=$apiKey';
//       final response = await http.get(Uri.parse(apiUrl));
//       if (response.statusCode == 200) {
//         final jsonResult = json.decode(response.body);
//         final plant = PlantIdResponse.fromJson(jsonResult);
//         return plant;
//       } else {
//         throw Exception('Failed to load plant details');
//       }
//     } catch (e) {
//       throw Exception('Failed to load plant details : $e');
//     }
//   }
//
//
//   Future<PlantIdResponse> _getPlantDetById(int id) async {
//     try {
//       final apiKey = 'NWF5qIDaYCqvWLTAUwPtVQF2TF3wj9UZNwZ2TfOEdGUx7UNMRu';
//       final apiUrl = 'https://plant.id/api/v2/species/$id?token=$apiKey';
//       final response = await http.get(Uri.parse(apiUrl));
//       if (response.statusCode == 200) {
//         final jsonResult = json.decode(response.body);
//         return PlantIdResponse.fromJson(jsonResult);
//       } else {
//         throw Exception('Failed to load plant details');
//       }
//     } catch (e) {
//       throw Exception('Failed to load plant details : $e');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Captured Image'),
//       ),
//       body: _isLoading
//           ? Center(
//         child: CircularProgressIndicator(),
//       )
//           : SingleChildScrollView(
//         child: Column(
//           children: [
//             Image.file(_image!, fit: BoxFit.cover),
//             if (_plantIdResponse != null)
//               Column(
//                 children: [
//                   SizedBox(height: 20),
//                   Text(
//                     _plantIdResponse!.name,
//                     style: TextStyle(
//                         fontSize: 20, fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(height: 10),
//                   if (_plantIdResponse!.imageUrl.isNotEmpty)
//                     Image.network(_plantIdResponse!.imageUrl),
//                   SizedBox(height: 10),
//                   Text(
//                     'Plant Details :',
//                     style: TextStyle(
//                         fontWeight: FontWeight.bold, fontSize: 18),
//                   ),
//                   SizedBox(height: 10),
//                   Text(_plantIdResponse!.wikiData ?? ''),
//                   SizedBox(height: 10),
//                   if (_plantIdResponse!.commonNames.isNotEmpty)
//                     Text(
//                         'Common Names: ${_plantIdResponse!.commonNames.join(', ')}'),
//                   SizedBox(height: 10),
//                   if (_plantIdResponse!.taxonomy != null)
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text('Taxonomy:',
//                             style:
//                             TextStyle(fontWeight: FontWeight.bold)),
//                         Text(
//                             'Kingdom: ${_plantIdResponse!.taxonomy.kingdom}'),
//                         Text(
//                             'Order: ${_plantIdResponse!.taxonomy.orders}'),
//                         Text(
//                             'Family: ${_plantIdResponse!.taxonomy.family}'),
//                         Text(
//                             'Genus: ${_plantIdResponse!.taxonomy.genus}'),
//                         Text(
//                             'Species: ${_plantIdResponse!.taxonomy.species}'),
//                       ],
//                     ),
//                 ],
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
