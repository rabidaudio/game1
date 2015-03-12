
var DEBUG = true;

window.onload = function(){

  window.log = (DEBUG ? console.log.bind(console) : function(){/*no-op*/} );

  require('./libs/LabelButton');

  log(Phaser);

  var game = new Phaser.Game(800, 600, Phaser.AUTO, 'my game');

  game.state.add('boot', require('./states/boot'));
  game.state.start('boot');
}