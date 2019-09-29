class DetailBean {
  String api;
  String v;
  //List<String> ret;
  Detail data;

  DetailBean({this.api, this.v,  this.data});

  DetailBean.fromJson(Map<String, dynamic> json) {
    api = json['api'];
    v = json['v'];
    //ret = json['ret'].cast<String>();
    data = json['data'] != null ? new Detail.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['api'] = this.api;
    data['v'] = this.v;
    //data['ret'] = this.ret;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Detail {
  String sellerId;
  String pcDescContent;
  List<ItemProperties> itemProperties;
  //List<Null> anchors;

  Detail({this.sellerId, this.pcDescContent, this.itemProperties});

  Detail.fromJson(Map<String, dynamic> json) {
    sellerId = json['sellerId'];
    pcDescContent = json['pcDescContent'];
    if (json['itemProperties'] != null) {
      itemProperties = new List<ItemProperties>();
      json['itemProperties'].forEach((v) {
        itemProperties.add(new ItemProperties.fromJson(v));
      });
    }
    if (json['anchors'] != null) {
      // anchors = new List<Null>();
      // json['anchors'].forEach((v) {
      //   anchors.add(new Null.fromJson(v));
      // });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sellerId'] = this.sellerId;
    data['pcDescContent'] = this.pcDescContent;
    if (this.itemProperties != null) {
      data['itemProperties'] =
          this.itemProperties.map((v) => v.toJson()).toList();
    }
//    if (this.anchors != null) {
//      //data['anchors'] = this.anchors.map((v) => v.toJson()).toList();
//    }
    return data;
  }
}

class ItemProperties {
  String name;
  String value;

  ItemProperties({this.name, this.value});

  ItemProperties.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['value'] = this.value;
    return data;
  }
}

