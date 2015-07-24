//================================================
//--------------ALL USER VARRIABLES---------------
//---------To be initiated from database----------
//================================================
var userName = "Drew Casner";
//================================================
//------------Title Template Code--------------
//================================================
_.templateSettings.variable = "rc";
var titleDataTemplate = _.template(
    $('#titleDataTemplate').html()
);

var titleData;
titleData = {
    userName: userName
};
$('#titleData').html(titleDataTemplate(titleData));
//================================================
//----------------------END-----------------------
//================================================