import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
/// Central API client for Watch-related endpoints.
/// NOTE:
/// - Kept backwards compatibility for existing calls:
///   - [fetchWatchesRaw]
///   - [fetchWatchById]
/// - Adds a more robust request layer + optional CRUD.
class WatchApiService extends GetxService {
  /// Base URL for watch collection.
  /// NOTE: This is intentionally aligned with whatever your controllers already use.
  /// If your backend requires a different path, change it here only.
  static const String baseUrl =
      'https://seangleangsim006-cmd.github.io/fake-json/';
  final http.Client _client;
  WatchApiService({http.Client? client}) : _client = client ?? http.Client();
  Future<_JsonResponse> _request({
    required String method,
    required Uri uri,
    Map<String, String>? headers,
    Object? body,
    Duration timeout = const Duration(seconds: 15),
  }) async {
    final mergedHeaders = <String, String>{
      'Accept': 'application/json',
      if (body != null) 'Content-Type': 'application/json',
      ...?headers,
    };
    final encodedBody = body == null ? null : jsonEncode(body);
    final future = () async {
      http.Response res;
      switch (method.toUpperCase()) {
        case 'GET':
          res = await _client.get(uri, headers: mergedHeaders);
          break;
        case 'POST':
          res = await _client.post(uri,
              headers: mergedHeaders, body: encodedBody);
          break;
        case 'PUT':
          res =
              await _client.put(uri, headers: mergedHeaders, body: encodedBody);
          break;
        case 'PATCH':
          res = await _client.patch(uri,
              headers: mergedHeaders, body: encodedBody);
          break;
        case 'DELETE':
          res = await _client.delete(uri, headers: mergedHeaders);
          break;
        default:
          throw ArgumentError('Unsupported HTTP method: $method');
      }
      return res;
    }();
    final res = await future.timeout(timeout);
    final decoded = _tryDecodeJson(res.body);
    if (res.statusCode < 200 || res.statusCode >= 300) {
      throw http.ClientException(
        'Watch API request failed: ${res.statusCode} ${res.reasonPhrase ?? ''}'
            .trim(),
        uri,
      );
    }
    return _JsonResponse(statusCode: res.statusCode, data: decoded);
  }
  dynamic _tryDecodeJson(String body) {
    final trimmed = body.trim();
    if (trimmed.isEmpty) return null;
    try {
      return jsonDecode(trimmed);
    } catch (_) {
      // Some endpoints may return non-JSON responses.
      return trimmed;
    }
  }
  /// Fetch watches list.
  /// Home screen (`HomeModel.fromApi`) can handle either:
  /// - a list of product objects
  /// - a map with `data` key
  Future<dynamic> fetchWatchesRaw() async {
    final res = await _request(
      method: 'GET',
      uri: Uri.parse(baseUrl),
    );
    return res.data;
  }
  /// Fetch a single watch by id.
  Future<Map<String, dynamic>> fetchWatchById(String id) async {
    final res = await _request(
      method: 'GET',
      uri: Uri.parse('$baseUrl/$id'),
    );
    final body = res.data;
    if (body is! Map<String, dynamic>) {
      throw Exception('Unexpected response for watch id=$id');
    }
    return body;
  }
  // ---------- Upgraded / additional API ----------
  /// Fetch watches with optional query.
  /// This is backend-agnostic: it will attach query parameters if provided.
  /// Example query keys depend on your backend (e.g. page/limit/search).
  Future<dynamic> fetchWatches({
    int? page,
    int? limit,
    String? query,
  }) async {
    final params = <String, String>{};
    if (page != null) params['page'] = page.toString();
    if (limit != null) params['limit'] = limit.toString();
    if (query != null && query.isNotEmpty) params['q'] = query;
    final uri = params.isEmpty
        ? Uri.parse(baseUrl)
        : Uri.parse(baseUrl).replace(queryParameters: params);
    final res = await _request(method: 'GET', uri: uri);
    return res.data;
  }
  /// Create a new watch.
  Future<Map<String, dynamic>> createWatch(Map<String, dynamic> payload) async {
    final res = await _request(
      method: 'POST',
      uri: Uri.parse(baseUrl),
      body: payload,
    );
    if (res.data is! Map<String, dynamic>) {
      throw Exception('Unexpected response while creating watch');
    }
    return res.data as Map<String, dynamic>;
  }
  /// Update an existing watch.
  Future<Map<String, dynamic>> updateWatch(
    String id,
    Map<String, dynamic> payload,
  ) async {
    final res = await _request(
      method: 'PUT',
      uri: Uri.parse('$baseUrl/$id'),
      body: payload,
    );
    if (res.data is! Map<String, dynamic>) {
      throw Exception('Unexpected response while updating watch id=$id');
    }
    return res.data as Map<String, dynamic>;
  }
  /// Delete a watch.
  Future<void> deleteWatch(String id) async {
    await _request(method: 'DELETE', uri: Uri.parse('$baseUrl/$id'));
  }
}
class _JsonResponse {
  final int statusCode;
  final dynamic data;
  _JsonResponse({required this.statusCode, required this.data});
}
