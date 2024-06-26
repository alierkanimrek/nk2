import 'utils.dart';



class Config extends JsonFile {
  String domain = "";
  String server_port = "";
  String log_level = "";
  String testing = "";
  String static_path = "";
  String profile_img_path = "";
  String gform1_url = "";
  String gform1_file = "";
  String gform1_titles = "";
  String gform2_url = "";
  String gform2_file = "";
  String gform2_titles = "";
  String blog1_url = "";
  String blog1_file = "";
  String profile_res_path = "";
  String lib_path = "";

  Config(super.fn, super.log);

  @override
  Future<bool> read() async {
    if (await super.read()) {
      try {
        domain = data["domain"];
        server_port = data["server_port"];
        log_level = data["log_level"];
        testing = data["testing"];
        static_path = data["static_path"];
        profile_img_path = data["profile_img_path"];
        gform1_url = data["gform1_url"];
        gform1_file = data["gform1_file"];
        gform1_titles = data["gform1_titles"];
        gform2_url = data["gform2_url"];
        gform2_file = data["gform2_file"];
        gform2_titles = data["gform2_titles"];
        blog1_url = data["blog1_url"];
        blog1_file = data["blog1_file"];
        profile_res_path = data["profile_res_path"];
        lib_path = data["lib_path"];
      }catch (e) {   err(e, ["Parse", fn]); return false;  }
    }
    else{ return false; }
    return true;
  }


  Future<bool> update() async {
    dynamic ndata = {
      'domain': domain,
      'server_port': server_port,
      'log_level': log_level,
      'testing': testing,
      'static_path': static_path,
      'profile_img_path': profile_img_path,
      'gform1_url': gform1_url,
      'gform1_file': gform1_file,
      'gform1_titles': gform1_titles,
      'gform2_url': gform2_url,
      'gform2_file': gform2_file,
      'gform2_titles': gform2_titles,
      'blog1_url': blog1_url,
      'blog1_file': blog1_file,
      'profile_res_path': profile_res_path,
      'lib_path': lib_path
    };
    if (!(await super.save(ndata))) {
      return false;
    }
    return true;
  }
}




