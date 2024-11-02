class Model_Desicion {
  List<Decisions>? decisions;
  var message;

  Model_Desicion({this.decisions, this.message});

  Model_Desicion.fromJson(Map<String, dynamic> json) {
    if (json['decisions'] != null) {
      decisions = <Decisions>[];
      json['decisions'].forEach((v) {
        decisions!.add(new Decisions.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.decisions != null) {
      data['decisions'] = this.decisions!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class Decisions {
  var id;
  var title;
  var content;
  var createdAt;
  var updatedAt;

  Decisions(
      {this.id, this.title, this.content, this.createdAt, this.updatedAt});

  Decisions.fromJson(Map<dynamic, dynamic> json) {
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
