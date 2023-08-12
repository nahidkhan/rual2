import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController textController = TextEditingController();
  late SharedPreferences _prefs;

  String _name = 'rual upgraded';

  loadData() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _name = _prefs.getString("NAME") ?? "rual";
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("This is $_name"),
            TextField(
              controller: textController,
              onSubmitted: (value) {
                getField(value);
              },
            ),
            TextButton.icon(
                onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();
                  prefs.remove("NAME");

                  setState(() {
                    _name = "nahiiiid";
                  });
                },
                icon: const Icon(Icons.remove_done),
                label: const Text("Remove data"))
          ],
        ),
      ),
      floatingActionButton: const FloatingActionButton(
        onPressed: null,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

getField(String value) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString("NAME", value);

  setState(() {
    _name = textController.value.text;
  });
}
