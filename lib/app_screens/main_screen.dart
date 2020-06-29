import 'dart:collection';

import 'package:clevertap_plugin/clevertap_plugin.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MainScreenState();
  }
}

class _MainScreenState extends State<MainScreen> {
  TextEditingController eventNameController = TextEditingController();
  TextEditingController eventPropertyNameController = TextEditingController();
  TextEditingController eventPropertyValueController = TextEditingController();
  Map<String, dynamic> properties = HashMap();

  CleverTapPlugin ctPlugin;

  @override
  void initState() {
    ctPlugin = new CleverTapPlugin();

    ctPlugin.setCleverTapDisplayUnitsLoadedHandler(handler);

    super.initState();
  }

  void handler(List<dynamic> displayUnitList) {
    this.setState(() async {
      List displayUnits = await CleverTapPlugin.getAllDisplayUnits();
      print("Display Units = " + displayUnits.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.subtitle;

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Raise an Event'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: <Widget>[
          TextField(
            obscureText: false,
            controller: eventNameController,
            decoration: InputDecoration(
              labelText: 'Event Name',
              labelStyle: textStyle,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0.5),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                  width: 110,
                  child: TextField(
                    obscureText: false,
                    controller: eventPropertyNameController,
                    decoration: InputDecoration(
                      labelText: 'Property',
                      labelStyle: textStyle,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0.5),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                SizedBox(
                  width: 120,
                  child: TextField(
                    obscureText: false,
                    controller: eventPropertyValueController,
                    decoration: InputDecoration(
                      labelText: 'Value',
                      labelStyle: textStyle,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0.5),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                SizedBox(
                  width: 60,
                  child: RaisedButton(
                    onPressed: () {
                      setState(() {
                        properties[eventPropertyNameController.text] =
                            eventPropertyValueController.text;
                        reset();
                      });
                    },
                    elevation: 6.0,
                    color: Colors.blueAccent[400],
                    child: Container(
                      child: const Text(
                        'Add',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: 500,
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: properties.length,
              itemBuilder: (BuildContext context, int index) {
                String key = properties.keys.elementAt(index);
                return Container(
                  padding: const EdgeInsets.all(5.0),
                  width: 500,
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: 130,
                            child: Text("$key"),
                          ),
                          const SizedBox(width: 16),
                          SizedBox(
                            width: 130,
                            child: Text("${properties[key]}"),
                          ),
                        ],
                      ),
                      Divider(),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          RaisedButton(
            onPressed: () {
              setState(
                () {
                  CleverTapPlugin.recordEvent(
                      eventNameController.text, properties);
                  resetAll();
                },
              );
            },
            elevation: 6.0,
            color: Colors.blueAccent[400],
            child: Container(
              padding: const EdgeInsets.all(10.0),
              child: const Text(
                'Push event',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void reset() {
    eventPropertyValueController.text = '';
    eventPropertyNameController.text = '';
  }

  void resetAll() {
    reset();
    properties.clear();
    eventNameController.text = '';
  }
}
