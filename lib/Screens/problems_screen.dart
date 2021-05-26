import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:quiz/constants.dart';

class ProblemsListScreen extends StatefulWidget {

  static String routeName = 'ProblemsListScreen';
  @override
  _ProblemsListScreenState createState() => _ProblemsListScreenState();
}

class _ProblemsListScreenState extends State<ProblemsListScreen> {
  
  bool isLoading = true;
  bool isInit = true;
  bool filtered = false;

  List<InfoCard> items = [];
  List<InfoCard> itemsFiltered = [];
  List<String> problemsCategory = [];


  void rerender(String val){

    itemsFiltered.clear();
    items.forEach((element) {
      if(element.category==val)
        itemsFiltered.add(element);
    });

    setState(() {
      filtered = true;
    });
  }
  
  @override
  void didChangeDependencies() {


    if(isInit){
      final FirebaseDatabase database = FirebaseDatabase(databaseURL: 'https://urban-feedback-default-rtdb.europe-west1.firebasedatabase.app');

      //database.reference().child('problems');

      DatabaseReference dbRef = database.reference().child('problems');
      print('firebase connected');

      dbRef.once().then((DataSnapshot snapshot) {
        Map<dynamic, dynamic> values = snapshot.value;
        values.forEach((key,values) {
          /*print(values);
          print(key);
          print(values['category']);
          print(values['problem']);
          print(values['location']);
          print(values['recommendation']);
          print(values['photo_url']);
          //Widget widget = InfoCard.fromJson(values);

           */
          items.add(InfoCard.fromJson(values));
          if(!problemsCategory.contains((values['category'] == null?values['catregory']:values['category'])))
            problemsCategory.add((values['category'] == null?values['catregory']:values['category']));

        });
        setState(() {
          isLoading = false;
        });
      });
      isInit = false;
    }
    super.didChangeDependencies();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0,title: Text('Список проблем'),),
      body: SafeArea(child: isLoading?Center(child:CircularProgressIndicator()):

      ListView(
        children: [
          Category(problems: problemsCategory, Rerender: rerender),
          if(filtered) ...itemsFiltered.map((e) => e).toList()
          else ...items.map((e) => e).toList()
        ]
      )),
    );
  }
}

class InfoCard extends StatelessWidget {
  String category,problem,location,recommendation,photo_url;

  InfoCard({
  @required this.category,
    @required this.problem,
    @required this.location,
    @required this.recommendation,
    @required this.photo_url
});

  factory InfoCard.fromJson(Map<dynamic, dynamic> json) => InfoCard(
    category: json['category'] == null?json['catregory']:json['category'],
    problem: json['problem'],
    location: json['location'],
    recommendation: json['recommendation']== null?json['recomendation']:json['recommendation'],
    photo_url: json['photo_url']
  );

  @override
  Widget build(BuildContext context) {
    return Container(

      child: Card(
        margin: EdgeInsets.all(16),

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
        ),
        child: Container(
          margin: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                  flex:2,child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('категория:',style: Constants().maintext,),
                  Container(
                    child: Text(category,style: Constants().subheader,),
                    alignment: Alignment.centerLeft,
                  ),
                  SizedBox(height: 10,),
                  Text('проблема:',style: Constants().maintext),
                  Container(
                    child: Text(problem,style: Constants().subheader,),
                    alignment: Alignment.centerLeft,
                  ),
                  SizedBox(height: 10,),
                  Text('рекомендация:',style: Constants().maintext),
                  Container(
                    child: Text(recommendation,style: Constants().maintext,),
                    alignment: Alignment.centerLeft,
                  )
                ],
              )), Flexible(flex:1,child: Column(
                children: [
                  Image.network(photo_url,fit: BoxFit.fitWidth,),
                  SizedBox(height: 10,),
                  Container(
                    child: Text(location,style: Constants().maintext,),
                  )
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}

class Category extends StatefulWidget {

  Function Rerender;
  List<String> problems;

  Category({
    @required this.problems,
    @required this.Rerender
});



@override
_CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  String val = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
        margin: EdgeInsets.all(16),
        padding: EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
        decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
                side: BorderSide(color: Colors.grey))),
        child: DropdownButton<String>(
          underline: Align(),
          hint: Text('Отфильтруйте по категории'),
          value: val == '' ? null : val,
          items: widget.problems.map((String value) {
            return new DropdownMenuItem<String>(
              value: value,
              child: new Text(value),
            );
          }).toList(),
          onChanged: (String value) {
            widget.Rerender(value);
            setState(() {
              val = value;
            });
          },
        ));
  }
}

