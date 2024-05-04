class GetQuestionsSubmittedModel {
  int? timestampp;
  String? instructions;
  String? greetingPitch;
  int? productId;
  int? id;
  String? type;
  String? text;
  String? answer;
  String? productName;
  String? cd;
  String? tabId;
  dynamic options;
  dynamic links;

  GetQuestionsSubmittedModel(
      {this.timestampp,
      this.instructions,
      this.greetingPitch,
      this.productId,
      this.id,
      this.type,
      this.text,
      this.answer,
      this.productName,
      this.cd,
      this.tabId,
      this.options,
      this.links});

  GetQuestionsSubmittedModel.fromJson(Map<String, dynamic> json) {
    timestampp = json['timestampp'];
    instructions = json['instructions'];
    greetingPitch = json['greeting_pitch'];
    productId = json['product_id'];
    id = json['id'];
    type = json['type'];
    text = json['text'];
    answer = json['answer'];
    productName = json['product_name'];
    cd = json['cd'];
    tabId = json['tab_id'];
    options = json['options'];
    links = json['links'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['timestampp'] = this.timestampp;
    data['instructions'] = this.instructions;
    data['greeting_pitch'] = this.greetingPitch;
    data['product_id'] = this.productId;
    data['id'] = this.id;
    data['type'] = this.type;
    data['text'] = this.text;
    data['answer'] = this.answer;
    data['product_name'] = this.productName;
    data['cd'] = this.cd;
    data['tab_id'] = this.tabId;
    data['options'] = this.options;
    data['links'] = this.links;
    return data;
  }
}
