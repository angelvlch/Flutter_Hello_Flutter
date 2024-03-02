import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> _toDo = [];
  int _selected_index = -1;
  String _userToDO = '';

  @override
  void initState() {
    super.initState();

  }

  Widget _createTask(BuildContext context, int index) {
    return Dismissible(
      key: Key(_toDo[index]),
      onDismissed: (direction) {
        setState(() {
          _toDo.removeAt(index);
        });
      },
      background: Container(
        color: Colors.red,
      ),
      child: ListTile(
        title: Text(
          _toDo[index],
          style: TextStyle(
            fontFamily: 'Lost',
            fontSize: 30,
          ),
        ),

        onTap: () {
          setState(() {
            _selected_index = index;
          });
        },
        selected: index == _selected_index,
        selectedColor: Colors.blueGrey,

        trailing: IconButton(
          onPressed: () {
            setState(() {
              _toDo.removeAt(index);
            });
          },
          icon: Icon(Icons.delete_rounded),
        ),
        onLongPress: () {
          setState(() {
            _selected_index = -1;
          });
        },
        //tileColor: Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.purple.shade100,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade50,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
           // Padding(padding: EdgeInsets.only(left:20)),
            Text('To do list',
                style: TextStyle(
                  fontSize: 25,
                  fontFamily: 'Lost',
                )),
            Text(
                '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
                style: TextStyle(
                  fontSize: 25,
                )),
          ],
        ),
        centerTitle: true,
      ),
      body: Column(
        textDirection: TextDirection.ltr,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(padding: EdgeInsets.only(top: 10)),
          Text(
            _selected_index == -1
                ? 'Nothing selected'
                : 'Selected: ${_toDo[_selected_index]}',
            style: TextStyle(
              fontSize: 30,
              fontFamily: 'Lost',
              color:
                  _selected_index == -1 ? Colors.black54 : Colors.teal.shade900,
            ),
          ),
          Expanded(
            child: ListView.separated(
              separatorBuilder: (BuildContext context, int index) {
                return Divider(
                  height: 2,
                );
              },
              itemCount: _toDo.length,
              itemBuilder: _createTask,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                  title: Text("Add new task:",
                      style: TextStyle(fontFamily: 'Lost')),
                  content: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)),
                      //icon: Icon(Icons.chevron_right),
                    ),
                    onChanged: (text) {
                      _userToDO = text;
                    },
                  ),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _toDo.add(_userToDO);
                        });
                        print(_toDo);
                        Navigator.of(context).pop();
                      },
                      child: Container(
                          alignment: Alignment.center,
                          child: Text('add',
                              style: TextStyle(
                                fontFamily: 'Lost',
                                fontSize: 20,
                                color: Colors.black,
                              ))),
                    ),
                  ]);
            },
          );
        },
        child: Icon(
          Icons.add,
          size: 45,
        ),
        backgroundColor: Colors.grey.shade50,
        tooltip: 'Добавить задачу',
      ),
    );
  }
}
