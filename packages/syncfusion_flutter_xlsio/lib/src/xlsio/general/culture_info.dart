part of xlsio;

/// Represent the Culture Info class.
class CultureInfo {
  /// Create an instances of culture info class.
  CultureInfo(String name) {
    _culture = name;
    initializeDateFormatting(_culture, null);
    _dateTimeFormat = DateTimeFormatInfo(_culture);
    _numberFormat = NumberFormatInfo(_culture);
    _textInfo = TextInfo();
  }

  String _culture;

  NumberFormatInfo _numberFormat;
  DateTimeFormatInfo _dateTimeFormat;
  TextInfo _textInfo;

  /// Set the current culture.
  static CultureInfo currentCulture = CultureInfo('en-US');

  /// Represents NumberFormatInfo separator.
  NumberFormatInfo get numberFormat {
    return _numberFormat;
  }

  /// Represents DateTimeFormatInfo separator.
  DateTimeFormatInfo get dateTimeFormat {
    return _dateTimeFormat;
  }

  /// Represents TextInfo separator.
  TextInfo get textInfo {
    return _textInfo;
  }
}

/// Represents the Number Format Info class.
class NumberFormatInfo {
  /// Create an instances of Number Format class.
  NumberFormatInfo(String locale) {
    _locale = locale;
  }
  String _locale;
  NumberSymbols _numberSymbolsField;

  String _currencySymbolField;
  String _decimalSeparator;
  String _groupSeparator;

  /// Gets the number symbol.
  NumberSymbols get _numberSymbols {
    if (_numberSymbolsField == null) {
      _numberSymbolsField = numberFormatSymbols[_locale] as NumberSymbols;
      if (_numberSymbolsField == null && _locale.length > 2) {
        _numberSymbolsField =
            numberFormatSymbols[_locale.replaceAll('-', '_')] as NumberSymbols;
      }
      _numberSymbolsField ??=
          numberFormatSymbols[_locale.substring(0, 2)] as NumberSymbols;
    }
    return _numberSymbolsField;
  }

  /// Represents decimal separator.
  String get numberDecimalSeparator {
    if (_decimalSeparator == null) {
      if (_numberSymbols != null) {
        _decimalSeparator = _numberSymbols.DECIMAL_SEP;
      } else {
        _decimalSeparator = '.';
      }
    }

    return _decimalSeparator;
  }

  set numberDecimalSeparator(String value) {
    _decimalSeparator = value;
  }

  /// Represents group separator.
  String get numberGroupSeparator {
    if (_groupSeparator == null) {
      if (_numberSymbols != null) {
        _groupSeparator = _numberSymbols.GROUP_SEP;
      }
    } else {
      _groupSeparator = ',';
    }
    return _groupSeparator;
  }

  set numberGroupSeparator(String value) {
    _groupSeparator = value;
  }

  /// Represents Currency Symbol.
  String get _currencySymbol {
    if (_currencySymbolField == null) {
      if (_numberSymbols != null) {
        final format = NumberFormat.currency(locale: _locale);
        _currencySymbolField = format.currencySymbol;
      } else {
        _currencySymbolField = '\$';
      }
    }
    return _currencySymbolField;
  }

  // ignore: unused_element
  set _currencySymbol(String value) {
    _currencySymbolField = value;
  }
}

/// Represents the Date Time Format Info class.
class DateTimeFormatInfo {
  /// Create an instances of Date Time Format Info class.
  DateTimeFormatInfo(String locale) {
    _locale = locale;
    _dateTimeSymbols = dateTimeSymbolMap();
  }
  String _locale;
  DateSymbols _dateSymbolsField;

  /// Represents date separator.
  String _dateSeparator;

  /// Represents time separator.
  String timeSeparator = ':';

  /// The custom format string for a short date value.
  String _shortDatePattern;

  /// The custom format string for a short time value.
  String _shortTimePattern = ':';

  final _fractionSeperators = ['/', '-', '.'];

  /// Represents the DateTime symbols map.
  Map<dynamic, dynamic> _dateTimeSymbols;

  /// Maximum supported date time.
  final DateTime _maxSupportedDateTime = DateTime(9999, 12, 31);

  /// Minimum supported date time.
  // ignore: unused_field
  final DateTime _minSupportedDateTime = DateTime(0001, 01, 01);

  /// Gets the date symbols.
  DateSymbols get _dateSymbols {
    if (_dateSymbolsField == null) {
      _dateSymbolsField = _dateTimeSymbols[_locale] as DateSymbols;
      if (_dateSymbolsField == null && _locale.length > 2) {
        _dateSymbolsField =
            _dateTimeSymbols[_locale.replaceAll('-', '_')] as DateSymbols;
      }
      _dateSymbolsField ??=
          _dateTimeSymbols[_locale.substring(0, 2)] as DateSymbols;
    }
    return _dateSymbolsField;
  }

  /// Represents date separator.
  String get dateSeparator {
    if (_dateSeparator == null) {
      if (_dateSymbols != null) {
        final dateFormat = _dateSymbols.DATEFORMATS[3];
        for (final String fraction in _fractionSeperators) {
          final index = dateFormat.indexOf(fraction);
          if (index != -1) {
            _dateSeparator = dateFormat[index];
            break;
          }
        }
      } else {
        _dateSeparator = '/';
      }
    }
    return _dateSeparator;
  }

  set dateSeparator(String value) {
    _dateSeparator = value;
  }

  /// The custom format string for a short date value.
  String get shortDatePattern {
    if (_shortDatePattern == null) {
      if (_dateSymbols != null) {
        return _dateSymbols.DATEFORMATS[3];
      } else {
        _shortDatePattern = 'M/d/yyyy';
      }
    }
    return _shortDatePattern;
  }

  set shortDatePattern(String value) {
    _shortDatePattern = value;
  }

  /// The custom format string for a short time value.
  String get shortTimePattern {
    if (_shortTimePattern == null) {
      if (_dateSymbols != null) {
        return _dateSymbols.TIMEFORMATS[3];
      } else {
        _shortTimePattern = 'h:mm tt';
      }
    }
    return _shortTimePattern;
  }

  set shortTimePattern(String value) {
    _shortTimePattern = value;
  }
}

/// Represents the Text info class.
class TextInfo {
  /// Represents argument separator.
  String argumentSeparator = ',';
}