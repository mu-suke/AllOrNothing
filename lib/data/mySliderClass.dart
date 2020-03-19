class MySlider {
  MySlider({
    this.title,
    this.value,
    this.createdAt
  });

  String title;
  int value;
  DateTime createdAt;

  MySlider.newSlider() {
    title = '';
    value = 0;
    createdAt = DateTime.now();
  }
}