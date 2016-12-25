/* index.js
*/

function change_scene(target_id){
  var scenes = document.getElementsByClassName('scene');
  for(var scene of scenes){
    scene.style.display = 'none';
  }
  var target_scene = document.getElementById(target_id);
  target_scene.style.display = 'block';
}
