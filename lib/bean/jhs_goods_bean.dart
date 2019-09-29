
class JHSGoodsBean {
  int status;
  String message;
  ProList proList;

  JHSGoodsBean({this.status, this.message, this.proList});

  JHSGoodsBean.fromJson(Map<String, dynamic> json) {
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

  List<JHSData> data;

  ProList(
      {
        this.data});

  ProList.fromJson(Map<String, dynamic> json) {

    if (json['data'] != null) {
      data = new List<JHSData>();
      json['data'].forEach((v) {
        data.add(new JHSData.fromJson(v));
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

  @override
  String toString() {
    return 'ProList{data: $data}';
  }


}

class JHSData {
  int id;
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
  String bussId;
  String commissionRate;

  JHSData(
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
        this.bussId,
        this.commissionRate});

  JHSData.fromJson(Map<String, dynamic> json) {
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
    bussId = json['buss_id'];
    commissionRate = json['commission_rate'];
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
    data['buss_id'] = this.bussId;
    data['commission_rate'] = this.commissionRate;
    return data;
  }

  @override
  String toString() {
    return 'Data{id: $id, classId: $classId, tmall: $tmall, bussName: $bussName, taobaoId: $taobaoId, prourl: $prourl, pic: $pic, couponLink: $couponLink, shoujia: $shoujia, juanhou: $juanhou, quanFee: $quanFee, sales: $sales, videoUrl: $videoUrl, bussId: $bussId, commissionRate: $commissionRate}';
  }


}

