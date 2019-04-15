class FavoriteListBean {
  Notice notice;
  List<FavoriteList> favoriteList;

  FavoriteListBean({this.notice, this.favoriteList});

  FavoriteListBean.fromJson(Map<String, dynamic> json) {
    notice =
    json['notice'] != null ? new Notice.fromJson(json['notice']) : null;
    if (json['favoriteList'] != null) {
      favoriteList = new List<FavoriteList>();
      json['favoriteList'].forEach((v) {
        favoriteList.add(new FavoriteList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.notice != null) {
      data['notice'] = this.notice.toJson();
    }
    if (this.favoriteList != null) {
      data['favoriteList'] = this.favoriteList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Notice {
  int replyCount;
  int msgCount;
  int fansCount;
  int referCount;

  Notice({this.replyCount, this.msgCount, this.fansCount, this.referCount});

  Notice.fromJson(Map<String, dynamic> json) {
    replyCount = json['replyCount'];
    msgCount = json['msgCount'];
    fansCount = json['fansCount'];
    referCount = json['referCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['replyCount'] = this.replyCount;
    data['msgCount'] = this.msgCount;
    data['fansCount'] = this.fansCount;
    data['referCount'] = this.referCount;
    return data;
  }
}

class FavoriteList {
  String title;
  int objid;
  int type;
  String url;

  FavoriteList({this.title, this.objid, this.type, this.url});

  FavoriteList.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    objid = json['objid'];
    type = json['type'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['objid'] = this.objid;
    data['type'] = this.type;
    data['url'] = this.url;
    return data;
  }
}
