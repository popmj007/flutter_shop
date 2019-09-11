import 'package:flutter/material.dart';
import 'package:flutter_shop/model/CategoryBigModel.dart';

class ChildCategory with ChangeNotifier {
  List<BxMallSubDto> childCategoryList = [];

  int page = 1; //列表页数

  String noMoreText = ''; //显示更多的标识

  getChildCategory(List<BxMallSubDto> list) {
    page = 1;
    noMoreText = '';

    BxMallSubDto all = BxMallSubDto();
    all.mallCategoryId = "";
    all.mallSubId = "";
    all.mallSubName = "全部";
    all.comments = "";
    childCategoryList = [all];
    childCategoryList.addAll(list);
    print("yxl=============>" + childCategoryList.length.toString());
    notifyListeners();
  }

  //改变noMoreText数据
  changeNoMore(String text) {
    noMoreText = text;
    notifyListeners();
  }

  addPage() {
    page++;
    notifyListeners();
  }

  setPage() {
    page =1;
    notifyListeners();
  }
}