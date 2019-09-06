
import 'package:flutter/material.dart';
import 'package:flutter_shop/model/CategoryGoodsListModel.dart';

class CategoryGoodsListProvide with ChangeNotifier{

  List<CategoryGoodsListData> goodsList = [];

  getGoodsList(List<CategoryGoodsListData> list){
    goodsList = list;
    notifyListeners();
  }
}