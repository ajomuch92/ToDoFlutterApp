class Task {
  String title, description, ownerUid, id;
  DateTime finishedDate;
  bool isComplete;

  Task({this.title, this.description, this.finishedDate, this.isComplete, this.ownerUid, this.id});

  factory Task.fromJson(Map<String, dynamic> json) => Task(
    description: json['attributes']['description'],
    title: json['attributes']['title'],
    ownerUid: json['attributes']['ownerUid'],
    finishedDate: DateTime.tryParse(json['attributes']['finishedDate']),
    isComplete: json['attributes']['isComplete'] as bool,
    id: json['uid']
  );
  
  factory Task.fromNewOrEditableJson(Map<String, dynamic> json) => Task(
    description: json['description'],
    title: json['title'],
    isComplete: json['isComplete'] as bool,
  );
  
  factory Task.fromJsonAndUid(Map<String, dynamic> json, String uid) => Task(
    description: json['description'],
    title: json['title'],
    ownerUid: json['ownerUid'],
    finishedDate: DateTime.tryParse(json['finishedDate'].toString()??''),
    isComplete: json['isComplete'] as bool,
    id: uid
  );

  Map<String, dynamic> toJson() => {
    'description': description,
    'title': title,
    'isComplete': isComplete,
    'ownerUid': ownerUid,
    'finishedDate': finishedDate
  };
}