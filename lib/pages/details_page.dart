import 'package:flutter/material.dart';
import 'package:flutter_shop/provide/details_info.dart';
import 'package:provide/provide.dart';

class DetailsPage extends StatelessWidget{

  final String goodsId;

  DetailsPage(this.goodsId);

  @override
  Widget build(BuildContext context) {

    _getBackInfo(context);
    // TODO: implement build
    return Container(
      child: Text('商品id:${goodsId}'),
    );
  }

  void _getBackInfo(BuildContext context)async{
    await Provide.value<DetailsInfoProvide>(context).getGoodsInfo(goodsId);
    print('加载完成。。。。');
  }

}