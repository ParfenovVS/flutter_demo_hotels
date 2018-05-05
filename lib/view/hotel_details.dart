import 'package:flutter/material.dart';
import 'package:flutter_demo/model/entity/hotel.dart';
import 'package:meta/meta.dart';

class HotelScreen extends StatelessWidget {
  final Hotel _hotel;

  HotelScreen(this._hotel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            floating: true,
            pinned: false,
            snap: true,
            title: Text(_hotel.name),
          ),
          SliverGrid(
            delegate: SliverChildBuilderDelegate(
              _buildItems(),
              childCount: _hotel.photos.length,
            ),
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          ),
        ],
      ),
    );
  }

  IndexedWidgetBuilder _buildItems() {
    return (context, index) => _PhotoListItem(url: _hotel.photos[index].url);
  }
}

class _PhotoListItem extends StatelessWidget {
  const _PhotoListItem({Key key, @required this.url})
      : assert(url != null),
        super(key: key);

  final String url;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FadeInImage(
        fadeInDuration: Duration(milliseconds: 300),
        placeholder: AssetImage(""),
        image: NetworkImage(url),
        fit: BoxFit.cover,
      ),
    );
  }
}
