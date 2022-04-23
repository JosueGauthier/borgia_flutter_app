// TODO Implement this library.

extension StringExtension on String {
  String capitalizefirstletter() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}
