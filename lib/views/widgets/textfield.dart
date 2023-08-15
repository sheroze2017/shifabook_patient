import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomTextFormField extends StatelessWidget {
  final FocusNode focusNode;
  final TextEditingController controller;
  final String labelText;
  final TextInputAction textInputAction;
  final void Function(String) onFieldSubmitted;
  final String? Function(String?)? validator;
  final String? hintText;
  const CustomTextFormField({
    Key? key,
    this.hintText,
    required this.focusNode,
    required this.controller,
    required this.labelText,
    required this.textInputAction,
    required this.onFieldSubmitted,
    required this.validator,
    IconButton? suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 6.h,
      child: TextFormField(
        focusNode: focusNode,
        style: GoogleFonts.lato(
          fontSize: 18.sp,
          fontWeight: FontWeight.w800,
        ),
        controller: controller,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(90.0)),
          ),
          filled: true,
          fillColor: Colors.grey[350],
          labelText: labelText,
          hintText: hintText,
          hintStyle: GoogleFonts.lato(
            color: Colors.black26,
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
        onFieldSubmitted: onFieldSubmitted,
        textInputAction: textInputAction,
        validator: validator,
      ),
    );
  }
}
