class JDDetail {
  String error;
  String msg;
  String totalCount;
  List<DetailData> data;

  JDDetail({this.error, this.msg, this.totalCount, this.data});

  JDDetail.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    msg = json['msg'];
    totalCount = json['totalCount'];
    if (json['data'] != null) {
      data = new List<DetailData>();
      json['data'].forEach((v) {
        data.add(new DetailData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['msg'] = this.msg;
    data['totalCount'] = this.totalCount;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DetailData {
//  String brandCode;
//  String brandName;
//  CategoryInfo categoryInfo;
//  String comments;
//  CommissionInfo commissionInfo;
  CouponInfo couponInfo;
//  String goodCommentsShare;
  ImageInfo imageInfo;
//  String inOrderComm30Days;
//  String inOrderCount30Days;
//  String isHot;
//  String isJdSale;
  String materialUrl;
//  String owner;
//  PinGouInfo pinGouInfo;
//  PingGouInfo pingGouInfo;
//  PriceInfo priceInfo;
//  ShopInfo shopInfo;
//  String skuId;
//  String skuName;
//  String spuid;

  DetailData(
      {
//        this.brandCode,
//        this.brandName,
//        this.categoryInfo,
//        this.comments,
//        this.commissionInfo,
        this.couponInfo,
//        this.goodCommentsShare,
        this.imageInfo,
//        this.inOrderComm30Days,
//        this.inOrderCount30Days,
//        this.isHot,
//        this.isJdSale,
//        this.materialUrl,
//        this.owner,
//        this.pinGouInfo,
//        this.pingGouInfo,
//        this.priceInfo,
//        this.shopInfo,
//        this.skuId,
//        this.skuName,
//        this.spuid
      });

  DetailData.fromJson(Map<String, dynamic> json) {
//    brandCode = json['brandCode'];
//    brandName = json['brandName'];
//    categoryInfo = json['categoryInfo'] != null
//        ? new CategoryInfo.fromJson(json['categoryInfo'])
//        : null;
//    comments = json['comments'];
//    commissionInfo = json['commissionInfo'] != null
//        ? new CommissionInfo.fromJson(json['commissionInfo'])
//        : null;
    couponInfo = json['couponInfo'] != null
        ? new CouponInfo.fromJson(json['couponInfo'])
        : null;
//    goodCommentsShare = json['goodCommentsShare'];
    imageInfo = json['imageInfo'] != null
        ? new ImageInfo.fromJson(json['imageInfo'])
        : null;
//    inOrderComm30Days = json['inOrderComm30Days'];
//    inOrderCount30Days = json['inOrderCount30Days'];
//    isHot = json['isHot'];
//    isJdSale = json['isJdSale'];
//    materialUrl = json['materialUrl'];
//    owner = json['owner'];
//    pinGouInfo = json['pinGouInfo'] != null
//        ? new PinGouInfo.fromJson(json['pinGouInfo'])
//        : null;
//    pingGouInfo = json['pingGouInfo'] != null
//        ? new PingGouInfo.fromJson(json['pingGouInfo'])
//        : null;
//    priceInfo = json['priceInfo'] != null
//        ? new PriceInfo.fromJson(json['priceInfo'])
//        : null;
//    shopInfo = json['shopInfo'] != null
//        ? new ShopInfo.fromJson(json['shopInfo'])
//        : null;
//    skuId = json['skuId'];
//    skuName = json['skuName'];
//    spuid = json['spuid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
//    data['brandCode'] = this.brandCode;
//    data['brandName'] = this.brandName;
//    if (this.categoryInfo != null) {
//      data['categoryInfo'] = this.categoryInfo.toJson();
//    }
//    data['comments'] = this.comments;
//    if (this.commissionInfo != null) {
//      data['commissionInfo'] = this.commissionInfo.toJson();
//    }
    if (this.couponInfo != null) {
      data['couponInfo'] = this.couponInfo.toJson();
    }
//    data['goodCommentsShare'] = this.goodCommentsShare;
    if (this.imageInfo != null) {
      data['imageInfo'] = this.imageInfo.toJson();
    }
  //  data['inOrderComm30Days'] = this.inOrderComm30Days;
//    data['inOrderCount30Days'] = this.inOrderCount30Days;
//    data['isHot'] = this.isHot;
//    data['isJdSale'] = this.isJdSale;
//    data['materialUrl'] = this.materialUrl;
//    data['owner'] = this.owner;
//    if (this.pinGouInfo != null) {
//      data['pinGouInfo'] = this.pinGouInfo.toJson();
//    }
//    if (this.pingGouInfo != null) {
//      data['pingGouInfo'] = this.pingGouInfo.toJson();
//    }
//    if (this.priceInfo != null) {
//      data['priceInfo'] = this.priceInfo.toJson();
//    }
//    if (this.shopInfo != null) {
//      data['shopInfo'] = this.shopInfo.toJson();
//    }
//    data['skuId'] = this.skuId;
//    data['skuName'] = this.skuName;
//    data['spuid'] = this.spuid;
    return data;
  }
}

class CategoryInfo {
  String cid1;
  String cid1Name;
  String cid2;
  String cid2Name;
  String cid3;
  String cid3Name;

  CategoryInfo(
      {this.cid1,
        this.cid1Name,
        this.cid2,
        this.cid2Name,
        this.cid3,
        this.cid3Name});

  CategoryInfo.fromJson(Map<String, dynamic> json) {
    cid1 = json['cid1'];
    cid1Name = json['cid1Name'];
    cid2 = json['cid2'];
    cid2Name = json['cid2Name'];
    cid3 = json['cid3'];
    cid3Name = json['cid3Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cid1'] = this.cid1;
    data['cid1Name'] = this.cid1Name;
    data['cid2'] = this.cid2;
    data['cid2Name'] = this.cid2Name;
    data['cid3'] = this.cid3;
    data['cid3Name'] = this.cid3Name;
    return data;
  }
}

class CommissionInfo {
  String commission;
  String commissionShare;

  CommissionInfo({this.commission, this.commissionShare});

  CommissionInfo.fromJson(Map<String, dynamic> json) {
    commission = json['commission'];
    commissionShare = json['commissionShare'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['commission'] = this.commission;
    data['commissionShare'] = this.commissionShare;
    return data;
  }
}

class CouponInfo {
  List<CouponList> couponList;

  CouponInfo({this.couponList});

  CouponInfo.fromJson(Map<String, dynamic> json) {
    if (json['couponList'] != null) {
      couponList = new List<CouponList>();
      json['couponList'].forEach((v) {
        couponList.add(new CouponList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.couponList != null) {
      data['couponList'] = this.couponList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}



class CouponList {
  String bindType;
  String discount;
  String getEndTime;
  String getStartTime;
  String isBest;
  String link;
  String platformType;
  String quota;
  String useEndTime;
  String useStartTime;

  CouponList(
      {this.bindType,
        this.discount,
        this.getEndTime,
        this.getStartTime,
        this.isBest,
        this.link,
        this.platformType,
        this.quota,
        this.useEndTime,
        this.useStartTime});

  CouponList.fromJson(Map<String, dynamic> json) {
    bindType = json['bindType'];
    discount = json['discount'];
    getEndTime = json['getEndTime'];
    getStartTime = json['getStartTime'];
    isBest = json['isBest'];
    link = json['link'];
    platformType = json['platformType'];
    quota = json['quota'];
    useEndTime = json['useEndTime'];
    useStartTime = json['useStartTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bindType'] = this.bindType;
    data['discount'] = this.discount;
    data['getEndTime'] = this.getEndTime;
    data['getStartTime'] = this.getStartTime;
    data['isBest'] = this.isBest;
    data['link'] = this.link;
    data['platformType'] = this.platformType;
    data['quota'] = this.quota;
    data['useEndTime'] = this.useEndTime;
    data['useStartTime'] = this.useStartTime;
    return data;
  }
}

class ImageInfo {
  List<ImageList> imageList;

  ImageInfo({this.imageList});

  ImageInfo.fromJson(Map<String, dynamic> json) {
    if (json['imageList'] != null) {
      imageList = new List<ImageList>();
      json['imageList'].forEach((v) {
        imageList.add(new ImageList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.imageList != null) {
      data['imageList'] = this.imageList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ImageList {
  String url;

  ImageList({this.url});

  ImageList.fromJson(Map<String, dynamic> json) {
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    return data;
  }
}

class PinGouInfo {
  String pingouEndTime;
  String pingouPrice;
  String pingouStartTime;
  String pingouTmCount;
  String pingouUrl;

  PinGouInfo(
      {this.pingouEndTime,
        this.pingouPrice,
        this.pingouStartTime,
        this.pingouTmCount,
        this.pingouUrl});

  PinGouInfo.fromJson(Map<String, dynamic> json) {
    pingouEndTime = json['pingouEndTime'];
    pingouPrice = json['pingouPrice'];
    pingouStartTime = json['pingouStartTime'];
    pingouTmCount = json['pingouTmCount'];
    pingouUrl = json['pingouUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pingouEndTime'] = this.pingouEndTime;
    data['pingouPrice'] = this.pingouPrice;
    data['pingouStartTime'] = this.pingouStartTime;
    data['pingouTmCount'] = this.pingouTmCount;
    data['pingouUrl'] = this.pingouUrl;
    return data;
  }
}

class PingGouInfo {
  String pingouPrice;
  String pingouTmCount;
  String pingouUrl;

  PingGouInfo({this.pingouPrice, this.pingouTmCount, this.pingouUrl});

  PingGouInfo.fromJson(Map<String, dynamic> json) {
    pingouPrice = json['pingouPrice'];
    pingouTmCount = json['pingouTmCount'];
    pingouUrl = json['pingouUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pingouPrice'] = this.pingouPrice;
    data['pingouTmCount'] = this.pingouTmCount;
    data['pingouUrl'] = this.pingouUrl;
    return data;
  }
}

class PriceInfo {
  String lowestPrice;
  String lowestPriceType;
  String price;

  PriceInfo({this.lowestPrice, this.lowestPriceType, this.price});

  PriceInfo.fromJson(Map<String, dynamic> json) {
    lowestPrice = json['lowestPrice'];
    lowestPriceType = json['lowestPriceType'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lowestPrice'] = this.lowestPrice;
    data['lowestPriceType'] = this.lowestPriceType;
    data['price'] = this.price;
    return data;
  }
}

class ShopInfo {
  String shopId;
  String shopName;

  ShopInfo({this.shopId, this.shopName});

  ShopInfo.fromJson(Map<String, dynamic> json) {
    shopId = json['shopId'];
    shopName = json['shopName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['shopId'] = this.shopId;
    data['shopName'] = this.shopName;
    return data;
  }
}

