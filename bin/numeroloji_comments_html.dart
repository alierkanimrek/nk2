import 'package:shelf/shelf.dart';
import 'html.dart';
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

    return tComment("\n\n", [
      tDiv("columns", c:[
        tDiv("column is-8 is-offset-2", c: tforeach(form.revRecList, (Map<String, String> comment){

          return tDiv("container", c:[
            tagx("a", attr: {"id": comment["pos"]!}),
            tDiv("card m-4 mb-6", attr:{"data-aos":"fade-up"}, c: [
              tDiv("card-content", c: [
                tDiv("media m-0",  c:[
                  tDiv("media-left", c:[
                    tagx("figure image", c:[
                      tagx("i fa-regular fa-2x fa-comment", attr:{"data-aos":"fade-right"})
                    ])
                  ]),
                  tDiv("media-content",  c:[
                    tagx("p title is-5", attr:{"data-aos":"fade-left"}, after_c: "@"+comment["nickname"]!),
                    tagx("p subtitle is-7 has-text-right has-text-grey-light", after_c: comment["time"]!.split(" ")[0])
                  ])
                ]),
                tagx("div content", attr:{"data-aos":"fade-up"}, after_c: comment["comment"]),
                tDiv("columns is-mobile is-justify-content-center", c:[
                  tDiv("column is-half p-0 has-text-left", c:[
                    tagx("span icon", c:[
                      tagx("a", attr: {"href":backUrl},c:[tagx("i txt-shadow fa-solid fa-chevron-left")])
                    ])
                  ]),
                  tDiv("column is-half p-0 has-text-right", c:[
                  ])
                ])
              ])
            ])
          ]);
        }))
      ])
    ]);
  }




  List<String> foot() {
    return footBack(backUrl, [
      tDiv("title", c: [ [glob.content.isADyn("consultancies")[1]["title"]] ])
    ]);
  }



}