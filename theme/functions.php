<?php

  // Register widgetized areas
  function valtech_widgets_init() {
    // Area 1
    register_sidebar(array(
      'name'          => 'Primary Widget Area',
      'id'            => 'primary-widget-area',
      'before_widget' => '<div id="%1$s" class="widget %2$s">',
      'after_widget'  => "</div>",
      'before_title'  => '<h5>',
      'after_title'   => '</h5>',
    ));
 
    // Area 2
    register_sidebar(array(
      'name'          => 'Secondary Widget Area',
      'id'            => 'secondary-widget-area',
      'before_widget' => '<div id="%1$s" class="widget %2$s">',
      'after_widget'  => "</div>",
      'before_title'  => '<h5>',
      'after_title'   => '</h5>',
    ));
  } // end theme_widgets_init
 
  add_action('widgets_init', 'valtech_widgets_init');

  add_theme_support('post-thumbnails');

?>
