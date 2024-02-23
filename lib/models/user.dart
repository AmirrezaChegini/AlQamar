import 'package:al_qamar/constants/api.dart';

class User {
  final String? _collectionId;
  final String? _collectionName;
  final String? _id;
  final String? _username;
  final String? _email;
  final bool? _verified;
  final bool? _emailVisibility;
  final String? _firstName;
  final String? _lastName;
  final String? _bio;
  final String? _image;
  final DateTime? _created;
  final DateTime? _updated;

  User(
    this._collectionId,
    this._collectionName,
    this._id,
    this._username,
    this._email,
    this._verified,
    this._emailVisibility,
    this._firstName,
    this._lastName,
    this._bio,
    this._image,
    this._created,
    this._updated,
  );

  factory User.fromMapJson(Map<String, dynamic> jsonObject) {
    return User(
      jsonObject['collectionId'],
      jsonObject['collectionName'],
      jsonObject['id'],
      jsonObject['username'],
      jsonObject['email'],
      jsonObject['verified'],
      jsonObject['emailVisibility'],
      jsonObject['firstName'],
      jsonObject['lastName'],
      jsonObject['bio'],
      jsonObject[
          '${Api.baseUrl}/api/files/${jsonObject['collectionId']}/${jsonObject['id']}/${jsonObject['image']}'],
      DateTime.parse(jsonObject['created']),
      DateTime.parse(jsonObject['updated']),
    );
  }

  String get collectionId => _collectionId ?? '';
  String get collectionName => _collectionName ?? '';
  String get id => _id ?? '';
  String get username => _username ?? '';
  String get email => _email ?? '';
  bool get verified => _verified ?? false;
  bool get emailVisibility => _emailVisibility ?? false;
  String get firstName => _firstName ?? '';
  String get lastName => _lastName ?? '';
  String get bio => _bio ?? '';
  String get image => _image ?? '';
  DateTime get created => _created ?? DateTime.now();
  DateTime get updated => _updated ?? DateTime.now();
}
