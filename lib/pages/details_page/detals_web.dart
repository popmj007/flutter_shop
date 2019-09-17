import 'package:provide/provide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import '../../provide/details_info.dart';
import 'package:flutter_html/flutter_html.dart';


class DetailsWeb extends StatelessWidget{


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var goodsDetail = Provide.value<DetailsInfoProvide>(context).goodsInfo.data.goodInfo.goodsDetail;
    print("html:  "+goodsDetail);
    return Container(
      child: Html(
        data: goodsDetail,
      ),
    );
  }

}