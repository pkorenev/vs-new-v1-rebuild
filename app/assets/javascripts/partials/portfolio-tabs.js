$(document).on('ready page:load', function(){
$('#portfolio-tabs-wrapper').each(function(){
  $("#all").click(visualizePortfolioShowAll);

  $("#firm-styles").click(visualizePortfolioShowFirmStyles);

  $("#polygraphy").click(visualizePortfolioShowPolygraphy);

  $("#web-sites").click(visualizePortfolioShowWeb);
});
});