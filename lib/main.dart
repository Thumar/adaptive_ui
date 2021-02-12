import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Adaptive',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Animal List'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 600) {
              return WideLayout();
            } else {
              return NarrowLayout();
            }
          },
        ));
  }
}

class NarrowLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimalListWidget(onTapCallback: (animal) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Scaffold(
              appBar: AppBar(title: Text(animal)),
              body: DetailPage(
                title: animal,
              ))));
    });
  }
}

class AnimalListWidget extends StatelessWidget {

  final void Function(String) onTapCallback;

  AnimalListWidget({Key key, this.onTapCallback}) : super(key: key);

  List<String> animals = <String>[
    'Tiger',
    'Lion',
    'Leopard',
    'Jaguar',
    'Wolf',
    'Elephant',
    'Deer'
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
              title: Text(animals[index]),
              onTap: () => onTapCallback(animals[index]));
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemCount: animals.length);
  }
}

class WideLayout extends StatefulWidget {
  @override
  _WideLayoutState createState() => _WideLayoutState();
}

class _WideLayoutState extends State<WideLayout> {
  String _animal = 'Lion';

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: AnimalListWidget(
              onTapCallback: (animal) => setState(() => _animal = animal)),
          flex: 2,
        ),
        Expanded(
          child: _animal == null ? Placeholder() : DetailPage(title: _animal),
          flex: 3,
        )
      ],
    );
  }
}

class DetailPage extends StatelessWidget {
  final String title;
  var animalList = {
    'Tiger': 'assets/images/Tiger.jpeg',
    'Deer': 'assets/images/Deer.jpeg',
    'Elephant': 'assets/images/Elephant.jpeg',
    'Lion': 'assets/images/Lion.jpeg',
    'Jaguar': 'assets/images/Jaguar.jpeg',
    'Wolf': 'assets/images/Wolf.jpeg',
    'Leopard': 'assets/images/Leopard.jpeg',
  };

  DetailPage({Key key, @required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(animalList[title]),
    );
  }
}
