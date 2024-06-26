import 'dart:math';

import 'package:shelf/shelf.dart';
import 'atom.dart';
import 'carousel.dart';
import 'html.dart';
import 'config.dart';
import 'base_html.dart';
import 'subbase_html.dart';
import 'tsv.dart';
import 'utils.dart';
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
    return tComment("\n\n", [tDiv("container",
      c: tforeach(blog.entries, (AtomEntry entry){

        return tDiv("box m-4 mb-6", c: [
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

      }))
    ]);
  }


}