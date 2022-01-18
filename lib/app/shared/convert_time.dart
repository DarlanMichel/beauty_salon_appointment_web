String convertTime(double time) {
  int fullTime = (time * 100).toInt();
  if (fullTime < 100) {
    return '$fullTime min';
  } else {
    var hour =
    fullTime.toString().substring(0, fullTime.toString().length - 2);
    var min = fullTime.toString().substring(fullTime.toString().length - 2);
    return '$hour h $min min';
  }
}