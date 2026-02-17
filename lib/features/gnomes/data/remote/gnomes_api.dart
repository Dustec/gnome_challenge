import 'package:dio/dio.dart';
import 'package:gnome_challenge/features/gnomes/data/dto/gnomes_dataset_dto.dart';
import 'package:retrofit/retrofit.dart';

part 'gnomes_api.g.dart';

@RestApi()
abstract class GnomesApi {
  factory GnomesApi(Dio dio, {String baseUrl}) = _GnomesApi;

  @GET('')
  Future<GnomesDatasetDto> getGnomesDataset();
}
