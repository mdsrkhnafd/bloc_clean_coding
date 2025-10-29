import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_localization/easy_localization.dart'; // 🔹 must import

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(const LanguageState(Locale('en'))) {
    on<LoadLanguageEvent>(_onLoadLanguage);
    on<ToggleLanguageEvent>(_onToggleLanguage);
  }

  Future<void> _onLoadLanguage(
      LoadLanguageEvent event, Emitter<LanguageState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    final langCode = prefs.getString('langCode') ?? 'en';
    emit(LanguageState(Locale(langCode)));
  }

  Future<void> _onToggleLanguage(
      ToggleLanguageEvent event, Emitter<LanguageState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    final newLocale = state.locale.languageCode == 'en'
        ? const Locale('ur')
        : const Locale('en');

    await prefs.setString('langCode', newLocale.languageCode);

    // 🔹 Works now because of the import
    await event.context.setLocale(newLocale);

    emit(LanguageState(newLocale)); // update icon only
  }
}
