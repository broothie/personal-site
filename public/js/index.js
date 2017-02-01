/* index.js
 */

function change_scene(target_id){
    var scenes = document.getElementsByClassName('scene');
    for(var counter = 0; counter < scenes.length; counter++){
        scenes[counter].style.display = 'none';
    }
    var target_scene = document.getElementById(target_id);
    target_scene.style.display = 'block';
}