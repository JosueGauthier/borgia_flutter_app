/* import 'package:flutter/material.dart';

class GenBill extends StatefulWidget {
  const GenBill({Key? key}) : super(key: key);

  @override
  State<GenBill> createState() => _GenBillState();
}

class _GenBillState extends State<GenBill> {
  List<dynamicWidget> dynamicList = [];

  List<String> price = [];

  List<String> product = [];

  addDynamic() {
    if (product.length != 0) {
      Icon floatingIcon = const Icon(Icons.add);

      product = [];
      price = [];
      dynamicList = [];
    }
    setState(() {});
    if (dynamicList.length >= 50) {
      return;
    }
    dynamicList.add(dynamicWidget());
  }

  submitData() {
    Icon floatingIcon = const Icon(Icons.arrow_back);
    product = [];
    price = [];
    dynamicList.forEach((widget) => product.add(widget.Product.text));
    dynamicList.forEach((widget) => price.add(widget.Price.text));
    setState(() {});
    print(product.length);
    //sendData();
  }

  @override
  Widget build(BuildContext context) {
    Widget dynamicTextField = Flexible(
      flex: 2,
      child: ListView.builder(
        itemCount: dynamicList.length,
        itemBuilder: (_, index) => dynamicList[index],
      ),
    );
    Widget result = Flexible(
        flex: 1,
        child: Card(
          child: ListView.builder(
            itemCount: product.length,
            itemBuilder: (_, index) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(left: 10.0),
                      child: Text("${index + 1} : ${product[index]}${price[index]}"),
                    ),
                    const Divider()
                  ],
                ),
              );
            },
          ),
        ));

    Widget submitButton = new Container(
      child: new RaisedButton(
        onPressed: submitData,
        child: new Padding(
          padding: new EdgeInsets.all(16.0),
          child: new Text('Submit Data'),
        ),
      ),
    );

    return Scaffold(
        body: Container(
          color: Colors.greenAccent,
          child: Column(children: <Widget>[
            product.length == 0 ? dynamicTextField : result,
            product.length == 0 ? submitButton : Container(),
          ]),
        ),
        floatingActionButton: FloatingActionButton(onPressed: addDynamic, child: Icon(Icons.add)));
  }
}

class dynamicWidget extends StatelessWidget {
  TextEditingController Product = TextEditingController();
  TextEditingController Price = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
//      margin: new EdgeInsets.all(8.0),
      child: ListBody(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 200,
                padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                child: TextFormField(
                  controller: Product,
                  decoration: const InputDecoration(labelText: 'Product Name', border: OutlineInputBorder()),
                ),
              ),
              Container(
                width: 100,
                padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                child: TextFormField(
                  controller: Price,
                  decoration: const InputDecoration(labelText: 'Price', border: OutlineInputBorder()),
                  keyboardType: TextInputType.number,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
 */