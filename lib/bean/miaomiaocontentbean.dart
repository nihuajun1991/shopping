class MiaoContentbean {
  MiaoContent data;

  MiaoContentbean({this.data});

  MiaoContentbean.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new MiaoContent.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class MiaoContent {
  int id;
  String authorId;
  String categoryId;
  CategoryInfo categoryInfo;
  String productCategoryId;
  String coverPath;
  String videoPath;
  String title;
  String summary;
  String body;
  int views;
  String likes;
  int isLike;
  String status;
  CreatedAt createdAt;
  //UpdatedAt updatedAt;
  AuthorInfo authorInfo;
  List<Products> products;

  MiaoContent(
      {this.id,
        this.authorId,
        this.categoryId,
        this.categoryInfo,
        this.productCategoryId,
        this.coverPath,
        this.videoPath,
        this.title,
        this.summary,
        this.body,
        this.views,
        this.likes,
        this.isLike,
        this.status,
        this.createdAt,
        //this.updatedAt,
        this.authorInfo,
        this.products});

  MiaoContent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    authorId = json['author_id'];
    categoryId = json['category_id'];
    categoryInfo = json['category_info'] != null
        ? new CategoryInfo.fromJson(json['category_info'])
        : null;
    productCategoryId = json['product_category_id'];
    coverPath = json['cover_path'];
    videoPath = json['video_path'];
    title = json['title'];
    summary = json['summary'];
    body = json['body'];
    views = json['views'];
    likes = json['likes'];
    isLike = json['is_like'];
    status = json['status'];
    createdAt = json['created_at'] != null
        ? new CreatedAt.fromJson(json['created_at'])
        : null;
//    updatedAt = json['updated_at'] != null
//        ? new UpdatedAt.fromJson(json['updated_at'])
//        : null;
    authorInfo = json['author_info'] != null
        ? new AuthorInfo.fromJson(json['author_info'])
        : null;
    if (json['products'] != null) {
      products = new List<Products>();
      json['products'].forEach((v) {
        products.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['author_id'] = this.authorId;
    data['category_id'] = this.categoryId;
    if (this.categoryInfo != null) {
      data['category_info'] = this.categoryInfo.toJson();
    }
    data['product_category_id'] = this.productCategoryId;
    data['cover_path'] = this.coverPath;
    data['video_path'] = this.videoPath;
    data['title'] = this.title;
    data['summary'] = this.summary;
    data['body'] = this.body;
    data['views'] = this.views;
    data['likes'] = this.likes;
    data['is_like'] = this.isLike;
    data['status'] = this.status;
    if (this.createdAt != null) {
      data['created_at'] = this.createdAt.toJson();
    }
//    if (this.updatedAt != null) {
//      data['updated_at'] = this.updatedAt.toJson();
//    }
    if (this.authorInfo != null) {
      data['author_info'] = this.authorInfo.toJson();
    }
    if (this.products != null) {
      data['products'] = this.products.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoryInfo {
  int id;
  String name;
  Null alias;
  String iconPath;
  String iconName;
  String bannerPath;
  String isShow;
  String createdAt;
  String updatedAt;

  CategoryInfo(
      {this.id,
        this.name,
        this.alias,
        this.iconPath,
        this.iconName,
        this.bannerPath,
        this.isShow,
        this.createdAt,
        this.updatedAt});

  CategoryInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    alias = json['alias'];
    iconPath = json['icon_path'];
    iconName = json['icon_name'];
    bannerPath = json['banner_path'];
    isShow = json['is_show'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['alias'] = this.alias;
    data['icon_path'] = this.iconPath;
    data['icon_name'] = this.iconName;
    data['banner_path'] = this.bannerPath;
    data['is_show'] = this.isShow;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class CreatedAt {
  String date;
  int timezoneType;
  String timezone;

  CreatedAt({this.date, this.timezoneType, this.timezone});

  CreatedAt.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    timezoneType = json['timezone_type'];
    timezone = json['timezone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['timezone_type'] = this.timezoneType;
    data['timezone'] = this.timezone;
    return data;
  }
}

class AuthorInfo {
  int id;
  String userId;
  String avatar;
  String author;
  String introduction;
  Null bgPath;
  String setAuthorAt;
  String createdAt;
  String updatedAt;

  AuthorInfo(
      {this.id,
        this.userId,
        this.avatar,
        this.author,
        this.introduction,
        this.bgPath,
        this.setAuthorAt,
        this.createdAt,
        this.updatedAt});

  AuthorInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    avatar = json['avatar'];
    author = json['author'];
    introduction = json['introduction'];
    bgPath = json['bg_path'];
    setAuthorAt = json['set_author_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['avatar'] = this.avatar;
    data['author'] = this.author;
    data['introduction'] = this.introduction;
    data['bg_path'] = this.bgPath;
    data['set_author_at'] = this.setAuthorAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Products {
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

  Products(
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

  Products.fromJson(Map<String, dynamic> json) {
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

