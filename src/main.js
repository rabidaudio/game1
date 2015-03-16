
var DEBUG = true;

window.onload = function(){

  window.log = (DEBUG ? console.log.bind(console) : function(){/*no-op*/} );

  require('./libs/LabelButton');
  require('./libs/mixins');

  var game = new Phaser.Game(800, 600, Phaser.AUTO, 'my game');

  game.state.add('boot', require('./states/boot'));
  game.state.add('test', require('./states/test'));
  game.state.add('tiled', require('./states/tiled'));
  game.state.start('boot');
  // game.state.start('tiled');
}