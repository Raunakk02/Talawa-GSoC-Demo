import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talawa/model/token.dart';

class Preferences with ChangeNotifier {
  static const tokenKey = "token";
  static const refreshTokenKey = "refreshTokenKey";
  static const userId = "userId";
  static const currentOrgId = "currentOrgId";
  static const currentOrgImgSrc = "currentOrgImgSrc";
  static const currentOrgName = "currentOrgName";
  static const orgUrl = "orgUrl";
  static const orgImgUrl = "orgUrl";
  static const userFName = "userFirstName";
  static const userLName = "userLastName";

  String orgName;
  String orgImgSrc;


  //it saves the user first name
  Future saveUserFName(String fName) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(userFName, fName);
  }


  //it gets the user first name
  Future<String> getUserFName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String fname = preferences.getString(userFName);
    notifyListeners();
    return fname;
  }


  //saves the user last name
  Future saveUserLName(String lName) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(userLName, lName);
  }


  //gets the user last name
  Future<String> getUserLName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String lname = preferences.getString(userLName);
    notifyListeners();
    return lname;
  }

  //saves the organization url
  Future saveOrgImgUrl(String url) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(orgImgUrl, url);
  }


  //get the organization url
  Future<String> getOrgImgUrl() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String url = preferences.getString(orgImgUrl);
    notifyListeners();
    return url;
  }


  //saves the organization url
  Future saveOrgUrl(String url) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(orgUrl, url);
  }


  //get the organization url
  Future<String> getOrgUrl() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String url = preferences.getString(orgUrl);
    notifyListeners();
    return url;
  }


  //saves the current organization name
  Future saveCurrentOrgName(String currName) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(currentOrgName, currName);
  }

  //get the current organization name
  Future<String> getCurrentOrgName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    orgName = preferences.getString(currentOrgName);
    notifyListeners();
    return orgName;
  }


  //saves the current organization image source
  Future saveCurrentOrgImgSrc(String currImgSrc) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(currentOrgImgSrc, currImgSrc);
  }


  //gets the current organization image source
  Future<String> getCurrentOrgImgSrc() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    orgImgSrc = preferences.getString(currentOrgImgSrc);
    notifyListeners();
    return orgImgSrc;
  }


  //saves the current organization id
  Future saveCurrentOrgId(String currOrgId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(currentOrgId, currOrgId);
  }


  //get the current organization id
  Future<String> getCurrentOrgId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String currentId = preferences.getString(currentOrgId);
    notifyListeners();
    return currentId;
  }


  //saves the user id
  Future saveUserId(String userID) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(userId, userID);
  }


  //gets the user id
  Future<String> getUserId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String uid = preferences.getString(userId);
    return uid;
  }


  //saves the current token
  Future saveToken(Token token) async {
    var storage=FlutterSecureStorage();
    token.parseJwt();
    await storage.write(
      key:
        tokenKey,
        value:
        (token.tokenString != null && token.tokenString.length > 0)
            ? token.tokenString
            : "");
    //print("Saved token");
  }


  //gets the current token
  Future<String> getToken() async {
    var storage=FlutterSecureStorage();
    String userToken = await storage.read(key:tokenKey);
    //print("getToken");
    return userToken;
  }


  //saves the refreshed token
  Future saveRefreshToken(Token token) async {
    var storage=FlutterSecureStorage();
    token.parseJwt();
    await storage.write(
      key:
        refreshTokenKey,
        value:
        (token.tokenString != null && token.tokenString.length > 0)
            ? token.tokenString
            : "");
    //print("Saved refresh token");
  }


  //get the refreshed token
  Future<String> getRefreshToken() async {
    var storage=FlutterSecureStorage();
    String refreshToken = await storage.read(key:refreshTokenKey);
    //print("Got refresh token");
    return refreshToken;
  }


  //get the current user id
  static Future<int> getCurrentUserId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var storage=FlutterSecureStorage();
    try {
      Token token =
          new Token(tokenString: await storage.read(key:tokenKey) ?? "");
      Map<String, dynamic> tokenMap = token.parseJwt();
      //print("Got uid");
      return tokenMap['id'];
    } catch (e) {
      print(e);
    }
    return -1;
  }


  //clears the user
  static Future<bool> clearUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var storage=FlutterSecureStorage();
    try {
      await storage.delete(key: tokenKey);
      //print("Delete token");
      preferences.remove(currentOrgId);
      await storage.delete(key: refreshTokenKey);
      //print("Refresh token");
      preferences.remove(userId);
      preferences.remove(currentOrgName);
      preferences.remove(currentOrgImgSrc);
      preferences.remove(orgUrl);
      preferences.remove(userFName);
      preferences.remove(userLName);
    } catch (e) {
      print(e);
      return false;
    }
    return true;
  }


  //removes the organization
  static Future<bool> removeOrg() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    try {
      preferences.remove(currentOrgId);
      preferences.remove(currentOrgName);
    } catch (e) {
      print(e);
      return false;
    }
    return true;
  }
}
