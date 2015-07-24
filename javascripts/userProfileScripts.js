//================================================
//------------Carousel Template Code--------------
//================================================
_.templateSettings.variable = "rc";
var carouselDataTemplate = _.template(
    $('#carouselData').html()
);

var carouselData;
carouselData = {
    userName: "Drew Casner",
    userLocationCity: "Aurora",
    userLocationState: "Colorado",
    userProfilePicture: "../images/userPicture.jpg",
    //add one for end indexing
    userTotalSports: 1 + 1,
    userSports: [{
        sport: "Track and Field",
        affiliatedOrganization: "Grandview Highschool",
        profilePicture: "../images/userTrackPhoto.jpg",
        backgroundPhoto: "../images/trackLanes.jpg",
        sportNumber: 1
    }]
};
$("#myCarousel").html(carouselDataTemplate(carouselData));
//================================================
//-----------User info Template Code--------------
//================================================
_.templateSettings.variable = "rc";
var basicUserInfo = _.template(
    $('#userData').html()
);

var basicUserInfoData;
basicUserInfoData = {
    userName: "Drew Casner",
    highschoolName: "Grandview",
    userClassYear: 2015,
    userAge: 18,
    userHeightFeet: 6,
    userHeightInches: 2,
    userWeight: 172,
    userBench: 205,
    userSquat: 285,
    userPowerClean: 215,
    user20STL: 4.35,
    user40Dash: 4.94,
    userVertical: 28
};
$("#userInfoGoesHere").html(basicUserInfo(basicUserInfoData));
//================================================
//---------------Carousel Change------------------
//================================================
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
        if (currentIndex === 1) {
            currentIndex = 3;
        }
        else {
            currentIndex = currentIndex - 1;
        }
    if(currentIndex===2){
    }
        setTimeout(enabledToggle, 600);
}
function rightTimeout() {
    console.log("test");
        if (currentIndex === 3) {
            currentIndex = 1;
        }
        else {
            currentIndex = currentIndex + 1;
        }
    setTimeout(enabledToggle, 600);
}
function enabledToggle() {
    enabled = true;
}
$userCarousel.on('slide.bs.carousel', function (e) {
});