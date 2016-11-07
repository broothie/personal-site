/* index.js
*/

// Updates the menu
function update_menu(menu_item_name){
  // Unapply selection styling to all menu items
  var menu_items = document.getElementsByClassName('menu-text');
  var menu_item_names = [];
  for(var counter = menu_items.length - 1; counter >= 0; counter--){
    var menu_item = menu_items[counter];
    menu_item.className = 'menu-text';
  }
  if(menu_item_name.length === 0){
    menu_item_name = 'Home';
  }
  // Apply selection styling to selected menu item
  var text_item = document.getElementsByName(menu_item_name)[0];
  text_item.className += ' menu-text-selected';
  window.location.hash = menu_item_name;
}

// Gets called on hash change and page load
function update_page(){
  // Get hash
  var anchor = window.location.hash;
  var unhashed_anchor = anchor.replace('#', '');
  // Update menu
  update_menu(unhashed_anchor);
}

// Add event listener
window.onhashchange = update_page;

var mugshot_index = 0;
var mugshots = [
  'img/Chimney_mugshot.jpg',
  'img/Killington_mugshot.jpg',
  'img/Niagara_mugshot.jpg',
  'img/Oozefest_mugshot.jpg',
];

function increment_mug(){
  mugshot_index++;
  var mugshot = document.getElementsByClassName('mugshot')[0];
  mugshot.src = mugshots[mugshot_index % mugshots.length];
}

// When page loads
window.onload = function(){
  // Randomize mugshot
  mugshot_index = Math.floor(Math.random() * 2);
  var mugshot = document.getElementsByClassName('mugshot')[0];
  mugshot.src = mugshots[mugshot_index];

  // Build scrollspy
  var stage = document.getElementsByClassName('stage')[0];
  stage.addEventListener('scroll', function(){
    // Get the mugshot top
    var mugshot_top = mugshot.getBoundingClientRect().top;

    // Loop through sections and test relation to mugshot
    var sections = document.getElementsByTagName('section');
    for(var counter = sections.length-1; counter >= 0; counter--){
      var section = sections[counter];

      // Get scene to compare to mugshot
      var scene = section.getElementsByClassName('scene')[0];
      var scene_top = scene.getBoundingClientRect().top;

      // Set scene if close enough
      if(mugshot_top-30 < scene_top && scene_top < mugshot_top+30){
        window.location.hash = section.id;
      }
    }
  });
  // Update page
  update_page();
};
