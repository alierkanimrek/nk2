import 'glob.dart';
import 'html.dart';




class Base {

  late Glob glob;


  Base(this.glob);


  List<String> base(
    String title,
    List<List<String>> body,
    {String? desc}) {


    return tagx("!doctype", attr: {"@": "html"}, end: false, c: [
      tagx("html", c: [
        tagx("head", c: [
          tagx("meta", attr:{"charset":"utf-8"}, end: false ),
          tagx("meta", attr:{"http-equiv":"X-UA-Compatible", "content":"IE=edge"}, end: false ),
          tagx("meta", attr:{"name":"viewport", "content":"width=device-width, initial-scale=1"}, end: false),
          tagx("link", attr:{"rel":"icon", "type":"image/png", "href":"favicon.png"}, end: false ),

          tagx("title", after_c: title),
          tagx("meta", attr:{"name": "description", "content": desc ?? "" }),

          glob.config.testing!="true"?production():[],

          tagx("link", attr: {"rel": "stylesheet", "href": "https://cdn.jsdelivr.net/npm/bulma@1.0.0/css/bulma.min.css"}, end: false),
          tagx("script", attr: {"src": "https://kit.fontawesome.com/bc898b5c24.js",  "crossorigin":"anonymous"}),
          tagx("script", attr: {"src": "https://code.jquery.com/jquery-3.7.1.slim.min.js", "integrity": "sha256-kmHvs0B+OpCW5GVHUNjv9rOmY0IvSIRcf7zGUDTDQM8=", "crossorigin":"anonymous"}),
          tagx("link", attr: {"rel": "stylesheet", "href":"https://unpkg.com/aos@next/dist/aos.css"}, end:false),
          tagx("link", attr: {"rel": "stylesheet", "href":"/${glob.config.lib_path}/base.css"}, end:false),
          tagx("script", attr:{"src":"/${glob.config.lib_path}/carousel.js"})
        ]),
        tagx("body", /*attr:{"data-aos":"fade-in", "easing":"lineer"},*/ c: body),
        footer(),
        lastScripts()
      ])
    ]);

  }




  List<String> footer() {
    return tComment("\n\nFooter", [
      tDiv("footer", attr:{"id":"footer"}, c:[
        tDiv("columns p-5", c:[

          tDiv("column is-full has-text-centered is-fixed-top", c:[
            tDiv("columns", c:[
              tDiv("column is-half",  c:[
                tDiv("card", c:[
                  tDiv("card-header", c:[
                    tagx("p card-header-title", attr:{"style":"font-size: 1.5rem;display: block;"}, after_c: "Nuray Kaya Farkındalık Merkezi"),
                  ]),
                  tDiv("card-image", c:[
                    tagx("figure image", c:[
                      tagx("iframe", attr:{"src": glob.content.isADyn("contact")[2][1], "frameborder":"0", "style":"border:0; width:100%;", "allowfullscreen":""})
                    ])
                  ]),
                  tDiv("card-content", c:[
                    tDiv("media", c:[
                      tDiv("media-content", c:[
                        tagx("p title is-5", after_c: glob.content.isADyn("contact")[1][1]),

                      ])
                    ]),
                  ]),

                ])

            ]),
              tDiv("column is-half", c:[
                tDiv("fixet-grid", c:[
                  tDiv("grid", c: tforeach(glob.content.isADyn("contact-online"), (dynamic e){
                    return tDiv("cell m-4", c:[tagx("a", attr: {"href":e[1]}, c:[
                      tagx("span icon is-large m-4",c:[tagx(["i", e[0], "fa-4x", "txt-shadow"].join(" "))])
                    ])]);
                  }))
                ])
              ])
          ]),

          tDiv("column is-full has-text-centered is-fixed-top",  c:[
            tagx("p cc", before_c: glob.content.isA("cc")+"<br>", c:[
              tagx("a", attr: {"href":glob.content.isA("cc-url")}, c:[
                tImg("cc-img", glob.content.isA("cc-logo"))
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
    return tComment("\n\nScripts", [
      tagx("script", attr:{"src":"https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"}),
      /*tagx("script", attr:{"src":"base.js"}),*/
      tagx("script", attr:{"src":"https://unpkg.com/aos@next/dist/aos.js"}),
      tagx("script", after_c: '''
          AOS.init({
            easing: "ease-out",
            duration: 800,
          });
       ''')
    ]);
  }



  List<String> sign() {
    return tComment("\n", [
      tDiv("container is-size-7 has-text-right", c:[
        tagx("label has-text-link", after_c: "by CookieMonster"),
        tagx("a py-0 pl-1 pr-3", attr:{"href":"https://github.com/alierkanimrek", "target":"_blank"}, c:[
          tagx("span icon is-small m-0", c:[
            tagx("i fab fa-github has-text-link", attr:{"aria-hidden":"true"})
          ])
        ])
      ])
    ]);
  }


  List<String> production(){
    return tComment("\n", [
      tagx("script", attr:{"async": "async", "src": "https://www.googletagmanager.com/gtag/js?id=UA-164503829-1"}),
      tagx("script", after_c: '''
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