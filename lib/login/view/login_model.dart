class LogInModel {
  String? companyName;
  String? companyLogo;
  int? uId;
  String? username;
  String? password;
  String? fullName;
  String? designation;
  String? department;
  String? email;
  int? role;
  int? companyId;
  String? rolename;

  LogInModel(
      {this.companyName,
      this.companyLogo,
      this.uId,
      this.username,
      this.password,
      this.fullName,
      this.designation,
      this.department,
      this.email,
      this.role,
      this.companyId,
      this.rolename});

  LogInModel.fromJson(Map<String, dynamic> json) {
    companyName = json['company_name'];
    companyLogo = json['company_logo'];
    uId = json['u_id'];
    username = json['username'];
    password = json['password'];
    fullName = json['full_name'];
    designation = json['designation'];
    department = json['department'];
    email = json['email'];
    role = json['role'];
    companyId = json['company_id'];
    rolename = json['rolename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['company_name'] = this.companyName;
    data['company_logo'] = this.companyLogo;
    data['u_id'] = this.uId;
    data['username'] = this.username;
    data['password'] = this.password;
    data['full_name'] = this.fullName;
    data['designation'] = this.designation;
    data['department'] = this.department;
    data['email'] = this.email;
    data['role'] = this.role;
    data['company_id'] = this.companyId;
    data['rolename'] = this.rolename;
    return data;
  }
}
