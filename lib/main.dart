import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Minutes App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: InputScreen(),
    );
  }
}

class InputScreen extends StatefulWidget {
  @override
  _InputScreenState createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Input Minutes'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: _controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Enter Minutes',
                ),
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  int minutes = int.tryParse(_controller.text) ?? 0;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DisplayScreen(minutes: minutes),
                    ),
                  );
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DisplayScreen extends StatefulWidget {
  final int minutes;

  DisplayScreen({required this.minutes});

  @override
  _DisplayScreenState createState() => _DisplayScreenState();
}



class _DisplayScreenState extends State<DisplayScreen> {
  Color _screenColor = Colors.red;
  bool disposed = false;

  @override
  void initState() {
    super.initState();
    _changeScreenColor();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    disposed = true;
    _screenColor = Colors.yellow;
    super.dispose();
  }

  void _changeScreenColor() async {
    // Wait for the specified number of minutes
    await Future.delayed(Duration(minutes: widget.minutes));
    // Change the screen color to red after waiting
    if (!disposed) {
          setState(() {
      _screenColor = Colors.yellow;
    });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pop(context);
          },
          backgroundColor: _screenColor,
          child: Icon(Icons.arrow_back, color: Colors.white),
        ),
      body: Container(
        color: _screenColor,
        child: Center(
          child: Text(
            'You entered ${widget.minutes} minutes.',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}