import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/provide/child_category.dart';
import 'package:flutter_shop/service/service_method.dart';
import 'package:flutter_shop/model/CategoryBigModel.dart';
import 'package:provide/provide.dart';
import 'package:flutter_shop/model/CategoryGoodsListModel.dart';

class CategoryPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _CategoryPageState();
  }


}

class _CategoryPageState extends State<CategoryPage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text('商品分类',style: TextStyle(color: Colors.white))),
      body: Container(
        child: Row(
          children: <Widget>[
            LeftCategoryNav(),
            Column(
              children: <Widget>[
                RightCategoryNav(),
                CategoryGoodsList()
              ],
            )
          ],
        ),
      )
    );
  }


}

class LeftCategoryNav extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _LeftCategoryNavState();
  }


}
class _LeftCategoryNavState extends State<LeftCategoryNav>{

  List mlist = [];
  var listIndex = 0;//大类索引

  @override
  void initState() {
    // TODO: implement initState
    _getCategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: ScreenUtil().setWidth(180),
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(width: 1,color: Colors.black12)
        )
      ),
      child: ListView.builder(
        itemCount: mlist.length,
        itemBuilder: (context,index){
          return _leftInkWell(index);
        }
      )
    );
  }

  void _getCategory() async{
    await request('getCategory').then((val){
      var data = json.decode(val.toString());
      CategoryModel categoryModel = CategoryModel.fromJson(data);
      categoryModel.data.forEach((item)=>print(item.mallCategoryName));
      setState(() {
        mlist = categoryModel.data;
      });

      //一级菜单默认选中第一项,所以先获取二级分类菜单数据
      Provide.value<ChildCategory>(context).getChildCategory(mlist[0].bxMallSubDto);
    });
  }

  Widget _leftInkWell(int index){

    bool isClick = false;
    isClick = (index == listIndex)?true:false;

    return InkWell(
      onTap: (){

        setState(() {
          listIndex = index;
          smallCategoryIndex = 0;
        });

        var childList = mlist[index].bxMallSubDto;
        Provide.value<ChildCategory>(context).getChildCategory(childList);
      },
      child: Container(
        height: ScreenUtil().setHeight(100),
        padding: EdgeInsets.only(left: 10,top: 20),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isClick?Colors.black12:Colors.white,
          border: Border(
            bottom: BorderSide(width: 1,color: Colors.black12)
          )
        ),
        child: Text(mlist[index].mallCategoryName,style: TextStyle(fontSize: ScreenUtil().setSp(28)),),
      ),
    );
  }

}

class RightCategoryNav extends StatefulWidget{


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _RightCategoryNavState();
  }

}
var smallCategoryIndex = 0;//小类索引
class _RightCategoryNavState extends State<RightCategoryNav>{




  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Provide<ChildCategory>(
        builder: (context,child,childCategory){
          return Container(
            height: ScreenUtil().setHeight(80),
            width: ScreenUtil().setWidth(570),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(width: 1,color: Colors.black12)
              )
            ),
            child:ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context,index){
                  return _rightInkWell(childCategory.childCategoryList[index],index);
                },
                itemCount: childCategory.childCategoryList.length,
            ),
          );
        },
      ),
    );
  }

  Widget _rightInkWell(BxMallSubDto item,int index){
    bool isClick = false;
    isClick = (smallCategoryIndex == index)?true:false;

    return InkWell(
      onTap: (){
        setState(() {
          smallCategoryIndex = index;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: isClick?Colors.pink[50]:Colors.white
        ),
        height: ScreenUtil().setHeight(100),
        padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
        child: Text(
          item.mallSubName,
          style: TextStyle(fontSize: ScreenUtil().setSp(28)),
        ),
      ),
    );
  }

}

class CategoryGoodsList extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _CategoryGoodsListState();
  }

}

class _CategoryGoodsListState extends State<CategoryGoodsList>{

  List<CategoryGoodsListData> mCategoryGoodsList;

  @override
  void initState() {
    // TODO: implement initState
    _getGoodList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: ScreenUtil().setWidth(570),
      height: ScreenUtil().setHeight(950),
      child: ListView.builder(
        itemCount: mCategoryGoodsList.length,
        itemBuilder: (context,index){
          return _GoodList(index);
        }
      ),
    );
  }

  void _getGoodList()async{
    var data={
      'categoryId':'4',
      'categorySubId':"",
      'page':1
    };
    await request('getMallGoods',formData: data).then((val){
      var data = json.decode(val.toString());
      CategoryGoodsListModel goodsList = CategoryGoodsListModel.fromJson(data);
      setState(() {
        mCategoryGoodsList = goodsList.data;
      });
      print('分类商品列表：>>>>>>>>>>>>>${mCategoryGoodsList[0].goodsName}'+'${mCategoryGoodsList.length}');
    });
  }

  Widget _goodsImage(index){
    return Container(
      width: ScreenUtil().setWidth(200),
      child: Image.network(mCategoryGoodsList[index].image),
    );
  }

  Widget _goodsName(int index){
    return Container(
      padding: EdgeInsets.only(top:5.0,bottom: 5.0),
      width: ScreenUtil().setWidth(370),
      child: Text(mCategoryGoodsList[index].goodsName,maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: ScreenUtil().setSp(28))),
    );
  }

  Widget _goodsPrice(int index){
    return Container(
      margin: EdgeInsets.only(top:10.0),
      width: ScreenUtil().setWidth(370),
      child: Row(
        children: <Widget>[
          Text(
            '价格：￥${mCategoryGoodsList[index].presentPrice}',
            style: TextStyle(color: Colors.pink,fontSize: ScreenUtil().setSp(30)),
          ),
          Text(
            '${mCategoryGoodsList[index].oriPrice}',
            style: TextStyle(color: Colors.black12,fontStyle: FontStyle.italic,decoration:TextDecoration.lineThrough,decorationColor: Colors.pink,fontSize: ScreenUtil().setSp(26)),
          )
        ],
      ),
    );
  }

  Widget _GoodList(int index){
    return InkWell(
      onTap: (){},
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(color: Colors.black12,width: 1))
        ),
        child: Row(
          children: <Widget>[
            _goodsImage(index),
            Column(
              children: <Widget>[
                _goodsName(index),
                _goodsPrice(index)
              ],
            )
          ],
        ),
      ),
    );
  }



}



