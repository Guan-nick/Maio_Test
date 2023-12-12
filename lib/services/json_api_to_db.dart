import 'dart:convert';
import 'package:http/http.dart' as http;

import '../database/data/photos.dart';
import '../database/database_helper.dart';

class JsonApiToDB {
  loadJson() async {
    final url = Uri.https('jsonplaceholder.typicode.com', '/photos');

    final response = await http.get(url);

    final List<dynamic> jsonData = json.decode(response.body);

    return jsonData;
  }

  jsonToDB() async {
    List<dynamic> jsonData = await loadJson();
    for (final item in jsonData) {
      var photo = Photos(
        albumId: item['albumId'],
        id: item['id'],
        title: item['title'],
        url: item['url'],
        thumbnailUrl: item['thumbnailUrl'],
      );
      SQLHelper.createItem(photo.toMap());
    }
  }

  jsonToMemory() async {
    List<dynamic> jsonData = await loadJson();
    final List<Photos> memoryData = [];
    for (final item in jsonData) {
      memoryData.add(
        Photos(
          albumId: item['albumId'],
          id: item['id'],
          title: item['title'],
          url: item['url'],
          thumbnailUrl: item['thumbnailUrl'],
        ),
      );
    }
    return memoryData;
  }
}
