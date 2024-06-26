import 'package:shelf/shelf.dart';

import 'atom.dart';
import 'html.dart';
import 'base_html.dart';
import 'utils.dart';
import 'widgets_html.dart';




class Index extends Base{


  Index(super.glob);


  Future<Response> handler(Request req) async {

    AtomEntry item = glob.blog1.random;

    List<String> render =  base(
      glob.content.isA("name"),[
      heroSection(),
      mainSection1("pt-0", [
        subContainer1("section-light", [ commentCarousel() ] ),
        mainSection(),
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
        ])
      ])
    ]);

    return Response.ok(
        render.join(),
        headers: { "content-type": "text/html"}
    );

  }





  List<String> heroSection() {

    int aosDelay = 1400;

    return tComment("\nHero Section", [
      tDiv("header-wrapper", attr:{"id":"home"},c:[
        tagx("section hero hero-index is-medium", attr:{"style":"""
          background-image: url(/img/${glob.img.pick(prefix: 'intro-')});
          background: linear-gradient(rgba(31, 44, 108, 0.65), rgba(31, 44, 108, 0.65)), rgba(0, 0, 0, 0.55) url(/img/${glob.img.pick(prefix: 'intro-')}) no-repeat;
          background-attachment: fixed;
          background-size: cover;
        """}, c:[
          tDiv("hero-body", c:[
            tDiv("container has-text-centered", c:[
              tagx("figure avatar", attr:{"id":"avatar", "data-aos":"fade-in", "data-aos-delay":"400"},  c:[
                tagx("img", attr:{"src":"/img/${glob.img.pick(prefix: 'profile-')}"})
              ]),
              tDiv("container", attr:{ "data-aos":"fade-in", "data-aos-delay":"800", "data-aos-anchor":"avatar"}, c:[
                tagx("h2 title txt-shadow",  after_c:glob.content.isA("name"))
              ]),
              tagx("h1 subtitle profession txt-shadow", attr:{"data-aos":"fade-in", "data-aos-delay":"1200", "data-aos-anchor":"avatar"}, after_c:glob.content.isA("profession")),
              tDiv("columns is-mobile is-centered p-2", c:[
                tDiv("column p-0",  c:[
                  tDiv("columns is-justify-content-center is-mobile", c: tforeach(glob.content.isADyn("contact-online"), (dynamic e){
                    aosDelay += 200;
                    return tDiv("column is-narrow px-0", attr:{"data-aos":"fade-in", "data-aos-delay":"$aosDelay", "data-aos-anchor":"avatar"}, c:[tagx("span icon is-large", c:[
                      tagx("a", attr: {"href":e[1]},c:[tagx(["i", e[0], "fa-2x", "txt-shadow"].join(" "))])
                    ])]);
                  })
                  )
                ])
              ]),
            ]),
          ]),
        ])
      ])
    ]);

  }




  List<String> mainSection() {

    return tComment("", tforeach( glob.content.isADyn("consultancies"), (dynamic e){
      return subContainer1("section-light", [
        intro1(
          e["title"],
          e["intro"],
          "/img/${glob.img.pick(prefix: e["img_prefix"])}",
          buttontext: e["link-text"],
          linkurl: e["url"],
          titled: true,
          direction: Direction.left
        )
      ]);
   }));

  }



  List<String> commentCarousel() {
    List<Map<String, String>> content = [];
    Map<String, dynamic> form1Con = glob.content.isADyn("consultancies")[0];
    Map<String, dynamic> form2Con = glob.content.isADyn("consultancies")[1];

    Map<String, String> createContent (List<Map<String, String>> rec, String subtitle, String link) {
      return {
        "comment": rec[0]["comment"]!,
        "subtitle": subtitle,
        "link": "$link/yorumlar#${rec[0]["pos"]!}",
      };
    }

    glob.form1.length>1?content.add(createContent( glob.form1.randomRecList(1), form1Con["title"]!, form1Con["url"]!)):null;
    glob.form2.length>1?content.add(createContent( glob.form2.randomRecList(1), form2Con["title"]!, form2Con["url"]!)):null;
    glob.form1.length>1?content.add(createContent( glob.form1.randomRecList(1), form1Con["title"]!, form1Con["url"]!)):null;
    glob.form2.length>1?content.add(createContent( glob.form2.randomRecList(1), form2Con["title"]!, form2Con["url"]!)):null;

    return tComment("", [
      carousel1("car", content, (Map<String, String> rec){
        return tDiv("content", c:[
          tagx("span icon is-large", c:[ tagx("i fa-regular fa-comment fa-2x", attr:{"aria-hidden":"true"})]),
          tagx("b", after_c: rec["subtitle"]),
          tagx("p indexcomment is-size-5", before_c: shortOf(rec["comment"]!,25), c:[
            rec["comment"]!.split(" ").length<=25?[]:
            tagx("a button is-rounded is-small",
              attr: {"href": rec["link"]!},
              after_c: glob.content.isA("readmore")),
          ])
        ]);
      })
    ]);

  }


}
