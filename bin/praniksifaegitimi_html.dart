import 'package:shelf/shelf.dart';
import 'atom.dart';
import 'html.dart';
import 'base_html.dart';
import 'utils.dart';
import 'widgets_html.dart';




class PranikSifaEgitimi extends Base{

  late Map<String, dynamic> subContent;

  PranikSifaEgitimi(super.glob){
    subContent = glob.content.isADyn("consultancies")[2];
  }



  Future<Response> handler(Request req) async {

    AtomEntry item = glob.blog1.random;

    List<String> render = await base(
      subContent["title"]!,[
      subHero1(glob.content.isA("name"), subContent["title"]!, subtitle:subContent["intro"]!),
      mainSection1("pt-0", [
        subContainer1("section-light", [
          intro1(
            subContent["title"],
            subContent["full"],
            "/img/${glob.img.pick(prefix: subContent["img_prefix"])}",
            direction: Direction.right,
            titled: false
          ),
          tDiv("container pt-3", c:[
            vButtons( [
              Button(
                  subContent["sub-content-1-text-1"],
                  "is-large is-success",
                  subContent["sub-content-1-url-1"],
                  icon: "fa-solid fa-graduation-cap",
                  iconClss: "icon is-large",
                  attr: {"data-aos":"fade-right"}
              )
            ])
          ])
        ]),
        subContainer1("section-dark", [ comments() ]),
        subContainer1("section-dark", [ sub1() ]),
        subContainer1("section-light", [
          intro1(
            item.title,
            item.summary,
            item.img,
            titled: true,
            buttontext: glob.content.isA("readmore"),
            linkurl: "/blog/"+item.id,
            direction: Direction.left
          )
        ]),
        subContainer1("section-light", [ subLinks() ]),
      ])
    ]);

    return Response.ok(
        render.join(),
        headers: { "content-type": "text/html"}
    );
  }




  List<String> comments() {

    return tComment("\n", [
      tagx("h1 title has-text-centered section-title", attr:{ "data-aos":"fade-left"}, after_c: subContent["sub-title-1"]),
      tDiv("block", c:[
        tagx("p has-text-centered mb-5", attr:{ "data-aos":"fade-right"}, after_c: subContent["sub-content-1"]),
        vButtons([
          Button(
              subContent["sub-content-1-text-2"],
              "is-large is-info",
              subContent["sub-content-1-url-2"],
              icon: "fa-regular fa-comments",
              iconClss: "icon is-large",
              attr: {"data-aos":"fade-up"}
          )
        ])
      ])

    ]);

  }


  List<String> subLinks() {
    Map<String, dynamic> sub1 = glob.content.isADyn("consultancies")[0];
    Map<String, dynamic> sub2 = glob.content.isADyn("consultancies")[3];
    return tDiv("container", c: [
      tDiv("columns", c:[
        tDiv("column is-half has-text-centered", c:[
          tagx("h1 title has-text-centered section-title", attr:{ "data-aos":"fade-right"}, after_c: sub1["sub-title-2"]),
          tagx("p mb-4", attr:{ "data-aos":"fade-right"}, after_c: sub1["sub-content-2"]),
          tagx("a button", attr:{"href": sub1["url"]!, "data-aos":"fade-up"}, after_c: sub1["link-text"])
        ]),
        tDiv("column is-half has-text-centered", c:[
          tagx("h1 title has-text-centered section-title", attr:{ "data-aos":"fade-left"}, after_c: sub2["sub-title-2"]),
          tagx("p mb-4", attr:{ "data-aos":"fade-left"}, after_c: sub2["sub-content-2"]),
          tagx("a button", attr:{"href": sub2["url"]!, "data-aos":"fade-up"}, after_c: sub2["link-text"])
        ])
      ])
    ]);

  }


  List<String> sub1() {

    return tComment("\n", [
      tagx("h1 title has-text-centered section-title", attr:{ "data-aos":"fade-left"}, after_c: subContent["sub-title-3"]),
      tDiv("block", c:[
        tagx("p has-text-centered mb-5", attr:{ "data-aos":"fade-right"}, after_c: subContent["sub-content-3"]),
        vButtons([
          Button(
              glob.content.isA("follow-on-instagram"),
              "is-large",
              glob.content.isADyn("contact-online")[0][1],
              icon: glob.content.isADyn("contact-online")[0][0],
              iconClss: "icon is-large",
              attr: {"data-aos":"fade-up"}
          )
        ])
      ])

    ]);

  }

}
