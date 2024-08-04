import 'package:logging/logging.dart';
import 'lib/jsony/lib/jsony.dart';
import 'utils.dart';




class Config extends Jsony {

  late JsonFile source;
  JsonyString domain = JsonyString("domain", "");
  JsonyString server_port = JsonyString("server_port", "");
  JsonyString log_level = JsonyString("log_level", "");
  JsonyString testing = JsonyString("testing", "");
  JsonyString static_path = JsonyString("static_path", "");
  JsonyString lib_path = JsonyString("lib_path", "");
  JsonyString profile_img_path = JsonyString("profile_img_path", "");
  JsonyString profile_res_path = JsonyString("profile_res_path", "");
  JsonyString gform1_url = JsonyString("gform1_url", "");
  JsonyString gform1_file = JsonyString("gform1_file", "");
  JsonyString gform1_titles = JsonyString("gform1_titles", "");
  JsonyString gform2_url = JsonyString("gform2_url", "");
  JsonyString gform2_file = JsonyString("gform2_file", "");
  JsonyString gform2_titles = JsonyString("gform2_titles", "");
  JsonyString blog1_url = JsonyString("blog1_url", "");
  JsonyString blog1_file = JsonyString("blog1_file", "");

  Config(String fn, Logger log):super("nk"){
    jsonTypes([domain, server_port, log_level, testing, static_path, lib_path,
      profile_img_path, profile_res_path, gform1_url, gform1_file, gform1_titles,
      gform2_url, gform2_file, gform2_titles, blog1_url, blog1_file,
    ]);
    source = JsonFile(fn, log);
  }

  @override
  Future<bool> read() async {
    if (await source.read()) {
      try {
        fromJson(source.raw);
        if(!isMatched){
          update();
        }
      }catch (e) {   source.err(e, ["Parse", source.fn]); return false;  }
    }
    else{ return false; }
    return true;
  }


  Future<bool> update() async {
    if (!(await source.save(toJson))) {
      return false;
    }
    return true;
  }
}




