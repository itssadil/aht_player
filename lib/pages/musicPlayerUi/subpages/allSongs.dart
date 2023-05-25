import 'package:flutter/material.dart';

class allSongs extends StatelessWidget {
  const allSongs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(color: Colors.white54),
        ListTile(
          title: Text(
            "All songs",
            style: TextStyle(color: Colors.white),
          ),
          leading:
              Icon(Icons.my_library_music_sharp, color: Colors.lightBlueAccent),
          trailing: Icon(
            Icons.keyboard_arrow_up_outlined,
            color: Colors.lightBlueAccent,
          ),
          onTap: () => _openModalSheet(context),
        ),
      ],
    );
  }

  _openModalSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Color(0xff001BF6).withOpacity(0.2),
      context: context,
      builder: (BuildContext context) {
        return ListView.builder(
          itemCount: 20,
          itemBuilder: (context, index) {
            return Card(
              color: Color(0xff001BF6).withOpacity(0.2),
              // elevation: 0,
              child: ListTile(
                leading: Icon(Icons.music_note_sharp, color: Colors.white),
                title: Text(
                  "Song Title $index",
                  style: TextStyle(color: Colors.white),
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: IconButton(
                  icon:
                      Icon(Icons.favorite_border_outlined, color: Colors.white),
                  onPressed: () {},
                ),
              ),
            );
          },
        );
      },
    );
  }
}
