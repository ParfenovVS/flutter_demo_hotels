import 'package:flutter/material.dart';
import 'package:flutter_demo/model/entity/hotel.dart';

class HotelScreen extends StatelessWidget {
  final Hotel _hotel;

  HotelScreen(this._hotel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_hotel.name),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: GridView.builder(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: _hotel.photos.length,
        itemBuilder: _buildItems(),
      ),
    );
  }

  IndexedWidgetBuilder _buildItems() {
    return (context, index) => _PhotoListItem(_hotel.photos[index].url);
  }
}

class _PhotoListItem extends StatelessWidget {
  final String url;

  _PhotoListItem(this.url);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      fit: BoxFit.cover,
    );
  }
}
