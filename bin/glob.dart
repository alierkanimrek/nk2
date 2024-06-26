import 'atom.dart';
import 'config.dart';
import 'content.dart';
import 'tsv.dart';
import 'utils.dart';



class Glob{
  late Config config;
  late Content content;
  late Tsv form1;
  late Tsv form2;
  late Atom blog1;
  late ImgFiles img;

  Glob(this.config, this.content, this.form1, this.form2, this.blog1, this.img);
}
