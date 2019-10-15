class Goodsbean {
  Results results;
  String requestId;

  Goodsbean({this.results, this.requestId});

  Goodsbean.fromJson(Map<String, dynamic> json) {
    results =
        json['results'] != null ? new Results.fromJson(json['results']) : null;
    requestId = json['request_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.results != null) {
      data['results'] = this.results.toJson();
    }
    data['request_id'] = this.requestId;
    return data;
  }
}

class Results {
  NTbkItem nTbkItem;

  Results({this.nTbkItem});

  Results.fromJson(Map<String, dynamic> json) {
    nTbkItem = json['n_tbk_item'] != null
        ? new NTbkItem.fromJson(json['n_tbk_item'])
        : null;
  }


  @override
  String toString() {
    return 'Results{nTbkItem: $nTbkItem}';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.nTbkItem != null) {
      data['n_tbk_item'] = this.nTbkItem.toJson();
    }
    return data;
  }
}

class NTbkItem {
  String catLeafName;
  String catName;
  String itemUrl;
  String materialLibType;
  //String nick;
  String numIid;
  String pictUrl;
  String provcity;
  String reservePrice;
  String sellerId;
  SmallImages smallImages;
  String title;
  String userType;
  String volume;
  String zkFinalPrice;

  NTbkItem(
      {this.catLeafName,
      this.catName,
      this.itemUrl,
      this.materialLibType,
      //this.nick,
      this.numIid,
      this.pictUrl,
      this.provcity,
      this.reservePrice,
      this.sellerId,
      this.smallImages,
      this.title,
      this.userType,
      this.volume,
      this.zkFinalPrice});


  @override
  String toString() {
    return 'NTbkItem{catLeafName: $catLeafName, catName: $catName, itemUrl: $itemUrl, materialLibType: $materialLibType,  numIid: $numIid, pictUrl: $pictUrl, provcity: $provcity, reservePrice: $reservePrice, sellerId: $sellerId, smallImages: $smallImages, title: $title, userType: $userType, volume: $volume, zkFinalPrice: $zkFinalPrice}';
  }

  NTbkItem.fromJson(Map<String, dynamic> json) {
    catLeafName = json['cat_leaf_name'];
    catName = json['cat_name'];
    itemUrl = json['item_url'];
    materialLibType = json['material_lib_type'];
    //nick = json['nick'];
    numIid = json['num_iid'];
    pictUrl = json['pict_url'];
    provcity = json['provcity'];
    reservePrice = json['reserve_price'];
    sellerId = json['seller_id'];
    smallImages = json['small_images'] != null
        ? new SmallImages.fromJson(json['small_images'])
        : null;
    title = json['title'];
    userType = json['user_type'];
    volume = json['volume'];
    zkFinalPrice = json['zk_final_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cat_leaf_name'] = this.catLeafName;
    data['cat_name'] = this.catName;
    data['item_url'] = this.itemUrl;
    data['material_lib_type'] = this.materialLibType;
    //data['nick'] = this.nick;
    data['num_iid'] = this.numIid;
    data['pict_url'] = this.pictUrl;
    data['provcity'] = this.provcity;
    data['reserve_price'] = this.reservePrice;
    data['seller_id'] = this.sellerId;
    if (this.smallImages != null) {
      data['small_images'] = this.smallImages.toJson();
    }
    data['title'] = this.title;
    data['user_type'] = this.userType;
    data['volume'] = this.volume;
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

