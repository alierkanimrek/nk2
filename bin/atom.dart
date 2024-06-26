import 'dart:math';
import 'utils.dart';
import 'package:dart_rss/dart_rss.dart';

/*
void main() async{
  Atom t = Atom("blogger1.xml", DateTime.utc(2020));
  //await j.save({"ali": 123, "veli": ["a","b"]});
  print(await t.read());
  t.entries.forEach((e) {
    print("\n\n"+e.title);
    print(e.summary);
  });
}
*/




class AtomEntry{

  String id = "";
  String published = "";
  String title = "";
  String summary = "";
  String content = "";
  String img = "";

  AtomEntry(AtomItem item){
    try{  id = item.id!.split("-")[2]; }catch(e){}
    try{ published = item.published!; }catch(e){}
    try{ title = item.title!; }catch(e){}
    try{ content = item.content!; }catch(e){}
    summary = extSummary();
    img = extImg();
  }


  String extImg(){
    String result = "";
    try {
      int imgTag = content.indexOf("<img");
      int srcAttr = content.indexOf("src=\"", imgTag) + 5;
      int endAttr = content.indexOf("\"", srcAttr);
      result = content.substring(srcAttr, endAttr);
    }catch(e){}
      return result;
    }




  String extSummary(){
    String result = "";
    int st = 0;
    int end = 0;
    try {
      while(true){
        st = content.indexOf(">",st)+1;
        end = content.indexOf("<",st);
        if(end == -1){ break; }
        if( content.substring(st,end).trim().length > 0){
          result = content.substring(st,end);
          break;
        }
      }
    }catch(e){}
    return result;
  }

}






class Atom extends AtomFile {

  List<AtomEntry> entries = [];
  late final DateTime beginning;
  late String url;


  Atom(super.fn, super.log, this.beginning, this.url);

  @override
  Future<bool> read() async {
    if (await super.read()) {  null; }
    else {  return false;   }
    atom.items.forEach((item) {
      int itemPubYear = 2020;
      try{ itemPubYear = DateTime.parse(item.published!).year; }catch(e){}
      if( itemPubYear >= beginning.year){
        entries.add(AtomEntry(item));
      }
    });
    return true;
  }


  AtomEntry get random{
    var index = Random().nextInt(entries.length);
    return entries[index];
  }


  AtomEntry entry(String id){
    AtomEntry result = AtomEntry(AtomItem());
    Iterable<AtomEntry> e = entries.where((element) => element.id == id );
    e.length>0?result=e.first:null;
    return result;
  }


  Future<void> update() async{
    if(await downloadResource(url, fn, super.log)){  read();  }
  }


}