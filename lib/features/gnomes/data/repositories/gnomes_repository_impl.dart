import 'package:gnome_challenge/features/gnomes/data/facade/gnomes_network_facade.dart';
import 'package:gnome_challenge/features/gnomes/data/mappers/gnomes_mapper.dart';
import 'package:gnome_challenge/features/gnomes/domain/model/gnome.dart';
import 'package:gnome_challenge/features/gnomes/domain/repositories/gnomes_repository.dart';

class GnomesRepositoryImpl implements GnomesRepository {
  const GnomesRepositoryImpl(this._networkFacade);

  final GnomesNetworkFacade _networkFacade;

  @override
  Future<List<Gnome>> fetchGnomes() async {
    final dataset = await _networkFacade.getGnomesDatasetWithRetrofit();
    return dataset.toDomain();
  }
}
