// Creado por Crystian Enrique Suarez Cuevas <200527>
// 18-10-2023
// Asignatura: Desarrollo Movil Integral
// Grado: 10° Grupo: A
// Profesor MTI. Marco Antorio Ramirez Hernandez
import 'package:dmi_moviedb_practica12_200527_flutter/model/Media.dart';
import 'package:flutter/material.dart';
import 'package:dmi_moviedb_practica12_200527_flutter/media_list.dart';
import 'package:dmi_moviedb_practica12_200527_flutter/common/MediaProvider.dart';

class Home extends StatefulWidget {
  const Home(
      {super.key}); // Constructor de Home con un parámetro opcional llamado key.
  @override
  State<Home> createState() =>
      _HomeState(); // Define una clase que extiende StatefulWidget y proporciona un método para crear su estado interno.
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    _pageController = new PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController?.dispose();
    super.dispose();
  }

  final MediaProvider movieProvider = new MediaPrvider();
  final MediaProvider showProvider = new ShowProvider();
  PageController? _pageController;
  int _page = 0;
  MediaType mediaType = MediaType.movie;
  // Define una clase que extiende State y representa el estado interno de Home.

  @override
  Widget build(BuildContext context) {
    // Crear una página Scaffold que contiene la estructura principal de la aplicación
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        // Barra de navegación superior (AppBar) con un título y un botón de búsqueda
        title: Text(
          '200527 - Peliquiando',
          style: TextStyle(fontFamily: 'Bebas', fontSize: 24),
          selectionColor: Colors.white,
        ), // Título de la aplicación
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {
              // Acción a ejecutar cuando se presiona el botón de búsqueda
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.black,
          child: ListView(
            children: [
              DrawerHeader(
                  child: Center(
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage('asset/icon/Logo.png'))),
                ),
              )),
              ListTile(
                leading: Icon(Icons.local_movies),
                title: Text('Peliculas',
                    style: TextStyle(fontFamily: 'Bebas', fontSize: 24)),
                //selected: mediaType == MediaType.movie,
                onTap: () {
                  _changeMediaType(MediaType.movie);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.live_tv),
                title: Text('Television',
                    style: TextStyle(fontFamily: 'Bebas', fontSize: 24)),
                //selected: mediaType == MediaType.movie,
                onTap: () {
                  _changeMediaType(MediaType.show);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.close),
                title: Text('Cerrar',
                    style: TextStyle(fontFamily: 'Bebas', fontSize: 24)),
                onTap: () => Navigator.of(context).pop(),
              )
            ],
          ),
        ),
      ),
      body: PageView(
        children: _getMediaList(),
        controller: _pageController,
        onPageChanged: (int index) {
          setState(() {
            _page = index;
          });
        },
      ),
      bottomNavigationBar: new BottomNavigationBar(
        // Barra de navegación inferior (BottomNavigationBar) con iconos y etiquetas
        items: _obtenerIconos(),
        onTap: _navigationTapped,
        currentIndex: _page,
      ),
    );
  }

  // Método para obtener los elementos de la barra de navegación inferior
  List<BottomNavigationBarItem> _obtenerIconos() {
    return mediaType == MediaType.movie
        ? [
            new BottomNavigationBarItem(
              icon: new Icon(Icons.thumb_up), // Icono de pulgar hacia arriba
              label: ("populares"), // Etiqueta para la opción "populares"
            ),
            new BottomNavigationBarItem(
              icon: new Icon(Icons.update), // Icono de actualización
              label: ("Proximamente"), // Etiqueta para la opción "Proximamente"
            ),
            new BottomNavigationBarItem(
              icon: new Icon(Icons.star), // Icono de estrella
              label:
                  ("Mejor valorados"), // Etiqueta para la opción "Mejor valorados"
            ),
          ]
        : [
            new BottomNavigationBarItem(
              icon: new Icon(Icons.thumb_up), // Icono de pulgar hacia arriba
              label: ("populares"), // Etiqueta para la opción "populares"
            ),
            new BottomNavigationBarItem(
              icon: new Icon(Icons.update), // Icono de actualización
              label: ("Proximamente"), // Etiqueta para la opción "Proximamente"
            ),
            new BottomNavigationBarItem(
              icon: new Icon(Icons.star), // Icono de estrella
              label:
                  ("Mejor valorados"), // Etiqueta para la opción "Mejor valorados"
            ),
          ];
  }
  // Método para obtener los elementos de la barra de navegación inferior

  void _changeMediaType(MediaType type) {
    if (mediaType != type) {
      setState(() {
        mediaType = type;
      });
    }
  }

  List<Widget> _getMediaList() {
    return (mediaType == MediaType.movie)
        ? <Widget>[
            MediaList(movieProvider, "popular"),
            MediaList(movieProvider, "upcoming"),
            MediaList(movieProvider, "top_rated")
          ]
        : <Widget>[
            MediaList(showProvider, "popular"),
            MediaList(showProvider, "on_the_air"),
            MediaList(showProvider, "top_rated")
          ];
  }

  void _navigationTapped(int page) {
    _pageController?.animateToPage(page,
        duration: const Duration(milliseconds: 2), curve: Curves.ease);
  }
}
