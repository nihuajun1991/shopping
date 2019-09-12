import 'dart:io';

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
    print('火热商品数据.......');
    Response response;
    Dio dio = new Dio();
    print(servicePath['homePagerContent']+"?page=${pager}&cid=${cid}");
        

    if (pager == null) {
      response =
          await dio.get(servicePath['homePagerContent'], queryParameters: {
        "cid": cid,
      });
    } else if(cid == null){
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
    response = await dio.post(servicePath['tbProductInfo'],data: {
      'ids':tbId
    });
    //print("response${response.data}");
    if (response.statusCode == 200) {
     // print(response.data);
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

Future getGoodsDetail1(itemNumId) async {
try {
    Response response;
    Dio dio = new Dio();
    //print(servicePath['tbGoodsDetail']+'?data=%7B"itemNumId"%3A"$itemNumId"%7D&qq-pf-to=pcqq.group');
    //response = await dio.get(servicePath['tbGoodsDetail']+'?data=%7B"itemNumId"%3A"$itemNumId"%7D&qq-pf-to=pcqq.group');
//    print(servicePath['tbGoodsDetail1']+'?data={%22id%22:%22$itemNumId%22}');
    response = await dio.get(servicePath['tbGoodsDetail1']+'?data={%22id%22:%22$itemNumId%22}');
    print('tbGoodsDetail:'+servicePath['tbGoodsDetail1']+'?data={%22id%22:%22$itemNumId%22}');
    if (response.statusCode == 200) {
      print("response${response.data}");
      return response;
    } else {
      throw Exception('后端接口出现异常');
    }
  } catch (e) {
    return print(e);
  }
}



Future getShanPinDetail(String taobaoId,String title) async {
  try{
   Response response;
   Dio dio = new Dio();
   var data={'taobao_id':taobaoId,'title':title};

   response = await dio.post(servicePath["tbShanPinDetail"],
     data:data,
     options: new Options(
       contentType: ContentType.parse("application/x-www-form-urlencoded")),
   );
   //print("response:${response.statusCode}");

   if (response.statusCode == 200) {
     //print("执行返回数据:${response.data}");
     return response.data;
   } else {
     return response.data;
   }
  }catch(e){
    return print(e);
  }

}


Future getNinePagerContent(double min_price,double max_price,int pagerindex) async {
  try {
    //print('开始获取首页数据.......');
    Response response;
    Dio dio = new Dio(
        BaseOptions(
          connectTimeout: 10000,
          receiveTimeout: 10000,
        )
    );
    print(servicePath['homePagerBanner']);
    response = await dio
        .get(servicePath['homePagerContent'], queryParameters: {
          "min_price": min_price,
          "max_price":max_price,
       "page":pagerindex
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


Future getPDDTab() async {
  try{
    Response response;
    Dio dio = new Dio();


    response = await dio.post(servicePath["pddcategory"]);
    //print("response:${response.statusCode}");

    if (response.statusCode == 200) {
      //print("执行返回数据:${response.data}");
      return response.data;
    } else {
      throw Exception('后端接口出现异常');
    }
  }catch(e){
    return print(e);
  }

}


Future getPDDCategroy(String opt_id,String page) async {
  try{
    Response response;
    Dio dio = new Dio();
    response = await dio.get(servicePath["pddcategorygoods"],queryParameters: {
      'opt_id':opt_id,
       'page':page
    });
    //print("response:${response.statusCode}");

    if (response.statusCode == 200) {
      //print("执行返回数据:${response.data}");
      return response.data;
    } else {
      throw Exception('后端接口出现异常');
    }
  }catch(e){
    return print(e);
  }

}

