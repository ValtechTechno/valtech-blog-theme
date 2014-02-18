<!DOCTYPE html>

<!-- paulirish.com/2008/conditional-stylesheets-vs-css-hacks-answer-neither/ -->
<!--[if IE 8]>    <html class="no-js lt-ie9" lang="fr"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js" lang="fr"> <!--<![endif]-->
<head>
  <meta charset="utf-8">

  <!-- Set the viewport width to device width for mobile -->
  <meta name="viewport" content="width=device-width, initial-scale=1.0">

  <title><?php bloginfo('name'); ?> | <?php is_home() ? bloginfo('description') : wp_title(''); ?></title>
  
  <!-- Included CSS Files (Compressed) -->
  <link rel="stylesheet" href="<?php echo get_stylesheet_directory_uri(); ?>/foundation/foundation.min.css">

  <link rel="stylesheet" media="all" href="<?php echo get_stylesheet_uri(); ?>" />
  <link rel="pingback" href="<?php bloginfo( 'pingback_url' ); ?>" />
<?php

wp_head();

?>

  <script src="<?php echo get_stylesheet_directory_uri(); ?>/modernizr/custom.modernizr.js"></script>
</head>
<body <?php body_class(); ?>>
 
  <header>
    <div class="row">
      <div class="large-12 columns">
        <div id="blue-bar">
          <a href="<?php echo home_url(); ?>" title="<?php bloginfo('description'); ?>">
            <img src="<?php echo get_stylesheet_directory_uri(); ?>/valtech-logo.png" alt="valtech_" />
          </a>
        </div>
      </div>
    </div>

    <!-- Nav Bar -->

    <div class="row">
      <div class="large-12 columns">
        <nav class="top-bar" data-topbar>
          <ul class="title-area">
            <li class="name"></li>
            <li class="toggle-topbar menu-icon"><a href="#"></a></li>
          </ul>
          <section class="top-bar-section">
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
    <div class="large-9 columns" role="content">
<?php

if ( have_posts() ) while ( have_posts() ) : the_post();

?>
      <article id="post-<?php the_ID(); ?>" <?php post_class(); ?>>
        <div class="post-avatar left">
          <a class="th radius" href="<?php echo get_author_posts_url( get_the_author_meta( 'ID' ) ); ?>">
            <?php echo get_avatar( get_the_author_meta( 'ID' ), 60 ); ?>
          </a>
        </div>
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
        <h6>
          <div class="clearfix">Publié par <?php the_author_link( ); ?>, le <?php the_time('j/m'); ?>/<span><?php the_time( 'Y' ); ?></span>, dans <?php the_category(', '); ?></div>
        </h6>

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
 
    <aside class="large-3 columns">

      <form role="search" method="get" id="searchform" action="<?php echo home_url( '/' ); ?>">
        <div class="row collapse">
          <div class="small-8 columns">
            <input type="search" placeholder="Rechercher" name="s" id="s">
          </div>
          <div class="small-4 columns">
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
    <div class="large-12 columns">
      <hr />
      <div class="row">
        <div class="large-4 columns">
          <p>Powered by <a target="_blank" href="http://wordpress.org/">WordPress</a>, <a target="_blank" href="https://www.varnish-cache.org/">Varnish</a></p>
        </div>
        <div class="large-4 columns">
          <p><a target="_blank" href="http://www.valtech.fr/fr/mentions-légales-copyright/mentions-légales-copyright">Mentions légales</a> - Copyright 2013 <a target="_blank" href="http://valtech.com">Valtech</a></p>
        </div> 
        <div class="large-4 columns">
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
  <script src="<?php echo get_stylesheet_directory_uri(); ?>/jquery/jquery.min.js"></script>
  <script src="<?php echo get_stylesheet_directory_uri(); ?>/foundation/foundation.min.js"></script>
  
  <!-- Initialize JS Plugins -->
  <script>
    $(document).foundation();
  </script>
<?php

  wp_footer();

?>

</body>
</html>

