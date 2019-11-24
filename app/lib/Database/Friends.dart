class Friends {
  final int user_id;
  final int friend_id;

  Friends({this.user_id, this.friend_id});

  // Convert a uSER into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {'user_id': user_id, 'friend_id': friend_id};
  }
}
