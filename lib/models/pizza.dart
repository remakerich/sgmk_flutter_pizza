import 'package:freezed_annotation/freezed_annotation.dart';

part 'pizza.freezed.dart';

@freezed
class Pizza with _$Pizza {
  const factory Pizza({
    @Default('') String name,
    @Default('') String assetPicture,
    @Default(0) int quantity,
    @Default(0) int price,
  }) = _Pizza;
}
