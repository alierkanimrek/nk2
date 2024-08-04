import 'package:shelf/shelf.dart';
import 'atom.dart';
import 'base_html.dart';
import 'utils.dart';
import 'widgets_html.dart';




class PranikSifa extends Base{

  late Map<String, dynamic> subContent;

  PranikSifa(super.glob){
    subContent = glob.content.isADyn("consultancies")[0];
  }



  Future<Response> handler(Request req) async {

    AtomEntry item = glob.blog1.random;

    List<String> render = base(
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
          )
        ]),
        subContainer1("section-light pt-0", [
          warning()
        ]),
        glob.form1.length>2?subContainer1("section-dark", [
          commentCarousel(),
          buttons()
        ]):subContainer1("section-dark", [
          button()
        ]),
        subContainer1("section-dark", [ sub1() ]),
        subContainer1("section-light", [
          intro1(
              item.title,
              item.summary,
              item.img,
              titled: true,
              buttontext: glob.content.isA("readmore"),
              linkurl: "/blog/${item.id}",
              direction: Direction.left
          )
        ]),
        subContainer1("section-light", [
          subLinks()
        ])
      ])
    ]);


    return Response.ok(
        render.join(),
        headers: { "content-type": "text/html"}
    );
  }




  List<String> commentCarousel() {
    return
      $.div("container")( c: [
        $.h1("title has-text-centered section-title")( a:{ "data-aos":"fade-down"}, after: subContent["sub-title-1"]),
        carousel1("car", glob.form1.randomRecList(3), (Map<String, String> rec){
          return
            $.p()(before: shortOf(rec["comment"]!,25), c:[
              rec["comment"]!.split(" ").length<=25
                ?[]
                :$.a("/pranik-sifa-danismanligi/yorumlar#${rec["pos"]!}","button is-rounded is-small")( after: glob.content.isA("readmore")),
            ]);
        })
      ]);
  }



  List<String> buttons() {

    return vButtons([
        Button(
            glob.content.isA("readall"),
            "is-large is-info ",
            "/pranik-sifa-danismanligi/yorumlar",
            icon: "fa-regular fa-comments",
            iconClss: "icon is-large",
            attr: {"data-aos":"fade-left"}
        ),
        Button(
            glob.content.isA("writecomment"),
            "is-large is-success",
            subContent["sub-content-1-url-1"],
            icon: "fa-regular fa-comment-dots",
            iconClss: "icon is-large",
            attr: {"data-aos":"fade-right"}
        )
      ]);

  }



  List<String> button() {

    return vButtons([
      Button(
          glob.content.isA("writecomment"),
          "is-large is-success",
          subContent["sub-content-1-url-1"],
          icon: "fa-regular fa-comment-dots",
          iconClss: "icon is-large",
          attr: {"data-aos":"fade-right"}
      )
    ]);

  }



  List<String> warning() {
    return
      $.div("box warning has-text-justified")(a:{ "data-aos":"zoom-in"}, after: glob.content.isA("warning"));
  }


  List<String> sub1() {
    return
      $.fake([
        $.h1("title has-text-centered section-title")(a:{ "data-aos":"fade-down"}, after: subContent["sub-title-3"]),
        $.div("block")( c:[
          $.p("has-text-centered mb-5")(a:{ "data-aos":"fade-up"}, after: subContent["sub-content-3"]),
          vButtons([
            Button(
                glob.content.isA("join-on-whatsapp"),
                "is-large",
                glob.content.isADyn("contact-online")[0][1],
                icon: glob.content.isADyn("contact-online")[0][0],
                iconClss: "icon is-large",
                attr: {"data-aos":"fade-up"}
            ),
            Button(
                glob.content.isA("dm-on-instagram"),
                "is-large",
                glob.content.isADyn("contact-online")[1][1],
                icon: glob.content.isADyn("contact-online")[1][0],
                iconClss: "icon is-large",
                attr: {"data-aos":"fade-up"}
            ),
            Button(
                glob.content.isA("tomail"),
                "is-large",
                glob.content.isADyn("contact-online")[5][1],
                icon: glob.content.isADyn("contact-online")[5][0],
                iconClss: "icon is-large",
                attr: {"data-aos":"fade-up"}
            )
          ])
        ])
      ]);

  }


  List<String> subLinks() {
    Map<String, dynamic> sub1 = glob.content.isADyn("consultancies")[2];
    Map<String, dynamic> sub2 = glob.content.isADyn("consultancies")[3];
    return
      $.div("container")( c: [
        $.div("columns")( c:[
          $.div("column is-half has-text-centered")( c:[
            $.h1("title has-text-centered section-title")( a:{ "data-aos":"fade-right"}, after: sub1["sub-title-2"]),
            $.p("mb-4")(a:{ "data-aos":"fade-right"}, after: sub1["sub-content-2"]),
            $.a(sub1["url"]!,"button")(a:{ "data-aos":"fade-up"}, after: sub1["link-text"])
          ]),
          $.div("column is-half has-text-centered")( c:[
            $.h1("title has-text-centered section-title")(a:{ "data-aos":"fade-left"}, after: sub2["sub-title-2"]),
            $.p("mb-4")(a:{ "data-aos":"fade-left"}, after: sub2["sub-content-2"]),
            $.a(sub2["url"]!,"button")(a:{"data-aos":"fade-up"}, after: sub2["link-text"])
          ])
        ])
      ]);
  }


}
