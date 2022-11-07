class LoginBody {
  String? userphone;
  String? password;

  LoginBody({this.userphone, this.password});

  toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['userphone'] = userphone;
    data['password'] = password;
    return data;
  }
}
