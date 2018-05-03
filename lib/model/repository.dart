import 'package:flutter_demo/model/entity/hotel.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class HotelRepository {
  final JsonDecoder _decoder = new JsonDecoder();

  Future<List<Hotel>> getHotels() {
    return http
        .get(
            "http://engine.hotellook.com/api/v2/static/hotels.json?locationId=895&token=0fd545bc8fe933f9df771cd71943b3ea")
        .then((http.Response response) {
      final String jsonBody = response.body;
      final statusCode = response.statusCode;

      if (statusCode < 200 || statusCode >= 300 || jsonBody == null) {
        print(statusCode);
        throw new ApiException(
            "Error while getting hotels [StatusCode:$statusCode]");
      }

      final hotelsContainer = _decoder.convert(jsonBody);
      final List hotels = hotelsContainer['hotels'];

      return hotels
          .map((hotelRaw) => new Hotel.fromMap(hotelRaw))
          .where((hotel) => hotel.photos != null && hotel.photos.isNotEmpty)
          .toList();
    });
  }
}

class ApiException implements Exception {
  final String _message;

  ApiException(this._message);

  String toString() {
    return "Exception: $_message";
  }
}
