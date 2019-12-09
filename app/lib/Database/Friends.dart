class Friends {
  final int userID;
  final int friendID;

  Friends({this.userID, this.friendID});

  // Convert a uSER into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {'user_id': userID, 'friend_id': friendID};
  }
}
