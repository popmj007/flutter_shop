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
      print(responseData);
      goodsInfo = DetailsModel.fromJson(responseData);

      notifyListeners();

    });

  }
}