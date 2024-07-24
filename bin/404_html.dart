import 'package:shelf/shelf.dart';
import 'base_html.dart';
import 'widgets_html.dart';




class PageNotFound extends Base{

  late Map<String, dynamic> subContent;

  PageNotFound(super.glob);



  Future<Response> handler(Request req) async {


    List<String> render = base(
      glob.content.isA("404-title"),[
        subHero1(glob.content.isA("name"), glob.content.isA("404-title"), subtitle:glob.content.isA("404-intro")),
        mainSection1("pt-0", [
          button()
       ])
    ]);

    return Response.ok(
        render.join(),
        headers: { "content-type": "text/html"}
    );
  }



  List<String> button() {

    return subContainer1("section-light", [
      vButtons([
        Button(
            glob.content.isA("name"),
            "is-large is-success",
            "/",
            icon: "fa-solid fa-house",
            iconClss: "icon is-large",
            attr: {"data-aos":"fade-right"}
        )
      ])
    ]);

  }





}
