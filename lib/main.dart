// // ignore_for_file: prefer_typing_uninitialized_variables, unused_local_variable

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:hive_flutter/hive_flutter.dart';

// void main() async {
//   //init hive
//   await Hive.initFlutter();
//   var box = await Hive.openBox('myBox');
//   runApp(const MyApp());
// }

// class MyApp extends StatefulWidget {
//   const MyApp({super.key});
//   static const color = Color.fromARGB(255, 252, 251, 247);
//   final tudoocolor = Colors.black;

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   final _myBox = Hive.box('myBox');
//   TudooDB db = TudooDB();

//   @override
//   void initState() {
//     //first time opening the data
//     if (_myBox.get("TudooListKey") == null) {
//       db.createInitData();
//     } else {
//       //already have some data
//       db.loadData();
//     }
//     super.initState();
//   }

//   final vartudoolist = TudooDB.tudoolist;
//   final _tudoocontroller = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setSystemUIOverlayStyle(
//         const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         backgroundColor: MyApp.color,
//         appBar: _appBar(),
//         body: Stack(
//           children: [
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 15),
//               child: Column(
//                 children: [
//                   const SizedBox(
//                     height: 18,
//                   ),
//                   // searchBar(),
//                   Expanded(
//                     child: ListView(
//                       children: [
//                         Container(
//                           margin: const EdgeInsets.only(top: 20),
//                           child: const Text(
//                             ' Your Tudoos',
//                             style: TextStyle(
//                               fontSize: 20,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 30,
//                         ),
//                         for (Tudoo tudoofor in vartudoolist)
//                           TudooList(
//                             tudoovar: tudoofor,
//                             onTudooChanged: tudooFunction,
//                             onDeleteItem: onDelete,
//                           ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Align(
//               alignment: Alignment.bottomCenter,
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 15,
//                         vertical: 1,
//                       ),
//                       margin: const EdgeInsets.only(
//                         bottom: 20,
//                         right: 20,
//                         left: 20,
//                       ),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         boxShadow: const [
//                           BoxShadow(
//                             offset: Offset.zero,
//                             blurRadius: 11.0,
//                             spreadRadius: 0.0,
//                             color: Color.fromARGB(255, 244, 236, 236),
//                           ),
//                         ], //because applying to a list
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: TextField(
//                         controller: _tudoocontroller,
//                         decoration: const InputDecoration(
//                           hintText: 'Hey! Add a new Tudoo...',
//                           border: InputBorder.none,
//                         ),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(
//                       top: 5.0,
//                       bottom: 25.0,
//                       right: 15.0,
//                     ),
//                     child: Container(
//                       height: 45.0,
//                       width: 45,
//                       decoration: const BoxDecoration(
//                         color: Color.fromARGB(255, 254, 253, 250),
//                       ),
//                       child: IconButton(
//                         onPressed: () {
//                           addTudoo(_tudoocontroller.text);
//                         },
//                         icon: const Icon(Icons.add_box,
//                             color: Color.fromARGB(255, 144, 0, 255), size: 30),
//                         iconSize: 30.0,
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void tudooFunction(Tudoo tudoo) {
//     setState(() {
//       tudoo.isDone = !tudoo.isDone;
//     });
//     //hive
//     db.updateData();
//     //it will make it opposite
//   }

//   void onDelete(String id) {
//     setState(() {
//       vartudoolist.removeWhere((tudoo) => tudoo.id == id);
//     });
//     db.updateData();
//   }

//   void addTudoo(String tudoo) {
//     setState(() {
//       if (tudoo.isEmpty) {
//         return;
//       }
//       vartudoolist.add(Tudoo(
//         tudoText: tudoo,
//         id: DateTime.now().millisecondsSinceEpoch.toString(),
//       ));
//     });
//     _tudoocontroller.clear();
//     db.updateData();
//   }

//   AppBar _appBar() {
//     var tudoocolor = Colors.black;
//     return AppBar(
//       backgroundColor: MyApp.color,
//       shadowColor: const Color.fromARGB(62, 230, 228, 221),
//       title: const Text(
//         'Tudoo',
//         style: TextStyle(
//           color: Colors.black,
//           fontSize: 25,
//         ),
//       ),
//       leading: Builder(
//         builder: (BuildContext context) {
//           return IconButton(
//             padding: const EdgeInsets.only(left: 15),
//             onPressed: () {
//               debugPrint("Tudoo is pressed!");
//             },
//             icon: Icon(
//               Icons.task_alt,
//               color: tudoocolor,
//               size: 30,
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// class TudooList extends StatelessWidget {
//   final Tudoo tudoovar;
//   final onTudooChanged;
//   final onDeleteItem;

//   const TudooList({
//     super.key,
//     required this.tudoovar,
//     required this.onTudooChanged,
//     required this.onDeleteItem,
//   });
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 15),
//       child: ListTile(
//         onTap: () {
//           onTudooChanged(tudoovar);
//         },
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(20),
//         ),
//         tileColor: Colors.white,
//         leading: Icon(
//           tudoovar.isDone ? Icons.check_circle_rounded : Icons.circle_outlined,
//           color: tudoovar.isDone
//               ? const Color.fromARGB(255, 123, 100, 198)
//               : const Color.fromARGB(255, 123, 100, 198),
//         ),
//         title: Text(
//           tudoovar.tudoText!,
//           style: TextStyle(
//             fontSize: 17.0,
//             color: tudoovar.isDone
//                 ? Color.fromARGB(108, 123, 100, 198)
//                 : const Color.fromARGB(255, 81, 0, 221),
//             decoration: tudoovar.isDone ? TextDecoration.lineThrough : null,
//           ),
//         ),
//         trailing: GestureDetector(
//           onTap: () {
//             onDeleteItem(tudoovar.id);
//           },
//           child: const Icon(
//             Icons.delete_rounded,
//             color: Color.fromARGB(255, 221, 15, 0),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class Tudoo {
//   String? tudoText;
//   String? id;
//   bool isDone;

//   Tudoo({
//     required this.tudoText,
//     required this.id,
//     this.isDone = false,
//   });
//   // static List<Tudoo> tudoolist() {
//   //   return [
//   //     Tudoo(
//   //       id: '1',
//   //       tudoText: 'Add New Tudoos',
//   //     ),
//   //     Tudoo(
//   //       id: '2',
//   //       tudoText: 'Click me to chnage my status.',
//   //     ),
//   //     Tudoo(
//   //       id: '3',
//   //       tudoText: 'Click on delete icon to remove me.',
//   //     ),
//   //     Tudoo(
//   //       id: '4',
//   //       tudoText: 'Have a good time.',
//   //     ),
//   //   ];
//   // }
// }

// class TudooDB {
//   static List tudoolist = [];
//   final _myBox = Hive.box('myBox');

//   void createInitData() {
//     tudoolist = [
//       Tudoo(
//         id: '1',
//         tudoText: 'Add New Tudoos',
//       ),
//       Tudoo(
//         id: '2',
//         tudoText: 'Click me to chnage my status.',
//       ),
//       Tudoo(
//         id: '3',
//         tudoText: 'Click on delete icon to remove me.',
//       ),
//       Tudoo(
//         id: '4',
//         tudoText: 'Have a good time.',
//       ),
//     ];
//   }

//   void loadData() {
//     tudoolist = _myBox.get("TudooListKey");
//   }

//   void updateData() {
//     _myBox.put("TudooListKey", tudoolist);
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TudooAdapter());
  await Hive.openBox<Tudoo>('myBox');
  runApp(const TudooApp());
}

class TudooApp extends StatelessWidget {
  const TudooApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TudooScreen(),
    );
  }
}

class TudooScreen extends StatefulWidget {
  const TudooScreen({Key? key}) : super(key: key);

  @override
  _TudooScreenState createState() => _TudooScreenState();
}

class _TudooScreenState extends State<TudooScreen> {
  final TudooDB tudooDB = TudooDB();
  final TextEditingController _tudooController = TextEditingController();

  @override
  void initState() {
    super.initState();
    tudooDB.createInitData();
    tudooDB.loadData();
  }

  void addTudoo(String tudooText) {
    if (tudooText.isNotEmpty) {
      final Tudoo tudoo = Tudoo(
        tudooText: tudooText,
        id: DateTime.now().toString(),
      );
      setState(() {
        tudooDB.tudooList.add(tudoo);
        tudooDB.updateData();
        _tudooController.clear();
      });
    }
  }

  void toggleTudooStatus(Tudoo tudoo) {
    setState(() {
      tudoo.isDone = !tudoo.isDone;
      tudooDB.updateData();
    });
  }

  void deleteTudoo(String id) {
    setState(() {
      tudooDB.tudooList.removeWhere((tudoo) => tudoo.id == id);
      tudooDB.updateData();
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );
    return Scaffold(
      appBar: _appBar(),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                const SizedBox(height: 18),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: const Text(
                          'Your Tudoos',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      for (Tudoo tudoo in tudooDB.tudooList)
                        TudooList(
                          tudoo: tudoo,
                          onTudooChanged: toggleTudooStatus,
                          onDeleteItem: deleteTudoo,
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    color: Colors.grey.shade200,
                    child: TextFormField(
                      controller: _tudooController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Try Adding a new tudoo...',
                      ),
                      onFieldSubmitted: addTudoo,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => addTudoo(_tudooController.text),
                  child: Container(
                    color: Colors.grey.shade300,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: const Icon(
                      Icons.task_alt,
                      color: Colors.black,
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: const Text(
        'Tudoo App',
        style: TextStyle(
          color: Colors.black,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class TudooList extends StatelessWidget {
  final Tudoo tudoo;
  final Function(Tudoo) onTudooChanged;
  final Function(String) onDeleteItem;

  const TudooList({
    Key? key,
    required this.tudoo,
    required this.onTudooChanged,
    required this.onDeleteItem,
  }) : super(key: key);
//widget
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: ListTile(
        onTap: () {
          onTudooChanged(tudoo);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        tileColor: Colors.white,
        leading: Icon(
          tudoo.isDone ? Icons.check_circle_rounded : Icons.circle_outlined,
          color: const Color.fromARGB(255, 123, 100, 198),
        ),
        title: Text(
          tudoo.tudooText,
          style: TextStyle(
            fontSize: 17.0,
            color: tudoo.isDone
                ? const Color.fromARGB(108, 123, 100, 198)
                : const Color.fromARGB(255, 81, 0, 221),
            decoration: tudoo.isDone ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: GestureDetector(
          onTap: () {
            onDeleteItem(tudoo.id);
          },
          child: const Icon(
            Icons.delete_rounded,
            color: Color.fromARGB(255, 221, 15, 0),
          ),
        ),
      ),
    );
  }
}

class Tudoo {
  final String tudooText;
  final String id;
  bool isDone;

  Tudoo({
    required this.tudooText,
    required this.id,
    this.isDone = false,
  });
}

class TudooAdapter extends TypeAdapter<Tudoo> {
  @override
  final typeId = 0;

  @override
  Tudoo read(BinaryReader reader) {
    return Tudoo(
      tudooText: reader.read(),
      id: reader.read(),
      isDone: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, Tudoo obj) {
    writer.write(obj.tudooText);
    writer.write(obj.id);
    writer.write(obj.isDone);
  }
}

class TudooDB {
  List<Tudoo> tudooList = [];
  final Box<Tudoo> _myBox = Hive.box<Tudoo>('myBox');

  void createInitData() {
    if (_myBox.isEmpty) {
      final List<Tudoo> initData = [
        Tudoo(tudooText: 'Add a new Tudoo!', id: DateTime.now().toString()),
        Tudoo(
            tudooText: 'Click on me to change my state!',
            id: DateTime.now().toString()),
        Tudoo(
            tudooText: 'Click on delete icon to remove me!',
            id: DateTime.now().toString()),
      ];
      _myBox.addAll(initData);
    }
  }

  void loadData() {
    tudooList = _myBox.values.toList();
  }

  void updateData() {
    _myBox.clear();
    _myBox.addAll(tudooList);
  }
}
