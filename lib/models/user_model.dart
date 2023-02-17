// User Model
class User {
  final String firstName, lastName, website;
  const User(this.firstName, this.lastName, this.website);

  User.fromJson(Map<String, dynamic> json)
      : firstName = json['first_name'],
        lastName = json['last_name'],
        website = json['website'];
}
