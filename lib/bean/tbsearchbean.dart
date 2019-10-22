class TbSearchbean {
  int status;
  String message;
  ProList proList;

  TbSearchbean({this.status, this.message, this.proList});

  TbSearchbean.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    proList =
    json['proList'] != null ? new ProList.fromJson(json['proList']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.proList != null) {
      data['proList'] = this.proList.toJson();
    }
    return data;
  }
}

class ProList {
  int total;
  int lastPage;
  List<TbSearchData> data;

  ProList({this.total, this.lastPage, this.data});

  ProList.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    lastPage = json['last_page'];
    if (json['data'] != null) {
      data = new List<TbSearchData>();
      json['data'].forEach((v) {
        data.add(new TbSearchData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['last_page'] = this.lastPage;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TbSearchData {
  String id;
  String classId;
  String tmall;
  String bussName;
  String taobaoId;
  String prourl;
  String pic;
  String couponLink;
  String shoujia;
  String juanhou;
  String quanFee;
  String sales;
  String videoUrl;
  String commissionRate;
  String shopTitle;
  String youhuiquanTimeGuoqi;
  int youhuiquanNumShengyu;

  TbSearchData(
      {this.id,
        this.classId,
        this.tmall,
        this.bussName,
        this.taobaoId,
        this.prourl,
        this.pic,
        this.couponLink,
        this.shoujia,
        this.juanhou,
        this.quanFee,
        this.sales,
        this.videoUrl,
        this.commissionRate,
        this.shopTitle,
        this.youhuiquanTimeGuoqi,
        this.youhuiquanNumShengyu});

  TbSearchData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    classId = json['class_id'];
    tmall = json['tmall'];
    bussName = json['buss_name'];
    taobaoId = json['taobao_id'];
    prourl = json['prourl'];
    pic = json['pic'];
    couponLink = json['couponLink'];
    shoujia = json['shoujia'];
    juanhou = json['juanhou'];
    quanFee = json['quan_fee'];
    sales = json['sales'];
    videoUrl = json['video_url'];
    commissionRate = json['commission_rate'];
    shopTitle = json['shop_title'];
    youhuiquanTimeGuoqi = json['youhuiquan_time_guoqi'];
    youhuiquanNumShengyu = json['youhuiquan_num_shengyu'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['class_id'] = this.classId;
    data['tmall'] = this.tmall;
    data['buss_name'] = this.bussName;
    data['taobao_id'] = this.taobaoId;
    data['prourl'] = this.prourl;
    data['pic'] = this.pic;
    data['couponLink'] = this.couponLink;
    data['shoujia'] = this.shoujia;
    data['juanhou'] = this.juanhou;
    data['quan_fee'] = this.quanFee;
    data['sales'] = this.sales;
    data['video_url'] = this.videoUrl;
    data['commission_rate'] = this.commissionRate;
    data['shop_title'] = this.shopTitle;
    data['youhuiquan_time_guoqi'] = this.youhuiquanTimeGuoqi;
    data['youhuiquan_num_shengyu'] = this.youhuiquanNumShengyu;
    return data;
  }
}

