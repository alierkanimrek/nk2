import 'lib/decor/lib/decor.dart';
import 'glob.dart';





class Base {

  late Glob glob;
  Decor $ = Decor();


  Base(this.glob);


  List<String> base(
    String title,
    List<List<String>> body,
    {String? desc}) {


    return
      $.html( c:[
        $.head( c:[
          $.meta({"charset":"utf-8"}),
          $.meta({"http-equiv":"X-UA-Compatible", "content":"IE=edge"} ),
          $.meta({"name":"viewport", "content":"width=device-width, initial-scale=1"}),
          $.link({"rel":"icon", "type":"image/png", "href":"favicon.png"}),
          $.title(title, desc??""),

          glob.config.testing()!="true"?production():[],

          $.link({"rel": "stylesheet", "href": "https://cdn.jsdelivr.net/npm/bulma@1.0.0/css/bulma.min.css"}),
          $.script("", {"src": "https://kit.fontawesome.com/bc898b5c24.js",  "crossorigin":"anonymous"}),
          $.script("", {"src": "https://code.jquery.com/jquery-3.7.1.slim.min.js", "integrity": "sha256-kmHvs0B+OpCW5GVHUNjv9rOmY0IvSIRcf7zGUDTDQM8=", "crossorigin":"anonymous"}),
          $.link({"rel": "stylesheet", "href":"https://unpkg.com/aos@next/dist/aos.css"}),
          $.link({"rel": "stylesheet", "href":"/${glob.config.lib_path()}/base.css"}),
          $.script("", {"src":"/${glob.config.lib_path()}/carousel.js"})
        ]),
        $.body()(c: body),
        footer(),
        lastScripts()
    ]);

  }




  List<String> footer() {
    return 
      $.fake([
      $.comment("\nFooter"),  
      $.div("footer")( a:{"id":"footer"}, c:[
        $.div("columns p-5")( c:[
          $.div("column is-full has-text-centered is-fixed-top")(c:[
            $.div("columns")( c:[
              $.div("column is-half")( c:[
                $.div("card")( c:[
                  $.div("card-header")( c:[
                    $.p("card-header-title")( a:{"style":"font-size: 1.5rem;display: block;"}, after: "Nuray Kaya Farkındalık Merkezi"),
                  ]),
                  $.div("card-image")( c:[
                    $.figure("image")( c:[
                      $.iframe("iframe")( a:{"src": glob.content.isADyn("contact")[2][1], "frameborder":"0", "style":"border:0; width:100%;", "allowfullscreen":""})
                    ])
                  ]),
                  $.div("card-content")( c:[
                    $.div("media")( c:[
                      $.div("media-content")( c:[
                        $.p("title is-5")(after: glob.content.isADyn("contact")[1][1]),
                      ])
                    ]),
                  ]),

                ])
            ]),
            $.div("column is-half")( c:[
              $.div("fixet-grid")( c:[
                $.div("grid")( c:[
                  $.forEach(glob.content.isADyn("contact-online"), (e){
                    e as List<dynamic>;
                    return
                      $.div("cell m-4")( c:[
                        $.a(e[1])( c:[
                          $.span("icon is-large m-4")(c:[
                            $.i([e[0], "fa-4x", "txt-shadow"].join(" "))()
                          ])
                        ])
                      ]);
                    }
                  )
                ])
              ])
            ])
          ]),
          $.div("column is-full has-text-centered is-fixed-top")( c:[
            $.p("cc")( before: glob.content.isA("cc")+"<br>", c:[
              $.a(glob.content.isA("cc-url"))( c:[
                $.img(glob.content.isA("cc-logo"), "Creative Commons","cc-img")()
              ])
            ])
          ])
        ])
      ]),
      sign()
    ])
    ]);

  }



  List<String> lastScripts() {
    return
      $.fake([
        $.comment("\nScripts"),
        $.script("",{"src":"https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"}),
        $.script("",{"src":"https://unpkg.com/aos@next/dist/aos.js"}),
        $.script('''
          AOS.init({
            easing: "ease-out",
            duration: 800,
          });
       ''')
    ]);
  }



  List<String> sign() {
    return
      $.div("container is-size-7 has-text-right")( c:[
        $.label("","has-text-link")(after: "by CookieMonster"),
        $.a("https://github.com/alierkanimrek/nk2", "py-0 pl-1 pr-3")(a:{"target":"_blank"}, c:[
          $.span("icon is-small m-0")( c:[
            $.i("fab fa-github has-text-link")( a:{"aria-hidden":"true"})
          ])
        ])
      ]);
  }


  List<String> production(){
    return 
      $.fake([
      $.script("", {"async": "async", "src": "https://www.googletagmanager.com/gtag/js?id=UA-164503829-1"}),
      $.script('''
        //<![CDATA[
        window.dataLayer = window.dataLayer || [];
        function gtag(){dataLayer.push(arguments);}
        gtag('js', new Date());
        gtag('config', 'UA-164503829-1');
        //]]>
      ''')
    ]);
  }


}