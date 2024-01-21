import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:responsive_sizer/responsive_sizer.dart';

class FitnessArticlesPage extends StatefulWidget {
  @override
  _FitnessArticlesPageState createState() => _FitnessArticlesPageState();
}

class _FitnessArticlesPageState extends State<FitnessArticlesPage> {
  List<dynamic> articles = [];

  @override
  void initState() {
    super.initState();
    fetchFitnessArticles();
  }

  Future<void> fetchFitnessArticles() async {
    final String apiKey =
        'YOUR_API_KEY'; // Replace with your New York Times API key
    final String apiUrl =
        'https://api.nytimes.com/svc/search/v2/articlesearch.json?q=Health&api-key=ZtvDAM3BI0y0JufFajLhlCOUhGmr7004';

    try {
      final response = await http.get(Uri.parse(apiUrl));
      final jsonData = json.decode(response.body);
      print(jsonData);
      if (jsonData['status'] == 'OK') {
        setState(() {
          articles = jsonData['response']['docs'];
        });
      }
    } catch (error) {
      print('Error fetching fitness articles: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black87),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              Get.to(FitnessArticlesPage());
              // Open user profile page
              // Add your navigation logic here
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: articles.length,
        itemBuilder: (BuildContext context, int index) {
          final article = articles[index];
          final headline = article['headline']['main'];
          final snippet = article['snippet'];
          final link = article['web_url'];
          print(link);
          return InkWell(
            onTap: () {
              print(link);
              //  InAppWebViewScreen(url: link);
            },
            child: Container(
              height: 25.h,
              margin: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.grey[200],
              ),
              child: ListTile(
                // leading: Icon(Icons.article_outlined, color: Colors.blue),
                leading: Image.network(
                    'data:image/png;base64,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'),
                title: Text(
                  headline,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  snippet,
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                // onTap: () {
                //  // InAppWebViewScreen(url: link);
                // },
              ),
            ),
          );
        },
      ),
    );
  }
}
