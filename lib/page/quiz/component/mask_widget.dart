import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

/// A widget which paints a [mask] widget into a save layer and blends that
/// layer with its [child].
///
/// [blendMode] determines how [mask] and [child] are blended with each other.
/// In the context of this widget [mask] is the `src` and [child] the `dst`.
///
/// This widget sizes itself to the dimensions of [child] and forces [mask] to
/// the same size. For the purpose of hit testing [mask] is painted over
/// [child].
///
/// Since [mask] is panted into a save layer, this widget is relatively
/// expensive. See [Canvas.saveLayer] for more on the performance implications
/// of a save layer.
///
/// [mask] must not contain [RenderObject]s which need compositing because
/// the save layer into which [mask] is painted cannot encompass compositing
/// layers. `RepaintBoundary` is a widget, whose [RenderObject] needs
/// compositing, for example.
class MaskWidget extends StatelessWidget {
  /// Creates a widget which paints a [mask] widget into a save layer and blends
  /// that layer with its [child].
  const MaskWidget({
    Key? key,
    this.blendMode = BlendMode.srcOver,
    this.childSaveLayer = false,
    required this.mask,
    required this.child,
    required this.top,
    required this.left,
  }) : super(key: key);

  /// The [BlendMode] to use when blending the [mask] save layer with [child].
  ///
  /// In the context of this widget [mask] is the `src` and [child] the `dst`.
  final BlendMode blendMode;

  /// Whether to paint [child] in its own save layer.
  ///
  /// This allows you to blend [child] and [mask] without the transparent
  /// areas of [child] influencing the result.
  ///
  /// Enabling this option impacts performance, since it adds another save layer
  /// and should only be done if necessary.
  final bool childSaveLayer;

  /// The widget which is painted over the [child] widget, in a save layer with
  /// [BlendMode] [blendMode].
  final Widget mask;

  /// The widget which determines the size of this widget and is painted behind
  /// the [mask] widget.
  final Widget child;

  final double top;

  final double left;


  @override
  Widget build(BuildContext context) {
    Widget child = Stack(
      textDirection: TextDirection.ltr,
      fit: StackFit.passthrough,
      children: [
        Positioned(
          top: top,
          left: left,
          child: this.child,
        ),
        Positioned.fill(
          child: SaveLayer(
            paint: Paint()..blendMode = blendMode,
            child: mask,
          ),
        ),
      ],
    );

    if (childSaveLayer) {
      child = SaveLayer(
        child: child,
      );
    }

    return child;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(EnumProperty('blendMode', blendMode))
      ..add(FlagProperty(
        'childSaveLayer',
        value: childSaveLayer,
        ifTrue: 'CHILD-SAVE-LAYER',
        defaultValue: false,
      ));
  }
}

/// A widget, which paints its [child] into a separate save layer.
///
/// The [Paint], that is used for the save layer, can be set through [paint].
///
/// Widgets that need compositing will only be partially or not at all painted
/// into the save layer. This can cause unexpected results, which is why
/// widgets that need compositing will cause an exception in debug mode, when
/// used as the [child]. To disable this check, set
/// [debugCheckChildDoesNotNeedCompositing] to `false`.
class SaveLayer extends SingleChildRenderObjectWidget {
  /// Creates a widget, which paints its [child] into a separate save layer.
  const SaveLayer({
    Key? key,
    this.paint,
    this.debugCheckChildDoesNotNeedCompositing = true,
    this.child,
  }) : super(key: key, child: child);

  /// The [Paint] to use for the save layer.
  ///
  /// If this is `null`, `Paint()` will be used.
  final Paint? paint;

  /// Whether to check that [child] does not need compositing.
  // ignore: diagnostic_describe_all_properties
  final bool debugCheckChildDoesNotNeedCompositing;

  /// The widget which will be painted into it's own save layer.
  ///
  /// {@macro flutter.widgets.ProxyWidget.child}
  @override
  final Widget? child;

  @override
  RenderObject createRenderObject(BuildContext context) => RenderSaveLayer(
        saveLayerPaint: paint,
        debugCheckChildDoesNotNeedCompositing:
            debugCheckChildDoesNotNeedCompositing,
      );

  @override
  void updateRenderObject(
    BuildContext context,
    covariant RenderSaveLayer renderObject,
  ) {
    super.updateRenderObject(context, renderObject);
    renderObject
      ..saveLayerPaint = paint
      ..debugCheckChildDoesNotNeedCompositing =
          debugCheckChildDoesNotNeedCompositing;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Paint?>('paint', paint));
  }
}

/// A [RenderProxyBox], that paints its child into a separate save layer.
class RenderSaveLayer extends RenderProxyBox {
  /// Creates a [RenderProxyBox], that paints its child into a separate save
  /// layer.
  RenderSaveLayer({
    required Paint? saveLayerPaint,
    required bool debugCheckChildDoesNotNeedCompositing,
  })  : _saveLayerPaint = saveLayerPaint,
        _debugCheckChildDoesNotNeedCompositing =
            debugCheckChildDoesNotNeedCompositing,
        super();

  /// The [Paint] to use for the save layer.
  ///
  /// If this is `null`, `Paint()` will be used.
  Paint? get saveLayerPaint => _saveLayerPaint;
  Paint? _saveLayerPaint;

  set saveLayerPaint(Paint? saveLayerPaint) {
    if (_saveLayerPaint == saveLayerPaint) return;
    markNeedsPaint();
    _saveLayerPaint = saveLayerPaint;
  }

  /// Whether to check that [child] does not need compositing.
  // ignore: diagnostic_describe_all_properties
  bool get debugCheckChildDoesNotNeedCompositing =>
      _debugCheckChildDoesNotNeedCompositing;
  bool _debugCheckChildDoesNotNeedCompositing;

  set debugCheckChildDoesNotNeedCompositing(
      bool debugCheckChildDoesNotNeedCompositing) {
    if (_debugCheckChildDoesNotNeedCompositing ==
        debugCheckChildDoesNotNeedCompositing) return;
    markNeedsCompositingBitsUpdate();
    _debugCheckChildDoesNotNeedCompositing =
        debugCheckChildDoesNotNeedCompositing;
  }

  @override
  bool get needsCompositing {
    assert(() {
      if (_debugCheckChildDoesNotNeedCompositing) {
        _debugChildDoesNotNeedCompositing();
      }
      return true;
    }());
    return super.needsCompositing;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final child = this.child;
    if (child == null) {
      return;
    }

    context.canvas.saveLayer(offset & size, _saveLayerPaint ?? Paint());
    context.paintChild(child, offset);
    context.canvas.restore();
  }

  void _debugChildDoesNotNeedCompositing() {
    final child = this.child;
    if (child == null) {
      return;
    }

    if (child.needsCompositing) {
      throw FlutterError.fromParts([
        ErrorSummary('`SaveLayer.child` cannot contain compositing layers.'),
        ErrorDescription(
          'The save layer, into which SaveLayer.child is painted, cannot '
          'encompass compositing layers.',
        ),
        ErrorHint(
          'Ensure `SaveLayer.child` contains no widgets which need '
          'compositing, such as `RepaintBoundary`.',
        ),
        _leafCompositingRenderObjects(child).first.describeForError('')
      ]);
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Paint?>(
      'saveLayerPaint',
      saveLayerPaint,
    ));
  }
}

Iterable<RenderObject> _leafCompositingRenderObjects(
  RenderObject renderObject,
) =>
    (_renderTreeNodes(renderObject).toList()..sort((a, b) => a.depth - b.depth))
        .where(_isLeafCompositingRenderObject);

Iterable<RenderObject> _renderTreeNodes(RenderObject root) sync* {
  final children = <RenderObject>[];
  root.visitChildren((child) {
    children.add(child);
  });
  yield root;
  yield* children.expand((child) => _renderTreeNodes(child));
}

bool _isLeafCompositingRenderObject(RenderObject renderObject) {
  if (renderObject.needsCompositing) {
    var hasChildThatNeedsCompositing = false;
    renderObject.visitChildren((child) {
      if (!hasChildThatNeedsCompositing) {
        hasChildThatNeedsCompositing = child.needsCompositing;
      }
    });
    return !hasChildThatNeedsCompositing;
  } else {
    return false;
  }
}
