class JDPagerbean {
  List<JDPagerData> data;
  String message;
  int totalpage;
  int total;
  int statusCode;

  JDPagerbean(
      {this.data, this.message, this.totalpage, this.total, this.statusCode});

  JDPagerbean.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<JDPagerData>();
      json['data'].forEach((v) {
        data.add(new JDPagerData.fromJson(v));
      });
    }
    message = json['message'];
    totalpage = json['totalpage'];
    total = json['total'];
    statusCode = json['status_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    data['totalpage'] = this.totalpage;
    data['total'] = this.total;
    data['status_code'] = this.statusCode;
    return data;
  }
}

class JDPagerData {
  int sId;
  String skuId;
  String skuName;
//  String skuDesc;
//  String materiaUrl;
  String picUrl;
  String wlPrice;
  String wlPriceAfter;
//  String wlCommissionShare;
  String couponList;
//  String bindType;
  String discount;
//  String quota;
  //Null platformType;
//  int beginTime;
//  int endTime;
//  String cname;
//  int cid;
//  int goodstype;
//  int goodslx;
//  String commission;
//  String wlCommission;
//  int twoHourSales;
//  int oneDaySales;
  int sales;
//  int spreadCount;
//  int spreadStartAt;
//  int spreadEndAt;
//  String spreadType;
//  String spreadAmount;
//  int groupCount;
//  int groupPrice;

  JDPagerData(
      {this.sId,
        this.skuId,
        this.skuName,
//        this.skuDesc,
//        this.materiaUrl,
        this.picUrl,
        this.wlPrice,
        this.wlPriceAfter,
//        this.wlCommissionShare,
        this.couponList,
//        this.bindType,
        this.discount,
//        this.quota,
//        this.platformType,
//        this.beginTime,
//        this.endTime,
//        this.cname,
//        this.cid,
//        this.goodstype,
//        this.goodslx,
//        this.commission,
//        this.wlCommission,
//        this.twoHourSales,
//        this.oneDaySales,
        this.sales,
//        this.spreadCount,
//        this.spreadStartAt,
//        this.spreadEndAt,
//        this.spreadType,
//        this.spreadAmount,
//        this.groupCount,
//        this.groupPrice
      });

  JDPagerData.fromJson(Map<String, dynamic> json) {
    sId = json['s_id'];
    skuId = json['skuId'].toString();
    skuName = json['skuName'];
//    skuDesc = json['skuDesc'];
//    materiaUrl = json['materiaUrl'];
    picUrl = json['picUrl'];
    wlPrice = json['wlPrice'].toString();
    wlPriceAfter = json['wlPrice_after'].toString();
//    wlCommissionShare = json['wlCommissionShare'];
    couponList = json['couponList'];
//    bindType = json['bindType'];
    discount = json['discount'].toString();
//    quota = json['quota'];
//    platformType = json['platformType'];
//    beginTime = json['beginTime'];
//    endTime = json['endTime'];
//    cname = json['cname'];
//    cid = json['cid'];
//    goodstype = json['goodstype'];
//    goodslx = json['goodslx'];
//    commission = json['commission'];
//    wlCommission = json['wlCommission'];
//    twoHourSales = json['two_hour_sales'];
//    oneDaySales = json['one_day_sales'];
    sales = json['sales']==null?0:json['sales'];
//    spreadCount = json['spread_count'];
//    spreadStartAt = json['spread_start_at'];
//    spreadEndAt = json['spread_end_at'];
//    spreadType = json['spread_type'];
//    spreadAmount = json['spread_amount'];
//    groupCount = json['group_count'];
//    groupPrice = json['group_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['s_id'] = this.sId;
    data['skuId'] = this.skuId;
    data['skuName'] = this.skuName;
//    data['skuDesc'] = this.skuDesc;
//    data['materiaUrl'] = this.materiaUrl;
    data['picUrl'] = this.picUrl;
    data['wlPrice'] = this.wlPrice;
    data['wlPrice_after'] = this.wlPriceAfter;
//    data['wlCommissionShare'] = this.wlCommissionShare;
    data['couponList'] = this.couponList;
//    data['bindType'] = this.bindType;
    data['discount'] = this.discount;
//    data['quota'] = this.quota;
//    data['platformType'] = this.platformType;
//    data['beginTime'] = this.beginTime;
//    data['endTime'] = this.endTime;
//    data['cname'] = this.cname;
//    data['cid'] = this.cid;
//    data['goodstype'] = this.goodstype;
//    data['goodslx'] = this.goodslx;
//    data['commission'] = this.commission;
//    data['wlCommission'] = this.wlCommission;
//    data['two_hour_sales'] = this.twoHourSales;
//    data['one_day_sales'] = this.oneDaySales;
    data['sales'] = this.sales;
//    data['spread_count'] = this.spreadCount;
//    data['spread_start_at'] = this.spreadStartAt;
//    data['spread_end_at'] = this.spreadEndAt;
//    data['spread_type'] = this.spreadType;
//    data['spread_amount'] = this.spreadAmount;
//    data['group_count'] = this.groupCount;
//    data['group_price'] = this.groupPrice;
    return data;
  }
}

