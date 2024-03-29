import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';
import '../config/service_url.dart';

Future request(url,{formData}) async{
  print("开始获取数据...");
  try {

    Response response;
    Dio dio = new Dio();
    dio.options.contentType=ContentType.parse("application/x-www-form-urlencoded");

    if(formData == null){
      response = await dio.post(servicePath[url]);//homePageBelowContent
    }else{
      response = await dio.post(servicePath[url],data: formData);
    }
    if(response.statusCode == 200){
      print(response.data);
      return response.data;
    }else{
      return throw Exception('后端接口出现异常');
    }
  } catch (e) {
    return print(e);
  }
}
