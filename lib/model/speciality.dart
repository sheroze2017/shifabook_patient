import 'package:flutter/cupertino.dart';

class SpecialityModel {
  String? imgAssetPath;
  String? speciality;
  int? noOfDoctors;
  int? id;
  Color? backgroundColor;
  SpecialityModel(
      {this.imgAssetPath,
      this.speciality,
      this.noOfDoctors,
      this.id,
      this.backgroundColor});
}
