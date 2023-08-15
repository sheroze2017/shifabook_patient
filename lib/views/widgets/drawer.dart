import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DrawerItem extends StatelessWidget {
  const DrawerItem(
      {Key? key,
      required this.name,
      required this.icon,
      required this.onPressed})
      : super(key: key);

  final String name;
  final IconData icon;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: SizedBox(
        height: 40,
        child: Row(
          children: [
            Icon(
              icon,
              size: 20.px,
              color: Colors.white,
            ),
            SizedBox(
              width: 5.h,
            ),
            Text(
              name,
              style: TextStyle(fontSize: 17.sp, color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
