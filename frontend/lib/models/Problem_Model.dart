class Problem_Model {
  Complaint? complaint;
  var message;

  Problem_Model({this.complaint, this.message});

  Problem_Model.fromJson(Map<String, dynamic> json) {
    complaint = json['complaint'] != null
        ? new Complaint.fromJson(json['complaint'])
        : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.complaint != null) {
      data['complaint'] = this.complaint!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Complaint {
  var title;
  var content;
  var studentId;
  var updatedAt;
  var createdAt;
  var id;
  Student? student;

  Complaint(
      {this.title,
        this.content,
        this.studentId,
        this.updatedAt,
        this.createdAt,
        this.id,
        this.student});

  Complaint.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    content = json['content'];
    studentId = json['student_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
    student =
    json['student'] != null ? new Student.fromJson(json['student']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['content'] = this.content;
    data['student_id'] = this.studentId;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    if (this.student != null) {
      data['student'] = this.student!.toJson();
    }
    return data;
  }
}

class Student {
  var id;
  var userName;
  var firstName;
  var lastName;
  var gender;
  var fatherName;
  var motherName;
  var governorate;
  var email;
  var phone;
  var password;
  var isDisabled;
  var collage;
  var collageId;
  var year;
  var isSuccessded;
  var createdAt;
  var updatedAt;

  Student(
      {this.id,
        this.userName,
        this.firstName,
        this.lastName,
        this.gender,
        this.fatherName,
        this.motherName,
        this.governorate,
        this.email,
        this.phone,
        this.password,
        this.isDisabled,
        this.collage,
        this.collageId,
        this.year,
        this.isSuccessded,
        this.createdAt,
        this.updatedAt});

  Student.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['user_name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    gender = json['gender'];
    fatherName = json['father_name'];
    motherName = json['mother_name'];
    governorate = json['governorate'];
    email = json['email'];
    phone = json['phone'];
    password = json['password'];
    isDisabled = json['is_disabled'];
    collage = json['collage'];
    collageId = json['collage_id'];
    year = json['year'];
    isSuccessded = json['is_successded'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_name'] = this.userName;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['gender'] = this.gender;
    data['father_name'] = this.fatherName;
    data['mother_name'] = this.motherName;
    data['governorate'] = this.governorate;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['password'] = this.password;
    data['is_disabled'] = this.isDisabled;
    data['collage'] = this.collage;
    data['collage_id'] = this.collageId;
    data['year'] = this.year;
    data['is_successded'] = this.isSuccessded;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
