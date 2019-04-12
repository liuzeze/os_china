class WenDaDetail {
  int id;
  String pubDate;
  String author;
  String body;
  String title;
  int answerCount;
  int authorid;
  int viewCount;
  int favorite;
  String portrait;
  String url;
  List<String> tags;

  WenDaDetail(
      {this.id,
        this.pubDate,
        this.author,
        this.body,
        this.title,
        this.answerCount,
        this.authorid,
        this.viewCount,
        this.favorite,
        this.portrait,
        this.url,
        this.tags});

  WenDaDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pubDate = json['pubDate'];
    author = json['author'];
    body = json['body'];
    title = json['title'];
    answerCount = json['answerCount'];
    authorid = json['authorid'];
    viewCount = json['viewCount'];
    favorite = json['favorite'];
    portrait = json['portrait'];
    url = json['url'];
    tags = json['tags'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['pubDate'] = this.pubDate;
    data['author'] = this.author;
    data['body'] = this.body;
    data['title'] = this.title;
    data['answerCount'] = this.answerCount;
    data['authorid'] = this.authorid;
    data['viewCount'] = this.viewCount;
    data['favorite'] = this.favorite;
    data['portrait'] = this.portrait;
    data['url'] = this.url;
    data['tags'] = this.tags;
    return data;
  }
}
