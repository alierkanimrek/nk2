import 'package:shelf/shelf.dart';
import 'atom.dart';
import 'base_html.dart';
import 'widgets_html.dart';




class BlogIndex extends Base {

  late Atom blog;
  late String title;

  BlogIndex(super.glob, this.blog){
    title = glob.content.isA("blog1_title");
  }


  Future<Response> handler(Request req) async {
    List<String> render = await base(title, [
      subHero1( glob.content.isA("name"), title),
      mainSection1("pt-0", [
        subContainer1("section-dark", [
          theme()
        ])
      ])
    ]);

    return Response.ok(render.join(),
        headers: { "content-type": "text/html"}
    );
  }





  List<String> theme() {
    return
      $.div("container")(c: [$.forEach(blog.entries, (AtomEntry entry){
        return $.div("box m-4 mb-6")( c: [
          intro1(
            entry.title,
            entry.summary,
            entry.img,
            titled: true,
            direction: Direction.left,
            buttontext: glob.content.isA("readmore"),
            linkurl: "/blog/"+entry.id
          )
        ]);
      })]);

  }


}