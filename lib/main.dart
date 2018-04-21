import 'package:flutter/material.dart';
import 'party.dart';
import 'PartyForm.dart';
import 'package:dartify/dartify.dart';

//firebase imports
import 'package:firebase_auth/firebase_auth.dart';

void main() => runApp(new Home());

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Pulse',
      theme: new ThemeData(
        primaryColor: Colors.white,
      ),
      home: new BuildParties(),
    );
  }
}

class BuildParties extends StatefulWidget {
  @override
  createState() => new BuildPartiesState();
}

class BuildPartiesState extends State<BuildParties> {
  Party p1 = new Party(
      "Jason's Party", "Foss", ["Hangang", "Break Bread"], 1002, false);
  Party p2 = new Party(
      "Arthur's Party", "Mary Low", ["Sleep", "until 4"], 1002, true);
  List<Party> parties = [this.p1, this.p2];
  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Pulse - Party List'),
      ),
      body: _buildPartyList(),
      floatingActionButton: new FloatingActionButton(
          onPressed: _addParty,
          child: new Icon(Icons.add),
      ),
    );
  }

  _addParty(){
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context) {
           new MyForm();
         },
      ),
    );
  }

//  _addParty(){
//    //pop up dialog box
//    final partyName = //dialogbox.text;
//    final password = //dialogbox2.text;
//    final private = //checkbox.value;
//    parties.add(new Party(partyName, "The Apts", [], ))
//  }

  Widget _buildPartyList() {
    return new ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if (i.isOdd) return new Divider();

          final index = i ~/ 2;

          return _buildPartyRow(parties[index]);
        },
        itemCount: 2 * parties.length
    );
  }

  Widget _buildPartyRow(Party p) {
    return new ListTile(
      title: new Text(
        p.p_name,
        style: _biggerFont,
      ),

      onTap: () {
        _openPlaylist(p.p_playlist);
      },
    );
  }

  void _openPlaylist(List<String> playlist) {
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context) {
          return new BuildPlaylist(playlist);
        },
      ),
    );
  }
}

class BuildPlaylist extends StatefulWidget {
  @override
  List<String> playlist;
  BuildPlaylist(List<String> PL){
    this.playlist = PL;
  }
  createState() => new BuildPlaylistState(this.playlist);
}

class BuildPlaylistState extends State<BuildPlaylist> {
  final _saved = new Set<String>();
  final _biggerFont = const TextStyle(fontSize: 18.0);
  List<String> playlist;
  BuildPlaylistState(List<String> PL){
    this.playlist = PL;
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Music Playlist'),
      ),
      body: _buildMusicList(this.playlist),
    );
  }

  Widget _buildMusicList(List<String> playlist) {
    return new ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if (i.isOdd) return new Divider();

          final index = i ~/ 2;

          return _buildMusicRow(playlist[index]);
        },
        itemCount: 2*playlist.length
    );
  }

  Widget _buildMusicRow(String music) {
    final alreadySaved = _saved.contains(music);
    return new ListTile(
      title: new Text(
        music,
        style: _biggerFont,
      ),
      trailing: new Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(
              () {
            if (alreadySaved) {
              _saved.remove(music);
            } else {
              _saved.add(music);
            }
          },
        );
      },
    );
  }
}
