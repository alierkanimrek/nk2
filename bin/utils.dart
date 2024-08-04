import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:io';
import 'dart:math';

import 'package:logging/logging.dart';
import "package:path/path.dart";
import 'package:dart_rss/dart_rss.dart';



class RawFile {

  late String _fn;
  String raw = "";
  late File _fh;
  Object? _err;
  late Logger log;


  RawFile(this._fn, this.log);


  Future<bool> read() async {
    _err = null;
    if(_fn.substring(0,1) != "/") {
      _fn = Platform.isWindows
          ?
      join(dirname(Platform.script.path).replaceAll("/", "\\").substring(1), _fn)
          :
      join(dirname(Platform.script.path), _fn);
    }
    _fh = File(_fn);
    try { raw = await _fh.readAsString(); }
    catch (e) {  err(e, ["Read error",_fn]); return false;  }
    log.config("Ok: '$_fn'");
    return true;
  }


  Future<bool> save(String data) async {
    _err = null;
    try {  await _fh.writeAsString(data, mode: FileMode.writeOnly); }
    catch (e) { err(e,["Save error", _fn]); return false;  }
    raw = data;
    log.info("File saved, '$_fn'");
    return true;
  }


  void err(Object e, List<dynamic> msg){
    List<String> n = msg.map((l) => l.toString()).toList();
    log.severe(n.join(", "), [e]);
  }

  String get fn{ return _fn; }

}







class JsonFile extends RawFile{

    dynamic data = {};

    JsonFile(super.fn, super.log);

    @override
    Future<bool> read() async {
      if(await super.read()){
        try { data = jsonDecode(raw); }
        catch (e) {  err(e, ["Decode", fn]);   return false;  }
      }
      else{ return false; }
      return true;
    }

    @override
    Future<bool> save(dynamic jdata) async {
      _err = null;
      late String raw;
      try { raw = jsonEncode(jdata); }
      catch (e) { err(e, ["Encode", fn]);   return false;  }
      if(!(await super.save(raw))){ return false; }
      data = jdata;
      return true;
    }
}




class TsvFile extends RawFile{

  List<List<String>> data = [];

  TsvFile(super.fn, super.log);

  @override
  Future<bool> read() async {
    if(await super.read()){
      try { data = tsvDecode(raw); }
      catch (e) {  err(e, ["Decode", fn]);   return false;  }
    }
    else{ return false; }
    return true;
  }

}



class AtomFile extends RawFile{

  late AtomFeed atom;

  AtomFile(super.fn, super.log);

  @override
  Future<bool> read() async {
    if(await super.read()){
      try {  atom = AtomFeed.parse(raw); }
      catch (e) {  err(e, ["Decode", fn]);   return false;  }
    }
    else{ return false; }
    return true;
  }

}



List<List<String>> tsvDecode(String raw){
  const splitter = LineSplitter();
  final lines = splitter.convert(raw);
  final List<List<String>> result = [];
  for(var i=1; i<lines.length; i++){
    result.add(lines[i].split('\t'));
  }
  return result;
}







List<List<String>> mixLists(List<String> a, List<String> b){
  List<List<String>> result = [];
  try{ for(var i=0; i<a.length; i++){  result.add([a[i],b[i]]); } }
  catch(e){ result.add(["bug",e.toString()]);}
  return result;
}




String shortOf(String txt, int wordCount, {bool ellipsis = true}){
  String result = "";
  List<String> words = txt.split(" ");
  if(words.length<=wordCount){  result = txt; ellipsis = false;}
  else{  result = words.getRange(0, wordCount).join(" "); }
  ellipsis? result += "...": null;
  return result;
}



String tr2en(String tr){
  String en = "";
  en = tr.trim().replaceAll("ı", "i");
  en = en.trim().replaceAll("ç", "c");
  en = en.trim().replaceAll("ş", "s");
  en = en.trim().replaceAll("ö", "o");
  en = en.trim().replaceAll("ü", "ü");
  en = en.trim().replaceAll("ğ", "g");
  en = en.trim().replaceAll("İ", "I");
  en = en.trim().replaceAll("Ç", "C");
  en = en.trim().replaceAll("Ş", "S");
  en = en.trim().replaceAll("Ö", "O");
  en = en.trim().replaceAll("Ü", "U");
  en = en.trim().replaceAll("Ğ", "G");
  return en;
}





Future<bool> downloadResource(String url, String file, Logger log) async{
  bool result = false;

  HttpClient client = HttpClient();
  File fh = File(file);
  File cfh = File(file+".down");
  int fhLength = await fh.exists()? await fh.length() : 0;

  try {

    HttpClientRequest request = await client.getUrl(Uri.parse(url));
    HttpClientResponse response = await request.close();
    final stringData = await response.transform(utf8.decoder).join();

    await cfh.writeAsString(stringData, mode: FileMode.writeOnly);

    if(await cfh.length() != fhLength){
      await fh.writeAsString(stringData, mode: FileMode.writeOnly);
      result = true;
    }

  }
  catch (e) {  log.severe("Download error: $url", [e]);   return false;  }
  finally {   client.close();  }
  log.info("Ok: '$url'");
  return result;
}



class ImgFiles{

  late final String path;
  late final Logger log;
  List<String> names = [];
  List<String> extensions = ["jpg", "JPG", "JPEG", "jpeg", "png", "PNG"];

  ImgFiles(this.path, this.log);


  Future<void> update() async{
    final dir = Directory(path);
    late List<FileSystemEntity> files;

    List<FileSystemEntity> f = await dir.list().toList();

    files = f.where((FileSystemEntity element) {
      bool result = false;
      try {
        if (extensions.contains(
            extension(basename(element.path)).split(".")[1])) {
          result = true;
        }
      }
      catch (e) {  log.severe("Img files error", [e]);   return false;  }
      finally{  }
      return result;
    }).toList();
    names = [];
    files.forEach((e){ names.add(basename(e.path)); });
    log.info("Ok: ${names.length} img files");
  }

  
  List<String> filter(String prefix){
    return names.where(( String element) {
      if( element.length > prefix.length ){
        if( element.substring(0, prefix.length) == prefix ){
          return true;
        }
      }
      return false;
    }).toList();
  }



  String pick({String? prefix}){
    List<String> source = [];
    prefix==null? source=names : source=filter(prefix);
    return source[Random().nextInt(source.length)];
  }


}


/*
void main() async{
  downloadResource("https://www.instagram.com/pranic_arhat_yoga/?__a=1", "/home/ali/StudioProjects/nuraykaya_com/bin/insta.json");
}
*/