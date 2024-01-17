class User {
  final int _id;
  final String? _firstName;
  final String? _lastName;
  final String? _email;
  String? _avatar;
  final String? _bio;

  User(
    this._id,
    this._firstName,
    this._lastName,
    this._email,
    this._avatar,
    this._bio,
  ) {
    _avatar != null
        ? _avatar = 'https://www.yadme.com/storage/$_avatar'
        : _avatar;
  }

  factory User.fromMapJson(Map<String, dynamic> jsonObject) {
    return User(
      jsonObject['userProfile'][0]['id'],
      jsonObject['userProfile'][0]['first_name'],
      jsonObject['userProfile'][0]['last_name'],
      jsonObject['user']['email'],
      jsonObject['userProfile'][0]['avatar'],
      jsonObject['userProfile'][0]['bio'],
    );
  }

  int get id => _id;
  String get firstName => _firstName ?? '';
  String get lastName => _lastName ?? '';
  String get email => _email ?? '';
  String get avatar => _avatar ?? '';
  String get bio => _bio ?? '';
}
