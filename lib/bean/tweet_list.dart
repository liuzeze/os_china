class TweetListBean {
  Notice notice;
  List<Tweetlist> tweetlist;

  TweetListBean({this.notice, this.tweetlist});

  TweetListBean.fromJson(Map<String, dynamic> json) {
    notice =
    json['notice'] != null ? new Notice.fromJson(json['notice']) : null;
    if (json['tweetlist'] != null) {
      tweetlist = new List<Tweetlist>();
      json['tweetlist'].forEach((v) {
        tweetlist.add(new Tweetlist.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.notice != null) {
      data['notice'] = this.notice.toJson();
    }
    if (this.tweetlist != null) {
      data['tweetlist'] = this.tweetlist.map((v) => v.toJson()).toList();
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

class Tweetlist {
  int id;
  String pubDate;
  String body;
  String author;
  int authorid;
  int commentCount;
  String portrait;
  String imgSmall;

  Tweetlist(
      {this.id,
        this.pubDate,
        this.body,
        this.author,
        this.authorid,
        this.commentCount,
        this.portrait,
        this.imgSmall
      });

  Tweetlist.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pubDate = json['pubDate'];
    body = json['body'];
    author = json['author'];
    authorid = json['authorid'];
    commentCount = json['commentCount'];
    portrait = json['portrait'];
    imgSmall = json['imgSmall'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['pubDate'] = this.pubDate;
    data['body'] = this.body;
    data['author'] = this.author;
    data['authorid'] = this.authorid;
    data['commentCount'] = this.commentCount;
    data['portrait'] = this.portrait;
    data['imgSmall'] = this.imgSmall;
    return data;
  }
}
