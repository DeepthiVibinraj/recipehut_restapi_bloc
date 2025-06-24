abstract class AuthEvent {}

class LoginRequested extends AuthEvent {
  final String email;
  final String password;
  LoginRequested(this.email, this.password);
}

class SignupRequested extends AuthEvent {
  final String userName;
  final String email;
  final String password;
  SignupRequested(this.userName, this.email, this.password);
}

class LogoutRequested extends AuthEvent {}
