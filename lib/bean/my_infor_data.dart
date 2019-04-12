class LoginInfor {
  ///{gender: male, name: jack_lz, location: 北京, id: 4114419, avatar: https://www.oschina.net/img/portrait.gif, email: 835052259@qq.com, url: https://my.oschina.net/u/4114419}

  String male;
  String name;
  String location;
  int id;
  String avatar;
  String email;
  String url;
  String error;
  String error_description;

  LoginInfor.fromJson(Map<String, dynamic> json) {
    male = json['male'];
    name = json['name'];
    location = json['location'];
    id = json['id'];
    avatar = json['avatar'];
    email = json['email'];
    url = json['url'];
    error = json['error'];
    error_description = json['error_description'];
  }
}

class MyInformation {
  String portrait;
  String name;
  String joinTime;
  String city;
  List<String> platforms;
  List<String> expertise;

  MyInformation.fromJson(Map<String, dynamic> json) {
    portrait = json['portrait'];
    name = json['name'];
    city = json['province'] + json['city'];
    joinTime = json['joinTime'];
    platforms =json['platforms']?.map<String>((c) => c.toString())?.toList();
    expertise =json['expertise']?.map<String>((c) => c.toString())?.toList();
  }
}
