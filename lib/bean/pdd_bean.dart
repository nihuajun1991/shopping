

class PDDBean {
  GoodsOptGetResponse goodsOptGetResponse;

  PDDBean({this.goodsOptGetResponse});

  PDDBean.fromJson(Map<String, dynamic> json) {
    goodsOptGetResponse = json['goods_opt_get_response'] != null
        ? new GoodsOptGetResponse.fromJson(json['goods_opt_get_response'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.goodsOptGetResponse != null) {
      data['goods_opt_get_response'] = this.goodsOptGetResponse.toJson();
    }
    return data;
  }
}

class GoodsOptGetResponse {
  List<GoodsOptList> goodsOptList;
  String requestId;

  GoodsOptGetResponse({this.goodsOptList, this.requestId});

  GoodsOptGetResponse.fromJson(Map<String, dynamic> json) {
    if (json['goods_opt_list'] != null) {
      goodsOptList = new List<GoodsOptList>();
      json['goods_opt_list'].forEach((v) {
        goodsOptList.add(new GoodsOptList.fromJson(v));
      });
    }
    requestId = json['request_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.goodsOptList != null) {
      data['goods_opt_list'] =
          this.goodsOptList.map((v) => v.toJson()).toList();
    }
    data['request_id'] = this.requestId;
    return data;
  }
}

class GoodsOptList {
  int parentOptId;
  int level;
  String optName;
  int optId;

  GoodsOptList({this.parentOptId, this.level, this.optName, this.optId});

  GoodsOptList.fromJson(Map<String, dynamic> json) {
    parentOptId = json['parent_opt_id'];
    level = json['level'];
    optName = json['opt_name'];
    optId = json['opt_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['parent_opt_id'] = this.parentOptId;
    data['level'] = this.level;
    data['opt_name'] = this.optName;
    data['opt_id'] = this.optId;
    return data;
  }
}

