import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:math_keyboard/src/foundation/node.dart';

/// Class representing a button configuration.
abstract class KeyboardButtonConfig {
  /// Constructs a [KeyboardButtonConfig].
  const KeyboardButtonConfig({
    this.flex,
    this.keyboardCharacters = const [],
  });

  /// Optional flex.
  final int? flex;

  /// The list of [RawKeyEvent.character] that should trigger this keyboard
  /// button on a physical keyboard.
  ///
  /// Note that the case of the characters is ignored.
  ///
  /// Special keyboard keys like backspace and arrow keys are specially handled
  /// and do *not* require this to be set.
  ///
  /// Must not be `null` but can be empty.
  final List<String> keyboardCharacters;
}

/// Class representing a button configuration for a [FunctionButton].
class BasicKeyboardButtonConfig extends KeyboardButtonConfig {
  /// Constructs a [KeyboardButtonConfig].
  const BasicKeyboardButtonConfig(
      {required this.label,
      required this.value,
      this.args,
      this.asTex = false,
      this.highlighted = false,
      List<String> keyboardCharacters = const [],
      int? flex,
      this.width})
      : super(
          flex: flex,
          keyboardCharacters: keyboardCharacters,
        );

  /// The label of the button.
  final String label;

  /// The value in tex.
  final String value;

  /// List defining the arguments for the function behind this button.
  final List<TeXArg>? args;

  /// Whether to display the label as TeX or as plain text.
  final bool asTex;

  /// The highlight level of this button.
  final bool highlighted;

  /// The width of the button, for large operators
  final double? width;
}

/// Class representing a button configuration of the Delete Button.
class DeleteButtonConfig extends KeyboardButtonConfig {
  /// Constructs a [DeleteButtonConfig].
  DeleteButtonConfig({int? flex}) : super(flex: flex);
}

/// Class representing a button configuration of the Previous Button.
class PreviousButtonConfig extends KeyboardButtonConfig {
  /// Constructs a [DeleteButtonConfig].
  PreviousButtonConfig({int? flex}) : super(flex: flex);
}

/// Class representing a button configuration of the Next Button.
class NextButtonConfig extends KeyboardButtonConfig {
  /// Constructs a [DeleteButtonConfig].
  NextButtonConfig({int? flex}) : super(flex: flex);
}

/// Class representing a button configuration of the Submit Button.
class SubmitButtonConfig extends KeyboardButtonConfig {
  /// Constructs a [SubmitButtonConfig].
  SubmitButtonConfig({int? flex}) : super(flex: flex);
}

/// Class representing a button configuration of the Page Toggle Button.
class PageButtonConfig extends KeyboardButtonConfig {
  /// Constructs a [PageButtonConfig].
  const PageButtonConfig({int? flex}) : super(flex: flex);
}

/// List of keyboard button configs for the digits from 0-9.
///
/// List access from 0 to 9 will return the appropriate digit button.
final _digitButtons = [
  for (var i = 0; i < 10; i++)
    BasicKeyboardButtonConfig(
      label: '$i',
      value: '$i',
      keyboardCharacters: ['$i'],
    ),
];

const _decimalButton = BasicKeyboardButtonConfig(
  label: '.',
  value: '.',
  keyboardCharacters: ['.', ','],
  highlighted: true,
);

const _subtractButton = BasicKeyboardButtonConfig(
  label: '−',
  value: '-',
  keyboardCharacters: ['-'],
  highlighted: true,
);

/// Keyboard showing extended functionality.
final functionKeyboard = [
  [
    const BasicKeyboardButtonConfig(
      label: r'\frac{\Box}{\Box}',
      value: r'\frac',
      args: [TeXArg.braces, TeXArg.braces],
      asTex: true,
    ),
    const BasicKeyboardButtonConfig(
      label: r'\Box^2',
      value: '^2',
      args: [TeXArg.braces],
      asTex: true,
    ),
    const BasicKeyboardButtonConfig(
      label: r'\Box^{\Box}',
      value: '^',
      args: [TeXArg.braces],
      asTex: true,
      keyboardCharacters: [
        '^',
        // This is a workaround for keyboard layout that use ^ as a toggle key.
        // In that case, "Dead" is reported as the character (e.g. for German
        // keyboards).
        'Dead',
      ],
    ),
    const BasicKeyboardButtonConfig(
      label: r'\Box_{\Box}',
      value: '_',
      args: [TeXArg.braces],
      asTex: true,
      keyboardCharacters: [
        '_',
      ],
    ),
    const BasicKeyboardButtonConfig(
      label: r'\sin',
      value: r'\sin(',
      asTex: true,
      keyboardCharacters: ['s'],
    ),
    const BasicKeyboardButtonConfig(
      label: r'\arcsin',
      value: r'\arcsin(',
      width: 77,
      asTex: true,
    ),
    const BasicKeyboardButtonConfig(
      label: r'\lim_{\Box}{\Box}', // TODO: add automatic \to two nodes
      width: 90,
      value: r'\lim_',
      asTex: true,
      args: [
        TeXArg.braces,
        TeXArg.braces,
      ],
    ),
    const BasicKeyboardButtonConfig(
      label: r'\to',
      value: r'\to',
      asTex: true,
    ),
    
  ],
  [
    const BasicKeyboardButtonConfig(
      label: r'f(\Box)',
      value: r'f',
      asTex: true,
      args: [TeXArg.parentheses],
    ),
    const BasicKeyboardButtonConfig(
      label: r'\sqrt{\Box}',
      value: r'\sqrt',
      args: [TeXArg.braces],
      asTex: true,
      keyboardCharacters: ['r'],
    ),
    const BasicKeyboardButtonConfig(
      label: r'\sqrt[\Box]{\Box}',
      value: r'\sqrt',
      args: [TeXArg.brackets, TeXArg.braces],
      asTex: true,
    ),
    const BasicKeyboardButtonConfig(
      label: r'\cos',
      value: r'\cos(',
      asTex: true,
      keyboardCharacters: ['c'],
    ),
    const BasicKeyboardButtonConfig(
      label: r'\arccos',
      value: r'\arccos(',
      width: 77,
      asTex: true,
    ),
    const BasicKeyboardButtonConfig(
      label: r'\int_{\Box}^{\Box}{\Box}',
      width: 90,
      value: r'\int',
      asTex: true,
      args: [
        TeXArg.integral_a,
        TeXArg.integral_b,
        TeXArg.braces,
      ],
    ),
    const BasicKeyboardButtonConfig(
      label: r'\int{\Box}',
      value: r'\int',
      asTex: true,
      args: [
        TeXArg.braces,
      ],
    ),
  ],
  [
    const BasicKeyboardButtonConfig(
      label: r'\log_{\Box}(\Box)',
      value: r'\log_',
      width: 100,
      asTex: true,
      args: [TeXArg.braces, TeXArg.parentheses],
    ),
    const BasicKeyboardButtonConfig(
      label: r'\ln(\Box)',
      value: r'\ln(',
      asTex: true,
      keyboardCharacters: ['l'],
    ),
    const BasicKeyboardButtonConfig(
      label: r'\tan',
      value: r'\tan(',
      asTex: true,
      keyboardCharacters: ['t'],
    ),
    const BasicKeyboardButtonConfig(
      label: r'\arctan',
      value: r'\arctan(',
      width: 77,
      asTex: true,
    ),
    const BasicKeyboardButtonConfig(
      label: r'\pm',
      value: r'\pm',
      asTex: true,
    ),
    const BasicKeyboardButtonConfig(
      label: r'\infty',
      value: r'\infty',
      asTex: true,
    ),
    const BasicKeyboardButtonConfig(
      label: r'\frac{d}{dx}(\Box)',
      value: r'\frac{d}{dx}',
      width: 90,
      asTex: true,
      args: [TeXArg.parentheses],
    ),
  ],
  [
    const PageButtonConfig(flex: 3),
    const BasicKeyboardButtonConfig(
      label: '(',
      value: '(',
      highlighted: true,
      keyboardCharacters: ['('],
    ),
    const BasicKeyboardButtonConfig(
      label: ')',
      value: ')',
      highlighted: true,
      keyboardCharacters: [')'],
    ),
    PreviousButtonConfig(),
    NextButtonConfig(),
    DeleteButtonConfig(),
  ],
];

/// Standard keyboard for math expression input.
final standardKeyboard = [
  [
    _digitButtons[7],
    _digitButtons[8],
    _digitButtons[9],
    const BasicKeyboardButtonConfig(
      label: '×',
      value: r'\cdot',
      keyboardCharacters: ['*'],
      highlighted: true,
    ),
    const BasicKeyboardButtonConfig(
      label: '÷',
      value: r'\frac',
      keyboardCharacters: ['/'],
      args: [TeXArg.braces, TeXArg.braces],
      highlighted: true,
    ),
    const BasicKeyboardButtonConfig(
      label: r'<',
      value: r'<',
      asTex: true,
      highlighted: true,
    ),
  ],
  [
    _digitButtons[4],
    _digitButtons[5],
    _digitButtons[6],
    const BasicKeyboardButtonConfig(
      label: '+',
      value: '+',
      keyboardCharacters: ['+'],
      highlighted: true,
    ),
    _subtractButton,
    const BasicKeyboardButtonConfig(
      label: r'\leq',
      value: r'{\leq}',
      asTex: true,
      highlighted: true,
    ),
  ],
  [
    _digitButtons[1],
    _digitButtons[2],
    _digitButtons[3],
    const BasicKeyboardButtonConfig(
      label: '=',
      value: r'=',
      keyboardCharacters: ['='],
      highlighted: true,
    ),
    DeleteButtonConfig(),
    const BasicKeyboardButtonConfig(
      label: r'>',
      value: r'>',
      asTex: true,
      highlighted: true,
    ),
    
  ],
  [
    const PageButtonConfig(),
    _digitButtons[0],
    PreviousButtonConfig(),
    NextButtonConfig(),
    SubmitButtonConfig(),
    const BasicKeyboardButtonConfig(
      label: r'\geq',
      value: r'{\geq}',
      asTex: true,
      highlighted: true,
    ),
  ],
];

/// Keyboard getting shown for number input only.
final numberKeyboard = [
  [
    _digitButtons[7],
    _digitButtons[8],
    _digitButtons[9],
    _subtractButton,
  ],
  [
    _digitButtons[4],
    _digitButtons[5],
    _digitButtons[6],
    _decimalButton,
  ],
  [
    _digitButtons[1],
    _digitButtons[2],
    _digitButtons[3],
    DeleteButtonConfig(),
  ],
  [
    PreviousButtonConfig(),
    _digitButtons[0],
    NextButtonConfig(),
    SubmitButtonConfig(),
  ],
];
