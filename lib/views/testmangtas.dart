import 'package:flutter/material.dart';

class testInterview extends StatefulWidget {
  const testInterview({super.key});

  @override
  State<testInterview> createState() => _testInterviewState();
}

class _testInterviewState extends State<testInterview> {
  List<String> restaurantNames = [
    "Tasty Bites",
    "Food Haven",
    "Savory Delights",
    "Culinary Corner",
    "Flavorsome Feast",
    "Gourmet Grill",
    "Chez Amour",
    "Spice Junction",
    "Bistro Bliss",
    "Rustic Eats",
  ];
  List<dynamic> restaurantrating = [4, 4, 4, 5, 3, 2, 4, 5, 2, 5];

  List<String> filteredRestaurantNames = [];

  // void _filterRestaurantNames(String searchText) {
  //   setState(() {
  //     filteredRestaurantNames = restaurantNames
  //         .where(
  //             (name) => name.toLowerCase().contains(searchText.toLowerCase()))
  //         .toList();
  //   });
  // }

  double selectedRating = 0.0;
  double selectedPrice = 0.0;

  void _filterRestaurantNames(String searchText) {
    setState(() {
      filteredRestaurantNames = restaurantNames
          .where((name) =>
              name.toLowerCase().contains(searchText.toLowerCase()) &&
              (_getRating(name) >= selectedRating) &&
              (_getPrice(name) <= selectedPrice))
          .toList();
    });
  }

  double _getRating(String restaurantName) {
    return 3 + (2 * (restaurantName.hashCode % 100) / 100);
  }

  double _getPrice(String restaurantName) {
    return 1 + (3 * (restaurantName.hashCode % 100) / 100);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Mangtas')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: _filterRestaurantNames,
              decoration: InputDecoration(
                labelText: 'Search Restaurants',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Slider(
            value: selectedRating,
            onChanged: (newValue) {
              setState(() {
                selectedRating = newValue;
              });
              _filterRestaurantNames("");
            },
            min: 0,
            max: 5,
            divisions: 5,
            label: 'Rating: ${selectedRating.toStringAsFixed(1)}',
          ),
          Slider(
            value: selectedPrice,
            onChanged: (newValue) {
              setState(() {
                selectedPrice = newValue;
              });
              _filterRestaurantNames("");
            },
            min: 0,
            max: 4,
            divisions: 4,
            label: 'Price: ${selectedPrice.toStringAsFixed(1)}',
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredRestaurantNames.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(filteredRestaurantNames[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
