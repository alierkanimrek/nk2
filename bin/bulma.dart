
Map<String, String> bulmaTags = {
  "button":"button button"
};

String bulma(String name, String? clss){ return [bulmaTags[name],clss!].join(" "); }

