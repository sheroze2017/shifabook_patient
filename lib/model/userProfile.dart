class UserProfile {
  bool? status;
  String? message;
  Null? error;
  Data? data;

  UserProfile({this.status, this.message, this.error, this.data});

  UserProfile.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    error = json['error'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['error'] = this.error;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? fullName;
  String? mobile;
  Null? email;
  String? gender;
  String? age;
  String? dob;
  bool? isActive;
  Null? image;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;
  Null? deactivatedAt;
  bool? isDeactivated;
  UserPatient? userPatient;
  List<Cities>? cities;

  Data(
      {this.id,
      this.fullName,
      this.mobile,
      this.email,
      this.gender,
      this.age,
      this.dob,
      this.isActive,
      this.image,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.deactivatedAt,
      this.isDeactivated,
      this.userPatient,
      this.cities});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    mobile = json['mobile'];
    email = json['email'];
    gender = json['gender'];
    age = json['age'];
    dob = json['dob'];
    isActive = json['is_active'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    deactivatedAt = json['deactivated_at'];
    isDeactivated = json['is_deactivated'];
    userPatient = json['user_patient'] != null
        ? new UserPatient.fromJson(json['user_patient'])
        : null;
    if (json['cities'] != null) {
      cities = <Cities>[];
      json['cities'].forEach((v) {
        cities!.add(new Cities.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['full_name'] = this.fullName;
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    data['gender'] = this.gender;
    data['age'] = this.age;
    data['dob'] = this.dob;
    data['is_active'] = this.isActive;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['deactivated_at'] = this.deactivatedAt;
    data['is_deactivated'] = this.isDeactivated;
    if (this.userPatient != null) {
      data['user_patient'] = this.userPatient!.toJson();
    }
    if (this.cities != null) {
      data['cities'] = this.cities!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserPatient {
  String? bloodType;
  List<String>? disease;
  List<String>? allergies;
  String? weight;
  String? height;
  String? sinceVisit;

  UserPatient(
      {this.bloodType,
      this.disease,
      this.allergies,
      this.weight,
      this.height,
      this.sinceVisit});

  UserPatient.fromJson(Map<String, dynamic> json) {
    bloodType = json['blood_type'];
    disease = json['disease'].cast<String>();
    allergies = json['allergies'].cast<String>();
    weight = json['weight'];
    height = json['height'];
    sinceVisit = json['since_visit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['blood_type'] = this.bloodType;
    data['disease'] = this.disease;
    data['allergies'] = this.allergies;
    data['weight'] = this.weight;
    data['height'] = this.height;
    data['since_visit'] = this.sinceVisit;
    return data;
  }
}

class Cities {
  int? id;
  String? name;

  Cities({this.id, this.name});

  Cities.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
