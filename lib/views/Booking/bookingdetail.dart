// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:responsive_sizer/responsive_sizer.dart';

// import '../../controller/Booking/createBooking.dart';

// class BookingListWidget extends StatefulWidget {
//   @override
//   State<BookingListWidget> createState() => _BookingListWidgetState();
// }

// class _BookingListWidgetState extends State<BookingListWidget> {
//   final bookingdetailController = Get.put(Createbooking());
//   bool checkdata = true;
//   Map<String, dynamic> bookingData2 = {};
//   @override
//   void initState() {
//     bookingData2 = bookingdetailController.bookingData;
//     Future.delayed(Duration(seconds: 1), () {
//       setState(() {
//         checkdata = false;
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Obx(
//         () => checkdata
//             ? Center(child: CircularProgressIndicator())
//             : Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Container(
//                   child: Column(
//                     children: [
//                       Container(
//                         height: 20.h,
//                         child: Column(
//                           children: [
//                             Text(bookingData2['data']['booking_log_doctor']['full_name'])
//                           ],
//                         ),
                        
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//       ),
//     );
//   }
// }
