/* считаем клики по wow-картинкам */

$(document).ready(function () {

    var prefixes_array = ['rb01', 'rb02', 'rb03'];
    var iprefix, i$rb;
    for (var i = 0; i < prefixes_array.length; i++) {

        // prefix является:
        //          - id ссылки, в которую завёрнута картинка
        //          - префиксом класса, в который вставлен id wow-картинки
        iprefix = prefixes_array[i];

        i$rb = $("#" + iprefix);
        if (i$rb.length == 1) {

            var bc = (function () {

                var _init = function ($rb) {

                    $rb.click(function (event) {
                        event.preventDefault();

                        $.ajax({
                            url: '/rb',
                            type: 'POST',
                            data: {c: $rb.attr('class')},
                            dataType: 'text'
                        });

                        window.location.href = $rb.attr('href');

                        //var $a = $('<a href="'+$rb.attr('href')+'" target="_blank">go!</a>');
                        //$(document).append(a);
                        //$a[0].click(); // => всплывающее окно заблокировано

                    });

                };

                return {
                    init: _init
                }

            })();

            bc.init(i$rb);

        }

    }

});