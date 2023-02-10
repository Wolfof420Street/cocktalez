class Failure {
  String? errorMessage;
  String? type;
  bool? isToastShown;
  Failure(this.errorMessage, {this.isToastShown = false, this.type = ''});
}