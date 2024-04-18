import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:your_own_ai/openAi/textCompletion/completion_prompts.dart';
import 'package:your_own_ai/openAi/textCompletion/completion_request.dart';
import 'package:your_own_ai/openAi/textCompletion/completion_response.dart';

import '../apikey.dart';
class CompletionsApi {
  // The completions endpoint
  static final Uri completionsEndpoint =
      Uri.parse('https://api.openai.com/v1/completions');

  // The headers for the completions endpoint, which are the same for
  // all requests
  static final Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $apiKey',
  };

  // Get the shared_preferences key from the current date under which
  // today's forecast will be stored
  // static final String key = DateFormat.yMMMd().format(DateTime.now());

  /// Returns a String with the AI-generated forecast either from
  /// shared_preferences or by getting a new one from the OpenAI API
  // static Future<String?> getForecast(int maxTokens) async {
  //   //  First check if there is already a forecast saved for today
  //   // Obtain a shared_preferences instance.
  //   final prefs = await SharedPreferences.getInstance();

  //   String? storedForecast = prefs.getString(key);

  //   // We found a stored forecast
  //   if (storedForecast != null) {
  //     debugPrint('Retrieved a weather forecast from storage');

  //     return storedForecast.trim();
  //   }
  //   // We need a new forecast
  //   else {
  //     CompletionsResponse newForecast = await getNewForecast(maxTokens);
  //     return newForecast.firstCompletion?.trim();
  //   }
  // }

  /// Gets a "weather forecast" from the OpenAI completions endpoint
  static Future getNewForecast(String text,int maxTokens) async {
    // debugPrint('Getting a new weather forecast');

    // Generate a random number for picking a random prompt
    // Random rng = Random();
    // int promptIndex = rng.nextInt(completionsPrompts.length);

    // // Get a random temperature for this request between 0.6 and 0.8
    // double temp = rng.nextInt(3) / 10 + 0.6;

    CompletionsRequest request = CompletionsRequest(
      model: "text-davinci-003",
      prompt: text,
      maxTokens: maxTokens,
      temperature: 0,
    );

    // debugPrint(
        // 'Sending OpenAI API request with prompt, "${completionsPrompts[promptIndex]}", and temperature, $temp.');

    http.Response response = await http.post(completionsEndpoint,
        headers: headers, body: request.toJson());

    debugPrint('Received OpenAI API response: ${response.body}');

    // Check to see if there was an error
    if (response.statusCode != 200) {
      // TODO handle errors
      debugPrint(
          'Failed to get a forecast with status code, ${response.statusCode}');
    }

    CompletionsResponse completionsResponse =
        CompletionsResponse.fromResponse(response);

    // Save the forecast
    // debugPrint(completionsResponse.choices![3]['text']);
    // saveForecast(completionsResponse);

    // return completionsResponse;
    return completionsResponse.choices![0]['text'];
  }

  // static Future<void> saveForecast(CompletionsResponse response) async {
  //   // Obtain a shared_preferences instance.
  //   final prefs = await SharedPreferences.getInstance();

  //   debugPrint('Saving today\'s forecast under key, $key');

  //   await prefs.setString(key, response.firstCompletion ?? "hlo");
  // }
}

  // The headers for the completions endpoint, which are the same for
  // all requests
  