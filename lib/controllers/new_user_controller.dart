import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Album> fetchAlbum() async {
  final response = await http.get(Uri.parse('https://api.jsonbin.io/b/62655cbb25069545a32872bb'));

  String responseBody = response.body;

  String responseBody_withoutSquareBrackets = responseBody.substring(1, responseBody.length - 1);
  print(responseBody_withoutSquareBrackets);

  //https://jsonplaceholder.typicode.com/albums/1
  //https://api.jsonbin.io/v3/b/62655a8f38be296761f76c0f

  //works with this
  // https://api.jsonbin.io/b/62655c68019db4679690ea84

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.

    return Album.fromJson(jsonDecode(responseBody_withoutSquareBrackets));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['last_name'] = this.lastName;
    data['first_name'] = this.firstName;
    data['password'] = this.password;
    data['email'] = this.email;
    data['surname'] = this.surname;
    data['family'] = this.family;
    data['balance'] = this.balance;
    data['year'] = this.year;
    data['campus'] = this.campus;
    data['phone'] = this.phone;
    data['avatar'] = this.avatar;
    data['theme'] = this.theme;
    return data;
  }
}
