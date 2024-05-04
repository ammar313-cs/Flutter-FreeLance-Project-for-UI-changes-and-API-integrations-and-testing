class LogoutModel {
  String? responce;

  LogoutModel({this.responce});

  LogoutModel.fromJson(Map<String, dynamic> json) {
    responce = json['Responce'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Responce'] = this.responce;
    return data;
  }
}
