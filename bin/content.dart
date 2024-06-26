import 'utils.dart';



class Content extends JsonFile {

  Map<String, dynamic> content = {};

  Content(super.fn, super.log);

  @override
  Future<bool> read() async {
    if (await super.read()) {
      try {
        content = data;
      }catch (e) {   err(e, ["Parse", fn]); return false;  }
    }
    else{ return false; }
    return true;
  }


  Future<bool> update() async {
    if (!(await super.save(content))) {
      return false;
    }
    return true;
  }


  String isA(String name){
    String result = "";
    try{ result = content[name]!; }
    catch (e) {   err(e, ["Content", name]);  }
    return result;
  }

  dynamic isADyn(String name){
    dynamic result = "";
    try{ result = content[name]!; }
    catch (e) {   err(e, ["Content", name]);  }
    return result;
  }
}




