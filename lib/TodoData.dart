class TodoData {
  String _description = "";

  TodoData({String description: ""}) {
    this._description = description;
  }

  @override
  String toString() {
    return 'Todo: ${this._description}';
  }
}
