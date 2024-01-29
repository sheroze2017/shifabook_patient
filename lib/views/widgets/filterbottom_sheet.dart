import 'package:flutter/material.dart';

class FilterBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Sort By',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20.0),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  Colors.transparent), // Set the background color
              foregroundColor: MaterialStateProperty.all<Color>(
                  Colors.white), // Set the text color
            ),
            onPressed: () {
              // Sort by experience
              Navigator.pop(context, 'experience');
            },
            child: Text('Sort by Experience'),
          ),
          SizedBox(height: 10.0),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  Colors.transparent), // Set the background color
              foregroundColor: MaterialStateProperty.all<Color>(
                  Colors.white), // Set the text color
            ),
            onPressed: () {
              // Sort by online fees
              Navigator.pop(context, 'online_fees');
            },
            child: Text('Sort by Online Fees'),
          ),
          SizedBox(height: 10.0),
          ElevatedButton(
            onPressed: () {
              // Sort by onsite fees
              Navigator.pop(context, 'onsite_fees');
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  Colors.transparent), // Set the background color
              foregroundColor: MaterialStateProperty.all<Color>(
                  Colors.white), // Set the text color
            ),
            child: Text('Sort by Onsite Fees'),
          ),
        ],
      ),
    );
  }
}

Future<String> showFilterBottomSheet(BuildContext context) async {
  String result = await showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return FilterBottomSheet();
    },
  );
  return result;
}
