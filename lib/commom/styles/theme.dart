import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff0f6681),
      surfaceTint: Color(0xff0f6681),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffbce9ff),
      onPrimaryContainer: Color(0xff004d63),
      secondary: Color(0xff126682),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffbee9ff),
      onSecondaryContainer: Color(0xff004d64),
      tertiary: Color(0xff1e6586),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffc5e7ff),
      onTertiaryContainer: Color(0xff004c6a),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff93000a),
      surface: Color(0xfff6fafd),
      onSurface: Color(0xff171c1f),
      onSurfaceVariant: Color(0xff40484c),
      outline: Color(0xff70787d),
      outlineVariant: Color(0xffc0c8cc),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2c3134),
      inversePrimary: Color(0xff8ad0ee),
      primaryFixed: Color(0xffbce9ff),
      onPrimaryFixed: Color(0xff001f29),
      primaryFixedDim: Color(0xff8ad0ee),
      onPrimaryFixedVariant: Color(0xff004d63),
      secondaryFixed: Color(0xffbee9ff),
      onSecondaryFixed: Color(0xff001f2a),
      secondaryFixedDim: Color(0xff8bd0f0),
      onSecondaryFixedVariant: Color(0xff004d64),
      tertiaryFixed: Color(0xffc5e7ff),
      onTertiaryFixed: Color(0xff001e2d),
      tertiaryFixedDim: Color(0xff91cef4),
      onTertiaryFixedVariant: Color(0xff004c6a),
      surfaceDim: Color(0xffd6dbde),
      surfaceBright: Color(0xfff6fafd),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff0f4f8),
      surfaceContainer: Color(0xffeaeef2),
      surfaceContainerHigh: Color(0xffe4e9ec),
      surfaceContainerHighest: Color(0xffdee3e6),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff003b4d),
      surfaceTint: Color(0xff0f6681),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff287591),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff003b4e),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff2a7592),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff003b53),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff327496),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff740006),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffcf2c27),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff6fafd),
      onSurface: Color(0xff0d1214),
      onSurfaceVariant: Color(0xff30373b),
      outline: Color(0xff4c5458),
      outlineVariant: Color(0xff666e73),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2c3134),
      inversePrimary: Color(0xff8ad0ee),
      primaryFixed: Color(0xff287591),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff005c76),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff2a7592),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff005c77),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff327496),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff0d5b7c),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffc2c7ca),
      surfaceBright: Color(0xfff6fafd),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff0f4f8),
      surfaceContainer: Color(0xffe4e9ec),
      surfaceContainerHigh: Color(0xffd9dde1),
      surfaceContainerHighest: Color(0xffced2d6),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff003140),
      surfaceTint: Color(0xff0f6681),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff005066),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff003040),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff005068),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff003044),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff004f6d),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff600004),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff98000a),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff6fafd),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff000000),
      outline: Color(0xff262d31),
      outlineVariant: Color(0xff424a4e),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2c3134),
      inversePrimary: Color(0xff8ad0ee),
      primaryFixed: Color(0xff005066),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff003848),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff005068),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff003749),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff004f6d),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff00374e),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffb5b9bd),
      surfaceBright: Color(0xfff6fafd),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffedf1f5),
      surfaceContainer: Color(0xffdee3e6),
      surfaceContainerHigh: Color(0xffd0d5d8),
      surfaceContainerHighest: Color(0xffc2c7ca),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xff8ad0ee),
      surfaceTint: Color(0xff8ad0ee),
      onPrimary: Color(0xff003545),
      primaryContainer: Color(0xff004d63),
      onPrimaryContainer: Color(0xffbce9ff),
      secondary: Color(0xff8bd0f0),
      onSecondary: Color(0xff003546),
      secondaryContainer: Color(0xff004d64),
      onSecondaryContainer: Color(0xffbee9ff),
      tertiary: Color(0xff91cef4),
      onTertiary: Color(0xff00344a),
      tertiaryContainer: Color(0xff004c6a),
      onTertiaryContainer: Color(0xffc5e7ff),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff0f1417),
      onSurface: Color(0xffdee3e6),
      onSurfaceVariant: Color(0xffc0c8cc),
      outline: Color(0xff8a9296),
      outlineVariant: Color(0xff40484c),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdee3e6),
      inversePrimary: Color(0xff0f6681),
      primaryFixed: Color(0xffbce9ff),
      onPrimaryFixed: Color(0xff001f29),
      primaryFixedDim: Color(0xff8ad0ee),
      onPrimaryFixedVariant: Color(0xff004d63),
      secondaryFixed: Color(0xffbee9ff),
      onSecondaryFixed: Color(0xff001f2a),
      secondaryFixedDim: Color(0xff8bd0f0),
      onSecondaryFixedVariant: Color(0xff004d64),
      tertiaryFixed: Color(0xffc5e7ff),
      onTertiaryFixed: Color(0xff001e2d),
      tertiaryFixedDim: Color(0xff91cef4),
      onTertiaryFixedVariant: Color(0xff004c6a),
      surfaceDim: Color(0xff0f1417),
      surfaceBright: Color(0xff353a3d),
      surfaceContainerLowest: Color(0xff0a0f11),
      surfaceContainerLow: Color(0xff171c1f),
      surfaceContainer: Color(0xff1b2023),
      surfaceContainerHigh: Color(0xff262b2d),
      surfaceContainerHighest: Color(0xff303538),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffabe5ff),
      surfaceTint: Color(0xff8ad0ee),
      onPrimary: Color(0xff002a37),
      primaryContainer: Color(0xff5299b6),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffaee4ff),
      onSecondary: Color(0xff002938),
      secondaryContainer: Color(0xff5499b7),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffb7e2ff),
      onTertiary: Color(0xff00293b),
      tertiaryContainer: Color(0xff5a98bc),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffd2cc),
      onError: Color(0xff540003),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff0f1417),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffd6dde2),
      outline: Color(0xffabb3b8),
      outlineVariant: Color(0xff899196),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdee3e6),
      inversePrimary: Color(0xff004e65),
      primaryFixed: Color(0xffbce9ff),
      onPrimaryFixed: Color(0xff00131c),
      primaryFixedDim: Color(0xff8ad0ee),
      onPrimaryFixedVariant: Color(0xff003b4d),
      secondaryFixed: Color(0xffbee9ff),
      onSecondaryFixed: Color(0xff00131c),
      secondaryFixedDim: Color(0xff8bd0f0),
      onSecondaryFixedVariant: Color(0xff003b4e),
      tertiaryFixed: Color(0xffc5e7ff),
      onTertiaryFixed: Color(0xff00131e),
      tertiaryFixedDim: Color(0xff91cef4),
      onTertiaryFixedVariant: Color(0xff003b53),
      surfaceDim: Color(0xff0f1417),
      surfaceBright: Color(0xff404548),
      surfaceContainerLowest: Color(0xff04080a),
      surfaceContainerLow: Color(0xff191e21),
      surfaceContainer: Color(0xff23292b),
      surfaceContainerHigh: Color(0xff2e3336),
      surfaceContainerHighest: Color(0xff393e41),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffdef3ff),
      surfaceTint: Color(0xff8ad0ee),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xff86ccea),
      onPrimaryContainer: Color(0xff000d14),
      secondary: Color(0xffdef3ff),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xff87cceb),
      onSecondaryContainer: Color(0xff000d14),
      tertiary: Color(0xffe2f2ff),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xff8dcaf0),
      onTertiaryContainer: Color(0xff000d16),
      error: Color(0xffffece9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffaea4),
      onErrorContainer: Color(0xff220001),
      surface: Color(0xff0f1417),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffffffff),
      outline: Color(0xffe9f1f6),
      outlineVariant: Color(0xffbcc4c9),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdee3e6),
      inversePrimary: Color(0xff004e65),
      primaryFixed: Color(0xffbce9ff),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xff8ad0ee),
      onPrimaryFixedVariant: Color(0xff00131c),
      secondaryFixed: Color(0xffbee9ff),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xff8bd0f0),
      onSecondaryFixedVariant: Color(0xff00131c),
      tertiaryFixed: Color(0xffc5e7ff),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xff91cef4),
      onTertiaryFixedVariant: Color(0xff00131e),
      surfaceDim: Color(0xff0f1417),
      surfaceBright: Color(0xff4c5154),
      surfaceContainerLowest: Color(0xff000000),
      surfaceContainerLow: Color(0xff1b2023),
      surfaceContainer: Color(0xff2c3134),
      surfaceContainerHigh: Color(0xff373c3f),
      surfaceContainerHighest: Color(0xff42474a),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }


  ThemeData theme(ColorScheme colorScheme) => ThemeData(
     useMaterial3: true,
     brightness: colorScheme.brightness,
     colorScheme: colorScheme,
     textTheme: textTheme.apply(
       bodyColor: colorScheme.onSurface,
       displayColor: colorScheme.onSurface,
     ),
     scaffoldBackgroundColor: colorScheme.surface,
     canvasColor: colorScheme.surface,
       appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surfaceContainer, // Uma cor de superfície com leve destaque
        foregroundColor: colorScheme.onSurface,       // Garante que o texto e os ícones na AppBar tenham a cor correta
      ),
      // Define a aparência padrão para o Drawer
      drawerTheme: DrawerThemeData(
        backgroundColor: colorScheme.surfaceContainer, // Mesma cor da AppBar para consistência
      ),
  );


  List<ExtendedColor> get extendedColors => [
  ];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
