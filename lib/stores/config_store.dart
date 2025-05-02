import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'config_store.g.dart';

class ConfigStore = _ConfigStore with _$ConfigStore;

abstract class _ConfigStore with Store {
   @observable
  ThemeMode _themeMode = ThemeMode.system; 

  @computed
  ThemeMode get themeMode => _themeMode;

  @action
  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
  }

  
}
