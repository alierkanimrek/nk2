import 'dart:math';
import 'lib/decor/lib/decor.dart';
import 'carousel.dart';

Decor $ = Decor();

enum Direction {left, right}


List<String> mainSection1(String clss, List<List<String>> c, {Map<String,String>? attr, String? comment}) {
  return $.fake([
    $.comment(comment!=null?"\n$comment":""), 
    $.div("main-content "+clss)(a:attr, c: c)
  ]);
}


List<String> subContainer1(
    String clss,
    List<List<String>> c,
    {
      Map<String,String>? attr,
      String? comment
    }){

  return $.fake([
    $.comment(comment!=null?"\n$comment":""), 
    $.div(clss)(a:attr, c:[
      $.div("container")(c: [
        $.div("column is-12")( c: c)
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

  List<String> imgHtml = img!=null ? $.div("column is-6 ")(
      a:{"data-aos":direction==Direction.left?"fade-left":"fade-right"}, c:[
        $.img(img,"", "img is-rounded")()
      ]):[];

  List<String> contentHtml = $.div("column is-6 right-image")(
      a:{"data-aos":direction==Direction.left?"fade-right":"fade-left"}, c:[
        $.div("content has-text-justified")( c:[
          titled?$.h4()(after: title):[],
          $.p()(after: theme),
          hasButton?$.a(linkurl, "button")( after:buttontext):[]
        ])
      ]);

  return $.fake([
    $.comment(title),
    $.div("columns is-multiline")( c:[
      direction==Direction.left?contentHtml:imgHtml,
      direction==Direction.right?contentHtml:imgHtml
    ])
  ]);
}



List<String> subHero1(String mainTitle, String title, {String? subtitle, String? backUrl}) {

  return $.fake([
    $.comment("\nSubHero"),
    $.div("header-wrapper pb-0")( c:[
      $.nav("navbar")(c:[
        $.div("navbar-brand")( c:[
          $.div("columns is-vcentered is-mobile m-1")( c:[
            $.div("column is-narrow")( c:[
              $.span("icon is-medium")( c:[
                $.a("/")(a:{"data-aos":"fade-left"}, c:[
                  $.i("fa-solid fa-chevron-left fa-2x txt-shadow")()
                ])
              ]),
            ]),
            $.div("column is-narrow")(c:[
              $.a("/")(a: {"data-aos":"fade-left"}, c:[
                $.h4("title txt-shadow")(after:mainTitle)
              ])
            ]),
            /*$.div("column"),
              $.div("column is-narrow", c:[
                $.div("columns is-mobile", c: tforeach(glob.content.isADyn("contact-online"), (dynamic e){
                  return $.div("column", c:[
                    tagx("span icon is-small", c:[
                      tagx("a", attr: {"href":e[1]},c:[tagx(["i", e[0], "txt-shadow"].join(" "))])
                  ])]);
                }))
              ])*/
          ]),
        ]),
      ]),
      $.section("hero hero-sub1 is-small")( c:[
        $.div("hero-body")(c:[
          $.div("container has-text-centered")(c:[
            $.div("columns is-vcentered is-mobile")( c:[
              backUrl!=null?$.div("column is-narrow")( c:[
                $.span("icon is-large")(c:[
                  $.a(backUrl)(a: {"data-aos":"fade-left"}, c:[
                    $.i("fa-solid fa-chevron-left fa-3x txt-shadow")()
                  ])
                ]),
              ]):[],
              $.div("column")(c:[
                $.h2("title p-5")( a:{"data-aos":"fade-down"}, after:title),
                subtitle!=null?$.p("subtitle")( a:{"data-aos":"fade-down"}, after:subtitle):[],
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

  return $.div()(c: [
    $.div("columns")(c: [$.forEach(buttons, (Button button) {

      Map<String, String> attr = button.attr!=null?button.attr!:{};
      String iconClss = button.iconClss!=null?button.iconClss!:"";

      return $.div("column txt-centered")( c:[
        $.a(button.url, "button "+button.clss)( a:attr, c:[
          button.icon!=null?$.span("icon "+iconClss)( c:[
            $.i(button.icon!)()]):[],
          $.span()(after: button.text)
        ])
      ]);

  })])]);

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

  return $.div(containerClss!=null?containerClss:"")( c:[

    title!=null?$(
        titleClss!=null?titleClss:"h2")(
        a: titleAttr!=null?titleAttr:null,
        after: title):[],

    $.div("columns is-mobile is-vcentered m-2")(
        a: columnsAttr!=null?columnsAttr:null, c:[

      carousel(name, [

        $.div("button column is-narrow "+name+"prev")( a:{"onclick":"carousel_prev(this)", "data-aos":"fade-right"}, c:[
          $.i("fa-solid fa-chevron-left")()
        ]),

        $.div("column")(c: [$.forEach(content, (dynamic item){
          return $.div("container is-hidden "+name)( a:{ "data-aos":"fade-in"}, c:[
            wrapper(item)
          ]);

        })]),

        $.div("button column is-narrow "+name+"next")(a:{"onclick":"carousel_next(this)", "data-aos":"fade-left"}, c:[
          $.i("fa-solid fa-chevron-right")()
        ]),
      ])

    ]),
  ]);

}



List<String> footBack(String backUrl, List<List<String>> c){

  return $.div("hero-body")( c:[
    $.div("container has-text-centered")(  c:[
      $.div("columns is-vcentered is-mobile")( c:[
        $.div("column is-narrow")( c:[
          $.span("icon is-large")( c:[
            $.a(backUrl)(a: {"data-aos":"fade-left"}, c:[
              $.i("fa-solid fa-chevron-left fa-3x txt-shadow")()
            ])
          ]),
        ]),
        $.div("column")( c: c),
      ]),
    ]),
  ]);

}