
class CommontListBean {
  List<CommentList> commentList;
  Notice notice;

  CommontListBean({this.commentList, this.notice});

  CommontListBean.fromJson(Map<String, dynamic> json) {
    if (json['commentList'] != null) {
      commentList = new List<CommentList>();
      json['commentList'].forEach((v) {
        commentList.add(new CommentList.fromJson(v));
      });
    }
    notice =
    json['notice'] != null ? new Notice.fromJson(json['notice']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.commentList != null) {
      data['commentList'] = this.commentList.map((v) => v.toJson()).toList();
    }
    if (this.notice != null) {
      data['notice'] = this.notice.toJson();
    }
    return data;
  }
}

class CommentList {
  String commentPortrait;
  int commentAuthorId;
  String commentAuthor;
  int id;
  int clientType;
  String pubDate;
  String content;

  CommentList(
      {this.commentPortrait,
        this.commentAuthorId,
        this.commentAuthor,
        this.id,
        this.clientType,
        this.pubDate,
        this.content});

  CommentList.fromJson(Map<String, dynamic> json) {
    commentPortrait = json['commentPortrait'];
    commentAuthorId = json['commentAuthorId'];
    commentAuthor = json['commentAuthor'];
    id = json['id'];
    clientType = json['client_type'];
    pubDate = json['pubDate'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['commentPortrait'] = this.commentPortrait;
    data['commentAuthorId'] = this.commentAuthorId;
    data['commentAuthor'] = this.commentAuthor;
    data['id'] = this.id;
    data['client_type'] = this.clientType;
    data['pubDate'] = this.pubDate;
    data['content'] = this.content;
    return data;
  }
}

class Notice {
  int referCount;
  int replyCount;
  int msgCount;
  int fansCount;

  Notice({this.referCount, this.replyCount, this.msgCount, this.fansCount});

  Notice.fromJson(Map<String, dynamic> json) {
    referCount = json['referCount'];
    replyCount = json['replyCount'];
    msgCount = json['msgCount'];
    fansCount = json['fansCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['referCount'] = this.referCount;
    data['replyCount'] = this.replyCount;
    data['msgCount'] = this.msgCount;
    data['fansCount'] = this.fansCount;
    return data;
  }
}
