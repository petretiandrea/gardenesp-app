import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gardenesp/model/Garden.dart';

class GardensList extends StatefulWidget {
  final List<Garden> gardens;
  final void Function(Garden)? onItemSelected;

  const GardensList({
    Key? key,
    required this.gardens,
    this.onItemSelected,
  }) : super(key: key);

  @override
  _GardensListState createState() => _GardensListState();
}

class _GardensListState extends State<GardensList> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => Divider(color: Colors.black),
      itemBuilder: (context, index) {
        final garden = widget.gardens[index];
        return _buildGardenTile(garden);
      },
      itemCount: widget.gardens.length,
    );
  }

  Widget _buildGardenTile(Garden garden) {
    return Container(
      child: ListTile(
        onTap: () => widget.onItemSelected?.call(garden),
        title: Text(garden.name),
        subtitle: Text(garden.description),
        leading: Image(
          image: Image.network(garden.image).image,
        ),
        contentPadding: const EdgeInsets.all(8),
      ),
    );
  }
}
