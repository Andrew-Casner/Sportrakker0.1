$userCarousel = $('.carousel');
var totalItems = $('.item').length;
var currentIndex = 1;
var enabled = true;
function right() {
    rightTimeout();
}
function left() {
    leftTimeout();
}
function leftTimeout() {
    if (enabled == true) {
        enabled = false;
        if (currentIndex == 1) {
            currentIndex = 3;
        }
        else {
            currentIndex = currentIndex - 1;
        }
        $('.test').appendTo('<p class="pull-right"><a href="#">Back to top</a></p>');
    }
    setTimeout(enabledToggle, 600);
}
function rightTimeout() {
    if (enabled == true) {
        enabled = false;
        if (currentIndex == 3) {
            currentIndex = 1;
        }
        else {
            currentIndex = currentIndex + 1;
        }
        $('.test2').text('' + currentIndex + '/' + totalItems + '');
    }
    setTimeout(enabledToggle, 600);
}
function enabledToggle() {
    enabled = true;
}
$userCarousel.on('slide.bs.carousel', function (e) {
});