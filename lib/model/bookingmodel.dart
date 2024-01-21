class BookingDetails {
  Data? data;

  BookingDetails({this.data});

  BookingDetails.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? scheduledAt;
  String? createdAt;
  String? updatedAt;
  int? landmarkId;
  bool? isCompleted;
  bool? isActive;
  BookingLogDoctor? bookingLogDoctor;
  BookingLogPatient? bookingLogPatient;
  Null? doctorPatientBooking;
  Categories? landmark;
  String? bookingStatus;

  Data(
      {this.id,
      this.scheduledAt,
      this.createdAt,
      this.updatedAt,
      this.landmarkId,
      this.isCompleted,
      this.isActive,
      this.bookingLogDoctor,
      this.bookingLogPatient,
      this.doctorPatientBooking,
      this.landmark,
      this.bookingStatus});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    scheduledAt = json['scheduled_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    landmarkId = json['landmark_id'];
    isCompleted = json['is_completed'];
    isActive = json['is_active'];
    bookingLogDoctor = json['booking_log_doctor'] != null
        ? new BookingLogDoctor.fromJson(json['booking_log_doctor'])
        : null;
    bookingLogPatient = json['booking_log_patient'] != null
        ? new BookingLogPatient.fromJson(json['booking_log_patient'])
        : null;
    doctorPatientBooking = json['doctor_patient_booking'];
    landmark = json['landmark'] != null
        ? new Categories.fromJson(json['landmark'])
        : null;
    bookingStatus = json['booking_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['scheduled_at'] = this.scheduledAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['landmark_id'] = this.landmarkId;
    data['is_completed'] = this.isCompleted;
    data['is_active'] = this.isActive;
    if (this.bookingLogDoctor != null) {
      data['booking_log_doctor'] = this.bookingLogDoctor!.toJson();
    }
    if (this.bookingLogPatient != null) {
      data['booking_log_patient'] = this.bookingLogPatient!.toJson();
    }
    data['doctor_patient_booking'] = this.doctorPatientBooking;
    if (this.landmark != null) {
      data['landmark'] = this.landmark!.toJson();
    }
    data['booking_status'] = this.bookingStatus;
    return data;
  }
}

class BookingLogDoctor {
  String? fullName;
  DoctorUser? doctorUser;
  List<Categories>? categories;

  BookingLogDoctor({this.fullName, this.doctorUser, this.categories});

  BookingLogDoctor.fromJson(Map<String, dynamic> json) {
    fullName = json['full_name'];
    doctorUser = json['doctor_user'] != null
        ? new DoctorUser.fromJson(json['doctor_user'])
        : null;
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(new Categories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['full_name'] = this.fullName;
    if (this.doctorUser != null) {
      data['doctor_user'] = this.doctorUser!.toJson();
    }
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DoctorUser {
  int? doctorId;
  int? onsiteConsultationFee;
  int? onlineConsultationFee;
  List<String>? qualification;

  DoctorUser(
      {this.doctorId,
      this.onsiteConsultationFee,
      this.onlineConsultationFee,
      this.qualification});

  DoctorUser.fromJson(Map<String, dynamic> json) {
    doctorId = json['doctor_id'];
    onsiteConsultationFee = json['onsite_consultation_fee'];
    onlineConsultationFee = json['online_consultation_fee'];
    qualification = json['qualification'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['doctor_id'] = this.doctorId;
    data['onsite_consultation_fee'] = this.onsiteConsultationFee;
    data['online_consultation_fee'] = this.onlineConsultationFee;
    data['qualification'] = this.qualification;
    return data;
  }
}

class Categories {
  String? name;

  Categories({this.name});

  Categories.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}

class BookingLogPatient {
  String? fullName;
  String? age;
  UserPatient? userPatient;

  BookingLogPatient({this.fullName, this.age, this.userPatient});

  BookingLogPatient.fromJson(Map<String, dynamic> json) {
    fullName = json['full_name'];
    age = json['age'];
    userPatient = json['user_patient'] != null
        ? new UserPatient.fromJson(json['user_patient'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['full_name'] = this.fullName;
    data['age'] = this.age;
    if (this.userPatient != null) {
      data['user_patient'] = this.userPatient!.toJson();
    }
    return data;
  }
}

class UserPatient {
  int? patientId;
  List<String>? disease;
  List<String>? allergies;
  String? weight;
  String? height;
  String? bloodType;

  UserPatient(
      {this.patientId,
      this.disease,
      this.allergies,
      this.weight,
      this.height,
      this.bloodType});

  UserPatient.fromJson(Map<String, dynamic> json) {
    patientId = json['patient_id'];
    disease = json['disease'].cast<String>();
    allergies = json['allergies'].cast<String>();
    weight = json['weight'];
    height = json['height'];
    bloodType = json['blood_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['patient_id'] = this.patientId;
    data['disease'] = this.disease;
    data['allergies'] = this.allergies;
    data['weight'] = this.weight;
    data['height'] = this.height;
    data['blood_type'] = this.bloodType;
    return data;
  }
}
