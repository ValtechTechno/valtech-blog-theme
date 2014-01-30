<!DOCTYPE html>

<!-- paulirish.com/2008/conditional-stylesheets-vs-css-hacks-answer-neither/ -->
<!--[if IE 8]>    <html class="no-js lt-ie9" lang="en"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js" lang="en"> <!--<![endif]-->
<head>
  <meta charset="utf-8" />

  <!-- Set the viewport width to device width for mobile -->
  <meta name="viewport" content="width=device-width" />

  <title><?php bloginfo('name'); ?> | <?php is_home() ? bloginfo('description') : wp_title(''); ?></title>
  
  <!-- Included CSS Files (Compressed) -->
  <link rel="stylesheet" href="<?php echo get_stylesheet_directory_uri(); ?>/foundation-3.2.5-custom/stylesheets/foundation.min.css">
  <link rel="stylesheet" href="<?php echo get_stylesheet_directory_uri(); ?>/foundation-3.2.5-custom/stylesheets/app.css">

  <link rel="stylesheet" type="text/css" media="all" href="<?php echo get_stylesheet_uri(); ?>" />
  <link rel="pingback" href="<?php bloginfo( 'pingback_url' ); ?>" />
<?php

wp_head();

?>

  <script src="<?php echo get_stylesheet_directory_uri(); ?>/foundation-3.2.5-custom/javascripts/modernizr.foundation.js"></script>
</head>
<body <?php body_class(); ?>>
 
  <header>
    <div class="row">
      <div class="twelve columns">
        <div id="blue-bar">
          <a href="<?php echo home_url(); ?>" title="<?php bloginfo('description'); ?>">
            <img src="<?php echo get_stylesheet_directory_uri(); ?>/valtech-logo.png" alt="valtech_" />
          </a>
        </div>
      </div>
    </div>

    <!-- Nav Bar -->

    <div class="row">
      <div class="twelve columns">
        <nav class="top-bar">
          <ul class="top-bar">
            <li class="toggle-topbar"><a href="#"></a></li>
          </ul>
          <section>
            <ul class="left">
<?php

  wp_nav_menu();

?>
            </ul>
          </section>
        </nav>
      </div>
    </div>
  </header>
 
  <!-- End Nav -->
 
 
  <!-- Main Page Content and Sidebar -->
 
  <div class="row" id="main-content">
 
    <!-- Main Blog Content -->
    <div class="nine columns" role="content">
<?php

if ( have_posts() ) while ( have_posts() ) : the_post();

?>
      <article id="post-<?php the_ID(); ?>" <?php post_class(); ?>>
        <h3>
          <a href="<?php the_permalink(); ?>" title="<?php printf('Permalien vers %s', the_title_attribute('echo=0')); ?>" rel="bookmark">
<?php

if ( get_the_title() == '' ) {
  echo '(No title)';
} else {
  the_title();
}

?>
          </a>
        </h3>
        <h6>Publié le <?php the_time('j/m'); ?>/<span><?php the_time( 'Y' ); ?></span>, par <?php the_author_link( ); ?> dans <?php the_category(', '); ?> | <?php comments_popup_link('Ajouter un commentaire', '1 Commentaire', '% Commentaires'); ?></h6>

<?php

if ( is_archive() || is_search() ) : the_content('Lire la suite »');
  wp_link_pages( array( 'before' => '' . 'Pages:', 'after' => '' ) );
else :
  if ( has_post_thumbnail() ) {
    the_post_thumbnail(array(620,240), array("class" => "alignleft post_thumbnail"));
  }
  the_content('Lire la suite »');
  wp_link_pages( array( 'before' => '' . 'Pages:', 'after' => '' ) );
endif;
comments_template('', true);

?>
      </article>

      <hr>
<?php endwhile; ?>

      <!--pagination-->
      <ul class="pagination">
        <li class="arrow"><?php next_posts_link('&larr; Articles précédents'); ?></li>
        <li class="arrow"><?php previous_posts_link('Articles suivants &rarr;'); ?></li>
      </ul>
 
    </div>
    <!-- End Main Content -->
 
 
    <!-- Sidebar -->
 
    <aside class="three columns">

      <form role="search" method="get" id="searchform" action="<?php echo home_url( '/' ); ?>">
        <div class="row collapse">
          <div class="eight mobile-three columns">
            <input type="search" placeholder="Rechercher" name="s" id="s">
          </div>
          <div class="four mobile-one columns">
            <input type="submit" class="expand postfix small secondary button" id="searchsubmit" value="Search">
          </div>
        </div>
      </form>

<?php

  if (!dynamic_sidebar('primary-widget-area')) :
  endif; // end primary widget area

  // A second sidebar for widgets, just because.
  if (is_active_sidebar('secondary-widget-area')) :
    dynamic_sidebar('secondary-widget-area');
  endif;

?>
    </aside>

  </div>
 
  <!-- End Main Content and Sidebar -->
 
 
  <!-- Footer -->
 
  <footer class="row">
    <div class="twelve columns">
      <hr />
      <div class="row">
        <div class="four columns">
          <p>Powered by <a target="_blank" href="http://wordpress.org/">WordPress</a>, <a target="_blank" href="https://www.varnish-cache.org/">Varnish</a></p>
        </div>
        <div class="four columns">
          <p><a target="_blank" href="http://www.valtech.fr/fr/mentions-légales-copyright/mentions-légales-copyright">Mentions légales</a> - Copyright 2013 <a target="_blank" href="http://valtech.com">Valtech</a></p>
        </div> 
        <div class="four columns">
          <ul class="inline-list right">
            <li>Follow us:</li>
            <li><a href="https://www.facebook.com/valtech">Facebook</a></li>
            <li><a href="https://twitter.com/ValtechTechno">Twitter</a></li>
          </ul>
        </div>
      </div>
    </div>
  </footer>
 
  <!-- End Footer -->
  
  <!-- Included JS Files (Compressed) -->
  <script src="<?php echo get_stylesheet_directory_uri(); ?>/foundation-3.2.5-custom/javascripts/jquery.js"></script>
  <script src="<?php echo get_stylesheet_directory_uri(); ?>/foundation-3.2.5-custom/javascripts/foundation.min.js"></script>
  
  <!-- Initialize JS Plugins -->
  <script src="<?php echo get_stylesheet_directory_uri(); ?>/foundation-3.2.5-custom/javascripts/app.js"></script>
<?php

  wp_footer();

?>

</body>
</html>

