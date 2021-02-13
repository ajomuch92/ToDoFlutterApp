class Task {
  String title, description, ownerUid;
  DateTime finishedDate;
  bool isComplete;

  Task({this.title, this.description, this.finishedDate, this.isComplete, this.ownerUid});

  factory Task.fromJson(Map<String, dynamic> json) => Task(
    description: json['description'],
    title: json['title'],
    ownerUid: json['ownerUid'],
    finishedDate: DateTime.tryParse(json['finishedDate']),
    isComplete: json['isComplete'] as bool,
  );

  Map<String, dynamic> toJson() => {
    'description': description,
    'title': title,
    'isComplete': isComplete
  };
}