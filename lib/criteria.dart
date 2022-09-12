import 'package:flutter/material.dart';

class CriteriaPage extends StatefulWidget {
  final List<dynamic> criteria;
  final String name;
  final String tag;
  final String color;
  const CriteriaPage(
      {Key? key,
      required this.criteria,
      required this.name,
      required this.tag,
      required this.color})
      : super(key: key);

  @override
  State<CriteriaPage> createState() => _CriteriaPageState();
}

class _CriteriaPageState extends State<CriteriaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        // color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 20, left: 20),
              color: Colors.black,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    style: const TextStyle(color: Colors.white),
                  ),
                  Text(widget.tag,
                      style: TextStyle(
                        color:
                            widget.color == 'green' ? Colors.green : Colors.red,
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: widget.criteria.length,
                  itemBuilder: (BuildContext context, int index) {
                    String texts = widget.criteria[index]['text'];
                    // final split = texts.split(r'$');
                    // final repl = texts.replaceAll('1', 'news');
                    // String news = "3333";
                    print(widget.criteria[index]['variable'].runtimeType);

                    return GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.only(top: 20, left: 20),
                        color: Colors.black,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //
                            // getRow(split, widget.criteria[index]["variable"]),
                            Text(
                              // repl,
                              widget.criteria[index]["text"],
                              // split[0],
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 18),
                            ),
                            SizedBox(
                                height: 25,
                                child: widget.criteria.length != index + 1
                                    ? Container(
                                        padding: const EdgeInsets.only(top: 7),
                                        child: const Text(
                                          "and",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      )
                                    : null)
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

Widget getRow(List<String> text, Map<String, dynamic> varl) {
  return Container(
    child: Row(
      children: [
       if (varl.isEmpty)  Text(text[0]),
       for(){},
      ],
    ),
  );
}

class Crite {
  final String type;
  final String text;
  final Map<String, dynamic> variable;

  Crite({required this.text, required this.type, required this.variable});
}
