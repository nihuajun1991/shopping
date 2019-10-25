class MMArticle {
  List<MMArticleData> data;
  Meta meta;

  MMArticle({this.data, this.meta});

  MMArticle.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<MMArticleData>();
      json['data'].forEach((v) { data.add(new MMArticleData.fromJson(v)); });
    }
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    if (this.meta != null) {
      data['meta'] = this.meta.toJson();
    }
    return data;
  }
}

class MMArticleData {
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
  String views;
  String likes;
  int isLike;
  String status;
  CreatedAt createdAt;
  UpdatedAt updatedAt;
  AuthorInfo authorInfo;
  //List<Products> products;

  MMArticleData({this.id, this.authorId, this.categoryId, this.categoryInfo, this.productCategoryId, this.coverPath, this.videoPath, this.title, this.summary, this.body, this.views, this.likes, this.isLike, this.status, this.createdAt, this.updatedAt, this.authorInfo});

  MMArticleData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    authorId = json['author_id'];
    categoryId = json['category_id'];
    categoryInfo = json['category_info'] != null ? new CategoryInfo.fromJson(json['category_info']) : null;
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
    createdAt = json['created_at'] != null ? new CreatedAt.fromJson(json['created_at']) : null;
    updatedAt = json['updated_at'] != null ? new UpdatedAt.fromJson(json['updated_at']) : null;
    authorInfo = json['author_info'] != null ? new AuthorInfo.fromJson(json['author_info']) : null;
//    if (json['products'] != null) {
//      products = new List<Products>();
//      json['products'].forEach((v) { products.add(new Products.fromJson(v)); });
//    }
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
    if (this.updatedAt != null) {
      data['updated_at'] = this.updatedAt.toJson();
    }
    if (this.authorInfo != null) {
      data['author_info'] = this.authorInfo.toJson();
    }
//    if (this.products != null) {
//      data['products'] = this.products.map((v) => v.toJson()).toList();
//    }
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

  CategoryInfo({this.id, this.name, this.alias, this.iconPath, this.iconName, this.bannerPath, this.isShow, this.createdAt, this.updatedAt});

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


class UpdatedAt {
  String date;
  int timezoneType;
  String timezone;

  UpdatedAt({this.date, this.timezoneType, this.timezone});

  UpdatedAt.fromJson(Map<String, dynamic> json) {
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

  AuthorInfo({this.id, this.userId, this.avatar, this.author, this.introduction, this.bgPath, this.setAuthorAt, this.createdAt, this.updatedAt});

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

//class Products {
//
//
//  Products({});
//
//Products.fromJson(Map<String, dynamic> json) {
//}
//
//Map<String, dynamic> toJson() {
//  final Map<String, dynamic> data = new Map<String, dynamic>();
//  return data;
//}
//}

class Meta {
  Pagination pagination;

  Meta({this.pagination});

  Meta.fromJson(Map<String, dynamic> json) {
    pagination = json['pagination'] != null ? new Pagination.fromJson(json['pagination']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pagination != null) {
      data['pagination'] = this.pagination.toJson();
    }
    return data;
  }
}

class Pagination {
  int total;
  int count;
  int perPage;
  int currentPage;
  int totalPages;
  Links links;

  Pagination({this.total, this.count, this.perPage, this.currentPage, this.totalPages, this.links});

  Pagination.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    count = json['count'];
    perPage = json['per_page'];
    currentPage = json['current_page'];
    totalPages = json['total_pages'];
    links = json['links'] != null ? new Links.fromJson(json['links']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['count'] = this.count;
    data['per_page'] = this.perPage;
    data['current_page'] = this.currentPage;
    data['total_pages'] = this.totalPages;
    if (this.links != null) {
      data['links'] = this.links.toJson();
    }
    return data;
  }
}

class Links {
  String next;

  Links({this.next});

  Links.fromJson(Map<String, dynamic> json) {
    next = json['next'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['next'] = this.next;
    return data;
  }
}

