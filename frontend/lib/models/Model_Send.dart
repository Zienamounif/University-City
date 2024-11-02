class Maison {
  List<House>? house;
  String? message;

  Maison({this.house, this.message});

  Maison.fromJson(Map<String, dynamic> json) {
    if (json['house'] != null) {
      house = <House>[];
      json['house'].forEach((v) {
        house!.add(new House.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.house != null) {
      data['house'] = this.house!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class House {
  int? id;
  String? type;
  int? build;
  int? floor;
  int? room;
  int? bed;
  int? isProtected;
  int? isFreind;
  int? discount;
  int? fees;
  dynamic studentId;
  String? status;
  String? createdAt;
  String? updatedAt;

  House(
      {this.id,
        this.type,
        this.build,
        this.floor,
        this.room,
        this.bed,
        this.isProtected,
        this.isFreind,
        this.discount,
        this.fees,
        this.studentId,
        this.status,
        this.createdAt,
        this.updatedAt});

  House.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    build = json['build'];
    floor = json['floor'];
    room = json['room'];
    bed = json['bed'];
    isProtected = json['is_protected'];
    isFreind = json['is_freind'];
    discount = json['discount'];
    fees = json['fees'];
    studentId = json['student_id'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['build'] = this.build;
    data['floor'] = this.floor;
    data['room'] = this.room;
    data['bed'] = this.bed;
    data['is_protected'] = this.isProtected;
    data['is_freind'] = this.isFreind;
    data['discount'] = this.discount;
    data['fees'] = this.fees;
    data['student_id'] = this.studentId;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
