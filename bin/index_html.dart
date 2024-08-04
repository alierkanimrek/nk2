import 'package:shelf/shelf.dart';

import 'atom.dart';
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
    ], desc: glob.content.isA("desc"));

    return Response.ok(
        render.join(),
        headers: { "content-type": "text/html"}
    );

  }





  List<String> heroSection() {

    int aosDelay = 1400;

    return 
      $.fake([
      $.comment("\nHero Section"),
      $.div("header-wrapper")( a:{"id":"home"},c:[
        $.section("hero hero-index is-medium")( a:{"style":"""
          background-image: url(/img/${glob.img.pick(prefix: 'intro-')});
          background: linear-gradient(rgba(31, 44, 108, 0.65), rgba(31, 44, 108, 0.65)), rgba(0, 0, 0, 0.55) url(/img/${glob.img.pick(prefix: 'intro-')}) no-repeat;
          background-attachment: fixed;
          background-size: cover;
        """}, c:[
          $.div("hero-body")( c:[
            $.div("container has-text-centered")( c:[
              $.figure("avatar")( a:{"id":"avatar", "data-aos":"fade-in", "data-aos-delay":"400"},  c:[
                $.img("/img/${glob.img.pick(prefix: 'profile-')}", "")()
              ]),
              $.div("container")( a:{ "data-aos":"fade-in", "data-aos-delay":"800", "data-aos-anchor":"avatar"}, c:[
                $.h2("title txt-shadow")( after:glob.content.isA("name"))
              ]),
              $.h1("subtitle profession txt-shadow")( a:{"data-aos":"fade-in", "data-aos-delay":"1200", "data-aos-anchor":"avatar"}, after:glob.content.isA("profession")),
              $.div("columns is-mobile is-centered p-2")( c:[
                $.div("column p-0")( c:[
                  $.div("columns is-justify-content-center is-mobile")( c: [
                    $.forEach(glob.content.isADyn("contact-online"), (e){
                      e as List<dynamic>;
                      aosDelay += 200;
                      return
                        $.div("column is-narrow px-0")( a:{"data-aos":"fade-in", "data-aos-delay":"$aosDelay", "data-aos-anchor":"avatar"}, c:[
                          $.span("icon is-large")( c:[
                            $.a(e[1])( c:[
                              $.i([e[0], "fa-2x", "txt-shadow"].join(" "))()
                            ])
                          ])
                        ]);
                    })
                  ])
                ])
              ]),
            ]),
          ]),
        ])
      ])
    ]);

  }




  List<String> mainSection() {

    return
      $.forEach( glob.content.isADyn("consultancies"), (e){
        e as Map<String, dynamic>;
        return subContainer1("section-light", [
          intro1(
            e["title"]!,
            e["intro"]!,
            "/img/${glob.img.pick(prefix: e["img_prefix"])}",
            buttontext: e["link-text"],
            linkurl: e["url"],
            titled: true,
            direction: Direction.left
          )
        ]);
      });
  }



  List<String> commentCarousel() {
    List<Map<String, String>> content = [];
    Map<String, dynamic> form1Con = glob.content.isADyn("consultancies")[0];
    Map<String, dynamic> form2Con = glob.content.isADyn("consultancies")[1];

    Map<String, String> createContent (List<Map<String, String>> rec, String subtitle, String link) {
      return {
        "comment": rec[0]["comment"]!,
        "nickname": rec[0]["nickname"]!,
        "subtitle": subtitle,
        "link": "$link/yorumlar#${rec[0]["pos"]!}",
      };
    }

    glob.form1.length>1?content.add(createContent( glob.form1.randomRecList(1), form1Con["title"]!, form1Con["url"]!)):null;
    glob.form2.length>1?content.add(createContent( glob.form2.randomRecList(1), form2Con["title"]!, form2Con["url"]!)):null;
    glob.form1.length>1?content.add(createContent( glob.form1.randomRecList(1), form1Con["title"]!, form1Con["url"]!)):null;
    glob.form2.length>1?content.add(createContent( glob.form2.randomRecList(1), form2Con["title"]!, form2Con["url"]!)):null;

    return
       carousel1("car", content, (Map<String, String> rec){
        return $.div("content")( c:[
          $.p("has-text-weight-bold mb-2")(before: rec["subtitle"]),
          $.span("icon is-large")( c:[
            $.i("fa-regular fa-comment fa-2x")( a:{"aria-hidden":"true"})
          ]),
          $.b()(after: "@${rec["nickname"]}"),
          $.p("indexcomment is-size-5")(before: shortOf(rec["comment"]!,25), c:[
            rec["comment"]!.split(" ").length<=25
              ?[]
              :$.a( rec["link"]!,"button is-rounded")( after: glob.content.isA("readmore")),
          ])
        ]);
      });
  }


}
