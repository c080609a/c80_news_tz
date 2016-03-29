$(document).ready(function() {
    $('.fact_time_issue').find('div.comments').click(function () {
        $('html, body').animate(
            {
            scrollTop: $("#comments_block").offset().top
            }, {
                duration: 1000,
                easing: "easeOutSine"
            });

    });
});