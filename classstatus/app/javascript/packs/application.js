// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require("jquery")

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

import 'bootstrap'
import '../stylesheets/application'
import '@fortawesome/fontawesome-free/css/all.css';

// TODO: Figure out what should really be here - all of this code is from
//       tutorials that are either testing that jQuery has loaded or examples
//       of how to do a small task in isolation.
//
//       For whatever it is worth jQuery here runs, jQuery on .html.erb pages
//       does not.

document.addEventListener("turbolinks:load", () => {
  $('[data-toggle="tooltip"]').tooltip()
})

$(document).on('turbolinks:load', function () {
})

// For navbar - change dropdown button to reflect selected choice.
$(document).ready(function () {
  $("#navbar-current-section").click(function(){
    $(this).parents(".dropdown").find('.btn').html($(this).text() +
     ' <span class="caret"></span>');
    $(this).parents(".dropdown").find('.btn').val($(this).data('value'));
  });
});
