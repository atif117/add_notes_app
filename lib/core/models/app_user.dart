class AppUser {
  String? name;
  String? email;
  String? password;
  AppUser({
    this.email,
    this.name,
    this.password,
  });
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["name"] = name;
    data["email"] = email;

    return data;
  }

  AppUser.fromjson(
    json,
  ) {
    name = json["name"];
    email = json["email"];
  }
}
