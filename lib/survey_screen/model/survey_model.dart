final String tableNotes = 'notes';

class SurveyFields {
  static final List<String> values = [
    /// Add all fields
    id,
    surveyId,
    qIdList,
    answer,
    uid,
    companyId,
    lat,
    long,
    imgStr,
    imgName,
    businesslist,
    financiallist,
    geographicList
  ];

  static final String id = '_id';
  static final String surveyId = 'surveyId';
  static final String qIdList = 'qIdList';
  static final String answer = 'answer';
  static final String uid = 'uid';
  static final String companyId = 'companyId';
  static final String lat = 'lat';
  static final String long = 'long';
  static final String imgStr = 'imgStr';
  static final String imgName = 'imgName';
  static final String businesslist = 'businesslist';
  static final String financiallist = 'financiallist';
  static final String geographicList = 'geographicList';
}

class SurveyModel {
  final int? id;
  final String? surveyId;
  final dynamic qIdList;
  final dynamic answer;
  final String uid;
  final String companyId;
  final String lat;
  final String long;
  final String imgStr;
  final String imgName;
  final dynamic businesslist;
  final dynamic financiallist;
  final dynamic geographicList;

   SurveyModel({
    this.id,
    required this.surveyId,
    required this.qIdList,
    required this.answer,
    required this.uid,
    required this.companyId,
    required this.lat,
    required this.long,
    required this.imgStr,
    required this.imgName,
    required this.businesslist,
    required this.financiallist,
    required this.geographicList,
  });

  SurveyModel copy({
    int? id,
    String? surveyId,
    dynamic qIdList,
    dynamic answer,
    String? uid,
    String? companyId,
    String? lat,
    String? long,
    String? imgStr,
    String? imgName,
    dynamic businesslist,
    dynamic financiallist,
    dynamic geographicList,
  }) =>
      SurveyModel(
        id: id ?? this.id,
        surveyId: surveyId ?? this.surveyId,
        qIdList: qIdList ?? this.qIdList,
        answer: answer ?? this.answer,
        uid: uid ?? this.uid,
        companyId: companyId ?? this.companyId,
        lat: lat ?? this.lat,
        long: long ?? this.long,
        imgStr: imgStr ?? this.imgStr,
        imgName: imgName ?? this.imgName,
        businesslist: businesslist ?? this.businesslist,
        financiallist: financiallist ?? this.financiallist,
        geographicList: geographicList ?? this.geographicList,
      );

  static SurveyModel fromJson(Map<String, Object?> json) => SurveyModel(
        id: json[SurveyFields.id] as int?,
        surveyId: json[SurveyFields.surveyId] as String,
        qIdList: json[SurveyFields.qIdList] as dynamic,
        answer: json[SurveyFields.answer] as dynamic,
        uid: json[SurveyFields.uid] as String,
        companyId: json[SurveyFields.companyId] as String,
        lat: json[SurveyFields.lat] as String,
        long: json[SurveyFields.long] as String,
        imgStr: json[SurveyFields.imgStr] as String,
        imgName: json[SurveyFields.imgName] as String,
        businesslist: json[SurveyFields.businesslist] as dynamic,
        financiallist: json[SurveyFields.financiallist] as dynamic,
    geographicList: json[SurveyFields.geographicList] as dynamic,
      );

  Map<String, Object?> toJson() => {
        SurveyFields.id: id,
        SurveyFields.surveyId: surveyId,
        SurveyFields.qIdList: qIdList,
        SurveyFields.answer: answer,
        SurveyFields.uid: uid,
        SurveyFields.companyId: companyId,
        SurveyFields.lat: lat,
        SurveyFields.long: long,
        SurveyFields.imgStr: imgStr,
        SurveyFields.imgName: imgName,
        SurveyFields.businesslist: businesslist,
        SurveyFields.financiallist: financiallist,
        SurveyFields.geographicList: geographicList,
      };
}
