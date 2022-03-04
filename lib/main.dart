import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'dart:async';
import 'dart:convert';

import 'widgets/content_items_list.dart';
import 'models/content_item.dart';

void main() {
  runApp(const PTBApp());
}

class PTBApp extends StatelessWidget {
  const PTBApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return MaterialApp(
      title: 'Prime Time Billboard',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PTBHomePage(title: 'Prime Time Billboard'),
    );
  }
}

class PTBHomePage extends StatelessWidget {
  const PTBHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(title),
      // ),
      body: FutureBuilder<List<ContentItem>>(
        future: fetchContentItems(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('An error has occurred!'),
            );
          } else if (snapshot.hasData) {
            return ContentItemsList(contentItems: snapshot.data!);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

Future<List<ContentItem>> fetchContentItems(http.Client client) async {
  final response = await client.get(
      Uri.parse('https://on-air-campaigns.firebaseio.com/ptb-challenge.json'));
  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parseContentItems, response.body);
}

// A function that converts a response body into a List<Photo>.
List<ContentItem> parseContentItems(String responseBody) {
  final parsed = jsonDecode(responseBody)['items'].cast<Map<String, dynamic>>();
  return parsed.map<ContentItem>((json) => ContentItem.fromJson(json)).toList();
}