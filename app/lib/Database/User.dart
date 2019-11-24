class User {
  final int id;
  final String name;
  final String nationality;
  final String occupation;
  final String company;
  final String languages;
  final List<String> contacts;
  final List<String> interests;

  User(
      {this.id,
      this.name,
      this.nationality,
      this.occupation,
      this.company,
      this.languages,
      this.contacts,
      this.interests});

  String listToCSV(List<String> list) {
    String csv = '';
    if (list.isNotEmpty) {
      csv = list.elementAt(0);

      for (int i = 1; i < list.length; i++) {
        csv += ',' + list.elementAt(i);
      }
    }

    return csv;
  }

  // Convert a uSER into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'nationality': nationality,
      'occupation': occupation,
      'company': company,
      'languages': languages,
      'contacts': listToCSV(contacts),
      'interests': listToCSV(interests)
    };
  }
}
