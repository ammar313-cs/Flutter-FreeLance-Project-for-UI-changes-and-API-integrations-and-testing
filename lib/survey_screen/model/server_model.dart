final String tableNotes = 'notes';

class ServerFields {
  static final List<String> values = [
    /// Add all fields
    survey_id,
    q_id,
    answer,
    cb,
    q_type,
    image_name,
    file_data,
    cd
  ];

  static final String survey_id = 'survey_id';
  static final String q_id = 'q_id';
  static final String answer = 'answer';
  static final String cb = 'cb';
  static final String q_type = 'q_type';
  static final String image_name = 'image_name';
  static final String file_data = 'file_data';
  static final String cd = 'cd';
}

class SurverModel {
  final String? survey_id;
  final String? q_id;
  final String? answer;
  final String? cb;
  final String? q_type;
  final String? image_name;
  final String? file_data;
  final String? cd;

  SurverModel({
    required this.survey_id,
    required this.q_id,
    required this.answer,
    required this.cb,
    required this.q_type,
    required this.image_name,
    required this.file_data,
    required this.cd,
  });

  SurverModel copy({
    String? survey_id,
    String? q_id,
    String? answer,
    String? cb,
    String? q_type,
    String? image_name,
    String? file_data,
    String? cd,
  }) =>
      SurverModel(
        survey_id: survey_id ?? this.survey_id,
        q_id: q_id ?? this.q_id,
        answer: answer ?? this.answer,
        cb: cb ?? this.cb,
        q_type: q_type ?? this.q_type,
        image_name: image_name ?? this.image_name,
        file_data: file_data ?? this.file_data,
        cd: cd ?? this.cd,
      );

  static SurverModel fromJson(Map<String, Object?> json) => SurverModel(
        survey_id: json[ServerFields.survey_id] as String,
        q_id: json[ServerFields.q_id] as String,
        answer: json[ServerFields.answer] as String,
        cb: json[ServerFields.cb] as String,
        q_type: json[ServerFields.q_type] as String,
        image_name: json[ServerFields.image_name] as String,
        file_data: json[ServerFields.file_data] as String,
        cd: json[ServerFields.cd] as String,
      );

  Map<String, Object?> toJson() => {
        ServerFields.survey_id: survey_id,
        ServerFields.q_id: q_id,
        ServerFields.answer: answer,
        ServerFields.cb: cb,
        ServerFields.q_type: q_type,
        ServerFields.image_name: image_name,
        ServerFields.file_data: file_data,
        ServerFields.cd: cd,
      };
}
