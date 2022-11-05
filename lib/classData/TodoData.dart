class TodoData {
  String title;
  String description;
  bool status;
  DateTime? dateTime;

  String getTitle() {
    return this.title;
  }

  String getDescription() {
    return this.description;
  }

  bool getStatus() {
    return this.status;
  }

  DateTime? getDateTime() {
    return this.dateTime;
  }

  TodoData({
    required this.title,
    required this.description,
    required this.status,
    this.dateTime,
  });

  @override
  String toString() {
    return 'Todo: ${this.title} -> ${this.description} -> ${this.status} -> ${this.dateTime.toString()}';
  }

  toJson() {
    return {
      "title": title,
      "description": description,
      "status": status,
      "dateTime": dateTime != null ? dateTime.toString() : dateTime,
    };
  }

  static TodoData fromJson(jsonData) {
    return TodoData(
        title: jsonData['title'],
        description: jsonData['description'],
        status: jsonData['status'],
        dateTime: jsonData['dateTime'] != null
            ? DateTime.parse(jsonData['dateTime'])
            : jsonData['dateTime']);
  }
}
