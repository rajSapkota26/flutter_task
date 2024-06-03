class DefaultResponse<T> {
  final T? data;
  final String message;
  final ResponseStatus status;

  DefaultResponse({this.data, required this.message, required this.status});
}

enum ResponseStatus {
  SUCCESS,
  ERROR,
  LOADING,
  EXPIRED,
  NOINTERNET,
  EXCEPTION
}
