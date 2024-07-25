import 'dart:async';
import 'dart:io';

import "package:path/path.dart";
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_static/shelf_static.dart';
import 'package:logging/logging.dart';
import 'package:logging_appenders/logging_appenders.dart';


import '404_html.dart';
import 'arhatik-yoga_html.dart';
import 'content.dart';
import 'config.dart';
import 'glob.dart';
import 'numeroloji_comments_html.dart';
import 'numeroloji_html.dart';
import 'praniksifa_comments_html.dart';
import 'praniksifaegitimi_html.dart';
import 'tsv.dart';
import 'atom.dart';
import 'blog.dart';
import 'blogitem.dart';
import 'index_html.dart';
import 'praniksifa_html.dart';
import 'utils.dart';

final String appLog = "app.log";
final String appConfig = "/etc/nk2/config.json";



void main(List<String> args) async {

  /*
    Inıt Log System
   */
  String logFn = Platform.isWindows?
  join(dirname(Platform.script.path).replaceAll("/", "\\").substring(1), appLog):
  join(dirname(Platform.script.path),appLog);

  final log = Logger('App');
  Logger.root.level = Level.ALL;

  final logfile = RotatingFileAppender(
    baseFilePath: logFn,
    formatter: DefaultLogRecordFormatter(),
    keepRotateCount: 5,
    rotateAtSizeBytes: 10 * 1024 * 1024
  );
  logfile.attachToLogger(log);

  void shelfLogger(String msg, bool isError){ isError?log.severe(msg):log.info(msg); }
  void setLogLevel(String level){
    int i = Level.LEVELS.indexWhere((element) => element.name == level);
    i>-1?log.info("Log Level : ${Level.LEVELS[i].name}"):null;
    i>-1?Logger.root.level = Level.LEVELS[i]:null;
  }

  log.info("App starting...");



  /*
  * Configuration File
  */
  log.info(appConfig);
  Config config = Config(appConfig, log);
  if(! await config.read()) {
    config = Config("config.json", log);
    await config.read() ? null : exit(-1);
  }

  setLogLevel(config.log_level());

  Timer.periodic(const Duration(minutes: 5), (timer) async{
    await config.read();
    setLogLevel(config.log_level());
  });

  Logger.root.onRecord.listen((record) {
    config.testing()=="true"?print(record.message):null;
  });



  /*
  * Contents
  */
  Content content = Content("content_tr.json", log);
  await content.read()?null:exit(-1);

  ImgFiles img = ImgFiles(join(config.static_path(),config.profile_img_path()), log);
  await img.update();


  /*
  * External Sources
  */
  Tsv form1 = Tsv(config.gform1_file(),
      log,
      config.gform1_titles().split(","),
      config.gform1_url(),
      content.isADyn("consultancies")[0]["title"]
  );
  if(! await form1.read()){ await form1.update(); }

  Tsv form2 = Tsv(config.gform2_file(),
      log,
      config.gform2_titles().split(","),
      config.gform2_url(),
      content.isADyn("consultancies")[1]["title"]
  );
  if(! await form2.read()){ await form2.update(); }

  Atom blog1 = Atom(config.blog1_file(), log, DateTime.utc(2020), config.blog1_url());
  if(! await blog1.read()){ await blog1.update(); }

  Timer.periodic(const Duration(hours: 6), (timer) async{
    await form1.update();
    await form2.update();
    await blog1.update();
    await content.read();
    await img.update();
  });








  /*
  Implements
  */
  Glob glob = Glob(config, content, form1, form2, blog1, img); // Global data container
  Index index = Index(glob);
  PranikSifa praniksifa = PranikSifa(glob);
  Numeroloji numeroloji = Numeroloji(glob);
  PranikSifaEgitimi pranikegitim = PranikSifaEgitimi(glob) ;
  ArhatikYoga arhatikyoga = ArhatikYoga(glob);
  BlogIndex blog = BlogIndex(glob, glob.blog1);
  BlogItem blogItem = BlogItem(glob, glob.blog1);
  PranikSifaComments pranikComm = PranikSifaComments(glob, glob.form1);
  NumerolojiComments numerolojiComm = NumerolojiComments(glob, glob.form2);
  PageNotFound pageNotFound = PageNotFound(glob);


  var staticHandler = Pipeline().addHandler(createStaticHandler(config.static_path()));


  final router = Router()
    ..get('/', index.handler)
    ..get('/pranik-sifa-danismanligi', praniksifa.handler)
    ..get('/numeroloji-danismanligi', numeroloji.handler)
    ..get('/pranik-sifa-egitimi', pranikegitim.handler)
    ..get('/kisisel-gelisim', arhatikyoga.handler)
    ..get('/blog', blog.handler)
    ..get('/blog/<id>', blogItem.handler)
    ..get('/pranik-sifa-danismanligi/yorumlar', pranikComm.handler)
    ..get('/numeroloji-danismanligi/yorumlar', numerolojiComm.handler)
    // Old site urls
    ..get('/danismanlik', (Request req){ return Response.found('/pranik-sifa-danismanligi');})
    ..get('/seminer', (Request req){ return Response.found('/pranik-sifa-egitimi');})
    ..get('/kisiselgelisim', (Request req){ return Response.found('/kisisel-gelisim');})
    ..get('/danismanlik/yorum', (Request req){ return Response.found('/pranik-sifa-danismanligi/yorumlar');})
    // 404
    ..get('/<.*>', pageNotFound.handler);


  final ip = InternetAddress.anyIPv4;

  final cascade = Cascade()
    .add(staticHandler)
    .add(router.call);

  final server = await serve(
      logRequests(logger: shelfLogger).addHandler(cascade.handler),
      ip,
      int.parse(config.server_port()));

  log.info('Server listening on port ${server.port}');
}
