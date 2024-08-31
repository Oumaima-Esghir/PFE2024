class Comment {
  String id;
  String pic;
  String text;
  String username;

  Comment({
    required this.id,
    required this.pic,
    required this.text,
    required this.username,
  });

  // Factory constructor to create a Comment from a map
  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      id: map['_id'] as String? ?? '',
      pic: map['userId'] != null && map['userId']['image'] != null
          ? map['userId']['image'] as String? ?? ''
          : '',
      text: map['text'] as String? ?? '',
      username: map['userId'] != null && map['userId']['username'] != null
          ? map['userId']['username'] as String? ?? ''
          : '',
    );
  }
}

void main() {
  // Example of how to use the fromMap method
  Map<String, dynamic> commentMap = {
    '_id': '1',
    'text': 'nice place',
    'userId': {
      'username': 'oumaima',
      'image': 'assets/images/sidisalem.jpg',
    },
  };

  Comment comment = Comment.fromMap(commentMap);
  print(comment.id); // Output: 1
  print(comment.text); // Output: nice place
  print(comment.pic); // Output: assets/images/sidisalem.jpg
  print(comment.username); // Output: oumaima
}
