import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Plant & Pet App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  List<String> _favoritePlants = [];

  static List<String> plants = [
    'Plant 1',
    'Plant 2',
    'Plant 3',
    'Plant 4',
    'Plant 5',
    'Plant 6',
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _pages = <Widget>[
      PlantList(
        plants: plants,
        favoritePlants: _favoritePlants,
        onFavoriteChanged: (plant, isFavorite) {
          setState(() {
            if (isFavorite) {
              _favoritePlants.add(plant);
            } else {
              _favoritePlants.remove(plant);
            }
          });
        },
      ),
      FavoriteList(favoritePlants: _favoritePlants),
      Center(child: Text('Settings')),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Plantas'),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class PlantList extends StatelessWidget {
  final List<String> plants;
  final List<String> favoritePlants;
  final Function(String, bool) onFavoriteChanged;

  PlantList({
    required this.plants,
    required this.favoritePlants,
    required this.onFavoriteChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: plants.length,
      itemBuilder: (context, index) {
        final plant = plants[index];
        final isFavorite = favoritePlants.contains(plant);
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS8x_YGTU5CUvrc2tim6MUhy5lgO2Pg7ABw5XlBqq74pB8I5-86eVlm67K4ytp_Ye10kbYUORXpLTCtOXi9-c64Ow'),
            radius: 20,
          ),
          title: Text(plant),
          trailing: FavoriteButton(
            isFavorite: isFavorite,
            onFavoriteChanged: (isFavorite) {
              onFavoriteChanged(plant, isFavorite);
            },
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PlantDetailScreen(plantName: plant),
              ),
            );
          },
        );
      },
    );
  }
}

class FavoriteButton extends StatelessWidget {
  final bool isFavorite;
  final Function(bool) onFavoriteChanged;

  FavoriteButton({
    required this.isFavorite,
    required this.onFavoriteChanged,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: isFavorite ? Colors.red : null,
      ),
      onPressed: () {
        onFavoriteChanged(!isFavorite);
      },
    );
  }
}

class FavoriteList extends StatelessWidget {
  final List<String> favoritePlants;

  FavoriteList({required this.favoritePlants});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: favoritePlants.length,
      itemBuilder: (context, index) {
        final plant = favoritePlants[index];
        return ListTile(
          title: Text(plant),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PlantDetailScreen(plantName: plant),
              ),
            );
          },
        );
      },
    );
  }
}

class PlantDetailScreen extends StatelessWidget {
  final String plantName;

  PlantDetailScreen({required this.plantName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(plantName),
      ),
      body: Center(
        child: Text('Información sobre $plantName'),
      ),
    );
  }
}
