class User {
  int _id;

  User(this._id);

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      json['id']
    );
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }
}