


import 'dart:convert';

import 'package:iot/data/apiimplementations/apiservices.dart';
import 'package:http/http.dart'as http;
import 'package:iot/data/appexceptions/exceptiontype.dart';

class ApiImplementations extends ApiServices{

  // ToDo deletedata from api
  @override
  Future<dynamic> deleteuserdata(String urls)async{
    dynamic jsondata;
    try {
      final response = await http.delete(Uri.parse(urls));
      jsondata = returnresponse(response);
    }catch (e){
      throw NoInterNetExceptions("");
    }
    return jsondata;
  }

  @override
  Future<dynamic>getapidata(String urls)async{
    dynamic jsondata;
    try {
      final response = await http.get(Uri.parse(urls));
      jsondata = returnresponse(response);
    }catch(e){
      throw NoInterNetExceptions("");
    }
    return jsondata;
  }

  @override
  Future<dynamic> postapidata(String urls, data, header)async{
    dynamic jsondata;
    try {
      final response = await http.post(Uri.parse(urls),body: data,headers: header);
      jsondata  = returnresponse(response);
    }catch(e){
      throw NoInterNetExceptions("");
    }
    return jsondata;
  }


  static returnresponse(http.Response response){
    switch(response.statusCode){
      case 201:
      case 200:
        final data = jsonDecode(response.body);
        return data;
      case 400:
        throw BadRequestExceptions("");
      case 404:
        throw UserNotFoundExceptions("");
      case 408:
        throw RequestTimeOuytExceptions("");
      case 403:
      case  401:
        throw UnAutherizedExceptions("");
      default:
        throw DefaultExcptions("");
    }
  }

}