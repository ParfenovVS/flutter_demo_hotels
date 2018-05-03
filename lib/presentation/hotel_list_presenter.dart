import 'package:flutter_demo/model/entity/hotel.dart';
import 'package:flutter_demo/model/repository.dart';

abstract class HotelListContract {
  void onSuccess(List<Hotel> hotels);
  void onError();
}

class HotelListPresenter {
  final HotelListContract _view;
  HotelRepository _repository;

  HotelListPresenter(this._view) {
    _repository = new HotelRepository();
  }

  void loadHotels() {
    assert(_view != null);
    _repository.getHotels().then((hotels) {
      hotels.sort((h1, h2) => h2.stars.compareTo(h1.stars));
      _view.onSuccess(hotels);
    }).catchError((onError) {
      print(onError);
      _view.onError();
    });
  }
}
