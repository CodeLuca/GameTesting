import 'dart:html' as html;
import 'package:stagexl/stagexl.dart';
import 'dart:math';

List _colors = [Color.Black, Color.Blue, Color.Red, Color.Green, Color.AliceBlue, Color.Azure, Color.DarkKhaki];
int _colorIndex = 0;
TextField _textField;
var shape;
var collision;
Random r;
int h;
int w;
bool gameisRunning = false;
var stage;
var renderLoop;

void main() {
  gameisRunning = true;
  // setup the Stage and RenderLoop
  var canvas = html.querySelector('#stage');
  stage = new Stage(canvas);
  renderLoop = new RenderLoop();
  renderLoop.addStage(stage);
  r = new Random();

  // draw a red circle
  shape = new Shape();
  collision = new Shape();
  collision.graphics.circle(-30, -30, 30);
  collision.graphics.fillColor(Color.Green);
  shape.graphics.rect(-10, -10, 10, 10);
  shape.graphics.fillColor(Color.Red);
  w = r.nextInt(1280);
  h = r.nextInt(720);
  shape.y = h;
  shape.x = w;
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
//  stage.addChild(_textField);

  stage.onEnterFrame.listen(_onEnterFrame);
  stage.onMouseClick.listen(_onMouseClick);

   _handleEvents(stage);
   AIMovement();
}

  _handleEvents(Stage stage) {
    stage.onKeyDown.listen((KeyboardEvent ke){
      if(shape.hitTestObject(collision)){
        w = r.nextInt(1280);
        h = r.nextInt(720);
        shape.y = h;
        shape.x = w;
      }

      if(collision.x < shape.x){
        collision.x += 10;
      } else {
        collision.x -= 10;
      }

      if(collision.y < shape.y){
        collision.y += 10;
      } else {
        collision.y -= 10;
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

  AIMovement(){
  }

  _onEnterFrame(EnterFrameEvent e) {
    _textField.text = new DateTime.now().toString();
  }

  _onMouseClick(MouseEvent e) {
    _colorIndex = (_colorIndex + 1) % _colors.length;
    _textField.textColor = _colors[_colorIndex];
  }