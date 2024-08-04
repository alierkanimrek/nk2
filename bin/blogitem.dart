import 'package:shelf/shelf.dart';
import 'atom.dart';
import 'base_html.dart';
import 'widgets_html.dart';




class BlogItem extends Base {

  late Atom blog;
  late AtomEntry item;
  final String backUrl = "/blog";

  BlogItem(super.glob, this.blog);


  Future<Response> handler(Request req, String id) async {
    item = blog.entry(id);

    List<String> render = await base(item.title,[
      subHero1( glob.content.isA("name"), item.title, backUrl: backUrl),
      mainSection1("pt-0", [
        subContainer1("section-light", [
          theme()
        ]),
        subContainer1("section-dark", [
          foot()
        ])
      ])
    ]);

    return Response.ok(render.join(),
        headers: { "content-type": "text/html"}
    );
  }




  List<String> theme() {
    return $.div("columns")( c:[
      $.div("column is-8 is-offset-2")( c:[
        $.div()(a:{"data-aos":"fade-up"}, after: item.content),
      ])
    ]);
  }






  List<String> foot() {
    return
      footBack(backUrl, [
      $.div("column")( c:[
        $.div("columns is-mobile")( c: [$.forEach([blog.random, blog.random, blog.random], (item){
          return $.div("column is-4")(a: {"data-aos":"fade-left"}, c:[
            $.div("box")( c:[
              $.h6()(after: item.title)
            ])
          ]);
        })]),
      ])
      ]);
  }




}