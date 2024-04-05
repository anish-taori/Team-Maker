import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Team Maker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TeamMakerScreen(),
    );
  }
}


class TeamMakerScreen extends StatefulWidget {
  @override
  _TeamMakerScreenState createState() => _TeamMakerScreenState();
}


class _TeamMakerScreenState extends State<TeamMakerScreen> {
  final List<String> playerNames = ["Bhatia", "Rama", "Anish", "Chodu", "Atulya","Devchaddi","Adwait","Jitin","Smit","Kamat","Panday"];
  final List<int> playerRatings = [50, 50, 50, 50, 50,50,50,50,50,50,50];


  List<String> team1 = [];
  List<String> team2 = [];


  List<String> selectedPlayers = [];


  void makeTeams() {
    team1.clear();
    team2.clear();
    List<String> currentTeam1 = [];
    //List<String> currentTeam2 = [];
    int mindiff=1000;
    int diff=0;
    int totalr=0;
    int extraPlayerAdv=-20;
    if(selectedPlayers.length%2==0){
      extraPlayerAdv=0;
    }
    for(int i=0;i<selectedPlayers.length;i++) {
      totalr+=getPlayerRating(selectedPlayers[i]);
    }
       print("totalr is "+totalr.toString());


    if(selectedPlayers.length <=4 && selectedPlayers.length >= 3) {
      for(int i=0;i<selectedPlayers.length;i++) {
        for(int j=i+1;j<selectedPlayers.length;j++) {
          currentTeam1.clear();
          currentTeam1.add(selectedPlayers[i]);
          currentTeam1.add(selectedPlayers[j]);
          diff=totalr+extraPlayerAdv-2*(getPlayerRating(selectedPlayers[i])+getPlayerRating(selectedPlayers[j]));
         if(diff<0) diff*=-1;
          if(diff<mindiff){
            print("diff is "+diff.toString());
            mindiff=diff;
            team1.clear();
            team1 = List.from(currentTeam1);
            team2.clear();
            for(int k=0;k<selectedPlayers.length;k++) {
              if(k!=i && k!=j) {
                team2.add(selectedPlayers[k]);
              }
            }
          }
        }
      }
    }


    if(selectedPlayers.length <=6 && selectedPlayers.length >= 5) {
      for(int i=0;i<selectedPlayers.length;i++) {
        for(int j=i+1;j<selectedPlayers.length;j++) {
          for(int k=j+1;k<selectedPlayers.length;k++){
          currentTeam1.clear();
          currentTeam1.add(selectedPlayers[i]);
          currentTeam1.add(selectedPlayers[j]);
          currentTeam1.add(selectedPlayers[k]);
          diff=totalr+extraPlayerAdv-2*(getPlayerRating(selectedPlayers[i])+getPlayerRating(selectedPlayers[j])+getPlayerRating(selectedPlayers[k]));
                   if(diff<0) diff*=-1;
          if(diff<mindiff){
            mindiff=diff;
            team1.clear();
            team1 = List.from(currentTeam1);
            team2.clear();
            for(int p=0;p<selectedPlayers.length;p++) {
              if(p!=i && p!=j && p!=k) {
                team2.add(selectedPlayers[p]);
              }
            }
          }
        }
        }
      }
    }


    if(selectedPlayers.length <=8 && selectedPlayers.length >= 7) {
      for(int i=0;i<selectedPlayers.length;i++) {
        for(int j=i+1;j<selectedPlayers.length;j++) {
          for(int k=j+1;k<selectedPlayers.length;k++){
             for(int l=k+1;l<selectedPlayers.length;l++){
          currentTeam1.clear();
          currentTeam1.add(selectedPlayers[i]);
          currentTeam1.add(selectedPlayers[j]);
          currentTeam1.add(selectedPlayers[k]);
          currentTeam1.add(selectedPlayers[l]);
          diff=totalr+extraPlayerAdv-2*(getPlayerRating(selectedPlayers[l])+getPlayerRating(selectedPlayers[i])+getPlayerRating(selectedPlayers[j])+getPlayerRating(selectedPlayers[k]));
                   if(diff<0) diff*=-1;
          if(diff<mindiff){
            mindiff=diff;
            team1.clear();
            team1 = List.from(currentTeam1);
            team2.clear();
            for(int p=0;p<selectedPlayers.length;p++) {
              if(p!=i && p!=j && p!=k && p!=l) {
                team2.add(selectedPlayers[p]);
              }
            }
          }
        }
        }
      }
    }
  }
  else{
      for(int i=0;i<selectedPlayers.length;i++) {
        for(int j=i+1;j<selectedPlayers.length;j++) {
          for(int k=j+1;k<selectedPlayers.length;k++){
             for(int l=k+1;l<selectedPlayers.length;l++){
              for(int m=l+1;m<selectedPlayers.length;m++){
          currentTeam1.clear();
          currentTeam1.add(selectedPlayers[i]);
          currentTeam1.add(selectedPlayers[j]);
          currentTeam1.add(selectedPlayers[k]);
          currentTeam1.add(selectedPlayers[l]);
          currentTeam1.add(selectedPlayers[m]);
          diff=totalr+extraPlayerAdv-2*( getPlayerRating(selectedPlayers[m])+getPlayerRating(selectedPlayers[l])+getPlayerRating(selectedPlayers[i])+getPlayerRating(selectedPlayers[j])+getPlayerRating(selectedPlayers[k]));
                   if(diff<0) diff*=-1;
          if(diff<mindiff){
            mindiff=diff;
            team1.clear();
            team1 = List.from(currentTeam1);
            team2.clear();
            for(int p=0;p<selectedPlayers.length;p++) {
              if(p!=i && p!=j && p!=k && p!=l && p!=m) {
                team2.add(selectedPlayers[p]);
              }
            }
          }
        }
          }
        }
      }
    }
  }
    setState(() {});
  }


  void _findTeams(int index, List<String> currentTeam1, List<String> currentTeam2) {
    if (index == selectedPlayers.length) {
      if (team1.isEmpty || team2.isEmpty || _getDifference(currentTeam1, currentTeam2) < _getDifference(team1, team2)) {
        team1 = List.from(currentTeam1);
        team2 = List.from(currentTeam2);
      }
      return;
    }


    // Try adding current player to team 1
    if (currentTeam1.length < (selectedPlayers.length + 1) ~/ 2) {
      currentTeam1.add(selectedPlayers[index]);
      _findTeams(index + 1, currentTeam1, currentTeam2);
      currentTeam1.removeLast();
    }


    // Try adding current player to team 2
    if (currentTeam2.length < selectedPlayers.length ~/ 2) {
      currentTeam2.add(selectedPlayers[index]);
      _findTeams(index + 1, currentTeam1, currentTeam2);
      currentTeam2.removeLast();
    }
  }


  int _getDifference(List<String> team1, List<String> team2) {
    double sum1 = 0;
    team1.forEach((playerName) {
      sum1 += getPlayerRating(playerName);
    });
    double sum2 = 0;
    team2.forEach((playerName) {
      sum2 += getPlayerRating(playerName);
    });
    return (sum1 - sum2).abs().toInt();
  }


  int getPlayerRating(String name) {
    final index = playerNames.indexOf(name);
    if (index != -1) {
      return playerRatings[index];
    }
    return 0;
  }


  void _increaseRating(String playerName) {
    final index = playerNames.indexOf(playerName);
    if (index != -1) {
      setState(() {
        playerRatings[index] += 1;
      });
    }
  }


  void _decreaseRating(String playerName) {
    final index = playerNames.indexOf(playerName);
    if (index != -1) {
      setState(() {
        playerRatings[index] -= 1;
      });
    }
  }


  void _navigateToSelectPlayersScreen() async {
    final List<String> result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SelectPlayersScreen(playerNames)),
    );
    if (result != null) {
      selectedPlayers = result;
      makeTeams(); // Make teams after players are selected
      _navigateToTeamsScreen(); // Navigate to display teams screen
    }
  }


  void _navigateToRatingsScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PlayerRatingsScreen(playerNames, playerRatings, _increaseRating, _decreaseRating)),
    );
  }


  void _navigateToTeamsScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TeamsScreen(team1, team2)),
    );
  }

   @override
    void initState() {
      super.initState();
      for (int i = 0; i < playerNames.length; i++) {
        SharedPreferences.getInstance().then((prefs) {
          final rating = prefs.getInt(playerNames[i]);
          if (rating != null) {
            setState(() {
              playerRatings[i] = rating;
            });
          }
        });
      }
    }

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: AppBar(
        title: Text('Team Maker'),
         
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _navigateToSelectPlayersScreen, // Navigate to select players screen
              child: Text('Select Players'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
            onPressed: _navigateToRatingsScreen,
            child: Text('Ratings'),
          ),
          ],
        ),
      ),
    );
  }
}


class PlayerRatingsScreen extends StatefulWidget {
  final List<String> playerNames;
  final List<int> playerRatings;
  final Function(String) increaseRating;
  final Function(String) decreaseRating;


  PlayerRatingsScreen(this.playerNames, this.playerRatings, this.increaseRating, this.decreaseRating);


  @override
  _PlayerRatingsScreenState createState() => _PlayerRatingsScreenState();
}


class _PlayerRatingsScreenState extends State<PlayerRatingsScreen> {
  var nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Player Ratings'),
      ),
      body: ListView.builder(
        itemCount: widget.playerNames.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(widget.playerNames[index]),
            subtitle: Text(widget.playerRatings[index].toString()),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () async{
                    setState(() {
                      widget.increaseRating(widget.playerNames[index]);
                    });
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    String name = widget.playerNames[index];
                    prefs.setInt(name, widget.playerRatings[index]);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    setState(() {
                      widget.decreaseRating(widget.playerNames[index]);
                    });
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}


class SelectPlayersScreen extends StatefulWidget {
  final List<String> playerNames;


  SelectPlayersScreen(this.playerNames);


  @override
  _SelectPlayersScreenState createState() => _SelectPlayersScreenState();
}


class _SelectPlayersScreenState extends State<SelectPlayersScreen> {
  List<String> selectedPlayers = [];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Players'),
      ),
      body: ListView.builder(
        itemCount: widget.playerNames.length,
        itemBuilder: (BuildContext context, int index) {
          final playerName = widget.playerNames[index];
          return CheckboxListTile(
            title: Text(playerName),
            value: selectedPlayers.contains(playerName),
            onChanged: (value) {
              setState(() {
                if (value==true) {
                  selectedPlayers.add(playerName);
                } else {
                  selectedPlayers.remove(playerName);
                }
              });
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context, selectedPlayers);
        },
        child: Icon(Icons.check),
      ),
    );
  }
}


class TeamsScreen extends StatelessWidget {
  final List<String> team1;
  final List<String> team2;


  TeamsScreen(this.team1, this.team2);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Teams'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Team 1:'),
            Text(team1.join(", ")),
            SizedBox(height: 20),
            Text('Team 2:'),
            Text(team2.join(", ")),
          ],
        ),
      ),
    );
  }
}



