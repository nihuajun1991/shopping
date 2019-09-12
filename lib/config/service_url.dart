import 'dart:convert';


const serviceUrl = "http://newapi.tkjidi.com/api/";
const taobaoUrl = "https://acs.m.taobao.com/h5/";
const taobaoUrl1 = "http://h5api.m.taobao.com/h5/";

// const BCGoodsDetailURL = "taobao.item.detail.get";
// const AlibcAppKey = "";
// const AlibcAppSecret = "";
// const AlibcApiUrl = "http://gw.api.taobao.com/router/rest";

//https://jdapi.xinfang999.com/index.php/api/tb/homeimg

const servicePath = {
  'homePagerContent':serviceUrl+'tkcms/product',//  商店首页
  'homePagerBanner':serviceUrl+'appapi/homebanner', //首页轮播
  'homePagerOrder':'https://www.sumaitao.wang/index.php/api/tb/homeimg',
  'homePagerHotList':serviceUrl+"tkcms/cachePro" ,//热卖商品
  'tabbarList':serviceUrl+"tkcms/classList" ,//热卖商品
  'tbProductInfo':serviceUrl+"getTbProductInfo",
  'tbGoodsDetail':taobaoUrl+"mtop.taobao.detail.getdetail/6.0/",
  'tbGoodsDetail1':taobaoUrl1+"mtop.taobao.detail.getdesc/6.0/",
  'tbShanPinDetail':'https://www.sumaitao.wang/index.php/api/tb/getUland',
  'pddcategory':'http://www.sumaitao.wang/index.php/api/pdd/category',
  'pddcategorygoods':'http://www.sumaitao.wang/index.php/api/pdd/search'
};

