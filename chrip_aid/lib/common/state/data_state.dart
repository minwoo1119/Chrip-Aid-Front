import 'package:flutter/material.dart';

class DataState<T> extends ValueNotifier<T?> {
  _StateData _state = _StateData.none;
  String? _message;

  DataState() : super(null);

  get isNone => _state == _StateData.none;

  get isLoading => _state == _StateData.loading;

  get isSuccess => _state == _StateData.success;

  get isError => _state == _StateData.error;

  get message => _message;

  void none({T? value, String? message}) {
    _state = _StateData.none;
    _message = message;
    if(this.value == value) notifyListeners();
    this.value = value;
  }

  void loading({T? value, String? message}) {
    _state = _StateData.loading;
    _message = message;
    if(this.value == value) notifyListeners();
    this.value = value;
  }

  void success({T? value, String? message}) {
    _state = _StateData.success;
    _message = message;
    if(this.value == value) notifyListeners();
    this.value = value;
  }

  void error({T? value, String? message}) {
    _state = _StateData.error;
    _message = message;
    if(this.value == value) notifyListeners();
    this.value = value;
  }
}

enum _StateData<T> {
  none,
  loading,
  success,
  error;
}
