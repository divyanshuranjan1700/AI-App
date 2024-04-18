import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:your_own_ai/openAi/ImageGeneration/image_request.dart';

import '../apikey.dart';
import 'image_response.dart';
import 'package:http/http.dart' as http;

class ImageCall {
  static final Uri imageEnd =
      Uri.parse('https://api.openai.com/v1/images/generations');
  static final Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $apiImg',
  };
  static getImage(String query) async {
    // ImageRequest request = ImageRequest(
    //     prompt: "Monkey on a ship", maxTokens: 1, size: "1024x1024");
    var response = await http.post(imageEnd,
        headers: headers,
        body: jsonEncode(
            {"prompt": query, "n": 1, "size": "1024x1024"}));
    if (response.statusCode != 200) {
      
      debugPrint("failed to load,${response.statusCode}");
      // debugPrint(data['data'][0]['url'].toString());

      // return data['data'][0]['url'];
    } else {
      var data = jsonDecode(response.body.toString());
      // print(data);
      debugPrint(data['data'][0]['url'].toString());
      return data['data'][0]['url'];
      // debugPrint("api Called");
    }
  }
}
