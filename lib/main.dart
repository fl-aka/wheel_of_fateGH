import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wheel_of_fate/rubik.dart';
import 'package:path_provider/path_provider.dart' as jalan;
import 'package:hive_flutter/hive_flutter.dart';
import 'savefile/reminder.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var jalandokumen = await jalan.getApplicationDocumentsDirectory();
  Hive.init(jalandokumen.path);
  await Hive.initFlutter();
  Hive.registerAdapter(PiecesAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Wheel Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _counter = 0, _angles = 0, _side = 0;
  bool _add = false, _minus = false;

  void _sideCheck() {
    if (_side == 8) _side = 0;
  }

  void _incrementCounter() {
    if (_angles == _counter) {
      _side++;
      _sideCheck();
      setState(() {
        _counter = _counter + pi / 4;
        _add = true;
        _minus = false;
      });
    }
  }

  void _lessCounter() {
    if (_angles == _counter) {
      _sideCheck();
      if (_side == 0) {
        _side = 7;
      } else {
        _side--;
      }

      setState(() {
        _counter = _counter - pi / 4;
        _add = false;
        _minus = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double lebar = 350, tinggi = 350;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            StreamBuilder(
                stream: Stream.periodic(const Duration(milliseconds: 50)),
                builder: (context, snapshot) {
                  if (_add) {
                    if (_angles < _counter) {
                      _angles += 0.09;
                    } else {
                      _angles = _counter;
                    }
                  }
                  if (_minus) {
                    if (_angles > _counter) {
                      _angles -= 0.09;
                    } else {
                      _angles = _counter;
                    }
                  }
                  if (_side == 0 && _angles == _counter) {
                    _angles = 0;
                    _counter = 0;
                  }
                  return Transform.rotate(
                    angle: _angles,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(250),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(250)),
                        height: tinggi,
                        width: lebar,
                        child: Column(children: [
                          Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onPanUpdate: (details) {
                                    if (_angles == _counter) {
                                      if (details.delta.dx < -2) {
                                        _lessCounter();
                                      }
                                      if (details.delta.dy > 2) {
                                        _lessCounter();
                                      }
                                      if (details.delta.dx > 2) {
                                        _incrementCounter();
                                      }
                                      setState(() {});
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Container(
                                      height: tinggi / 3.2,
                                      width: 35,
                                      color: Colors.amber,
                                      child: Stack(
                                        children: [
                                          Positioned(
                                              right: tinggi / 13,
                                              bottom: lebar / 13,
                                              child: Transform.rotate(
                                                angle: getAngle(),
                                                child: const Icon(
                                                  Icons.person,
                                                  size: 40,
                                                ),
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onPanUpdate: (details) {
                                    if (_angles == _counter) {
                                      if (details.delta.dx < -2) {
                                        _lessCounter();
                                      }
                                      if (details.delta.dx > 2) {
                                        _incrementCounter();
                                      }
                                      setState(() {});
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 3.0, right: 3.0, bottom: 3.0),
                                    child: Container(
                                      height: tinggi / 3.1,
                                      width: 35,
                                      color: Colors.red,
                                      child: Stack(children: [
                                        Positioned(
                                            left: lebar / 11,
                                            bottom: tinggi / 7,
                                            child: Transform.rotate(
                                              angle: getAngle(),
                                              child: const Icon(
                                                Icons.ac_unit,
                                                size: 45,
                                              ),
                                            ))
                                      ]),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onPanUpdate: (details) {
                                    if (_angles == _counter) {
                                      if (details.delta.dy < -2) {
                                        _lessCounter();
                                      }
                                      if (details.delta.dx < -2) {
                                        _lessCounter();
                                      }
                                      if (details.delta.dy > 2) {
                                        _incrementCounter();
                                      }
                                      setState(() {});
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Container(
                                      height: tinggi / 3.2,
                                      width: 35,
                                      color: Colors.orange,
                                      child: Stack(
                                        children: [
                                          Positioned(
                                              left: tinggi / 13,
                                              bottom: lebar / 13,
                                              child: Transform.rotate(
                                                angle: getAngle(),
                                                child: const Icon(
                                                  Icons.flag,
                                                  size: 40,
                                                ),
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onPanUpdate: (details) {
                                    if (_angles == _counter) {
                                      if (details.delta.dy < -2) {
                                        _incrementCounter();
                                      }
                                      if (details.delta.dy > 2) {
                                        _lessCounter();
                                      }
                                      setState(() {});
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        right: 3.0, top: 3, bottom: 3),
                                    child: Container(
                                      height: tinggi / 3.2,
                                      width: 35,
                                      color: Colors.indigo,
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            right: lebar / 7,
                                            bottom: tinggi / 11,
                                            child: Transform.rotate(
                                              angle: getAngle(),
                                              child: const Icon(
                                                Icons.fire_extinguisher,
                                                size: 45,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 3.0, right: 3, top: 4, bottom: 4.8),
                                  child: Container(
                                    height: tinggi / 3.2,
                                    width: 35,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(80),
                                      color: Colors.purple,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onPanUpdate: (details) {
                                    if (_angles == _counter) {
                                      if (details.delta.dy < -2) {
                                        _lessCounter();
                                      }
                                      if (details.delta.dy > 2) {
                                        _incrementCounter();
                                      }
                                      setState(() {});
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 3.0, top: 3, bottom: 3),
                                    child: Container(
                                      height: tinggi / 3.2,
                                      width: 35,
                                      color: Colors.green,
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            left: lebar / 7,
                                            bottom: tinggi / 11,
                                            child: Transform.rotate(
                                              angle: getAngle(),
                                              child: const Icon(
                                                Icons.home,
                                                size: 45,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onPanUpdate: (details) {
                                    if (_angles == _counter) {
                                      if (details.delta.dy < -2) {
                                        _incrementCounter();
                                      }
                                      if (details.delta.dy > 2) {
                                        _lessCounter();
                                      }
                                      if (details.delta.dx > 2) {
                                        _lessCounter();
                                      }
                                      setState(() {});
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Container(
                                      height: tinggi / 3.2,
                                      width: 35,
                                      color: Colors.deepOrangeAccent,
                                      child: Stack(
                                        children: [
                                          Positioned(
                                              right: tinggi / 13,
                                              top: lebar / 13,
                                              child: Transform.rotate(
                                                angle: getAngle(),
                                                child: const Icon(
                                                  Icons.snowmobile,
                                                  size: 40,
                                                ),
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onPanUpdate: (details) {
                                    if (_angles == _counter) {
                                      if (details.delta.dx < -2) {
                                        _incrementCounter();
                                      }
                                      if (details.delta.dx > 2) {
                                        _lessCounter();
                                      }
                                      setState(() {});
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 3.0, left: 3, right: 3),
                                    child: Container(
                                      height: tinggi / 3.1,
                                      width: 35,
                                      color: Colors.redAccent,
                                      child: Stack(children: [
                                        Positioned(
                                            left: lebar / 11,
                                            top: tinggi / 7,
                                            child: Transform.rotate(
                                              angle: getAngle(),
                                              child: const Icon(
                                                Icons.baby_changing_station,
                                                size: 45,
                                              ),
                                            ))
                                      ]),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onPanUpdate: (details) {
                                    if (_angles == _counter) {
                                      if (details.delta.dy < -2) {
                                        _lessCounter();
                                      }
                                      if (details.delta.dy > 2) {
                                        _incrementCounter();
                                      }
                                      if (details.delta.dx < -2) {
                                        _incrementCounter();
                                      }
                                      setState(() {});
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Container(
                                      height: tinggi / 3.2,
                                      width: 35,
                                      color: Colors.cyan,
                                      child: Stack(children: [
                                        Positioned(
                                            left: tinggi / 13,
                                            top: lebar / 13,
                                            child: Transform.rotate(
                                              angle: getAngle(),
                                              child: const Icon(
                                                Icons.message,
                                                size: 40,
                                              ),
                                            ))
                                      ]),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                        ]),
                      ),
                    ),
                  );
                }),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              '$_side',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return const RubicExe();
          }));
        },
        tooltip: 'Go To Rubic Page',
        child: const Icon(Icons.square),
      ),
    );
  }

  double getAngle() {
    return (_side == 1 || _side == 5)
        ? _angles - pi / 2
        : (_side == 2 || _side == 6)
            ? _angles - pi
            : (_side == 3 || _side == 7)
                ? _angles + pi / 2
                : (_side == 4)
                    ? pi
                    : 0;
  }
}
