import 'package:flutter/material.dart';
import 'package:magdsoft_flutter_structure/data/data_providers/remote/http_helper.dart';
import 'package:magdsoft_flutter_structure/data/network/responses/help_response.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  _HelpScreenState createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  List<bool> isOpen = [false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset("assets/images/overlay.png"),
          Column(
            children: [
              SafeArea(
                child: SizedBox(
                    height: 100,
                    child: Center(
                      child: Text(
                        "Help",
                        style: Theme.of(context)
                            .textTheme
                            .headline4
                            ?.copyWith(color: Colors.white),
                      ),
                    )),
              ),
              Expanded(
                child: FutureBuilder<HelpResponse>(
                  future: HttpHelper.getHelp(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data!.help!.length,
                        // snapshot.data == null ? 0 : snapshot.data!.help!.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              SizedBox(
                                child: Container(
                                  child: _buildPanel(
                                      snapshot.data!.help!,
                                      snapshot.data!.help![index].question!,
                                      snapshot.data!.help![index].answer!),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }

                    // By default, show a loading spinner.
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildPanel(List list, String header, String body) {
    return ExpansionPanelList(
        expansionCallback: (int index, bool isExpanded) {
          setState(() {
            isOpen[index] = !isOpen[index];
          });
        },
        children: [
          ExpansionPanel(
              headerBuilder: (BuildContext context, bool isExpanded) {
                return ListTile(
                  title: Text(header),
                );
              },
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(body),
              ),
              isExpanded: isOpen[0])
        ]);
  }
}

class Item {
  String headerValue;
  String expandedValue;
  bool isExpanded;

  Item({
    required this.headerValue,
    required this.expandedValue,
    this.isExpanded = false,
  });
}
