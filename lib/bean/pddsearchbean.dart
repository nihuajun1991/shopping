class PDDSearchbean {
  GoodsSearchResponse goodsSearchResponse;

  PDDSearchbean({this.goodsSearchResponse});

  PDDSearchbean.fromJson(Map<String, dynamic> json) {
    goodsSearchResponse = json['goods_search_response'] != null
        ? new GoodsSearchResponse.fromJson(json['goods_search_response'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.goodsSearchResponse != null) {
      data['goods_search_response'] = this.goodsSearchResponse.toJson();
    }
    return data;
  }
}

class GoodsSearchResponse {
  List<GoodsList> goodsList;
  int totalCount;
  String requestId;

  GoodsSearchResponse({this.goodsList, this.totalCount, this.requestId});

  GoodsSearchResponse.fromJson(Map<String, dynamic> json) {
    if (json['goods_list'] != null) {
      goodsList = new List<GoodsList>();
      json['goods_list'].forEach((v) {
        goodsList.add(new GoodsList.fromJson(v));
      });
    }
    totalCount = json['total_count'];
    requestId = json['request_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.goodsList != null) {
      data['goods_list'] = this.goodsList.map((v) => v.toJson()).toList();
    }
    data['total_count'] = this.totalCount;
    data['request_id'] = this.requestId;
    return data;
  }
}

class GoodsList {
  String categoryName;
  //Null cltCpnEndTime;
  //Null cltCpnMinAmt;
  int couponRemainQuantity;
  //Null cltCpnRemainQuantity;
  int promotionRate;
  //List<int> serviceTags;
  int mallId;
  String mallName;
  int mallCouponEndTime;
 // Null cltCpnBatchSn;
  String lgstTxt;
  String goodsName;
  //Null cltCpnDiscount;
  int goodsId;
 // Null goodsGalleryUrls;
  String goodsDesc;
  String optName;
  List<int> optIds;
  String goodsImageUrl;
  bool hasMallCoupon;
  int minGroupPrice;
  int couponStartTime;
  int couponDiscount;
  int couponEndTime;
  int zsDuoId;
  int mallCouponRemainQuantity;
  int planType;
 // Null cltCpnQuantity;
  double crtRfOrdrRto1m;
 // Null cpsSign;
  List<int> catIds;
  int couponMinOrderAmount;
  int categoryId;
  int mallCouponDiscountPct;
//  Null activityType;
 // Null catId;
  int couponTotalQuantity;
  int mallCouponMinOrderAmount;
  int merchantType;
 // Null cltCpnStartTime;
  String salesTip;
  bool onlySceneAuth;
  int mallCouponId;
  String descTxt;
  String goodsThumbnailUrl;
  int optId;
  int minNormalPrice;
  bool hasCoupon;
  int mallCouponStartTime;
  String servTxt;
  int mallRate;
  int mallCouponTotalQuantity;
//  Null createAt;
  int mallCouponMaxDiscountAmount;
  int mallCps;

  GoodsList(
      {this.categoryName,
       // this.cltCpnEndTime,
        //this.cltCpnMinAmt,
        this.couponRemainQuantity,
      //  this.cltCpnRemainQuantity,
        this.promotionRate,
        //this.serviceTags,
        this.mallId,
        this.mallName,
        this.mallCouponEndTime,
      //  this.cltCpnBatchSn,
        this.lgstTxt,
        this.goodsName,
       // this.cltCpnDiscount,
        this.goodsId,
      //  this.goodsGalleryUrls,
        this.goodsDesc,
        this.optName,
        this.optIds,
        this.goodsImageUrl,
        this.hasMallCoupon,
        this.minGroupPrice,
        this.couponStartTime,
        this.couponDiscount,
        this.couponEndTime,
        this.zsDuoId,
        this.mallCouponRemainQuantity,
        this.planType,
      //  this.cltCpnQuantity,
        this.crtRfOrdrRto1m,
      //  this.cpsSign,
        this.catIds,
        this.couponMinOrderAmount,
        this.categoryId,
        this.mallCouponDiscountPct,
      //  this.activityType,
       // this.catId,
        this.couponTotalQuantity,
        this.mallCouponMinOrderAmount,
        this.merchantType,
      //  this.cltCpnStartTime,
        this.salesTip,
        this.onlySceneAuth,
        this.mallCouponId,
        this.descTxt,
        this.goodsThumbnailUrl,
        this.optId,
        this.minNormalPrice,
        this.hasCoupon,
        this.mallCouponStartTime,
        this.servTxt,
        this.mallRate,
        this.mallCouponTotalQuantity,
       // this.createAt,
        this.mallCouponMaxDiscountAmount,
        this.mallCps});

  GoodsList.fromJson(Map<String, dynamic> json) {
    categoryName = json['category_name'];
   // cltCpnEndTime = json['clt_cpn_end_time'];
   // cltCpnMinAmt = json['clt_cpn_min_amt'];
    couponRemainQuantity = json['coupon_remain_quantity'];
   // cltCpnRemainQuantity = json['clt_cpn_remain_quantity'];
    promotionRate = json['promotion_rate'];
    //serviceTags = json['service_tags'].cast<int>();
    mallId = json['mall_id'];
    mallName = json['mall_name'];
    mallCouponEndTime = json['mall_coupon_end_time'];
  //  cltCpnBatchSn = json['clt_cpn_batch_sn'];
    lgstTxt = json['lgst_txt'];
    goodsName = json['goods_name'];
   // cltCpnDiscount = json['clt_cpn_discount'];
    goodsId = json['goods_id'];
 //   goodsGalleryUrls = json['goods_gallery_urls'];
    goodsDesc = json['goods_desc'];
    optName = json['opt_name'];
    optIds = json['opt_ids'].cast<int>();
    goodsImageUrl = json['goods_image_url'];
    hasMallCoupon = json['has_mall_coupon'];
    minGroupPrice = json['min_group_price'];
    couponStartTime = json['coupon_start_time'];
    couponDiscount = json['coupon_discount'];
    couponEndTime = json['coupon_end_time'];
    zsDuoId = json['zs_duo_id'];
    mallCouponRemainQuantity = json['mall_coupon_remain_quantity'];
    planType = json['plan_type'];
  // cltCpnQuantity = json['clt_cpn_quantity'];
    crtRfOrdrRto1m = json['crt_rf_ordr_rto1m'];
  //  cpsSign = json['cps_sign'];
    catIds = json['cat_ids'].cast<int>();
    couponMinOrderAmount = json['coupon_min_order_amount'];
    categoryId = json['category_id'];
    mallCouponDiscountPct = json['mall_coupon_discount_pct'];
  //  activityType = json['activity_type'];
  //  catId = json['cat_id'];
    couponTotalQuantity = json['coupon_total_quantity'];
    mallCouponMinOrderAmount = json['mall_coupon_min_order_amount'];
    merchantType = json['merchant_type'];
  //  cltCpnStartTime = json['clt_cpn_start_time'];
    salesTip = json['sales_tip'];
    onlySceneAuth = json['only_scene_auth'];
    mallCouponId = json['mall_coupon_id'];
    descTxt = json['desc_txt'];
    goodsThumbnailUrl = json['goods_thumbnail_url'];
    optId = json['opt_id'];
    minNormalPrice = json['min_normal_price'];
    hasCoupon = json['has_coupon'];
    mallCouponStartTime = json['mall_coupon_start_time'];
    servTxt = json['serv_txt'];
    mallRate = json['mall_rate'];
    mallCouponTotalQuantity = json['mall_coupon_total_quantity'];
  //  createAt = json['create_at'];
    mallCouponMaxDiscountAmount = json['mall_coupon_max_discount_amount'];
    mallCps = json['mall_cps'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_name'] = this.categoryName;
    //data['clt_cpn_end_time'] = this.cltCpnEndTime;
   // data['clt_cpn_min_amt'] = this.cltCpnMinAmt;
    data['coupon_remain_quantity'] = this.couponRemainQuantity;
    //data['clt_cpn_remain_quantity'] = this.cltCpnRemainQuantity;
    data['promotion_rate'] = this.promotionRate;
    //data['service_tags'] = this.serviceTags;
    data['mall_id'] = this.mallId;
    data['mall_name'] = this.mallName;
    data['mall_coupon_end_time'] = this.mallCouponEndTime;
   // data['clt_cpn_batch_sn'] = this.cltCpnBatchSn;
    data['lgst_txt'] = this.lgstTxt;
    data['goods_name'] = this.goodsName;
   // data['clt_cpn_discount'] = this.cltCpnDiscount;
    data['goods_id'] = this.goodsId;
   // data['goods_gallery_urls'] = this.goodsGalleryUrls;
    data['goods_desc'] = this.goodsDesc;
    data['opt_name'] = this.optName;
    data['opt_ids'] = this.optIds;
    data['goods_image_url'] = this.goodsImageUrl;
    data['has_mall_coupon'] = this.hasMallCoupon;
    data['min_group_price'] = this.minGroupPrice;
    data['coupon_start_time'] = this.couponStartTime;
    data['coupon_discount'] = this.couponDiscount;
    data['coupon_end_time'] = this.couponEndTime;
    data['zs_duo_id'] = this.zsDuoId;
    data['mall_coupon_remain_quantity'] = this.mallCouponRemainQuantity;
    data['plan_type'] = this.planType;
   // data['clt_cpn_quantity'] = this.cltCpnQuantity;
    data['crt_rf_ordr_rto1m'] = this.crtRfOrdrRto1m;
   // data['cps_sign'] = this.cpsSign;
    data['cat_ids'] = this.catIds;
    data['coupon_min_order_amount'] = this.couponMinOrderAmount;
    data['category_id'] = this.categoryId;
    data['mall_coupon_discount_pct'] = this.mallCouponDiscountPct;
    //data['activity_type'] = this.activityType;
   // data['cat_id'] = this.catId;
    data['coupon_total_quantity'] = this.couponTotalQuantity;
    data['mall_coupon_min_order_amount'] = this.mallCouponMinOrderAmount;
    data['merchant_type'] = this.merchantType;
  //  data['clt_cpn_start_time'] = this.cltCpnStartTime;
    data['sales_tip'] = this.salesTip;
    data['only_scene_auth'] = this.onlySceneAuth;
    data['mall_coupon_id'] = this.mallCouponId;
    data['desc_txt'] = this.descTxt;
    data['goods_thumbnail_url'] = this.goodsThumbnailUrl;
    data['opt_id'] = this.optId;
    data['min_normal_price'] = this.minNormalPrice;
    data['has_coupon'] = this.hasCoupon;
    data['mall_coupon_start_time'] = this.mallCouponStartTime;
    data['serv_txt'] = this.servTxt;
    data['mall_rate'] = this.mallRate;
    data['mall_coupon_total_quantity'] = this.mallCouponTotalQuantity;
    //data['create_at'] = this.createAt;
    data['mall_coupon_max_discount_amount'] = this.mallCouponMaxDiscountAmount;
    data['mall_cps'] = this.mallCps;
    return data;
  }
}

