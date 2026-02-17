import 'package:gnome_challenge/core/network/domain/network_client.dart';
import 'package:gnome_challenge/core/network/domain/network_exception.dart';
import 'package:gnome_challenge/core/network/domain/network_request.dart';
import 'package:gnome_challenge/core/network/domain/network_response.dart';
import 'package:gnome_challenge/features/gnomes/data/dto/gnomes_dataset_dto.dart';
import 'package:gnome_challenge/features/gnomes/data/remote/gnomes_api.dart';

class GnomesNetworkFacade {
  const GnomesNetworkFacade({
    required GnomesApi retrofitApi,
    required NetworkClient networkClient,
  })  : _retrofitApi = retrofitApi,
        _networkClient = networkClient;

  final GnomesApi _retrofitApi;
  final NetworkClient _networkClient;

  Future<GnomesDatasetDto> getGnomesDatasetWithRetrofit() {
    return _retrofitApi.getGnomesDataset();
  }

  Future<NetworkResponse<GnomesDatasetDto>> getGnomesDatasetWithClient(
    String dataUrl,
  ) {
    return _networkClient.send<GnomesDatasetDto>(
      NetworkRequest.get(dataUrl),
      decoder: (rawData) {
        if (rawData is! Map<Object?, Object?>) {
          throw const NetworkException(
            type: NetworkExceptionType.unknown,
            message: 'Invalid payload type for gnomes dataset',
          );
        }

        return GnomesDatasetDto.fromJson(
          Map<String, dynamic>.from(rawData),
        );
      },
    );
  }
}
