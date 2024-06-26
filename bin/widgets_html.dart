import 'dart:math';

import 'carousel.dart';
import 'html.dart';


enum Direction {left, right}


List<String> mainSection1(String clss, List<List<String>> c, {Map<String,String>? attr, String? comment}) {
  return tComment(comment!=null?"\n$comment":"", [
    tDiv("main-content "+clss, attr:attr, c: c)
  ]);
}


List<String> subContainer1(
    String clss,
    List<List<String>> c,
    {
      Map<String,String>? attr,
      String? comment
    }){

  return tComment(comment!=null?"\n$comment":"", [
    tDiv(clss, attr:attr, c:[
      tDiv("container", c: [
        tDiv("column is-12", c: c)
      ]),
    ])
  ]);

}



List<String> intro1(
    String title,
    String theme,
    String? img,
    {
      Direction? direction,
      bool? titled,
      String? buttontext,
      String? linkurl
    }){

  direction = direction==null && Random().nextInt(10)>5 ? Direction.left : Direction.right;
  titled = titled!=null ? titled : false;
  bool hasButton = linkurl!=null&&buttontext!=null ? true : false;

  List<String> imgHtml = img!=null ? tDiv("column is-6 ",
      attr:{"data-aos":direction==Direction.left?"fade-left":"fade-right"}, c:[
        tImg("img is-rounded", img)
      ]):[];

  List<String> contentHtml = tDiv("column is-6 right-image",
      attr:{"data-aos":direction==Direction.left?"fade-right":"fade-left"}, c:[
        tDiv("content has-text-justified", c:[
          titled?tagx("h4", after_c: title):[],
          tagx("p", after_c: theme),
          hasButton?tagx("a button", attr:{"href":linkurl }, after_c:buttontext):[]
        ])
      ]);

  return tComment(title, [
    tDiv("columns is-multiline", c:[
      direction==Direction.left?contentHtml:imgHtml,
      direction==Direction.right?contentHtml:imgHtml
    ])
  ]);
}



List<String> subHero1(String mainTitle, String title, {String? subtitle, String? backUrl}) {

  return tComment("\nSubHero", [
    tDiv("header-wrapper pb-0", c:[
      tagx("nav navbar", c:[
        tDiv("navbar-brand", c:[
          tDiv("columns is-vcentered is-mobile m-1", c:[
            tDiv("column is-narrow", c:[
              tagx("span icon is-medium", c:[
                tagx("a", attr: {"href":"/", "data-aos":"fade-left"}, c:[tagx("i fa-solid fa-chevron-left fa-2x txt-shadow")])
              ]),
            ]),
            tDiv("column is-narrow", c:[
              tagx("a", attr: {"href":"/", "data-aos":"fade-left"}, c:[tagx("h4 title txt-shadow", after_c:mainTitle)])
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
              backUrl!=null?tDiv("column is-narrow", c:[
                tagx("span icon is-large", c:[
                  tagx("a", attr: {"href":backUrl, "data-aos":"fade-left"}, c:[tagx("i fa-solid fa-chevron-left fa-3x txt-shadow")])
                ]),
              ]):[],
              tDiv("column", c:[
                tagx("h2 title p-5", attr:{"data-aos":"fade-down"}, after_c:title),
                subtitle!=null?tagx("p subtitle ", attr:{"data-aos":"fade-down"}, after_c:subtitle):[],
              ]),
            ]),
          ]),
        ]),
      ])

    ])
  ]);

}


class Button{

  late String text;
  late String? icon;
  late String url;
  late String clss;
  late String? iconClss;
  late Map<String, String>? attr;

  Button(this.text, this.clss, this.url, {this.icon, this.attr, this.iconClss});

}



List<String> vButtons(List<Button> buttons){

  return tDiv("", c: [
    tDiv("columns", c: tforeach(buttons, (Button button) {

      Map<String, String> attr = button.attr!=null?button.attr!:{};
      attr["href"] = button.url;
      String iconClss = button.iconClss!=null?button.iconClss!:"";

      return tDiv("column txt-centered", c:[
        tagx("a button "+button.clss,  attr: attr, c:[
          button.icon!=null?tagx("span icon "+iconClss, c:[ tagx("i "+button.icon!)]):[],
          tagx("span", after_c: button.text)
        ])
      ]);

  }))]);

}





List<String> carousel1(
    String name,
    List<dynamic> content,
    Function wrapper,
    {String? containerClss,
    String? title,
    String? titleClss,
    Map<String,String>? titleAttr,
    Map<String,String>? columnsAttr}){

  return tDiv(containerClss!=null?containerClss:"", c:[

    title!=null?tagx(
        titleClss!=null?titleClss:"h2",
        attr: titleAttr!=null?titleAttr:null,
        after_c: title):[],

    tDiv("columns is-mobile is-vcentered m-2",
        attr: columnsAttr!=null?columnsAttr:null, c:[

      carousel(name, [

        tDiv("button column is-narrow "+name+"prev", attr:{"onclick":"carousel_prev(this)", "data-aos":"fade-right"}, c:[
          tagx("i fa-solid fa-chevron-left")
        ]),

        tDiv("column", c: tforeach(content, (dynamic item){
          return tDiv("container is-hidden "+name,   attr:{ "data-aos":"fade-in"}, c:[
            wrapper(item)
          ]);

        })),

        tDiv("button column is-narrow "+name+"next", attr:{"onclick":"carousel_next(this)", "data-aos":"fade-left"}, c:[
          tagx("i fa-solid fa-chevron-right")
        ]),
      ])

    ]),
  ]);

}



List<String> footBack(String backUrl, List<List<String>> c){

  return tDiv("hero-body", c:[
    tDiv("container has-text-centered",  c:[
      tDiv("columns is-vcentered is-mobile", c:[
        tDiv("column is-narrow", c:[
          tagx("span icon is-large", c:[
            tagx("a", attr: {"href":backUrl, "data-aos":"fade-left"}, c:[
              tagx("i fa-solid fa-chevron-left fa-3x txt-shadow")
            ])
          ]),
        ]),
        tDiv("column", c: c),
      ]),
    ]),
  ]);

}