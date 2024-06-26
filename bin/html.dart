


int tagIndent=0;




String _tag(String tag, Map<String,String> ?attr){
  List<String> t = ["<$tag"];
  if(attr!=null) {
    try{ t.add(" class='${attr["class"]!}'"); attr.remove("class"); } catch (e){ null; }
    try{ t.add(" id='${attr["id"]!}'"); attr.remove("id"); } catch (e){ null; }
    try{ t.add(" ${attr["@"]!}"); attr.remove("@"); } catch (e){ null; }
    attr.forEach((key, value) {
      t.add("$key='$value'");
    });
  }
  t.add(">");
  return t.join(" ");
}



List<String> tagx(
    String tag,
    {List<List<String>> ?c,
      Map<String,String> ?attr,
      String ?before_c,
      String ?after_c,
      bool end=true
    }) {

  String ind = List.filled(tagIndent, ' ').join();
  List<String> content = [];

  List<String> tags = tag.split(" ");
  if(tags.length>1){
    tag = tags.removeAt(0);
    attr!=null?attr.addAll({"class": tags.join(" ")}):attr={"class": tags.join(" ")};
  }
  content.add(_tag(tag, attr));
  before_c!=null?content.add(before_c):null;
  c?.forEach((child) { for (var c in child) { content.add("$ind$c"); } });
  after_c!=null?content.add(after_c):null;
  end?content.add("</$tag>"):null;
  return content;
}



List<String> tDiv(String ?clss,{
      Map<String,String> ?attr,
      List<List<String>> ?c}) {
  return tagx("div ${clss!}", attr: attr, c:c);
}

List<String> tImg(String ?clss, String ?src, {
  Map<String,String> ?attr,
  List<List<String>> ?c}) {
  (src!=null && attr==null)?attr = {}:null;
  src!=null?attr?.addAll({"src":src}):null;
  return tagx("img ${clss!}", attr: attr, c:c);
}


List<String> tComment(String comment, List<List<String>>? c) {
  List<String> content = ['<!-- $comment -->'];
  c?.forEach((child) { for (var c in child) { content.add("$c"); } });
  return content;
}


List<List<String>> tforeach(List<dynamic> content, Function wrapper){
  List<List<String>> c = [];
  content.forEach((content) {
    try{c.add(wrapper(content));}
    catch(e){ c.add(tagx("strong", after_c: e.toString())); }
  });
  return c;
}

