import 'dart:math';

import 'utils.dart';



class Tsv extends TsvFile {

  late List<String> titles;
  late String url;
  late String name;


  Tsv(super.fn, super.log, this.titles, this.url, this.name);

  @override
  Future<bool> read() async {
    if (await super.read()) {
      data = (filter((Map<String, String> rec){
        return rec["allow"]==""?true:false;
      }));
    }
    else{ return false; }
    return true;
  }


  int get length{ return data.length; }

  Map<String, String> rec(int pos){
    Map<String, String> result = {};
    try{
      List<String> d = data[pos] ;
      for(var i=0; i<d.length;i++){    result[titles[i]] = d[i];      }
      result["pos"] = pos.toString();
    }
    catch(e){null;}
    return result;
  }



  List<Map<String,String>> get recList{
    List<Map<String,String>> result = [];
    for(var i=0; i<data.length;i++){    result.add(rec(i));    }
    return result;
  }



  List<Map<String,String>> get revRecList{
    List<Map<String,String>> result = [];
    for(var i=data.length-1; i>-1;i--){    result.add(rec(i));    }
    return result;
  }



  List<List<String>> filter(Function f){
    return data.where((e) {
      Map<String, String> rec = {};
      for (var i = 0; i < titles.length; i++) {
        rec[titles[i]] = "";
        try{  rec[titles[i]] = e[i]; }catch(e){null;}
      }
      return f(rec);
    }).toList();
  }




  List<Map<String, String>> randomRecList(int count){
    List<Map<String, String>> result = [];
    List<int> indexList = [];
    if(count >= data.length){    result = recList;  }
    else {
      do {
        var index = Random().nextInt(length);
        !indexList.contains(index)? result.add(rec(index)) : null;
      }
      while (result.length < count);
    }
    return result;
  }


  Future<void> update() async{
    if(await downloadResource(url, fn, super.log)){  read();  }
  }

}




