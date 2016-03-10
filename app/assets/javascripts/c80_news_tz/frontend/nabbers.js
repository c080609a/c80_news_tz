/* считаем клики по wow-картинкам */

$(document).ready(function() {

    // prefix является:
    //          - id ссылки, в которую завёрнута картинка,
    //          - префиксом класса, в который вставлен id картинки
    //          - именем маршрута, на другом конце которого считают клики
    var prefix = 'rb01';

    var $rb01 = $("#"+prefix);
    $rb01.click(function (event) {
        event.preventDefault();

        $.ajax({
            url: '/'+prefix,
            type: 'POST',
            data: { c:$rb01.attr('class') },
            dataType: 'text'
        });

        window.location.href = $rb01.attr('href');

    });

});