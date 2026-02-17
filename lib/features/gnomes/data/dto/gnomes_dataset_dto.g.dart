// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gnomes_dataset_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GnomesDatasetDto _$GnomesDatasetDtoFromJson(Map<String, dynamic> json) =>
    GnomesDatasetDto(
      gnomes:
          (json['Brastlewark'] as List<dynamic>)
              .map((e) => GnomeDto.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$GnomesDatasetDtoToJson(GnomesDatasetDto instance) =>
    <String, dynamic>{'Brastlewark': instance.gnomes};

GnomeDto _$GnomeDtoFromJson(Map<String, dynamic> json) => GnomeDto(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  thumbnail: json['thumbnail'] as String,
  age: (json['age'] as num).toInt(),
  weight: (json['weight'] as num).toDouble(),
  height: (json['height'] as num).toDouble(),
  hairColor: json['hair_color'] as String,
  professions:
      (json['professions'] as List<dynamic>).map((e) => e as String).toList(),
  friends: (json['friends'] as List<dynamic>).map((e) => e as String).toList(),
);

Map<String, dynamic> _$GnomeDtoToJson(GnomeDto instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'thumbnail': instance.thumbnail,
  'age': instance.age,
  'weight': instance.weight,
  'height': instance.height,
  'hair_color': instance.hairColor,
  'professions': instance.professions,
  'friends': instance.friends,
};
