class GetChatHistoryModel {
  int? id;
  int? from;
  int? to;
  int? cb;
  String? cd;
  Null? deleted;
  String? messages;
  bool? reads;
  String? dates;

  GetChatHistoryModel(
      {this.id,
      this.from,
      this.to,
      this.cb,
      this.cd,
      this.deleted,
      this.messages,
      this.reads,
      this.dates});

  GetChatHistoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    from = json['from_'];
    to = json['to_'];
    cb = json['cb'];
    cd = json['cd'];
    deleted = json['deleted'];
    messages = json['messages'];
    reads = json['reads'];
    dates = json['dates'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['from_'] = this.from;
    data['to_'] = this.to;
    data['cb'] = this.cb;
    data['cd'] = this.cd;
    data['deleted'] = this.deleted;
    data['messages'] = this.messages;
    data['reads'] = this.reads;
    data['dates'] = this.dates;
    return data;
  }
}
