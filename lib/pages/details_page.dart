import 'package:flutter/material.dart';
import 'package:flutter_shop/provide/details_info.dart';
import 'package:provide/provide.dart';

class DetailsPage extends StatelessWidget{

  final String goodsId;

  DetailsPage(this.goodsId);



  @override
  Widget build(BuildContext context) {


    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            print('返回上一页');
            Navigator.pop(context);
          },
        ),
        title: Text('商品详情页'),
        centerTitle:true,

      ),
      body: FutureBuilder(
          future:_getBackInfo(context),
          builder: (context,snapshot){
            if(snapshot.hasData){
              return Container(
                child: Column(
                  children: <Widget>[

                  ],
                ),
              );
            }else{
              return Text('加载中。。。');
            }
          }
      ),
    );
  }

  Future _getBackInfo(BuildContext context)async{
    await Provide.value<DetailsInfoProvide>(context).getGoodsInfo(goodsId);
    print('加载完成。。。。');
  }

/*  Widget goodsID = Container(
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: Colors.amber,
      border: Border(
        bottom: BorderSide(width: 0.5,color: Colors.black26)
      )
    ),
    child: Text('商品id:${goodsId}'),
  );*/



}

/*class _DetailsPageState extends State<DetailsPage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }*/



