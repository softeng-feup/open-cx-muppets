class User {
  final int id;
  final String name;
  final String nationality;
  final String occupation;
  final String company;
  final String languages;
  final String contacts; //CSV contact list
  final String interests;

  User(
      {this.id,
      this.name,
      this.nationality,
      this.occupation,
      this.company,
      this.languages,
      this.contacts,
      this.interests});

  // Convert a uSER into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'nationality' : nationality,
      'occupation' : occupation,
      'company' : company,
      'languages' : languages,
      'contacts' : contacts,
      'interests' : interests
    };
  }
}
