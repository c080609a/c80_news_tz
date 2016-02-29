var facts_wookmark_options;

$(function () {
    if (facts_wookmark_options == undefined) {
        facts_wookmark_options = { align:"left", offset:20 };
    }
    setTimeout(function () {
        $('.div_facts').wookmark(facts_wookmark_options);
    },100);
});