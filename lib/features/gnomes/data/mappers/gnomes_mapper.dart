import 'package:gnome_challenge/features/gnomes/data/dto/gnomes_dto.dart';
import 'package:gnome_challenge/features/gnomes/domain/model/gnome.dart';

extension GnomeListDtoMapper on List<GnomeDto> {
  List<Gnome> toDomain() {
    return map((dto) => dto.toDomain()).toList(growable: false);
  }
}

extension GnomeDtoMapper on GnomeDto {
  Gnome toDomain() {
    final safeName = (name ?? '').trim();
    final safeHairColor = (hairColor ?? '').trim();

    return Gnome(
      id: id ?? 0,
      name: safeName.isEmpty ? 'Unknown' : safeName,
      thumbnail: thumbnail ?? '',
      age: age ?? 0,
      weight: weight ?? 0,
      height: height ?? 0,
      hairColor: safeHairColor.isEmpty ? 'Unknown' : safeHairColor,
      professions: professions ?? const <String>[],
      friends: friends ?? const <String>[],
    );
  }
}
