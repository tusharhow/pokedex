import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:get/get.dart';
import 'package:pokedex/constants.dart';

import 'package:pokedex/controller/pokeController.dart';
import 'package:pokedex/model/poke_model.dart';

import 'components/backround_clipper.dart';
// import 'package:flutter_swiper/flutter_swiper.dart';

void main() {
  runApp(MyApp());
}

final pokeController = Get.put(PokeController());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: Colors.white,
          elevation: 0,
        ),
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _pokeDataModel;
  @override
  void initState() {
    super.initState();
    _pokeDataModel = PokeController().getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(children: [
          Text(
            'PokeDex',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 45,
                letterSpacing: 6),
          ),
          Text(
            'Poke Universe',
            style:
                TextStyle(color: Colors.black, fontSize: 18, letterSpacing: 8),
          ),
          SizedBox(
            height: 70,
          ),
          Expanded(
              child: FutureBuilder<PokeModel>(
                  future: _pokeDataModel,
                  builder: (context, snapshot) {
                    return Stack(children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: kDefaultPadding * 2),
                        child: ClipPath(
                          clipper: CardClipper(),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            height:
                                MediaQuery.of(context).size.width * 0.8 * 1.55,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.orange,
                                  Colors.deepOrangeAccent
                                ],
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                              ),
                            ),
                            child: Swiper(
                              outer: true,
                              containerHeight: 100,
                              autoplay: true,
                              itemCount: snapshot.data!.pokemon.length,
                              itemBuilder: (context, index) {
                                var pokeList = snapshot.data!.pokemon[index];
                                return Column(
                                  
                                  children: [
                                    SizedBox(
                                      height: 130,
                                    ),
                                    Image(
                                      image: NetworkImage(pokeList.img),
                                      height: 200,
                                    
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      pokeList.name,
                                      style: TextStyle(
                                        fontSize: 40,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          "Height: " '${pokeList.height}',
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.white),
                                        ),
                                        Text(
                                          "Weight: " '${pokeList.weight}',
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 50,),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ]);
                  }))
        ]));
  }
}
