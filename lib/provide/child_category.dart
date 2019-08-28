import 'package:flutter/material.dart';
import 'package:flutter_shop/model/CategoryBigModel.dart';

class ChildCategory with ChangeNotifier{
  List<BxMallSubDto> childCategoryList = [];

  getChildCategory(List list){
    childCategoryList = list;
    print("yxl=============>"+childCategoryList.length.toString());
    notifyListeners();
  }
}