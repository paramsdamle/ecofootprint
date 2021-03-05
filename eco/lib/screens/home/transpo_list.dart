import 'package:eco/models/transpo.dart';
import 'package:eco/screens/home/transpo_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TranspoList extends StatefulWidget {
  @override
  _TranspoListState createState() => _TranspoListState();
}

class _TranspoListState extends State<TranspoList> {
  @override
  Widget build(BuildContext context) {

    final transpos = Provider.of<List<Transpo>>(context) ?? [];

    return ListView.builder(
      itemCount: transpos.length,
      itemBuilder: (context, index) {
        return TranspoTile(transpo: transpos[index]);
      },
    );
  }
}