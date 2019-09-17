import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_shop/model/details.dart';
import 'package:flutter_shop/service/service_method.dart';

class DetailsInfoProvide with ChangeNotifier{

  DetailsModel goodsInfo = null;

  getGoodsInfo(String id){
    var formData = {'goodId':id,};

    request('getGoodDetailById',formData:formData).then((val){
      var responseData = json.decode(val.toString());
      goodsInfo = DetailsModel.fromJson(responseData);
      print("商品詳情:"+goodsInfo.data.goodInfo.goodsName);

      notifyListeners();

    });

  }
}