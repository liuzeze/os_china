class WenDaList {

  List<PostList> postList;

  WenDaList({this.postList});

  WenDaList.fromJson(Map<String, dynamic> json) {
    if (json['post_list'] != null) {
      postList = new List<PostList>();
      json['post_list'].forEach((v) {
        postList.add(new PostList.fromJson(v));
      });
    }
  }
}

class PostList {
  int answerCount;
  String author;
  int id;
  int viewCount;
  String title;
  String portrait;
  String pubDate;

  PostList(
      {this.answerCount,
        this.author,
        this.id,
        this.viewCount,
        this.title,
        this.portrait,
        this.pubDate});

  PostList.fromJson(Map<String, dynamic> json) {
    answerCount = json['answerCount'];

    author = json['author'];
    id = json['id'];
    viewCount = json['viewCount'];
    title = json['title'];
    portrait = json['portrait'];
    pubDate = json['pubDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['answerCount'] = this.answerCount;

    data['author'] = this.author;
    data['id'] = this.id;
    data['viewCount'] = this.viewCount;
    data['title'] = this.title;
    data['portrait'] = this.portrait;
    data['pubDate'] = this.pubDate;
    return data;
  }
}

