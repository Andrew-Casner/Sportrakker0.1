$userCarousel = $('.carousel');
var totalItems = $('.item').length;
var currentIndex = 1;
var enabled = true;
//================================================
//---------------Carousel Change------------------
//================================================

function right() {
    rightTimeout();
}
function left() {
    leftTimeout();
}
function leftTimeout() {
        if (currentIndex === 1) {
            currentIndex = 3;
        }
        else {
            currentIndex = currentIndex - 1;
        }
    if(currentIndex===2){
        $('.basicUserInfo').empty();
        $('.basicUserInfo').append('<p>Test</p>');
    }
        //$('.test').append('<p class="pull-right"><a href="#">Back to top</a></p>');
        setTimeout(enabledToggle, 600);
}
function rightTimeout() {
        if (currentIndex === 3) {
            currentIndex = 1;
        }
        else {
            currentIndex = currentIndex + 1;
        }
    $('.test').empty();
    $('.test').append('<h1>Headding 2</h1> <p data-pg-id="1932">Test</p>');
    setTimeout(enabledToggle, 600);
}
function enabledToggle() {
    enabled = true;
}
$userCarousel.on('slide.bs.carousel', function (e) {
});
//================================================
//------------Track Stat Page Creation-------------
//================================================
function loadUserData() {
    var test = "this is a test";
     var test2 = "this is a second test";
    $('.basicUserInfo').append();
    //$('.test').empty();
    //$('.test').append('<h1>Headding 2</h1> <p data-pg-id="1932">'+test2+'</p>');
}
