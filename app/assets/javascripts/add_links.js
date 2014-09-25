function init_locale_links(){
$('span.untranslated-locale').each(function(){
    $span = $(this)
    var $li = $span.parent()
    $li.append('<a class="added-via-js" href="'+$span.attr('data-href')+'">'+$span.text()+'</a>')
    $span.remove()
})
}

init_locale_links()

$(document).on('page:load', init_locale_links)