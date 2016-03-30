$(document).ready(function () {

    var $form = $("#comment_form");
    var $comment_message = $("#comment_message");

    var fCheckText = function (e) {
        if (!empty($(this).val())) {
            $("input#comment_submit", $form).attr("disabled", false)
        } else {
            $("input#comment_submit", $form).attr("disabled", true)
        }
    };

    $comment_message.keyup(fCheckText);
    $comment_message.change(fCheckText);
    $comment_message.blur(fCheckText);
    $comment_message.focus(fCheckText);

    $form.submit(function () {
        $("input#comment_submit", $form)
            .attr('disabled', true)
            .addClass('loading');
    });

});

// показать форму "оставить комментарий к публикации"
function comment_show_form() {
    //clearInterval(window.timer);
    //$(".comment_item .reply").removeClass("hidden");
    var $form = $("#comment_form");
    var $placeholder = $("#comment_form_placeholder");
    if ($form.length) {
        //$("#preview_placeholder", form).hide();
        //$('input[name="parent_id"]', form).val(0);
        //$('input[name="comment_id"]', form).val(0);
        //$(".time_left", form).text("");
        $placeholder.append($form);
        //$(".edit,.delete", form).addClass("hidden");
        $("input#comment_submit", $form).removeClass("loading");
        $form.show();
        $("#comment_message", $form).val("").focus();
        $('.comment_answers').addClass('hidden');
        $form.attr('action', '/comments.js');
    } else {
        var $social = $("#social_buttons");
        $social.attr('id','social_buttons_2');
        $social.find('p').text('Чтобы иметь возможность оставлять комментарии, пожалуйста, авторизуйтесь через:');
        $placeholder.append($social.clone());
    }
    return false
}

function comment_show_reply_form(comment_id) {
    //clearInterval(window.timer);
    //$(".comment_item .reply").removeClass("hidden");
    var form = $("#comment_form");
    if (form.length) {
        //$("#preview_placeholder", form).hide();
        //$('input[name="parent_id"]', form).val(comment_id);
        //$('input[name="comment_id"]', form).val(0);
        //$(".edit,.delete", form).addClass("hidden");
        //$(".submit", form).removeClass("hidden");
        //$(".time_left", form).text("");
        //$("#comment_" + comment_id + " > .comment_body > .reply").addClass("hidden");
        var $comment_answers = $("#comment_" + comment_id + " > .comment_body > .comment_answers");
        _show_comment_answers($comment_answers);
        $comment_answers.find("> .reply_form_placeholder").append(form);
        form.show();
        $("#comment_message", form).val("").focus();
        //_activate_comment_body(comment_id);
        //mention_autocomplete($("#comment_message"));
        form.attr('action', '/comments');
    } else {
        //var placeholder = $("#expired_placeholder");
        //$("#comment_" + comment_id + " > .comment_body > .reply").addClass("hidden");
        //$("#comment_" + comment_id + " > .comment_body > .reply_form_placeholder").append(placeholder);
        //placeholder.removeClass("hidden")
    }
    return false
}

// открыть ответы указанного коментария, ответы остальных комментариев - скрыть
function _show_comment_answers($comment_answers) {
    $('.comment_answers').addClass('hidden');
    $comment_answers.removeClass('hidden');
}

// подсветить коммент, в который вставлена reply_form
/*
 function _activate_comment_body(comment_id) {
 $('.comment_body').removeClass('active');
 $("#comment_" + comment_id + " > .comment_body").addClass('active');
 }*/
