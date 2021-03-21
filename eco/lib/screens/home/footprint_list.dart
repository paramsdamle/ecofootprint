import 'package:eco/models/footprint.dart';
import 'package:eco/screens/home/footprint_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FootprintList extends StatefulWidget {
  @override
  _FootprintListState createState() => _FootprintListState();
}

class _FootprintListState extends State<FootprintList> {
  @override
  Widget build(BuildContext context) {

    final footprints = Provider.of<List<Footprint>>(context) ?? [];

    return ListView.builder(
      itemCount: footprints.length,
      itemBuilder: (context, index) {
        return FootprintTile(fp: footprints[index]);
      },
    );
  }
}