import 'package:gnome_challenge/features/gnomes/data/dto/gnomes_dto.dart';
import 'package:gnome_challenge/features/gnomes/data/remote/gnomes_api.dart';

class GnomesNetworkFacade {
  const GnomesNetworkFacade({required GnomesApi retrofitApi})
    : _retrofitApi = retrofitApi;

  final GnomesApi _retrofitApi;

  Future<List<GnomeDto>> getGnomesDataset() async {
    final dataset = await _retrofitApi.getGnomesDataset();
    return dataset.gnomes ?? const <GnomeDto>[];
  }
}
