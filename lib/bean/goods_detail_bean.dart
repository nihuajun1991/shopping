
class GoodsDetailBean {
  int code;
  String msg;
  ShanPin data;
  int count;

  GoodsDetailBean({this.code, this.msg, this.data, this.count});

  GoodsDetailBean.fromJson(Map<String, dynamic> json) {
    code = json['code'] !=null ? json['code'] :null;
    msg = json['msg'];
    data = json['data'] != null ? new ShanPin.fromJson(json['data']) : null;
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['count'] = this.count;
    return data;
  }
}

class ShanPin {
//  String categoryId;
//  String categoryName;
//  String commissionRate;
//  String commissionType;
  String couponAmount;
//  String couponEndTime;
//  String couponId;
//  String couponInfo;
//  String couponRemainCount;
  String couponShareUrl;
//  String couponStartFee;
//  String couponStartTime;
//  String couponTotalCount;
//  String includeDxjh;
//  String includeMkt;
//  String infoDxjh;
//  //String itemDescription;
//  String itemId;
//  String itemUrl;
//  String levelOneCategoryId;
//  String levelOneCategoryName;
//  String nick;
//  String numIid;
//  String pictUrl;
//  String provcity;
//  String realPostFee;
//  String reservePrice;
//  String sellerId;
//  String shopDsr;
//  String shopTitle;
//  String shortTitle;
  SmallImages smallImages;
  String title;
//  String tkTotalCommi;
//  String tkTotalSales;
  String url;
//  String userType;
//  String volume;
//  String whiteImage;
//  String xId;
  String zkFinalPrice;

  ShanPin(
      {
//        this.categoryId,
//      this.categoryName,
//      this.commissionRate,
//      this.commissionType,
      this.couponAmount,
//      this.couponEndTime,
//      this.couponId,
//      this.couponInfo,
//      this.couponRemainCount,
      this.couponShareUrl,
//      this.couponStartFee,
//      this.couponStartTime,
//      this.couponTotalCount,
//      this.includeDxjh,
//      this.includeMkt,
//      this.infoDxjh,
//      //this.itemDescription,
//      this.itemId,
//      this.itemUrl,
//      this.levelOneCategoryId,
//      this.levelOneCategoryName,
//      this.nick,
//      this.numIid,
//      this.pictUrl,
//      this.provcity,
//      this.realPostFee,
//      this.reservePrice,
//      this.sellerId,
//      this.shopDsr,
//      this.shopTitle,
//      this.shortTitle,
      this.smallImages,
      this.title,
//      this.tkTotalCommi,
//      this.tkTotalSales,
      this.url,
//      this.userType,
//      this.volume,
//      this.whiteImage,
//      this.xId,
      this.zkFinalPrice
      }
      );

  ShanPin.fromJson(Map<String, dynamic> json) {
//    categoryId = json['category_id'];
//    categoryName = json['category_name'];
//    commissionRate = json['commission_rate'];
//    commissionType = json['commission_type'];
    couponAmount = json['coupon_amount'];
//    couponEndTime = json['coupon_end_time'];
//    couponId = json['coupon_id'];
//    couponInfo = json['coupon_info'];
//    couponRemainCount = json['coupon_remain_count'];
    couponShareUrl = json['coupon_share_url'];
//    couponStartFee = json['coupon_start_fee'];
//    couponStartTime = json['coupon_start_time'];
//    couponTotalCount = json['coupon_total_count'];
//    includeDxjh = json['include_dxjh'];
//    includeMkt = json['include_mkt'];
//    infoDxjh = json['info_dxjh'];
    //itemDescription = json['item_description'];
//    itemId = json['item_id'];
//    itemUrl = json['item_url'];
//    levelOneCategoryId = json['level_one_category_id'];
//    levelOneCategoryName = json['level_one_category_name'];
//    nick = json['nick'];
//    numIid = json['num_iid'];
//    pictUrl = json['pict_url'];
//    provcity = json['provcity'];
//    realPostFee = json['real_post_fee'];
//    reservePrice = json['reserve_price'];
//    sellerId = json['seller_id'];
//    shopDsr = json['shop_dsr'];
//    shopTitle = json['shop_title'];
//    shortTitle = json['short_title'];
    smallImages = json['small_images'] != null
        ? new SmallImages.fromJson(json['small_images'])
        : null;
    title = json['title'];
//    tkTotalCommi = json['tk_total_commi'];
//    tkTotalSales = json['tk_total_sales'];
    url = json['url'];
//    userType = json['user_type'];
//    volume = json['volume'];
//    whiteImage = json['white_image'];
//    xId = json['x_id'];
    zkFinalPrice = json['zk_final_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
//    data['category_id'] = this.categoryId;
//    data['category_name'] = this.categoryName;
//    data['commission_rate'] = this.commissionRate;
//    data['commission_type'] = this.commissionType;
    data['coupon_amount'] = this.couponAmount;
//    data['coupon_end_time'] = this.couponEndTime;
//    data['coupon_id'] = this.couponId;
//    data['coupon_info'] = this.couponInfo;
//    data['coupon_remain_count'] = this.couponRemainCount;
    data['coupon_share_url'] = this.couponShareUrl;
//    data['coupon_start_fee'] = this.couponStartFee;
//    data['coupon_start_time'] = this.couponStartTime;
//    data['coupon_total_count'] = this.couponTotalCount;
//    data['include_dxjh'] = this.includeDxjh;
//    data['include_mkt'] = this.includeMkt;
//    data['info_dxjh'] = this.infoDxjh;
//    //data['item_description'] = this.itemDescription;
//    data['item_id'] = this.itemId;
//    data['item_url'] = this.itemUrl;
//    data['level_one_category_id'] = this.levelOneCategoryId;
//    data['level_one_category_name'] = this.levelOneCategoryName;
//    data['nick'] = this.nick;
//    data['num_iid'] = this.numIid;
//    data['pict_url'] = this.pictUrl;
//    data['provcity'] = this.provcity;
//    data['real_post_fee'] = this.realPostFee;
//    data['reserve_price'] = this.reservePrice;
//    data['seller_id'] = this.sellerId;
//    data['shop_dsr'] = this.shopDsr;
//    data['shop_title'] = this.shopTitle;
//    data['short_title'] = this.shortTitle;
    if (this.smallImages != null) {
      data['small_images'] = this.smallImages.toJson();
    }
    data['title'] = this.title;
//    data['tk_total_commi'] = this.tkTotalCommi;
//    data['tk_total_sales'] = this.tkTotalSales;
    data['url'] = this.url;
//    data['user_type'] = this.userType;
//    data['volume'] = this.volume;
//    data['white_image'] = this.whiteImage;
//    data['x_id'] = this.xId;
    data['zk_final_price'] = this.zkFinalPrice;
    return data;
  }
}

class SmallImages {
  List<String> string;

  SmallImages({this.string});

  SmallImages.fromJson(Map<String, dynamic> json) {
    string = json['string'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['string'] = this.string;
    return data;
  }
}

