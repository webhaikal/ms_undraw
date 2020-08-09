import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

part 'model.dart';

void main(List<String> args) async {
  print('Downloading undraw illustration list');
  final timestamp = DateTime.now();
  final _illustrations = await _getIllustrations();
  print(
      '${_illustrations.length} undraw illustration list downloaded in ${DateTime.now().difference(timestamp)}');

  print('Transforming enums');
  final _enumList = _getEnuns(_illustrations);
  print('Enums transformed');

  final _baseUrl =
      'https://42f2671d685f51e10fc6-b9fcecea3e50b3b59bdc28dead054ebc.ssl.cf5.rackcdn.com/illustrations';

  print('Transforming illustrations');
  final _identifierAndUrl = _getIdentifierAndUrl(_illustrations);
  print('Illustrations transformed');

  print('Writing in file');
  await _updateFile(_enumList, _baseUrl, _identifierAndUrl);
  print('File writed');

  print('Formatting file');
  await Process.run(
      'dartfmt.bat', ['-w', '--fix', '.\\lib\\illustrations.g.dart']);
  print('File formatted');
}

Future<List<IllustrationElement>> _getIllustrations() async {
  var _isEnd = false;
  var _page = 0;
  List<IllustrationElement> _illustrations = [];
  do {
    print('Downloading page $_page');
    final http.Response response =
        await http.get("https://undraw.co/api/illustrations?page=$_page");
    final illustrations = Illustration.fromMap(jsonDecode(response.body));
    _isEnd = illustrations.hasMore;
    _page = illustrations.nextPage;
    _illustrations.addAll(illustrations.illustrations);
  } while (_isEnd);
  return _illustrations;
}

List<String> _getEnuns(List<IllustrationElement> illustrations) =>
    (illustrations..sort((ia, ib) => ia.title.compareTo(ib.title)))
        .map((illustration) {
      return '''
/// Title: ${illustration.title}
/// Slug: ${illustration.slug}
/// ![](${illustration.image})
${_kebabCase(illustration.title)}''';
    }).toList();

final _startNum = RegExp(r"^\d");

String _kebabCase(String value) => value
    .toLowerCase()
    .trim()
    .replaceAll(' ', '_')
    .replaceAll('-', '_')
    .replaceAllMapped(_startNum, (match) => '_${match.group(0)}')
    .replaceFirst('void', 'void_');

List<String> _getIdentifierAndUrl(List<IllustrationElement> illustrations) =>
    illustrations
        .map((ill) =>
            "{'url': '\$baseUrl/${ill.image.split('/').last}','identifier': '${_kebabCase(ill.title)}'}")
        .toList();

Future _updateFile(
    List<String> enuns, String baseUrl, List<String> identifierAndUrl) async {
  final File _illustrations = File('./lib/illustrations.g.dart');
  final content = '''
// ignore_for_file: unused_field
/// Enums to help locate the correct illustration
enum UnDrawIllustration {${enuns.join(',')}}

/// Base url for the illustrations
const baseUrl = "$baseUrl";

/// List of illustrations with url to download
List<Map<String, String>> illustrationList = [${identifierAndUrl.join(',')}];
''';
  if (!await _illustrations.exists())
    await _illustrations.create(recursive: true);
  await _illustrations.writeAsString(content,
      encoding: Encoding.getByName('utf-8'));
}
