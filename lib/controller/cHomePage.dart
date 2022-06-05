import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ControllerHome {
  Dio dio = new Dio();

  dynamic getData(BuildContext context) async {
    try {
      Response response = await dio.get(
        "https://jsonplaceholder.typicode.com/posts",
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );
      //inspect(response);

      if (response.statusCode == 200) {
        var lll = [];
        for (var i = 0; i < response.data.length; i++) {
          Map<String, dynamic> data = response.data[i];
          var a = data;
          lll.add(a);
        }
        //inspect(lll);
        return lll;
      } else {
        return false;
      }
    } catch (e) {
      inspect(e);
      return false;
    }
  }
}
