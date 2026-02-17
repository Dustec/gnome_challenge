import 'package:gnome_challenge/features/gnomes/domain/model/gnome.dart';

abstract class GnomesRepository {
  Future<List<Gnome>> fetchGnomes();
}
