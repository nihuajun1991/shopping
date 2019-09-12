class NineBean {
  int status;
  String message;
  ProList proList;

  NineBean({this.status, this.message, this.proList});

  NineBean.fromJson(Map<String, dynamic> json) {
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
  int perPage;
  int currentPage;
  int lastPage;
  String nextPageUrl;
  String prevPageUrl;
  int from;
  int to;
  List<NineData> data;

  ProList(
      {this.total,
        this.perPage,
        this.currentPage,
        this.lastPage,
        this.nextPageUrl,
        this.prevPageUrl,
        this.from,
        this.to,
        this.data});

  ProList.fromJson(Map<String, dynamic> json) {
    total = json['total']!=null?json['total']:'';
    perPage = json['per_page']!=null?json['per_page']:'';
    currentPage = json['current_page']!=null?json['current_page']:'';
    lastPage = json['last_page']!=null?json['last_page']:'';
    nextPageUrl = json['next_page_url']!=null?json['next_page_url']:'';
    prevPageUrl = json['prev_page_url']!=null?json['prev_page_url']:'';
    from = json['from']!=null?json['from']:'';
    to = json['to']!=null?json['to']:'';
    if (json['data'] != null) {
      data = new List<NineData>();
      json['data'].forEach((v) {
        data.add(new NineData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['per_page'] = this.perPage;
    data['current_page'] = this.currentPage;
    data['last_page'] = this.lastPage;
    data['next_page_url'] = this.nextPageUrl;
    data['prev_page_url'] = this.prevPageUrl;
    data['from'] = this.from;
    data['to'] = this.to;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NineData {
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
  String commissionRate;
  String nick;
  String youhuiquanNumShengyu;
  String youhuiquanTimeGuoqi;
  String shopTitle;

  NineData(
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
        this.nick,
        this.youhuiquanNumShengyu,
        this.youhuiquanTimeGuoqi,
        this.shopTitle});

  NineData.fromJson(Map<String, dynamic> json) {
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
    nick = json['nick'];
    youhuiquanNumShengyu = json['youhuiquan_num_shengyu'];
    youhuiquanTimeGuoqi = json['youhuiquan_time_guoqi'];
    shopTitle = json['shop_title'];
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
    data['nick'] = this.nick;
    data['youhuiquan_num_shengyu'] = this.youhuiquanNumShengyu;
    data['youhuiquan_time_guoqi'] = this.youhuiquanTimeGuoqi;
    data['shop_title'] = this.shopTitle;
    return data;
  }

  @override
  String toString() {
    return 'NineData{id: $id, classId: $classId, tmall: $tmall, bussName: $bussName, taobaoId: $taobaoId, prourl: $prourl, pic: $pic, couponLink: $couponLink, shoujia: $shoujia, juanhou: $juanhou, quanFee: $quanFee, sales: $sales, videoUrl: $videoUrl, commissionRate: $commissionRate, nick: $nick, youhuiquanNumShengyu: $youhuiquanNumShengyu, youhuiquanTimeGuoqi: $youhuiquanTimeGuoqi, shopTitle: $shopTitle}';
  }


}