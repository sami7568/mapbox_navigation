class LoginResponse {
  final String userName;
  final String userEmail;
  final String status;

  LoginResponse(
      {required this.status, required this.userEmail, required this.userName});
}
