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
  DoctorAvailability? doctorAvailability;

  Data({this.fullName, this.image, this.doctorUser, this.doctorAvailability});

  Data.fromJson(Map<String, dynamic> json) {
    fullName = json['full_name'];
    image = json['image'];
    doctorUser = json['doctor_user'] != null
        ? new DoctorUser.fromJson(json['doctor_user'])
        : null;
    doctorAvailability = json['doctor_availability'] != null
        ? new DoctorAvailability.fromJson(json['doctor_availability'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['full_name'] = this.fullName;
    data['image'] = this.image;
    if (this.doctorUser != null) {
      data['doctor_user'] = this.doctorUser!.toJson();
    }
    if (this.doctorAvailability != null) {
      data['doctor_availability'] = this.doctorAvailability!.toJson();
    }
    return data;
  }
}

class DoctorUser {
  int? id;
  List<String>? affilation;
  List<String>? qualification;
  int? yearsOfExperience;
  int? onsiteConsultationFee;
  int? onlineConsultationFee;

  DoctorUser(
      {this.id,
      this.affilation,
      this.qualification,
      this.yearsOfExperience,
      this.onsiteConsultationFee,
      this.onlineConsultationFee});

  DoctorUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    affilation = json['affilation'].cast<String>();
    qualification = json['qualification'].cast<String>();
    yearsOfExperience = json['years_of_experience'];
    onsiteConsultationFee = json['onsite_consultation_fee'];
    onlineConsultationFee = json['online_consultation_fee'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['affilation'] = this.affilation;
    data['qualification'] = this.qualification;
    data['years_of_experience'] = this.yearsOfExperience;
    data['onsite_consultation_fee'] = this.onsiteConsultationFee;
    data['online_consultation_fee'] = this.onlineConsultationFee;
    return data;
  }
}

class DoctorAvailability {
  List<Availability>? availability;

  DoctorAvailability({this.availability});

  DoctorAvailability.fromJson(Map<String, dynamic> json) {
    if (json['availability'] != null) {
      availability = <Availability>[];
      json['availability'].forEach((v) {
        availability!.add(new Availability.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.availability != null) {
      data['availability'] = this.availability!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Availability {
  String? day;
  List<Times>? times;
  int? landmarkId;

  Availability({this.day, this.times, this.landmarkId});

  Availability.fromJson(Map<String, dynamic> json) {
    day = json['Day'];
    if (json['times'] != null) {
      times = <Times>[];
      json['times'].forEach((v) {
        times!.add(new Times.fromJson(v));
      });
    }
    landmarkId = json['landmark_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Day'] = this.day;
    if (this.times != null) {
      data['times'] = this.times!.map((v) => v.toJson()).toList();
    }
    data['landmark_id'] = this.landmarkId;
    return data;
  }
}

class Times {
  String? endTime;
  String? startTime;

  Times({this.endTime, this.startTime});

  Times.fromJson(Map<String, dynamic> json) {
    endTime = json['end_time'];
    startTime = json['start_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['end_time'] = this.endTime;
    data['start_time'] = this.startTime;
    return data;
  }
}
