abstract class AuthService {
  Future<void> signIn(String email, String password);
  Future<void> signInGoogle();
  Future<void> signOut();
}
