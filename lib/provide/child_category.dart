import 'package:flutter/material.dart';
import 'package:flutter_shop/model/CategoryBigModel.dart';

class ChildCategory with ChangeNotifier{
  List<BxMallSubDto> childCategoryList = [];

  getChildCategory(List<BxMallSubDto> list){
    BxMallSubDto all = BxMallSubDto();
    all.mallCategoryId = "";
    all.mallSubId = "";
    all.mallSubName = "全部";
    all.comments = "";
    childCategoryList = [all];
    childCategoryList.addAll(list);
    print("yxl=============>"+childCategoryList.length.toString());
    notifyListeners();
  }
}