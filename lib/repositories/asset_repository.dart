import 'package:mantia/models/office_asset.dart';
import 'package:mantia/remote/maintenance_order_remote_data_source.dart';
import 'package:mantia/services/asset_service.dart';

class AssetRepository {
  final AssetService service;
  final MaintenanceOrderRemoteDataSource remote;

  AssetRepository({required this.service, required this.remote});

  Future<List<OfficeAsset>> getAssets() => service.getAssets();

  Future<Set<String>> getOccupiedAssetIds() => remote.getOccupiedAssetIds();
}
