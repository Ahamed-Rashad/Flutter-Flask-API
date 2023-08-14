import 'dart:convert';
import 'package:app/function.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String url = '';
  String output = 'Initial Output';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Simple Flask App')),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                onChanged: (value) {
                  url = 'http://10.0.2.2:5000/api?query=' + value.toString();
                },
              ),
              TextButton(
                onPressed: () async {
                  try {
                    String fetchedData = await fetchdata(url); // Await the fetchdata future
                    var decoded = jsonDecode(fetchedData);
                    setState(() {
                      output = decoded['output'];
                    });
                  } catch (error) {
                    setState(() {
                      output = 'Error: $error';
                    });
                  }
                },
                child: Text('Fetch ASCII Value', style: TextStyle(fontSize: 20)),
              ),
              Text(output, style: TextStyle(fontSize: 40, color: Colors.green)),
            ],
          ),
        ),
      ),
    );
  }
}
