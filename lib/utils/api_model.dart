class ApiModel<T, V> {
  final T? data;
  final V? error;

  ApiModel(this.data, this.error);

  bool get isSuccess => error == null;

  bool get isError => error != null;

  factory ApiModel.success(T data) => ApiModel(data, null);

  factory ApiModel.error(V error) => ApiModel(null, error);

  void fold<R>(R Function(T data) onSuccess, R Function(V error) onError) {
    if (isSuccess) {
      onSuccess(data as T);
    } else {
      onError(error as V);
    }
  }
}
