import 'package:equatable/equatable.dart';

class LocaleState extends Equatable {
  const LocaleState({this.isArabic = true});

  final bool isArabic;

  LocaleState copyWith({bool? isArabic}) {
    return LocaleState(isArabic: isArabic ?? this.isArabic);
  }

  @override
  List<Object?> get props => [isArabic];
}
