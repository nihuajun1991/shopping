class Miaoswiper {
  List<SwiperData> data;

  Miaoswiper({this.data});

  Miaoswiper.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<SwiperData>();
      json['data'].forEach((v) {
        data.add(new SwiperData.fromJson(v));
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

class SwiperData {
  String id;
  String title;
  String taobaoId;
  String categoryId;
  String thumb;
  String originUrl;
  String couponUrl;
  String couponCondition;
  String couponTotal;
  String couponReceived;
  String couponRemain;
  String expireTime;
  String price;
  String priceCoupon;
  String couponAmount;
  String sales;
  String guidContent;
  String shopType;
  String isVideo;
  String isBig;
  String videoUrl;
  String isMerchants;
  String commissionType;
  String commissionRate;
  String activityType;
  String isGold;
  String isFreight;
  String isAbroad;
  String isFlagship;

  SwiperData(
      {this.id,
        this.title,
        this.taobaoId,
        this.categoryId,
        this.thumb,
        this.originUrl,
        this.couponUrl,
        this.couponCondition,
        this.couponTotal,
        this.couponReceived,
        this.couponRemain,
        this.expireTime,
        this.price,
        this.priceCoupon,
        this.couponAmount,
        this.sales,
        this.guidContent,
        this.shopType,
        this.isVideo,
        this.isBig,
        this.videoUrl,
        this.isMerchants,
        this.commissionType,
        this.commissionRate,
        this.activityType,
        this.isGold,
        this.isFreight,
        this.isAbroad,
        this.isFlagship});

  SwiperData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    taobaoId = json['taobao_id'];
    categoryId = json['category_id'];
    thumb = json['thumb'];
    originUrl = json['origin_url'];
    couponUrl = json['coupon_url'];
    couponCondition = json['coupon_condition'];
    couponTotal = json['coupon_total'];
    couponReceived = json['coupon_received'];
    couponRemain = json['coupon_remain'];
    expireTime = json['expire_time'];
    price = json['price'];
    priceCoupon = json['price_coupon'];
    couponAmount = json['coupon_amount'];
    sales = json['sales'];
    guidContent = json['guid_content'];
    shopType = json['shop_type'];
    isVideo = json['is_video'];
    isBig = json['is_big'];
    videoUrl = json['video_url'];
    isMerchants = json['is_merchants'];
    commissionType = json['commission_type'];
    commissionRate = json['commission_rate'];
    activityType = json['activity_type'];
    isGold = json['is_gold'];
    isFreight = json['is_freight'];
    isAbroad = json['is_abroad'];
    isFlagship = json['is_flagship'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['taobao_id'] = this.taobaoId;
    data['category_id'] = this.categoryId;
    data['thumb'] = this.thumb;
    data['origin_url'] = this.originUrl;
    data['coupon_url'] = this.couponUrl;
    data['coupon_condition'] = this.couponCondition;
    data['coupon_total'] = this.couponTotal;
    data['coupon_received'] = this.couponReceived;
    data['coupon_remain'] = this.couponRemain;
    data['expire_time'] = this.expireTime;
    data['price'] = this.price;
    data['price_coupon'] = this.priceCoupon;
    data['coupon_amount'] = this.couponAmount;
    data['sales'] = this.sales;
    data['guid_content'] = this.guidContent;
    data['shop_type'] = this.shopType;
    data['is_video'] = this.isVideo;
    data['is_big'] = this.isBig;
    data['video_url'] = this.videoUrl;
    data['is_merchants'] = this.isMerchants;
    data['commission_type'] = this.commissionType;
    data['commission_rate'] = this.commissionRate;
    data['activity_type'] = this.activityType;
    data['is_gold'] = this.isGold;
    data['is_freight'] = this.isFreight;
    data['is_abroad'] = this.isAbroad;
    data['is_flagship'] = this.isFlagship;
    return data;
  }
}

