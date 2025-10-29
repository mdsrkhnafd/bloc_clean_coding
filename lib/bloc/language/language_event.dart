part of 'language_bloc.dart';

abstract class LanguageEvent extends Equatable {
  const LanguageEvent();
  @override
  List<Object?> get props => [];
}

class LoadLanguageEvent extends LanguageEvent {}

class ToggleLanguageEvent extends LanguageEvent {
  final BuildContext context;
  const ToggleLanguageEvent(this.context);
}
