import 'dart:async';
import 'package:http/http.dart' as http;

abstract class Client {
  static String urlBase = 'http://172.16.4.241:3000/';
  static Uri formatUrl(path, { id: null }) {
    Uri url;
    if (id != null) {
      url = Uri.parse('${urlBase}'+path+'/'+'${id}');
    } else {
      url = Uri.parse('${urlBase}'+path);
    }
    return url;
  }
  static Future get(path) {
    Uri url = Uri.parse('${urlBase}'+path);
    return http.get(url);
  }
  static Future getById(path, id) {
    Uri url = Uri.parse('${urlBase}'+path+'/'+'${id}');
    print(url);
    return http.get(url);
  }
  static Future create(data, path) {
    Uri url = Uri.parse('${urlBase}'+path);
    print(data);
    return http.post(url, body: data, headers:{'Content-Type': 'application/json'},);
  }

  static Future update(id, data, path) {
    Uri url = Uri.parse('${urlBase}'+path+'/'+'${id}');
    print(data);
    return http.put(url, body: data, headers:{'Content-Type': 'application/json'},);
  }
  static Future delete(path, id) {
    Uri url = Uri.parse('${urlBase}'+path+'/'+'${id}');
    return http.delete(url);
  }

  static Future getT(path,{ query = null}) async{
    var url;
    if(query != null)
      url =  formatUrl(path+'?'+'ponto=$query');
    else  url =  formatUrl(path);
    return http.get(url, headers:{'Content-Type': 'application/json'});
  }

  static Future getMototaxisPontos(path) async{
    var url =  formatUrl(path);
    return http.get(url, headers:{'Content-Type': 'application/json'});
  }
}