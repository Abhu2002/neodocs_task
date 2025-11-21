import 'dart:convert';
import 'dart:io';
import '../model/range_item.dart';

/// Service responsible for fetching ranges from the API
class RangeService {
  static const String _baseUrl =
      'https://nd-assignment.azurewebsites.net/api/get-ranges';

  // From assignment PDF
  static const String _token =
      'eb3dae0a10614a7e719277e07e268b12aeb3af6d7a4655472608451b321f5a95';

  Future<List<RangeItem>> fetchRanges() async {
    final client = HttpClient();
    try {
      final uri = Uri.parse(_baseUrl);
      final request = await client.getUrl(uri);
      request.headers.set(
        HttpHeaders.authorizationHeader,
        'Bearer $_token',
      );

      final HttpClientResponse response = await request.close();
      final String body = await response.transform(utf8.decoder).join();

      if (response.statusCode != 200) {
        throw HttpException(
            'Failed to load ranges. Status: ${response.statusCode}');
      }

      final dynamic decoded = jsonDecode(body);

      // According to your sample, the response is a JSON array.
      if (decoded is List) {
        return decoded
            .map<RangeItem>((e) => RangeItem.fromJson(e))
            .toList(growable: false);
      } else {
        throw const FormatException('Unexpected JSON format (expected List).');
      }
    } finally {
      client.close();
    }
  }
}