class MailContent {
  String title;
  String category;
  String description;
  String address;
  List<String> images = [];
  DateTime filingTime;
  String status;
  List<String> upvotes = [];
  String uid;
  String email;

  MailContent(
      {this.title,
      this.category,
      this.description,
      this.address,
      this.images,
      this.filingTime,
      this.status,
      this.upvotes,
      this.uid,
      this.email});
}

List<String> status = [
  'Pending',
  'Passed',
  'In Progress',
  'Rejected',
  'Solved'
];
