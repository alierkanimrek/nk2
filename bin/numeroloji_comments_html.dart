import 'package:shelf/shelf.dart';
import 'base_html.dart';
import 'tsv.dart';
import 'widgets_html.dart';




class NumerolojiComments extends Base {

  late Tsv form;
  late String title;
  late String backUrl;


  NumerolojiComments(super.glob, this.form){
    title = glob.content.isA("comm2_title");
    backUrl = glob.content.isADyn("consultancies")[1]["url"];
  }


  Future<Response> handler(Request req) async {
    List<String> render = await base(title,[
      subHero1( glob.content.isA("name"), title, backUrl: backUrl),
      mainSection1("pt-0", [
        subContainer1("section-dark", [
          theme()
        ]),
        subContainer1("section-light", [
          foot()
        ])
      ])
    ]);

    return Response.ok(render.join(),
        headers: { "content-type": "text/html"}
    );
  }





  List<String> theme() {

    return 
      $.fake([
      $.div("columns")(c:[
        $.div("column is-8 is-offset-2")(c:[ $.forEach(form.revRecList, (Map<String, String> comment){
          return
            $.div("container")(c:[
            $.a("")(a: {"id": comment["pos"]!}),
            $.div("card m-4 mb-6")(a:{"data-aos":"fade-up"}, c: [
              $.div("card-content")( c: [
                $.div("media m-0")( c:[
                  $.div("media-left")( c:[
                    $.figure("image")( c:[
                      $.i("fa-regular fa-2x fa-comment")(a:{"data-aos":"fade-right"})
                    ])
                  ]),
                  $.div("media-content")(c:[
                    $.p("title is-5")(a:{"data-aos":"fade-left"}, after: "@"+comment["nickname"]!),
                    $.p("subtitle is-7 has-text-right has-text-grey-light")(after: comment["time"]!.split(" ")[0])
                  ])
                ]),
                $.div("content")(a:{"data-aos":"fade-up"}, after: comment["comment"]),
                $.div("columns is-mobile is-justify-content-center")( c:[
                  $.div("column is-half p-0 has-text-left")( c:[
                    $.span("icon")( c:[
                      $.a(backUrl)(c:[
                        $.i("txt-shadow fa-solid fa-chevron-left")()
                      ])
                    ])
                  ]),
                  $.div("column is-half p-0 has-text-right")(c:[
                  ])
                ])
              ])
            ])
          ]);
        })])
      ])
      ]);
  }




  List<String> foot() {
    return footBack(backUrl, [
      $.div("title")(c: [ [glob.content.isADyn("consultancies")[1]["title"]] ])
    ]);
  }



}