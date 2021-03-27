import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyFirstApp());

class MyFirstApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final wordPair = WordPair.random();
    return MaterialApp(
      title: 'First App ',
      theme:ThemeData(
          primaryColor:Colors.white,
      ),
    //   home: Scaffold(
    //     appBar: AppBar(
    //       title:Center( 
    //        child:Text('Welcome emaan',style: TextStyle(color:Colors.yellow), ),
          
    //     ),),
        home:  RandomWords(),
            // child:  Text("Hello eman !!"),
            //   child: Text(wordPair.asPascalCase),
            
      
    );
    
  }
}

 class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
    final _suggestion= <WordPair>[];
    final _save=<WordPair>{};
    final _biggerFont= const TextStyle(fontSize: 20);
  @override
  Widget build(BuildContext context) {
    //  final wordPair = WordPair.random();
    // return Text(wordPair.asPascalCase);

    return Scaffold(
        appBar:AppBar(
            title:Text("start"),
            actions:[
                IconButton(
                    icon:Icon(Icons.list),
                    onPressed:_pushSaved,
                )
            ]
        ),
        body:_buildSuggestions(),
    );
   
  }
  void _pushSaved(){
Navigator.of(context).push(
    MaterialPageRoute(
        builder:(BuildContext context) {
final tiles=_save.map(
    (WordPair pair){
        return ListTile(
                 title:Text(
                        pair.asPascalCase,
                        style: _biggerFont,
                           ),
                       );
                             },
                        ); 
final divided=ListTile.divideTiles(
    context:context,
    tiles:tiles,
).toList();

return Scaffold(
    appBar:AppBar(
        title:Text("listTiles")
    ),
    body:ListView(children: divided, )
);
},
    ),
);
  }
  Widget _buildSuggestions(){
  
      return ListView.builder(
        padding: const EdgeInsets.all(15),
        itemBuilder:(BuildContext _context,int i){
            if(i.isOdd){
                return Divider();
            }
          final index =i ~/2 ; 
          if(index >= _suggestion.length){
              _suggestion.addAll(generateWordPairs().take(1));
          }
          return _buildRow(_suggestion[index]);
        }
      );
  }
Widget _buildRow(WordPair pair){
    final alreadySaved=_save.contains(pair);
    return ListTile(
        title:Text(
            pair.asPascalCase,
             style: _biggerFont,
        ),
        trailing:Icon(
            alreadySaved? Icons.favorite:Icons.favorite_border ,
            color:alreadySaved?Colors.red:null,
        ),
        onTap:(){
          setState((){
            if(alreadySaved){
                _save.remove(pair);
            }
            else{
                _save.add(pair);
            }
        });},
    );
}  } 
 