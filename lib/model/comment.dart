class Comment {
  String id;
  String pic;
  String text;
  String username;
 
 

  Comment({
  
   required this.id,
    required this.pic,
    required this.text,
    required this.username
  });
}
List<Comment> listOfComments = [
  Comment(
    id: "1",
    text: "nice place",
    pic:"assets/images/sidisalem.jpg",
    username: "oumaima"
  ),
   Comment(
    id: "2",
    text: "nice place",
    pic:"assets/images/sidisalem.jpg",
    username: "oumaima"
  ),
 
  ];