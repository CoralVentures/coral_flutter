class AuthenticationRepository {
  /// We are making a pretend AuthenticationRepository with a contrived method
  /// `authenticate`. This method will return whatever you pass in for
  /// `isAuthenticated`.
  bool authenticate({
    required bool isAuthenticated,
  }) {
    return isAuthenticated;
  }
}
