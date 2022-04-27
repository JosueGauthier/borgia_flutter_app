extension StringExtension on String {
  String capitalizefirstletter() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
