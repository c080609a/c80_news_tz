$(document).ready(function() {
    $('.fact_time_issue').find('a.comments').click(function (e) {
        e.preventDefault();
        e.stopImmediatePropagation();

        $('html, body').animate(
            {
            scrollTop: $("#comments_block").offset().top
            }, {
                duration: 1000,
                easing: "easeOutSine"
            }
        );

    });
});