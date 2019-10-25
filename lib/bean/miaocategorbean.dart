class MiaoCategor {
  List<MiaoCategorData> data;

  MiaoCategor({this.data});

  MiaoCategor.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<MiaoCategorData>();
      json['data'].forEach((v) {
        data.add(new MiaoCategorData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MiaoCategorData {
  int id;
  String name;
  String alias;
  String iconPath;
  String bannerPath;

  MiaoCategorData({this.id, this.name, this.alias, this.iconPath, this.bannerPath});

  MiaoCategorData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    alias = json['alias'];
    iconPath = json['icon_path'];
    bannerPath = json['banner_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['alias'] = this.alias;
    data['icon_path'] = this.iconPath;
    data['banner_path'] = this.bannerPath;
    return data;
  }
}

