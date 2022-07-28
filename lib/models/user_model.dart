class UserModel {
  int? id;
  String? password;
  String? lastLogin;
  bool? isSuperuser;
  String? username;
  String? firstName;
  String? lastName;
  String? email;
  bool? isStaff;
  bool? isActive;
  String? dateJoined;
  String? surname;
  String? family;
  String? balance;
  String? virtualBalance;
  int? year;
  String? campus;
  String? phone;
  String? image;
  String? theme;
  String? jwtIat;
  List<Groups>? groups;

  UserModel(
      {this.id,
      this.password,
      this.lastLogin,
      this.isSuperuser,
      this.username,
      this.firstName,
      this.lastName,
      this.email,
      this.isStaff,
      this.isActive,
      this.dateJoined,
      this.surname,
      this.family,
      this.balance,
      this.virtualBalance,
      this.year,
      this.campus,
      this.phone,
      this.image,
      this.theme,
      this.jwtIat,
      this.groups});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    password = json['password'];
    lastLogin = json['last_login'];
    isSuperuser = json['is_superuser'];
    username = json['username'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    isStaff = json['is_staff'];
    isActive = json['is_active'];
    dateJoined = json['date_joined'];
    surname = json['surname'];
    family = json['family'];
    balance = json['balance'];
    virtualBalance = json['virtual_balance'];
    year = json['year'];
    campus = json['campus'];
    phone = json['phone'];
    image = json['avatar'];
    theme = json['theme'];
    jwtIat = json['jwt_iat'];
    if (json['groups'] != null) {
      groups = <Groups>[];
      json['groups'].forEach((v) {
        groups!.add(Groups.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['password'] = password;
    data['last_login'] = lastLogin;
    data['is_superuser'] = isSuperuser;
    data['username'] = username;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['is_staff'] = isStaff;
    data['is_active'] = isActive;
    data['date_joined'] = dateJoined;
    data['surname'] = surname;
    data['family'] = family;
    data['balance'] = balance;
    data['virtual_balance'] = virtualBalance;
    data['year'] = year;
    data['campus'] = campus;
    data['phone'] = phone;
    data['avatar'] = image;
    data['theme'] = theme;
    data['jwt_iat'] = jwtIat;
    if (groups != null) {
      data['groups'] = groups!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Groups {
  int? id;
  String? name;
  List<Permissions>? permissions;

  Groups({this.id, this.name, this.permissions});

  Groups.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['permissions'] != null) {
      permissions = <Permissions>[];
      json['permissions'].forEach((v) {
        permissions!.add(Permissions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    if (permissions != null) {
      data['permissions'] = permissions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Permissions {
  int? id;
  String? name;
  String? codename;
  int? contentType;

  Permissions({this.id, this.name, this.codename, this.contentType});

  Permissions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    codename = json['codename'];
    contentType = json['content_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['codename'] = codename;
    data['content_type'] = contentType;
    return data;
  }
}
