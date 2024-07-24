import 'package:shelf/shelf.dart';
import 'base_html.dart';
import 'utils.dart';
import 'widgets_html.dart';




class Numeroloji extends Base{

  late Map<String, dynamic> subContent;

  Numeroloji(super.glob){
    subContent = glob.content.isADyn("consultancies")[1];
  }



  Future<Response> handler(Request req) async {

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
          )
        ]),
        glob.form2.length>2?subContainer1("section-dark", [
          commentCarousel(),
          buttons()
        ]):subContainer1("section-dark", [
          button()
        ]),
        subContainer1("section-light", [ sub1() ]),
      ])
    ]);

    return Response.ok(
        render.join(),
        headers: { "content-type": "text/html"}
    );
  }




  List<String> commentCarousel() {
    return
      $.div("container")(c:[
        $.h1("title has-text-centered section-title")( a:{ "data-aos":"fade-down"}, after: subContent["sub-title-1"]),
        carousel1("car", glob.form2.randomRecList(3), (Map<String, String> rec){
          return
            $.p()(before: shortOf(rec["comment"]!,25), c:[
              rec["comment"]!.split(" ").length<=25
                ?[]
                :$.a("/numeroloji-danismanligi/yorumlar#${rec["pos"]!}", "button is-rounded is-small")(after: glob.content.isA("readmore")),
            ]);
        })
      ]);
  }



  List<String> buttons() {

    return vButtons([
      Button(
          glob.content.isA("readall"),
          "is-large is-info ",
          "/numeroloji-danismanligi/yorumlar",
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




  List<String> sub1() {
    return
      $.fake([
        $.h1("title has-text-centered section-title")(a:{ "data-aos":"fade-down"}, after: subContent["sub-title-3"]),
        $.div("block")( c:[
          $.p("has-text-centered mb-5")( a:{ "data-aos":"fade-up"}, after: subContent["sub-content-3"]),
            vButtons([
              Button(
                  glob.content.isA("dm-on-instagram"),
                  "is-large",
                  glob.content.isADyn("contact-online")[0][1],
                  icon: glob.content.isADyn("contact-online")[0][0],
                  iconClss: "icon is-large",
                  attr: {"data-aos":"fade-right"}
              ),
              Button(
                  glob.content.isA("tomail"),
                  "is-large",
                  glob.content.isADyn("contact-online")[4][1],
                  icon: glob.content.isADyn("contact-online")[4][0],
                  iconClss: "icon is-large",
                  attr: {"data-aos":"fade-left"}
              )
            ])
        ])
    ]);
  }

}
