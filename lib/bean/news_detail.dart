


class NewsDetail {
  int id;
  String body;
  String pubDate;
  String author;
  String title;
  int authorid;
  List<Relativies> relativies;
  Notice notice;
  int favorite;
  int commentCount;
  String url;

  NewsDetail(
      {this.id,
        this.body,
        this.pubDate,
        this.author,
        this.title,
        this.authorid,
        this.relativies,
        this.notice,
        this.favorite,
        this.commentCount,
        this.url});

  NewsDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    body = json['body'];
    pubDate = json['pubDate'];
    author = json['author'];
    title = json['title'];
    authorid = json['authorid'];
    if (json['relativies'] != null) {
      relativies = new List<Relativies>();
      json['relativies'].forEach((v) {
        relativies.add(new Relativies.fromJson(v));
      });
    }
    notice =
    json['notice'] != null ? new Notice.fromJson(json['notice']) : null;
    favorite = json['favorite'];
    commentCount = json['commentCount'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['body'] = this.body;
    data['pubDate'] = this.pubDate;
    data['author'] = this.author;
    data['title'] = this.title;
    data['authorid'] = this.authorid;
    if (this.relativies != null) {
      data['relativies'] = this.relativies.map((v) => v.toJson()).toList();
    }
    if (this.notice != null) {
      data['notice'] = this.notice.toJson();
    }
    data['favorite'] = this.favorite;
    data['commentCount'] = this.commentCount;
    data['url'] = this.url;
    return data;
  }
}

class Relativies {
  String title;
  String url;

  Relativies({this.title, this.url});

  Relativies.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['url'] = this.url;
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
