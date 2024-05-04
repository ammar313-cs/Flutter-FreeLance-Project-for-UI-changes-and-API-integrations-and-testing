class SurveyQuestionsModel {
  dynamic isLast;
  int? logicExists;
  String? tabId;
  String? instructions;
  int? surveyId;
  int? id;
  String? type;
  int? goTo;
  String? goToOption;
  String? text;
  int? required;
  int? breakAfter;
  String? answerIs;
  dynamic options;

  SurveyQuestionsModel(
      {this.isLast,
      this.logicExists,
      this.tabId,
      this.instructions,
      this.surveyId,
      this.id,
      this.type,
      this.goTo,
      this.goToOption,
      this.text,
      this.required,
      this.breakAfter,
      this.answerIs,
      this.options});

  SurveyQuestionsModel.fromJson(Map<String, dynamic> json) {
    isLast = json['is_last'];
    logicExists = json['logic_exists'];
    tabId = json['tab_id'];
    instructions = json['instructions'];
    surveyId = json['survey_id'];
    id = json['id'];
    type = json['type'];
    goTo = json['go_to'];
    goToOption = json['go_to_option'];
    text = json['text'];
    required = json['required'];
    breakAfter = json['break_after'];
    answerIs = json['answerIs'];
    options = json['options'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_last'] = this.isLast;
    data['logic_exists'] = this.logicExists;
    data['tab_id'] = this.tabId;
    data['instructions'] = this.instructions;
    data['survey_id'] = this.surveyId;
    data['id'] = this.id;
    data['type'] = this.type;
    data['go_to'] = this.goTo;
    data['go_to_option'] = this.goToOption;
    data['text'] = this.text;
    data['required'] = this.required;
    data['break_after'] = this.breakAfter;
    data['answerIs'] = this.answerIs;
    data['options'] = this.options;
    return data;
  }
}
