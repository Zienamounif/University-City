class Desicion_Model2 {
  int? id;
  String? title;
  String? content;
  Null? createdAt;
  Null? updatedAt;

  Desicion_Model2(
      {this.id, this.title, this.content, this.createdAt, this.updatedAt});

  Desicion_Model2.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['content'] = this.content;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
