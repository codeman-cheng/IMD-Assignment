class User{
  static UserInfo userInfo;

  static UserInfo getUser(token) {
    if (userInfo == null) {
      userInfo = new UserInfo(token);
    }
    else {
      print('已经创建过token');
    }
    return userInfo;
  }
}

class UserInfo {
  String token;
  UserInfo (token){
    this.token = token;
  }

}