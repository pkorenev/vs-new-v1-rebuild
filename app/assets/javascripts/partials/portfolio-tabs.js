$(document).on('ready page:load', function(){
$('#portfolio-tabs-wrapper').each(function(){
  $("#all-tab").click(visualizePortfolioShowAll);

  $("#firm-styles-tab").click(visualizePortfolioShowFirmStyles);

  $("#polygraphy-tab").click(visualizePortfolioShowPolygraphy);

  $("#web-sites-tab").click(visualizePortfolioShowWeb);
});
});