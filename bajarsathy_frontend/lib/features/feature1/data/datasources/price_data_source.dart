import 'package:bajarsathy_frontend/features/feature1/data/models/price_model.dart';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

abstract class PriceDataSource {
  Future<List<PriceModel>> getPrices();
}

class PriceDataSourceImplemention implements PriceDataSource {
  final http.Client client;

  PriceDataSourceImplemention(this.client);

  @override
  Future<List<PriceModel>> getPrices() async {
    // get today date yyyy-mm-dd format
    final today = DateTime.now();
    final year = today.year;
    final month = today.month;
    final day = today.day;
    final date = '$year-$month-$day';
    try {
      final response = await client
          .get(
            Uri.parse('https://sumanshrestha14.com.np/api/prices'),

            headers: {
              "Accept": "application/json",
              "Content-Type": "application/json",
              "X-API-KEY": "kalimati_secret_123",
            },
          )
          .timeout(
            const Duration(seconds: 30),
            onTimeout: () {
              debugPrint(
                'Request timeout: No response received within 30 seconds',
              );
              throw Exception(
                'Request timeout: No response received within 30 seconds',
              );
            },
          );

      if (response.statusCode == 200) {
        try {
          final jsonMap = json.decode(response.body) as Map<String, dynamic>;

          // Extract the data field which contains the list of prices
          if (jsonMap.containsKey('data')) {
            final jsonList = jsonMap['data'] as List;
            debugPrint('Successfully parsed ${jsonList.length} price items');
            return jsonList
                .map(
                  (json) => PriceModel.fromJson(json as Map<String, dynamic>),
                )
                .toList();
          } else {
            debugPrint('Response body: ${response.body}');
            throw Exception('API response missing "data" field');
          }
        } catch (e) {
          debugPrint('JSON Parsing Error: $e');
          debugPrint('Response body: ${response.body}');
          throw Exception('Failed to parse prices data: $e');
        }
      } else {
        debugPrint('HTTP Error: Status Code ${response.statusCode}');
        debugPrint('Response body: ${response.body}');
        throw Exception(
          'Failed to load prices: HTTP ${response.statusCode} - ${response.body}',
        );
      }
    } on SocketException catch (e) {
      debugPrint('SocketException: ${e.message}');
      debugPrint('OS Error: ${e.osError}');
      debugPrint('Address: ${e.address}');
      debugPrint('Port: ${e.port}');
      throw Exception(
        'Network connection failed: ${e.message}. Please check your internet connection.',
      );
    } on http.ClientException catch (e) {
      debugPrint('ClientException: ${e.message}');
      debugPrint('URI: ${e.uri}');
      if (e.message.contains('Failed host lookup') ||
          e.message.contains('SocketException')) {
        throw Exception(
          'Cannot reach server: ${e.message}. Please check your internet connection and try again.',
        );
      }
      throw Exception('Network error: ${e.message}');
    } on Exception catch (e) {
      debugPrint('Exception: $e');
      rethrow;
    } catch (e, stackTrace) {
      debugPrint('Unexpected Error: $e');
      debugPrint('Stack Trace: $stackTrace');
      throw Exception('Unexpected error occurred: $e');
    }
  }
}
