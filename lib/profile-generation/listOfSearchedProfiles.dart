import 'package:flutter/material.dart';
import 'package:osint/model/navDrawer.dart';
import 'package:osint/profile-generation/profile.dart';
import 'package:osint/profile-generation/profileTile.dart';
import 'package:provider/provider.dart';

class ProfileList extends StatefulWidget {
  @override
  _ProfileListState createState() => _ProfileListState();
}

class _ProfileListState extends State<ProfileList> {
  @override
  Widget build(BuildContext context) {
    final profiles = Provider.of<List<Profiless>>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Previous Profiles Generated'),
      ),
      drawer: NavDrawer(),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 8),
        child: ListView.builder(
          itemCount: profiles.length,
          itemBuilder: (context, index) {
            return ProfileTile(
              profiled: profiles[index],
            );
          },
        ),
      ),
    );
  }
}
