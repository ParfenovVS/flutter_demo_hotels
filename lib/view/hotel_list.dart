import 'package:flutter/material.dart';
import 'package:flutter_demo/model/entity/hotel.dart';
import 'package:flutter_demo/presentation/hotel_list_presenter.dart';
import 'package:flutter_demo/view/hotel_details.dart';
import 'package:flutter_demo/common/strings.dart';
import 'package:flutter_demo/common/transitions.dart';

class HotelsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(Strings.hotels)),
        body: HotelList());
  }
}

class HotelList extends StatefulWidget {
  HotelList({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HotelListState();
}

class _HotelListState extends State<HotelList> implements HotelListContract {
  HotelListPresenter _presenter;

  List<Hotel> _hotels;

  bool _isLoading;

  _HotelListState() {
    _presenter = HotelListPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    _presenter.loadHotels();
  }

  @override
  void onSuccess(List<Hotel> hotels) {
    setState(() {
      _hotels = hotels;
      _isLoading = false;
    });
  }

  @override
  void onError() {
    Scaffold
        .of(context)
        .showSnackBar(SnackBar(content: Text(Strings.defaultError)));
  }

  @override
  Widget build(BuildContext context) {
    Widget widget;

    if (_isLoading) {
      widget = Center(
        child: CircularProgressIndicator(),
      );
    } else {
      widget = ListView(
        padding: EdgeInsets.symmetric(horizontal: 4.0),
        children: _buildHotelList(),
      );
    }

    return widget;
  }

  List<_HotelListItem> _buildHotelList() {
    return _hotels.map((hotel) => _HotelListItem(hotel)).toList();
  }
}

class _HotelListItem extends StatelessWidget {
  final Hotel _hotel;

  _HotelListItem(this._hotel);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 4.0),
      child: Card(
        child: InkWell(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Image.network(
                _hotel.photos[0].url,
                fit: BoxFit.cover,
              ),
              ListTile(
                title: Text(_hotel.name),
                subtitle: Text(_hotel.address),
                trailing: Row(
                  children: <Widget>[
                    Image.asset(
                      "assets/image/ic_star_black_24dp.png",
                      scale: 1.5,
                      color: Colors.orange,
                    ),
                    Text(
                      _hotel.stars.toString(),
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ],
                ),
              )
            ],
          ),
          onTap: () => Navigator.of(context).push(
                PageRouteBuilder(
                  pageBuilder: (context, _, __) => HotelScreen(_hotel),
                  transitionsBuilder: Transitions.slideInTransitionsBuilder(),
                  transitionDuration: DEFAULT_SLIDE_IN_DURATION,
                ),
              ),
        ),
      ),
    );
  }
}
