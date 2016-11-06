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
    menu_item_names.push(menu_item.getAttribute('name'));
  }
  if(menu_item_names.indexOf(menu_item_name) == -1){
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

// Add event listeners
window.onhashchange = update_page;

// When page loads
window.onload = function(){
  // Build scrollspy
  var stage = document.getElementsByClassName('stage')[0];
  stage.addEventListener('scroll', function(){
    // Get the mugshot top
    var mugshot = document.getElementsByClassName('mugshot')[0];
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
  update_page();
};
