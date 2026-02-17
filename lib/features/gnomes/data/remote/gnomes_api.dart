import 'package:dio/dio.dart';
import 'package:gnome_challenge/features/gnomes/data/dto/gnomes_dto.dart';
import 'package:retrofit/retrofit.dart';

part 'gnomes_api.g.dart';

const String _gnomesDatasetPath = '/rrafols/mobile_test/master/data.json';

@RestApi()
abstract class GnomesApi {
  factory GnomesApi(Dio dio, {String baseUrl}) = _GnomesApi;

  @GET(_gnomesDatasetPath)
  Future<GnomesDatasetDto> getGnomesDataset();
}
