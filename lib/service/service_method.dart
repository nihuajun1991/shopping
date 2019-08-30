import 'package:dio/dio.dart';
import 'dart:async';
//import 'dart:io';

import '../config/service_url.dart';

//获取首页主题内容




Future getHomePagerContent() async {
  try {
    //print('开始获取首页数据.......');
    Response response;
    Dio dio = new Dio(
      BaseOptions(
        connectTimeout: 10000,
        receiveTimeout: 10000,
      )
    );
    //print(servicePath['homePagerBanner']);
    response = await dio
        .get(servicePath['homePagerBanner'], queryParameters: {"act": "app"});
    if (response.statusCode == 200) {
      //print(response.data);
      return response.data;
    } else {
      throw Exception('后端接口出现异常');
    }
  } catch (e) {
    return print(e);
  }
}

Future getHomeOrderImg() async {
  try {
    //print('开始获取首页数据.......');
    Response response;
    Dio dio = new Dio();
    //print(servicePath['homePagerOrder']);
    response = await dio.get(servicePath['homePagerOrder']);
    if (response.statusCode == 200) {
      //print(response.data);
      return response.data;
    } else {
      throw Exception('后端接口出现异常');
    }
  } catch (e) {
    return print(e);
  }
}

Future getHotList() async {
  try {
    //print('开始获取热卖商品数据.......');
    Response response;
    Dio dio = new Dio();
    //print(servicePath['homePagerHotList']);
    response = await dio.get(servicePath['homePagerHotList']);
    if (response.statusCode == 200) {
      //print(response.data);
      return response.data;
    } else {
      throw Exception('后端接口出现异常');
    }
  } catch (e) {
    return print(e);
  }
}

Future getShanPinList({pager, cid}) async {
  try {
    //print('开始获取商品数据.......');
    Response response;
    Dio dio = new Dio();
    //print(servicePath['homePagerContent']+"?page=${pager}&cid=${cid}");
        

    if (pager == null) {
      response =
          await dio.get(servicePath['homePagerContent'], queryParameters: {
        "cid": cid,
      });
    } else if(pager == null){
      response =
          await dio.get(servicePath['homePagerContent'], queryParameters: {
        "page": pager,
      });
    }else{
      response =
          await dio.get(servicePath['homePagerContent'], queryParameters: {
        "cid": cid,"page": pager,
      });
    }

    if (response.statusCode == 200) {
      //print(response.data);
      return response;
    } else {
      throw Exception('后端接口出现异常');
    }
  } catch (e) {
    return print(e);
  }
}

Future getTagBarList() async {
  try {
    //print('开始获取标题数据.......');
    Response response;
    Dio dio = new Dio();
    //print(servicePath['tabbarList']);
    response = await dio.get(servicePath['tabbarList']);

    if (response.statusCode == 200) {
      //print(response.data);
      return response;
    } else {
      throw Exception('后端接口出现异常');
    }
  } catch (e) {
    return print(e);
  }
}


Future getTbProductInfo(tbId) async {
  try {
    print('开始获取标题数据.......');
    Response response;
    Dio dio = new Dio();
    print(servicePath['tbProductInfo']+"?tbId=$tbId");
    response = await dio.post(servicePath['tbProductInfo'],queryParameters: {
      'ids':tbId
    });

    if (response.statusCode == 200) {
      //print(response.data);
      return response;
    } else {
      throw Exception('后端接口出现异常');
    }
  } catch (e) {
    return print(e);
  }
}

Future getGoodsDetail(itemNumId) async {
try {
    Response response;
    Dio dio = new Dio();
    print(servicePath['tbGoodsDetail']+'?data=%7B"itemNumId"%3A"$itemNumId"%7D&qq-pf-to=pcqq.group');
    response = await dio.get(servicePath['tbGoodsDetail']+'?data=%7B"itemNumId"%3A"$itemNumId"%7D&qq-pf-to=pcqq.group');
    print('tbGoodsDetail:'+response.data.toString());
    if (response.statusCode == 200) {
      //print(response.data);
      return response;
    } else {
      throw Exception('后端接口出现异常');
    }
  } catch (e) {
    return print(e);
  }
}

Future getGoodsDetail1(itemNumId) async {
try {
    Response response;
    Dio dio = new Dio();
    //print(servicePath['tbGoodsDetail']+'?data=%7B"itemNumId"%3A"$itemNumId"%7D&qq-pf-to=pcqq.group');
    //response = await dio.get(servicePath['tbGoodsDetail']+'?data=%7B"itemNumId"%3A"$itemNumId"%7D&qq-pf-to=pcqq.group');
    print(servicePath['tbGoodsDetail1']+'?data={%22id%22:%22$itemNumId%22}');
    response = await dio.get(servicePath['tbGoodsDetail1']+'?data={%22id%22:%22$itemNumId%22}');
    //print('tbGoodsDetail:'+response.data.toString());
    if (response.statusCode == 200) {
      //print(response.data);
      return response;
    } else {
      throw Exception('后端接口出现异常');
    }
  } catch (e) {
    return print(e);
  }
}

