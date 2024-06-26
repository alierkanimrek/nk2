import 'package:shelf/shelf.dart';

import 'html.dart';
import 'base_html.dart';




class SubBase extends Base{

  late Map<String, dynamic> subContent;
  late String backUrl;
  late String title;

  SubBase(super.glob, this.title, this.backUrl);

  Future<Response> handler(Request req) async {
    List<String> render = await base(title,[
      heroSection(),
      mainSection()
    ]);

    return Response.ok(render.join(),
        headers: { "content-type": "text/html"}
    );
  }




  List<String> heroSection() {

    return tComment("\nHero Section", [
      tDiv("header-wrapper pb-0", attr:{"id":"home"},c:[
        tagx("nav navbar", c:[
          tDiv("navbar-brand", c:[
            tDiv("columns is-vcentered is-mobile m-1", c:[
              tDiv("column is-narrow", c:[
                tagx("span icon is-medium", c:[
                  tagx("a", attr: {"href":"/", "data-aos":"fade-left"}, c:[tagx("i fa-solid fa-chevron-left fa-2x txt-shadow")])
                ]),
              ]),
              tDiv("column is-narrow", c:[
                tagx("a", attr: {"href":"/", "data-aos":"fade-left"}, c:[tagx("h4 title txt-shadow", after_c:glob.content.isA("name"))])
              ]),
              /*tDiv("column"),
              tDiv("column is-narrow", c:[
                tDiv("columns is-mobile", c: tforeach(glob.content.isADyn("contact-online"), (dynamic e){
                  return tDiv("column", c:[
                    tagx("span icon is-small", c:[
                      tagx("a", attr: {"href":e[1]},c:[tagx(["i", e[0], "txt-shadow"].join(" "))])
                  ])]);
                }))
              ])*/
            ]),
          ]),
        ]),
        tagx("section hero hero-sub1 is-small", c:[
          tDiv("hero-body", c:[
            tDiv("container has-text-centered",  c:[
              tDiv("columns is-vcentered is-mobile", c:[
                tDiv("column is-narrow", c:[
                  tagx("span icon is-large", c:[
                    tagx("a", attr: {"href":backUrl, "data-aos":"fade-left"}, c:[tagx("i fa-solid fa-chevron-left fa-3x txt-shadow")])
                  ]),
                ]),
                tDiv("column", c:[
                  tagx("h2 title p-5", attr:{"data-aos":"fade-down"}, after_c:title),
                ]),
              ]),
            ]),
          ]),
        ])

      ])
    ]);

  }


  List<String> mainSection() {  throw UnimplementedError(); }




}
