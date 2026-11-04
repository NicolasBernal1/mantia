import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mantia/core/app_exception.dart';
import 'package:mantia/core/app_logger.dart';
import 'package:mantia/models/office_asset.dart';

class AssetService {
  final String baseUrl;

  AssetService(this.baseUrl);

  Future<List<OfficeAsset>> getAssets() async {
    try {
      final response = await http
          .get(Uri.parse(baseUrl))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));

        AppLogger.debug('Activos cargados: ${data.length} activos cargados');
        return data.map((item) => OfficeAsset.fromJson(item)).toList();
      }

      if (response.statusCode == 404) {
        throw const AppException('No se encontró el catálogo de activos');
      }

      if (response.statusCode == 500) {
        throw const AppException(
          'El servidor tuvo un problema, intenta de nuevo',
        );
      }
      throw AppException('Error HTTP ${response.statusCode}');
    } on AppException {
      rethrow;
    } catch (e, st) {
      AppLogger.error('No se cargaron correctamente los activos', e, st);
      throw const AppException(
        'No se pudo consultar el catálogo, revisa tu conexión',
      );
    }
  }
}
