import 'package:json_annotation/json_annotation.dart';

part 'gnomes_dataset_dto.g.dart';

@JsonSerializable()
class GnomesDatasetDto {
  const GnomesDatasetDto({
    required this.gnomes,
  });

  factory GnomesDatasetDto.fromJson(Map<String, dynamic> json) {
    return _$GnomesDatasetDtoFromJson(json);
  }

  @JsonKey(name: 'Brastlewark')
  final List<GnomeDto> gnomes;

  Map<String, dynamic> toJson() => _$GnomesDatasetDtoToJson(this);
}

@JsonSerializable()
class GnomeDto {
  const GnomeDto({
    required this.id,
    required this.name,
    required this.thumbnail,
    required this.age,
    required this.weight,
    required this.height,
    required this.hairColor,
    required this.professions,
    required this.friends,
  });

  factory GnomeDto.fromJson(Map<String, dynamic> json) {
    return _$GnomeDtoFromJson(json);
  }

  final int id;
  final String name;
  final String thumbnail;
  final int age;
  final double weight;
  final double height;

  @JsonKey(name: 'hair_color')
  final String hairColor;

  final List<String> professions;
  final List<String> friends;

  Map<String, dynamic> toJson() => _$GnomeDtoToJson(this);
}
