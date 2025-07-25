class UserRepository {
  UserRepository._privateConstructor();
  static final UserRepository instance = UserRepository._privateConstructor();

  final List<Map<String, String>> _users = [];
  Map<String, String>? _currentUser;

  bool register(String name, String email, String password, String phone) {
    if (_users.any((u) => u['email'] == email)) return false;
    _users.add({
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
    });
    return true;
  }

  bool login(String email, String password) {
    final user = _users.firstWhere(
      (u) => u['email'] == email && u['password'] == password,
      orElse: () => {},
    );
    if (user.isNotEmpty) {
      _currentUser = user;
      return true;
    }
    return false;
  }

  void logout() {
    _currentUser = null;
  }

  Map<String, String>? get currentUser => _currentUser;
}
