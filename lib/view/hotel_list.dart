import 'package:flutter/material.dart';
import 'package:flutter_demo/model/entity/hotel.dart';
import 'package:flutter_demo/presentation/hotel_list_presenter.dart';
import 'package:flutter_demo/view/hotel_details.dart';
import 'package:flutter_demo/common/strings.dart';
import 'package:flutter_demo/common/transitions.dart';

class HotelsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return HotelList();
  }
}

class HotelList extends StatefulWidget {
  HotelList({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HotelListState();
}

class _HotelListState extends State<HotelList> implements HotelListContract {
  HotelListPresenter _presenter;

  List<_HotelListItem> _hotels;

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
      _hotels = hotels.map((hotel) => _HotelListItem(hotel)).toList();
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
      widget = Scaffold(
        appBar: AppBar(
          title: Text(Strings.hotels),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      widget = Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              floating: true,
              pinned: false,
              snap: true,
              title: Text(Strings.hotels),
            ),
            SliverPadding(
              padding: EdgeInsets.only(left: 4.0, right: 4.0, bottom: 40.0),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => _hotels[index],
                  childCount: _hotels.length,
                ),
              ),
            )
          ],
        ),
      );
    }

    return widget;
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
        child: Stack(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                FadeInImage(
                  height: 200.0,
                  fadeInDuration: Duration(milliseconds: 300),
                  placeholder: AssetImage(""),
                  image: NetworkImage(_hotel.photos[0].url),
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
            new Positioned.fill(
              child: new Material(
                color: Colors.transparent,
                child: new InkWell(
                  onTap: () => Navigator.of(context).push(
                        PageRouteBuilder(
                          pageBuilder: (context, _, __) => HotelScreen(_hotel),
                          transitionsBuilder:
                              Transitions.fadeTransitionsBuilder(),
                          transitionDuration: DEFAULT_SLIDE_IN_DURATION,
                        ),
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
