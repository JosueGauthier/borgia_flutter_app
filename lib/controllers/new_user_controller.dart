// ignore_for_file: unused_import

import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Album> fetchAlbum() async {
  final response = await http.get(Uri.parse('https://api.jsonbin.io/b/62655cbb25069545a32872bb'));

  String responseBody = response.body;

  String responseBodyWithoutSquareBrackets = responseBody.substring(1, responseBody.length - 1);

  if (response.statusCode == 200) {
    return Album.fromJson(jsonDecode(responseBodyWithoutSquareBrackets));
  } else {
    throw Exception('Failed to load album');
  }
}

class Album {
  int? id;
  String? username;
  String? lastName;
  String? firstName;
  String? password;
  String? email;
  String? surname;
  String? family;
  String? balance;
  String? year;
  String? campus;
  String? phone;
  String? avatar;
  String? theme;

  Album(
      {this.id,
      this.username,
      this.lastName,
      this.firstName,
      this.password,
      this.email,
      this.surname,
      this.family,
      this.balance,
      this.year,
      this.campus,
      this.phone,
      this.avatar,
      this.theme});

  Album.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    lastName = json['last_name'];
    firstName = json['first_name'];
    password = json['password'];
    email = json['email'];
    surname = json['surname'];
    family = json['family'];
    balance = json['balance'];
    year = json['year'];
    campus = json['campus'];
    phone = json['phone'];
    avatar = json['avatar'];
    theme = json['theme'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['last_name'] = lastName;
    data['first_name'] = firstName;
    data['password'] = password;
    data['email'] = email;
    data['surname'] = surname;
    data['family'] = family;
    data['balance'] = balance;
    data['year'] = year;
    data['campus'] = campus;
    data['phone'] = phone;
    data['avatar'] = avatar;
    data['theme'] = theme;
    return data;
  }
}
