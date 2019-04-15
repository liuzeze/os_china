class TweetDetailBean {
  int id;
  String pubDate;
  String body;
  String author;
  int authorid;
  String imgBig;
  String imgSmall;
  int commentCount;
  String portrait;

  TweetDetailBean(
      {this.id,
        this.pubDate,
        this.body,
        this.author,
        this.authorid,
        this.imgBig,
        this.imgSmall,
        this.commentCount,
        this.portrait});

  TweetDetailBean.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pubDate = json['pubDate'];
    body = json['body'];
    author = json['author'];
    authorid = json['authorid'];
    imgBig = json['imgBig'];
    imgSmall = json['imgSmall'];
    commentCount = json['commentCount'];
    portrait = json['portrait'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['pubDate'] = this.pubDate;
    data['body'] = this.body;
    data['author'] = this.author;
    data['authorid'] = this.authorid;
    data['imgBig'] = this.imgBig;
    data['imgSmall'] = this.imgSmall;
    data['commentCount'] = this.commentCount;
    data['portrait'] = this.portrait;
    return data;
  }
}
