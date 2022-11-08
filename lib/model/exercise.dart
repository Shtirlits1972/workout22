class exercise {
  int id = 0;
  String NameEx = '';

  @override
  String toString() {
    return 'id = $id, NameEx = $NameEx';
  }

  exercise(this.id, this.NameEx);
  exercise.empty() {
    this.id = 0;
    this.NameEx = '';
  }
}
