import 'package:flutter/material.dart';
import 'package:osint/config/palette.dart';
import 'package:osint/hunter/hunter.dart';
import 'package:osint/hunter/hunterSearchTile.dart';
import 'package:provider/provider.dart';

class HunterList extends StatefulWidget {
  @override
  _HunterListState createState() => _HunterListState();
}

class _HunterListState extends State<HunterList> {
  @override
  Widget build(BuildContext context) {
    final hunterProfiles = Provider.of<List<Hunter>>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: Text(
          'Profiles Generated',
          style: TextStyle(color: Palette.darkBlue),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 8),
        child: ListView.builder(
          itemCount: hunterProfiles.length,
          itemBuilder: (context, index) {
            return HunterTile(
              hunterProfiled: hunterProfiles[index],
            );
          },
        ),
      ),
    );
  }
}
