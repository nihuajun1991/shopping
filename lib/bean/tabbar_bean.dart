
class TabBar_Bean {
  int status;
  String message;
  List<Classlist> classlist;
  IsLike isLike;

  TabBar_Bean({this.status, this.message, this.classlist, this.isLike});

  TabBar_Bean.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['classlist'] != null) {
      classlist = new List<Classlist>();
      json['classlist'].forEach((v) {
        classlist.add(new Classlist.fromJson(v));
      });
    }
    isLike =
        json['isLike'] != null ? new IsLike.fromJson(json['isLike']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.classlist != null) {
      data['classlist'] = this.classlist.map((v) => v.toJson()).toList();
    }
    if (this.isLike != null) {
      data['isLike'] = this.isLike.toJson();
    }
    return data;
  }
}

class Classlist {
  int id;
  String className;
  String classTitle;
  String classKeywords;
  String classDescription;
  String image;

  Classlist(
      {this.id,
      this.className,
      this.classTitle,
      this.classKeywords,
      this.classDescription,
      this.image});

  Classlist.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    className = json['class_name'];
    classTitle = json['class_title'];
    classKeywords = json['class_keywords'];
    classDescription = json['class_description'];
    image = json['image'];
  }
  

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['class_name'] = this.className;
    data['class_title'] = this.classTitle;
    data['class_keywords'] = this.classKeywords;
    data['class_description'] = this.classDescription;
    data['image'] = this.image;
    return data;
  }
}

class IsLike {
  String isShow;
  String imgUrl;
  String action;

  IsLike({this.isShow, this.imgUrl, this.action});

  IsLike.fromJson(Map<String, dynamic> json) {
    isShow = json['isShow'];
    imgUrl = json['imgUrl'];
    action = json['action'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isShow'] = this.isShow;
    data['imgUrl'] = this.imgUrl;
    data['action'] = this.action;
    return data;
  }
}

