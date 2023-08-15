// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../controller/location/locationController.dart';

// class MyPage extends StatelessWidget {
//   const MyPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<LocationController>(
//         init: LocationController(),
//         builder: (controller) {
//           return Scaffold(
//             appBar: AppBar(
//               title: const Text('Get Current Location'),
//             ),
//             body: Center(
//               child: controller.isLoading.value
//                   ? const CircularProgressIndicator()
//                   : Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 16),
//                           child: Text(
//                             controller.currentLocation == null
//                                 ? 'No Address Found'
//                                 : controller.currentLocation!,
//                             style: const TextStyle(fontSize: 23),
//                             textAlign: TextAlign.center,
//                           ),
//                         ),
//                         const SizedBox(height: 20),
//                         ElevatedButton(
//                           onPressed: () async {
//                             await controller.getCurrentLocation();
//                           },
//                           child: const Text('Get Current Location'),
//                         ),
//                       ],
//                     ),
//             ),
//           );
//         });
//   }
// }
