import 'package:shelf/shelf.dart';
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

    return 
      $.fake([
      $.div("header-wrapper pb-0")(a:{"id":"home"},c:[
        $.nav("navbar")(c:[
          $.div("navbar-brand")(c:[
            $.div("columns is-vcentered is-mobile m-1")(c:[
              $.div("column is-narrow")(c:[
                $.span("icon is-medium")(c:[
                  $.a("/")(a: {"data-aos":"fade-left"}, c:[
                    $.i("fa-solid fa-chevron-left fa-2x txt-shadow")()
                  ])
                ]),
              ]),
              $.div("column is-narrow")(c:[
                $.a("/")(a: {"data-aos":"fade-left"}, c:[
                  $.h4("title txt-shadow")( after:glob.content.isA("name"))])
              ]),
              /*$.div("column"),
              $.div("column is-narrow")(c:[
                $.div("columns is-mobile")(c: tforeach(glob.content.isADyn("contact-online"), (dynamic e){
                  return $.div("column")(c:[
                    $.span("icon is-small")(c:[
                      $.a("")(a: {"href":e[1]},c:[tagx(["i", e[0], "txt-shadow"].join(" "))])
                  ])]);
                }))
              ])*/
            ]),
          ]),
        ]),
        $.section("hero hero-sub1 is-small")(c:[
          $.div("hero-body")(c:[
            $.div("container has-text-centered")( c:[
              $.div("columns is-vcentered is-mobile")(c:[
                $.div("column is-narrow")(c:[
                  $.span("icon is-large")(c:[
                    $.a(backUrl)(a: {"data-aos":"fade-left"}, c:[
                      $.i("fa-solid fa-chevron-left fa-3x txt-shadow")()
                    ])
                  ]),
                ]),
                $.div("column")(c:[
                  $.h2("title p-5")(a:{"data-aos":"fade-down"}, after:title),
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
