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
//   void main() async {
//     final response = await http.get(Uri.parse('	https://plant.id/api/v2'));
//     final jsonRes = json.decode(response.body);
//
//     final suggestions = jsonRes['Suggestions'];
//     if (suggestions.isNotEmpty) {
//       final jsonPlant = suggestions[0]['Plant_name'];
//       // ...
//     } else {
//       print('No suggestions found');
//     }
//
//     // rest of your code goes here
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
//         final plantId = jsonResult['data'][0]['id'];
//         return await _getPlantDetById(plantId);
//       } else {
//         throw Exception('Failed to load plant details');
//       }
//     } catch (e) {
//       throw Exception('Failed to load plant details : $e');
//     }
//   }
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
//               child: CircularProgressIndicator(),
//             )
//           : SingleChildScrollView(
//               child: Column(
//                 children: [
//                   Image.file(_image!, fit: BoxFit.cover),
//                   if (_plantIdResponse != null)
//                     Column(
//                       children: [
//                         SizedBox(height: 20),
//                         Text(
//                           _plantIdResponse!.name,
//                           style: TextStyle(
//                               fontSize: 20, fontWeight: FontWeight.bold),
//                         ),
//                         SizedBox(height: 10),
//                         if (_plantIdResponse!.imageUrl.isNotEmpty)
//                           Image.network(_plantIdResponse!.imageUrl),
//                         SizedBox(height: 10),
//                         Text(
//                           'Plant Details :',
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold, fontSize: 18),
//                         ),
//                         SizedBox(height: 10),
//                         Text(_plantIdResponse!.wikiData ?? ''),
//                         SizedBox(height: 10),
//                         if (_plantIdResponse!.commonNames.isNotEmpty)
//                           Text(
//                               'Common Names: ${_plantIdResponse!.commonNames.join(', ')}'),
//                         SizedBox(height: 10),
//                         if (_plantIdResponse!.taxonomy != null)
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text('Taxonomy:',
//                                   style:
//                                       TextStyle(fontWeight: FontWeight.bold)),
//                               Text(
//                                   'Kingdom: ${_plantIdResponse!.taxonomy.kingdom}'),
//                               Text(
//                                   'Order: ${_plantIdResponse!.taxonomy.orders}'),
//                               Text(
//                                   'Family: ${_plantIdResponse!.taxonomy.family}'),
//                               Text(
//                                   'Genus: ${_plantIdResponse!.taxonomy.genus}'),
//                               Text(
//                                   'Species: ${_plantIdResponse!.taxonomy.species}'),
//                             ],
//                           ),
//                       ],
//                     ),
//                 ],
//               ),
//             ),
//     );
//   }
// }
