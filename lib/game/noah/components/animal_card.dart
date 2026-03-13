import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

import '../models/animal_pair.dart';

/// Tappable card component representing a single animal in the Noah matching game.
///
/// Renders the animal sprite image on a warm card background.
/// Calls [onTap] when tapped and exposes [select], [deselect],
/// [triggerMatchFeedback], and [triggerWrongFeedback] for [NoahGame] to drive.
class AnimalCard extends PositionComponent with TapCallbacks {
  /// The data model backing this card.
  final AnimalPair data;

  /// Called by Flame event system; forwarded to [NoahGame._handleCardTap].
  final void Function(AnimalCard card) onTap;

  bool _isSelected = false;
  bool _isMatched = false;

  /// Backing rectangle that changes colour to reflect card state.
  late final RectangleComponent _bg;

  static const Color _colourDefault = Color(0xFFFFE0A0);
  static const Color _colourSelected = Color(0xFFF4A261);
  static const Color _colourMatched = Color(0xFF8BC34A);

  /// Creates an [AnimalCard] at [position] with [size].
  AnimalCard({
    required this.data,
    required this.onTap,
    required super.position,
    required super.size,
  });

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    _bg = RectangleComponent(
      size: size,
      paint: Paint()..color = _colourDefault,
    );
    add(_bg);

    // Border overlay
    add(
      RectangleComponent(
        size: size,
        paint: Paint()
          ..color = Colors.transparent
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3
          ..color = const Color(0xFFBB8A52),
      ),
    );

    // Animal sprite — fills the card with padding
    final sprite = await Sprite.load(data.flamePath);
    final padding = size.x * 0.1;
    add(
      SpriteComponent(
        sprite: sprite,
        position: Vector2(padding, padding),
        size: size - Vector2(padding * 2, padding * 2),
      ),
    );
  }

  @override
  void onTapDown(TapDownEvent event) {
    if (!_isMatched) onTap(this);
  }

  /// Highlights this card as the currently selected card.
  void select() {
    _isSelected = true;
    _bg.paint.color = _colourSelected;
    add(ScaleEffect.to(Vector2.all(1.08), EffectController(duration: 0.1)));
  }

  /// Removes the selection highlight.
  void deselect() {
    _isSelected = false;
    _bg.paint.color = _colourDefault;
    add(ScaleEffect.to(Vector2.all(1.0), EffectController(duration: 0.1)));
  }

  /// Plays a success animation and locks the card as matched.
  void triggerMatchFeedback() {
    _isMatched = true;
    _isSelected = false;
    _bg.paint.color = _colourMatched;
    add(
      ScaleEffect.to(
        Vector2.all(1.1),
        EffectController(duration: 0.15, reverseDuration: 0.15),
      ),
    );
  }

  /// Plays a shake-like feedback animation for an incorrect pairing attempt.
  void triggerWrongFeedback() {
    _isSelected = false;
    _bg.paint.color = _colourDefault;
    add(
      ScaleEffect.to(
        Vector2.all(0.93),
        EffectController(duration: 0.08, reverseDuration: 0.08),
      ),
    );
  }

  /// Whether this card is currently matched and locked.
  bool get isMatched => _isMatched;

  /// Whether this card is currently selected.
  bool get isSelected => _isSelected;
}
