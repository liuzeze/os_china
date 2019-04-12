class MessageBean {
  Notice notice;
  List<MessageList> messageList;

  MessageBean({this.notice, this.messageList});

  MessageBean.fromJson(Map<String, dynamic> json) {
    notice =
    json['notice'] != null ? new Notice.fromJson(json['notice']) : null;
    if (json['messageList'] != null) {
      messageList = new List<MessageList>();
      json['messageList'].forEach((v) {
        messageList.add(new MessageList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.notice != null) {
      data['notice'] = this.notice.toJson();
    }
    if (this.messageList != null) {
      data['messageList'] = this.messageList.map((v) => v.toJson()).toList();
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

class MessageList {
  String content;
  int senderid;
  String sender;
  int friendid;
  int id;
  String pubDate;
  String friendname;
  int messageCount;
  String portrait;

  MessageList(
      {this.content,
        this.senderid,
        this.sender,
        this.friendid,
        this.id,
        this.pubDate,
        this.friendname,
        this.messageCount,
        this.portrait});

  MessageList.fromJson(Map<String, dynamic> json) {
    content = json['content'];
    senderid = json['senderid'];
    sender = json['sender'];
    friendid = json['friendid'];
    id = json['id'];
    pubDate = json['pubDate'];
    friendname = json['friendname'];
    messageCount = json['messageCount'];
    portrait = json['portrait'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content'] = this.content;
    data['senderid'] = this.senderid;
    data['sender'] = this.sender;
    data['friendid'] = this.friendid;
    data['id'] = this.id;
    data['pubDate'] = this.pubDate;
    data['friendname'] = this.friendname;
    data['messageCount'] = this.messageCount;
    data['portrait'] = this.portrait;
    return data;
  }
}
