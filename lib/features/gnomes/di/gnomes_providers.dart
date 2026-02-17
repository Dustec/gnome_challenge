import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gnome_challenge/core/config/app_env.dart';
import 'package:gnome_challenge/core/network/di/network_providers.dart';
import 'package:gnome_challenge/features/gnomes/data/facade/gnomes_network_facade.dart';
import 'package:gnome_challenge/features/gnomes/data/remote/gnomes_api.dart';

final gnomesDataUrlProvider = Provider<String>((ref) {
  return AppEnv.gnomesDataUrl;
});

final gnomesApiProvider = Provider<GnomesApi>((ref) {
  return GnomesApi(
    ref.watch(dioProvider),
    baseUrl: ref.watch(gnomesDataUrlProvider),
  );
});

final gnomesNetworkFacadeProvider = Provider<GnomesNetworkFacade>((ref) {
  return GnomesNetworkFacade(
    retrofitApi: ref.watch(gnomesApiProvider),
    networkClient: ref.watch(networkClientProvider),
  );
});
