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
    return tDiv("columns", c:[
      tDiv("column is-8 is-offset-2", c:[
        tagx("div", attr:{"data-aos":"fade-up"}, after_c: item.content),
      ])
    ]);
  }






  List<String> foot() {
    return footBack(backUrl, [
      tDiv("column", c:[
        tDiv("columns is-mobile", c: tforeach([blog.random, blog.random, blog.random], (item){

          return tDiv("column is-4", attr: {"data-aos":"fade-left"}, c:[
            tDiv("box ", c:[
              tagx("h6", after_c: item.title!)
            ])
          ]);

        })),
      ])
    ]);
  }




}