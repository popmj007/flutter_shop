import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/provide/child_category.dart';
import 'package:flutter_shop/service/service_method.dart';
import 'package:flutter_shop/model/CategoryBigModel.dart';
import 'package:provide/provide.dart';
import 'package:flutter_shop/model/CategoryGoodsListModel.dart';
import '../provide/category_goods_list.dart';

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

  List mlist = [];//大类分类集合
  var listIndex = 0;//大类索引

  @override
  void initState() {
    // TODO: implement initState
    _getCategory();
    super.initState();
  }

  void _getCategory() async{
    await request('getCategory').then((val){
      var data = json.decode(val.toString());
      CategoryModel categoryModel = CategoryModel.fromJson(data);
      categoryModel.data.forEach((item)=>print(item.mallCategoryName));
      setState(() {
        mlist = categoryModel.data;
      });

      //一级菜单默认[选中第一项],所以先获取二级分类菜单数据
      Provide.value<ChildCategory>(context).getChildCategory(mlist[0].bxMallSubDto);

      _getGoodList(categoryId:mlist[0].mallCategoryId);//不知道二级分类全部的传参，暂时先传二级分类的第一种分类
    });
  }

  void _getGoodList({String categoryId})async{
    var data={
      'categoryId':categoryId==null?'4':categoryId,
      'categorySubId':"",
      'page':1
    };
    await request('getMallGoods',formData: data).then((val){
      var data = json.decode(val.toString());
      CategoryGoodsListModel goodsList = CategoryGoodsListModel.fromJson(data);
      Provide.value<CategoryGoodsListProvide>(context).getGoodsList(goodsList.data);
    });
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


  Widget _leftInkWell(int index){

    bool isClick = false;
    isClick = (index == listIndex)?true:false;

    return InkWell(
      onTap: (){
        setState(() {
          listIndex = index;
          smallCategoryIndex = 0;
        });

        var childList = mlist[index].bxMallSubDto;//通过点击的大类索引获取二级分类集合
        var categoryId = mlist[index].mallCategoryId;
        Provide.value<ChildCategory>(context).getChildCategory(childList);//状态管理给二级分类集合赋值
        _getGoodList(categoryId:categoryId);
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
    return Provide<ChildCategory>(
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


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Provide<CategoryGoodsListProvide>(
      builder: (context,child,data){
        return Container(
          width: ScreenUtil().setWidth(570),
          height: ScreenUtil().setHeight(986),
          child: ListView.builder(
            itemCount: data.goodsList.length,
              itemBuilder: (context,index){
                return _ListWidget(data.goodsList, index);
              }
          ),
        );
      },
    );
  }

  Widget _ListWidget(List newList,int index){
    return InkWell(
      onTap: (){},
      child: Container(
        padding: EdgeInsets.only(top: 5.0,bottom: 5.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(width: 1.0,color: Colors.black12)
          )
        ),
        child: Row(
          children: <Widget>[
            _goodsImage(newList,index),
            Column(
              children: <Widget>[
                _goodsName(newList,index),
                _goodsPrice(newList,index)
              ],
            )
          ],
        ),
      ),

    );
  }

  /*void _getGoodList()async{
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
  }*/

  Widget _goodsImage(List newList,int index){
    return Container(
      width: ScreenUtil().setWidth(200),
      child: Image.network(newList[index].image),
    );
  }

  Widget _goodsName(List newList,int index){
    return Container(
      padding: EdgeInsets.only(top:5.0,bottom: 5.0),
      width: ScreenUtil().setWidth(370),
      child: Text(newList[index].goodsName,maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: ScreenUtil().setSp(28))),
    );
  }

  Widget _goodsPrice(List newList,int index){
    return Container(
      margin: EdgeInsets.only(top:10.0),
      width: ScreenUtil().setWidth(370),
      child: Row(
        children: <Widget>[
          Text(
            '价格：￥${newList[index].presentPrice}',
            style: TextStyle(color: Colors.pink,fontSize: ScreenUtil().setSp(30)),
          ),
          Text(
            '${newList[index].oriPrice}',
            style: TextStyle(color: Colors.black12,fontStyle: FontStyle.italic,decoration:TextDecoration.lineThrough,decorationColor: Colors.pink,fontSize: ScreenUtil().setSp(26)),
          )
        ],
      ),
    );
  }

}



