import 'html.dart';



List<String> carousel(String className, List<List<String>>? c) {
  List<String> content = ['<!-- Carousel for $className -->'];
  c?.forEach((child) { for (var c in child) { content.add("$c"); } });
  content.add('''<script>
    carousel_init("$className");
  <\/script>''');
  return content;
}

