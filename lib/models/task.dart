class Task {
  Task(
    this.id,
    this.completed,
    this.description,
    this.owner,
    this.data,
  );
  String id;
  bool completed;
  String description;
  String owner;
  String data;

  factory Task.fromJson(Map<String, dynamic> json) {
    //class takhou format json wi t7othom tableau type task
    return Task(
      json['_id'].toString(),
      json['completed'],
      json['description'].toString(),
      json['owner'].toString(),
      json['createdAt'].toString(),
    );
  }
}
