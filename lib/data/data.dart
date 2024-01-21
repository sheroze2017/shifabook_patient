import 'package:flutter/cupertino.dart';

import '../model/speciality.dart';

List<SpecialityModel> getSpeciality() {
  List<SpecialityModel> specialities = <SpecialityModel>[];
  SpecialityModel specialityModel = new SpecialityModel();

  //1
  specialityModel.noOfDoctors = 10;
  specialityModel.speciality = "Dermatologist";
  specialityModel.imgAssetPath = "assets/derma.png";
  specialityModel.id = 1;
  specialityModel.backgroundColor = Color(0xffFBB97C);
  specialities.add(specialityModel);

  specialityModel = new SpecialityModel();

  //2
  specialityModel.noOfDoctors = 2;
  specialityModel.id = 2;
  specialityModel.speciality = "Gynecologist";
  specialityModel.imgAssetPath = "assets/gynp.png";
  specialityModel.backgroundColor = Color(0xffF69383);
  specialities.add(specialityModel);

  specialityModel = new SpecialityModel();

  //3
  specialityModel.noOfDoctors = 27;
  specialityModel.id = 3;
  specialityModel.speciality = "Psychiatrist";
  specialityModel.imgAssetPath = "assets/counsel.png";
  specialityModel.backgroundColor = Color.fromARGB(255, 171, 94, 94);
  specialities.add(specialityModel);

  specialityModel = new SpecialityModel();

  specialityModel.noOfDoctors = 7;
  specialityModel.speciality = "Urologist";
  specialityModel.id = 4;
  specialityModel.imgAssetPath = "assets/img2.png";
  specialityModel.backgroundColor = Color.fromARGB(255, 234, 128, 128);
  specialities.add(specialityModel);

  specialityModel = new SpecialityModel();

  specialityModel.noOfDoctors = 17;
  specialityModel.id = 5;
  specialityModel.speciality = "Child Specialist";
  specialityModel.imgAssetPath = "assets/childp.png";
  specialityModel.backgroundColor = Color.fromARGB(255, 147, 122, 122);
  specialities.add(specialityModel);

  specialityModel = new SpecialityModel();
  specialityModel.noOfDoctors = 17;
  specialityModel.id = 6;
  specialityModel.speciality = "General Physician";
  specialityModel.imgAssetPath = "assets/genp.png";
  specialityModel.backgroundColor = Color.fromARGB(255, 200, 173, 173);
  specialities.add(specialityModel);

  specialityModel = new SpecialityModel();

  specialityModel = new SpecialityModel();
  specialityModel.noOfDoctors = 17;
  specialityModel.id = 7;
  specialityModel.speciality = "Eye Specialist";
  specialityModel.imgAssetPath = "assets/eyep.png";
  specialityModel.backgroundColor = Color.fromARGB(255, 243, 188, 188);
  specialities.add(specialityModel);

  specialityModel = new SpecialityModel();
  return specialities;
}
