class DoctorCategory {
  bool? status;
  String? message;
  Null? error;
  List<Data>? data;

  DoctorCategory({this.status, this.message, this.error, this.data});

  DoctorCategory.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['error'] = this.error;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? fullName;
  Null? image;
  DoctorUser? doctorUser;

  Data({this.fullName, this.image, this.doctorUser});

  Data.fromJson(Map<String, dynamic> json) {
    fullName = json['full_name'];
    image = json['image'];
    doctorUser = json['doctor_user'] != null
        ? new DoctorUser.fromJson(json['doctor_user'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['full_name'] = this.fullName;
    data['image'] = this.image;
    if (this.doctorUser != null) {
      data['doctor_user'] = this.doctorUser!.toJson();
    }
    return data;
  }
}

class DoctorUser {
  List<String>? affilation;
  List<String>? qualification;
  int? yearsOfExperience;
  int? onsiteConsultationFee;
  int? onlineConsultationFee;

  DoctorUser(
      {this.affilation,
      this.qualification,
      this.yearsOfExperience,
      this.onsiteConsultationFee,
      this.onlineConsultationFee});

  DoctorUser.fromJson(Map<String, dynamic> json) {
    affilation = json['affilation'].cast<String>();
    qualification = json['qualification'].cast<String>();
    yearsOfExperience = json['years_of_experience'];
    onsiteConsultationFee = json['onsite_consultation_fee'];
    onlineConsultationFee = json['online_consultation_fee'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['affilation'] = this.affilation;
    data['qualification'] = this.qualification;
    data['years_of_experience'] = this.yearsOfExperience;
    data['onsite_consultation_fee'] = this.onsiteConsultationFee;
    data['online_consultation_fee'] = this.onlineConsultationFee;
    return data;
  }
}
