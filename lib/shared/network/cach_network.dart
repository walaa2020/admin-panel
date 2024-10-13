import 'dart:convert';

import 'package:reda3/models/article_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/doctor_model.dart';

class CacheNetwork{
  static late SharedPreferences sharedPref;
  static Future cacheInitialisation()async{
    sharedPref=await SharedPreferences.getInstance();
  }
  static Future<bool> insertToCache({required String key,required String value})async{
    return await sharedPref.setString(key, value);
  }
  static String getCacheData({required String key})  {
    return sharedPref.getString(key)??"";
  }
  static Future<bool> deleteCacheItem({required String key}) async {
    return await sharedPref.remove(key);
  }
  static Future<void> clearSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
  static Future<bool> insertToCacheInt({required String key,required int value})async{
    return await sharedPref.setInt(key, value);
  }
  static int getCacheDataInt({required String key})  {
    return sharedPref.getInt(key)??0;
  }


  static Future<void> saveItemsList(List<ArticleModel> items) async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
     List<String> itemsJson = items.map((item) => json.encode(item.toJson())).toList();
     await prefs.setStringList('items', itemsJson);
  }

  static Future<List<ArticleModel>> getItemsList() async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
     List<String>? itemsJson = prefs.getStringList('items');
     if (itemsJson != null) {
     return itemsJson.map((itemJson) => ArticleModel.fromJson(json.decode(itemJson))).toList();
     } else {
     return [];
     }
  }
}