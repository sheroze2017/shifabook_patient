import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SymptomsScreen extends StatefulWidget {
  @override
  _SymptomsScreenState createState() => _SymptomsScreenState();
}

class _SymptomsScreenState extends State<SymptomsScreen> {
  List<dynamic> _symptoms = [];

  Future<void> fetchSymptoms() async {
    // Replace 'YOUR_TOKEN' with your actual token
    String url =
        'https://healthservice.priaid.ch/symptoms?token=YOUR_TOKEN&language=en-gb';

    // Make the HTTP GET request
    http.Response response = await http.get(Uri.parse(url));

    // Handle the response
    if (response.statusCode == 200) {
      // Successful request
      // Parse and use the response data
      var responseData = jsonDecode(response.body);
      setState(() {
        _symptoms = responseData;
      });
    } else {
      // Error handling
      // Handle the API request error
      print('Error: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchSymptoms();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Symptoms'),
      ),
      body: ListView.builder(
        itemCount: _symptoms.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(_symptoms[index]['Name']),
          );
        },
      ),
    );
  }
}
