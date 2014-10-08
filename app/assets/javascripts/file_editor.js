$(document).on('ready page:load', function() {

    $('#file-editor-view').each(function () {
        $file_editor_view = $(this)


//var editor = ace.edit("editor");

        var $editor = $file_editor_view.find('#editor')
        var ace_mode = $editor.attr('data-ace-mode')
        if (ace_mode) {
            var editor = ace.edit("editor");
            editor.setTheme("ace/theme/monokai");
            editor.getSession().setMode("ace/mode/" + ace_mode);
        }


        function message(str, status) {
            var $message = $('<div class="message ' + status + '">' + str + '</div>')
            $message.insertBefore($('body').children().first())
            $message.delay(1000).fadeOut({
                complete: function () {
                    var $this = $(this)
                    $this.remove()
                }
            })
        }

        $file_editor_view.find('#button-save-file').on('click', function (event) {
            event.preventDefault()
            $this = $(this)
            $wrapper = $this.parent();
            $wrapper.addClass('processing')
            $nav = $('#nav')
            url = '/file_editor' + $nav.attr('data-path')

            file_content = editor.getValue()

            $.post(url, { file_content: file_content }, function () {
                $wrapper.removeClass('processing')
                message('file successfully saved', 'successful')
            })


        })

    })

})