import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resultados/supabase.dart';
//import 'package:supabase_flutter/supabase_flutter.dart';
import 'articulos.dart';
import 'gridprovider.dart';
import 'loterias.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  SupaBaseHandler client = SupaBaseHandler();
  List<Articulos> gridMap = [];
  List<Articulos> newArray1 = [];
  List<Articulos> newArray2 = [];
  List<Articulos> gridMapSearch = [];
  TextEditingController estado = TextEditingController();
  bool flag = true;
  int currentIndex = 0;
  bool seguir = true;
  int pageActual = 0;
  List<Widget> paginas = [
    const MyWidget(),
    const Loterias(),
//    const EndSession(),
  ];
  @override
  void initState() {
    //final prov = Provider.of<GridProvider>(context, listen: false);
    super.initState();
    String xfecha = DateTime.now().toString().substring(0, 10);
    leerGanadores(xfecha);
  }

  leerGanadores(xfecha) async {
    gridMap = await client.recibirDatos(xfecha);
    setState(() {
      gridMap = gridMap;
    });
    return gridMap;
  }

  void updateArrays() async {
    final prov = Provider.of<GridProvider>(context, listen: false);
    for (int i = 0; i < gridMapSearch.length; i + 24) {
      await Future.delayed(const Duration(seconds: 5));
      newArray1 = gridMapSearch.sublist(i, i + 12);
      if (gridMapSearch.length > 12) {
        newArray2 = gridMapSearch.sublist(i + 12, i + 24);
      }
      setState(() {
        prov.setArray01(newArray1);
        prov.setArray02(newArray2);
      });
      if (gridMapSearch.length > 12) {
        i = i + 24;
      }
      newArray1 = [];
      newArray2 = [];
      //  imprime = false;
    }
    seguir = true;
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<GridProvider>(context, listen: false);
//    final watch = Provider.of<GridProvider>(context,listen: false);
    if (gridMap.isNotEmpty && seguir) {
      gridMapSearch = gridMap;
      updateArrays();
      seguir = false;
    }
    return Scaffold(
      /*    appBar: AppBar(
          title: Container(
        height: 35,
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 117, 231, 251),
            borderRadius: BorderRadius.circular(20)),
        child: Center(child: Text("Agencia de Loterias ")),
      )),*/
      body: pageActual > 0
          ? paginas[pageActual]
          : Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Center(
                        child: Text(prov.newArray01[0].operador,
                            style: const TextStyle(fontSize: 25)),
                      ),
                      Expanded(
                        child: Container(
                          color: const Color.fromARGB(255, 242, 229, 234),
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              crossAxisSpacing: 4.0,
                              mainAxisSpacing: 4.0,
                              mainAxisExtent: 150,
                            ),
                            itemCount: prov.newArray01.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      16.0,
                                    ),
                                    color: Colors.amberAccent.shade100,
                                  ),
                                  child: Column(
                                    children: [
                                      //       'https://lotoven.com' + newArray1[index].urlimage,
                                      //                          'https://lotoven.com' +
                                      //                              prov.newArray01[index].urlimage
                                      //                        Image.network(
                                      //                          "https://qpewttmefqniyqflyjmu.supabase.co/storage/v1/object/public/media/imagenes/1687730617564000.png",
                                      Image.asset(
                                        prov.newArray01[index].nombre + '.png',
                                        height: 80,
                                        fit: BoxFit.cover,
                                      ),
                                      Text(prov.newArray01[index].nombre,
                                          style: const TextStyle(fontSize: 12)),
                                      Text(prov.newArray01[index].hora,
                                          style: const TextStyle(fontSize: 12)),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Center(
                        child: Text(prov.newArray02[0].operador,
                            style: const TextStyle(fontSize: 25)),
                      ),
                      Expanded(
                        child: Container(
                          color: const Color.fromARGB(255, 12, 243, 146),
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              crossAxisSpacing: 4.0,
                              mainAxisSpacing: 4.0,
                              mainAxisExtent: 150,
                            ),
                            itemCount: prov.newArray02.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  color:
                                      const Color.fromARGB(255, 242, 229, 234),
                                  child: Column(
                                    children: [
                                      //                        'https://lotoven.com' + newArray2[index].urlimage,
                                      //                          'https://lotoven.com' +
                                      //                              prov.newArray02[index].urlimage,
                                      Image.asset(
                                        prov.newArray02[index].nombre + '.png',
                                        //                   Image.network(
                                        //                    "https://qpewttmefqniyqflyjmu.supabase.co/storage/v1/object/public/media/imagenes/1687731106796000.jpg",
                                        height: 80,
                                        //                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                      Text(prov.newArray02[index].nombre,
                                          style: const TextStyle(fontSize: 12)),
                                      Text(prov.newArray02[index].hora,
                                          style: const TextStyle(fontSize: 12)),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
      bottomNavigationBar: BottomNavigationBar(
          iconSize: 24.0,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            if (mounted) {
              setState(() {
                pageActual = index;
              });
            }
          },
          currentIndex: pageActual,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Inicio"),
            BottomNavigationBarItem(icon: Icon(Icons.radio), label: "Operador"),
            // BottomNavigationBarItem(icon: Icon(Icons.library_music),label:"Musica"),
            // BottomNavigationBarItem(icon: Icon(Icons.rss_feed),label:"Noticias"),
            // BottomNavigationBarItem(icon: Icon(Icons.logout),label:"Salir"),
          ]),
    );
  }
}
