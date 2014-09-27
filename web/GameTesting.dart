import 'dart:html' as html;
import 'package:stagexl/stagexl.dart';

List _colors = [Color.Black, Color.Blue, Color.Red, Color.Green, Color.AliceBlue, Color.Azure, Color.DarkKhaki];
int _colorIndex = 0;
TextField _textField;
var shape;
var collision;

void main() {

  // setup the Stage and RenderLoop
  var canvas = html.querySelector('#stage');
  var stage = new Stage(canvas);
  var renderLoop = new RenderLoop();
  renderLoop.addStage(stage);

  // draw a red circle
  shape = new Shape();
  collision = new Shape();
  collision.graphics.circle(200, 200, 30);
  collision.graphics.fillColor(Color.Green);
  shape.graphics.rect(100, 100, 10, 10);
  shape.graphics.fillColor(Color.Red);
  stage.addChild(collision);
  stage.addChild(shape);
  stage.focus = stage;

  _textField = new TextField();
  _textField.defaultTextFormat = new TextFormat("Verdana", 14, Color.Black);
  _textField.width = 200;
  _textField.height = 20;
  _textField.background = true;
  _textField.backgroundColor = Color.Yellow;
  _textField.text = new DateTime.now().toString();
  stage.addChild(_textField);

  stage.onEnterFrame.listen(_onEnterFrame);
  stage.onMouseClick.listen(_onMouseClick);

   _handleEvents(stage);
}

  _handleEvents(Stage stage) {
    stage.onKeyDown.listen((KeyboardEvent ke){
      if(shape.hitTestObject(collision)){
        shape.x = 10;
        shape.y = 200;
      }
      switch (ke.keyCode) {
      case 87:
        shape.y -= 10;
      break;
      case 83:
        shape.y += 10;
      break;
      case 65:
        shape.x -= 10;
      break;
      case 68:
        shape.x += 10;

      }
    });
  }

  _onEnterFrame(EnterFrameEvent e) {
    _textField.text = new DateTime.now().toString();
  }

  _onMouseClick(MouseEvent e) {
    _colorIndex = (_colorIndex + 1) % _colors.length;
    _textField.textColor = _colors[_colorIndex];
  }