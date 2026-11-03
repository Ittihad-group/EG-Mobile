import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/storage/local_storage.dart';
import 'locale_state.dart';

class LocaleCubit extends Cubit<LocaleState> {
  LocaleCubit({required LocalStorage localStorage})
      : _localStorage = localStorage,
        super(const LocaleState());

  static const _key = 'is_arabic';

  final LocalStorage _localStorage;

  Future<void> load() async {
    final saved = await _localStorage.getBool(_key);
    emit(LocaleState(isArabic: saved ?? true));
  }

  Future<void> toggle() async {
    final next = !state.isArabic;
    await _localStorage.setBool(_key, next);
    emit(LocaleState(isArabic: next));
  }

  Future<void> setArabic(bool value) async {
    await _localStorage.setBool(_key, value);
    emit(LocaleState(isArabic: value));
  }
}
