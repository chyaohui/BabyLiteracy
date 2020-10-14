import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:xml/xml.dart';
import 'package:flutter/services.dart';

/// An example widget which uses an [SvgOverride] widget to render an SVG with dynamic colors.
//class ZenButtonCookie extends StatelessWidget {
//  final CookieColor color; // My internal color object. Adapt this for your needs.
//  const ZenButtonCookie(this.color);
//
//  @override
//  Widget build(BuildContext context) {
//    return SvgOverride(
//      "path/to/svg.svg",
//      hash(path, color),
//          (elem) => processElement(elem, color),
//    );
//  }
//
//  /// Ensure that the hash uniquely represents the XML transformations performed.
//  static hash(String svgPath, CookieColor color) => hashValues(svgPath, color?.base, color?.edge);
//
//  // Do XML attributes manipulation magic here
//  static processElement(XmlElement elem, CookieColor color) {
//    var setAttr = SvgOverride.setAttr;
//    var getHex = SvgOverride.getHex;
//
//    switch (elem.getAttribute('class')) {
//      case 'base':
//        setAttr(elem, "fill", getHex(color?.base));
//        break;
//      case 'edge':
//        setAttr(elem, "fill", getHex(color?.edge));
//        break;
//    }
//  }
//}

/// A SVG widget which allows the ability to override SVG element attributes.
class SvgOverride extends SvgPicture {

  /// Ensure that [cacheHash] uniquely represents the XML transformations performed.
  SvgOverride(
      String svgPath,
      int cacheHash,
      void Function(XmlElement) processElement, {
        double width = double.infinity,
        double height = double.infinity,
        BoxFit fit = BoxFit.contain,
        Alignment alignment = Alignment.center,
        bool canDrawOutOfView = false,
      }) : super(
    DynamicAssetPicture(
      svgPath,
      cacheHash,
      svgOverrideDecoder(processElement, canDrawOutOfView),
    ),
    width: width,
    height: height,
    fit: fit,
    alignment: alignment,
    allowDrawingOutsideViewBox: canDrawOutOfView,
  );

  /// Updates XMLs attributes of an SVG before parsing the SVG itself.
  static svgOverrideDecoder(
      void Function(XmlElement) processElement, canDrawOutOfView) =>
          (String raw, ColorFilter colorFilter, String key) async {
        raw = parseXmlFromString(raw, processElement);
        return svg.svgPictureStringDecoder(
            raw, canDrawOutOfView, colorFilter, key);
      };

  /// Parses an XML from a string and processes the attributes.
  static String parseXmlFromString(
      String xml, void Function(XmlElement) processElement) {
    var root = parse(xml);
    var elements = root.descendants.whereType<XmlElement>();
    elements.forEach(processElement);
    return root.toXmlString();
  }

  /// Sets the value of an attribute or creates the attribute if it doesn't exist.
  static setAttr(XmlElement elem, String attr, String value) {
    var attribute = elem.getAttributeNode(attr);
    if (attribute == null) {
      attribute = XmlAttribute(XmlName(attr), value);
      elem.attributes.add(attribute);
    } else {
      attribute.value = value;
    }
  }

  /// Converts a color into a hex string. Prefixes a cacheHash sign if [leadingHashSign] is true.
  static String getHex(Color color, {bool leadingHashSign = true}) =>
      color == null
          ? ""
          : '${leadingHashSign ? '#' : ''}'
          '${color.alpha.toRadixString(16).padLeft(2, '0')}'
          '${color.red.toRadixString(16).padLeft(2, '0')}'
          '${color.green.toRadixString(16).padLeft(2, '0')}'
          '${color.blue.toRadixString(16).padLeft(2, '0')}';
}

class DynamicAssetPicture extends ExactAssetPicture {
  final int cacheHash;
  const DynamicAssetPicture(
      String assetName, this.cacheHash, PictureInfoDecoder<String> decoder)
      : super(decoder, assetName);

  @override
  Future<OverrideSvgKey> obtainKey(PictureConfiguration picture) {
    return SynchronousFuture<OverrideSvgKey>(
      OverrideSvgKey(
        bundle: bundle ?? picture.bundle ?? rootBundle,
        name: keyName,
        colorFilter: colorFilter,
        cacheHash: cacheHash,
      ),
    );
  }

  @override
  bool operator ==(dynamic other) =>
      runtimeType == other.runtimeType && cacheHash == other.cacheHash;

  @override
  int get hashCode => hashValues(super.hashCode, cacheHash);
}

class OverrideSvgKey extends AssetBundlePictureKey {
  final int cacheHash;
  const OverrideSvgKey(
      {AssetBundle bundle, String name, ColorFilter colorFilter, this.cacheHash})
      : super(bundle: bundle, name: name, colorFilter: colorFilter);

  @override
  bool operator ==(dynamic other) => hashCode == other.hashCode;

  @override
  int get hashCode => hashValues(super.hashCode, cacheHash);
}