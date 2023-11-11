import 'package:shared_preferences/shared_preferences.dart';

class ChacheHelper
{
  static var  sharedPreferences;

  ChacheHelper() {
     sharedPreferences = SharedPreferences.getInstance();
  }
   // SharedPreferences prefs = await SharedPreferences.getInstance();
  static Future  init () async
  {
    sharedPreferences =  await SharedPreferences.getInstance();
  }

  static Future<bool> putData({ required String key , required bool value})
  {
    return  sharedPreferences.setBool(key,value);
  }

  static Future<bool?> getBoolean({ required String key})async
  {
    return await sharedPreferences.getBool(key);
  }


  static  getData({ required String key})
  {
      dynamic list = getkeys();
      var found =  list.any((item) => item == key);
      if (found)
        {
          return  sharedPreferences.get(key);
        }
      else
        {
          return null;
        }


  }


  static  getkeys()
  {
    return  sharedPreferences.getKeys();
  }

  static Future<bool> RemoveData({ required String key})async
  {
    return await sharedPreferences.remove(key);
  }

static Future<bool> saveData ({
    required String key,
    required dynamic value,}) async{
        if(value is String) return await sharedPreferences.setString(key,value);
        if(value is int)return await sharedPreferences.setInt(key,value);
        if(value is bool) return await sharedPreferences.setBool(key,value);
        return await sharedPreferences.setDouble(key,value);}



}