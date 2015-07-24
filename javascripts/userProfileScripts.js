//================================================
//--------------ALL USER VARRIABLES---------------
//---------To be initiated from database----------
//================================================
var userName = "Drew Casner";
var userHighschoolName = "Grandview";
var userClassYear = "2015";
var userAge = 18;
var userHeightFeet = 6;
var userHeightInches = 2;
var userWeight = 172;
var userBench = 205;
var userSquat = 285;
var userPowerClean = 215;
var user20STL = 4.35;
var user40Dash = 4.94;
var userVertical = 28;
var userLocationCity = "Aurora";
var userLocationState = "Colorado";
var userProfilePicture = "../images/userPicture.jpg";
var userTotalSports = 1;
//================================================
//------------Carousel Template Code--------------
//================================================
_.templateSettings.variable = "rc";
var carouselDataTemplate = _.template(
    $('#carouselDataTemplate').html()
);

var carouselData;
carouselData = {
    userName: userName,
    userLocationCity: userLocationCity,
    userLocationState: userLocationState,
    userProfilePicture: userProfilePicture,
    //add one for end indexing
    userTotalSports: userTotalSports + 1,
    userSports: [{
        //figure out system for loading multipule sports
        sport: "Track and Field",
        affiliatedOrganization: "Grandview Highschool",
        profilePicture: "../images/userTrackPhoto.jpg",
        backgroundPhoto: "../images/trackLanes.jpg",
        sportNumber: 1
    }]
};
$("#myCarousel").html(carouselDataTemplate(carouselData));
//================================================
//-----------User Info Template Code--------------
//================================================
_.templateSettings.variable = "rc";
var userDataTemplate = _.template(
    $('#userDataTemplate').html()
);

var userData;
userData = {
    userName: userName,
    userHighschoolName: userHighschoolName,
    userClassYear: userClassYear,
    userAge: userAge,
    userHeightFeet: userHeightFeet,
    userHeightInches: userHeightInches,
    userWeight: userWeight,
    userBench: userBench,
    userSquat: userSquat,
    userPowerClean: userPowerClean,
    user20STL: user20STL,
    user40Dash: user40Dash,
    userVertical: userVertical
};
$("#userData").html(userDataTemplate(userData));
//================================================
//---------------Carousel Change------------------
//================================================
$userCarousel = $('.carousel');
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
            currentIndex = 2+ userTotalSports;
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
        if (currentIndex === userTotalSports) {
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
//================================================
//----------------------END-----------------------
//================================================


$userCarousel.on('slide.bs.carousel', function (e) {
});