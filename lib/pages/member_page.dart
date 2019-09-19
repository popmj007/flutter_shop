import 'package:flutter/material.dart';
import 'package:flutter_shop/provide/counter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provide/provide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class MemberPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('会员中心'),
      ),
      body: ListView(
        children: <Widget>[
          _topHeader(),
          _orderTitle(),
          _orderType(),
          _actionList()
        ],
      ),
    );
  }
  
  Widget _topHeader(){
    return Container(
      width: ScreenUtil().setWidth(750),
      padding: EdgeInsets.all(20.0),
      color: Colors.pinkAccent,
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top:30.0),
            child: ClipOval(
              child: Image.network('https://ui.ptlogin2.qq.com/style/0/images/1.gif'),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top:10.0),
            child: Text(
              'YANXIAOLONG',
              style: TextStyle(
                fontSize: ScreenUtil().setSp(36),
                color: Colors.white
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _orderTitle(){
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(width: 1,color: Colors.black12)
        )
      ),
      child: ListTile(
        leading: Icon(Icons.list),
        title: Text('我的订单'),
        subtitle: Text('我的货单'),
        trailing: Icon(Icons.arrow_right),
      ),
    );
  }

  Widget _orderType(){
    return Container(
      margin: EdgeInsets.only(top: 5.0),
      width: ScreenUtil().setWidth(750),
      padding: EdgeInsets.only(top: 10.0,bottom: 10.0),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          InkWell(
            onTap: (){
              _showToast('待付款');
            },
            child: Container(
              width: ScreenUtil().setWidth(187),
              child: Column(
                children: <Widget>[
                  Icon(
                    Icons.party_mode,
                    size: 30,
                  ),
                  Text('待付款'),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: (){
              _showToast('待发货');
            },
            child: Container(
              width: ScreenUtil().setWidth(187),
              child: Column(
                children: <Widget>[
                  Icon(
                    Icons.query_builder,
                    size: 30,
                  ),
                  Text('待发货')
                ],
              ),
            ),
          ),
          InkWell(
            onTap: (){
              _showToast('待收货');
            },
            child: Container(
              width: ScreenUtil().setWidth(187),
              child:Column(
                children: <Widget>[
                  Icon(
                    Icons.directions_car,
                    size: 30,
                  ),
                  Text('待收货')
                ],
              ),
            ),
          ),
          InkWell(
            onTap: (){
              _showToast('待评价');
            },
            radius: 300,
            splashColor: Colors.red,
            child: Container(
              width: ScreenUtil().setWidth(187),
              child: Column(
                children: <Widget>[
                  Icon(
                    Icons.content_paste,
                    size: 30,
                  ),
                  Text('待评价')
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _myListTitle(String title){
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(width: 1,color: Colors.black12)
        )
      ),
      child: ListTile(
        onTap: (){
          _showToast(title);
        },
        leading: Icon(Icons.blur_circular),
        title: Text(title),
        trailing: Icon(Icons.arrow_right),
      ),
    );
  }

  Widget _actionList(){
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: <Widget>[
          _myListTitle('领取优惠券'),
          _myListTitle('已领取优惠券'),
          _myListTitle('地址管理'),
          _myListTitle('客服电话'),
          _myListTitle('关于我们'),
        ],
      ),
    );
  }

  void _showToast(String msg){
    Fluttertoast.showToast(
      msg: msg,
      textColor: Colors.white,
      backgroundColor: Colors.red,
      gravity: ToastGravity.CENTER,
      toastLength: Toast.LENGTH_SHORT,
      fontSize: 16
    );
  }


}