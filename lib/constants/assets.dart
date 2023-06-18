/// Consolidates SCG image paths in their own class, hints to the UI to use an SvgPicture to render
class SvgPaths {
  static String compassFull = '${ImagePaths.common}/cocktail.svg';
  static String compassSimple = '${ImagePaths.common}/cocktail.svg';
}

/// Consolidates raster image paths used across the app
class ImagePaths {
  static String root = 'assets/images';
  static String common = 'assets/images/_common';

  static String introOne = '$common/intro_one.png';
  static String introTwo = '$common/intro_two.png';
  static String introThree = '$common/intro_three.png';
  static String introFour = '$common/intro_four.png';

  static String cloud = '$common/cloud-white.png';

  static String collectibles = '$root/collectibles';
  static String particle = '$common/particle-21x23.png';
  static String ribbonEnd = '$common/ribbon-end.png';

  static String textures = '$common/texture';
  static String icons = '$common/icons';

  static String roller1 = '$textures/roller-1-white.gif';
  static String roller2 = '$textures/roller-2-white.gif';

  static String appLogo = '$common/app-logo.png';
  static String appLogoPlain = '$common/app-logo-plain.png';
}
