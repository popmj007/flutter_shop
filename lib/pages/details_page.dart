import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget{

  final String goodsId;

  DetailsPage(this.goodsId);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Text('商品id:${goodsId}'),
    );
  }

}