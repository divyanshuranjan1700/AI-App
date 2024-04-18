import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class ImageResponse {
  final int created;
  final List<dynamic>? data;
  const ImageResponse({
    required this.created,
    required this.data,
  });

// factory ImageResponse.fromResponse(Response response ) {
//      Map<String, dynamic> responseBody = json.decode(response.body);
//      List<dynamic> data = responseBody['data'];
//   return ImageResponse(
//     created: json['created'] as int,
//     data: json['data'] as List<dynamic>?,

//   );
// }
  factory ImageResponse.fromJson(Map<String, dynamic> json) => ImageResponse(
        created: json["created"],
        data: List<img_url>.from(json["data"].map((x) => img_url.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "created": created,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class img_url {
  img_url({
    this.url,
  });
  String? url;
  factory img_url.fromJson(Map<String, dynamic> json) => img_url(
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
      };
}
