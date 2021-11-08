var age = gon.user_age;
var gender = gon.user_gender;
var select_age = document.getElementById("user_age");
var select_gender = document.getElementById("user_gender");
switch (age) {
  case 0:
    select_age.options[1].selected = true;
    break;
  case 1:
    select_age.options[2].selected = true;
    break;
  case 2:
    select_age.options[3].selected = true;
    break;
  case 3:
    select_age.options[4].selected = true;
    break;
  case 4:
    select_age.options[5].selected = true;
    break;
  case 5:
    select_age.options[6].selected = true;
    break;
  case 6:
    select_age.options[7].selected = true;
    break;
  case 7:
    select_age.options[8].selected = true;
    break;
  case 8:
    select_age.options[9].selected = true;
    break;
}
switch (gender) {
  case 0:
    select_gender.options[1].selected = true;
    break;
  case 1:
    select_gender.options[2].selected = true;
    break;
  case 2:
    select_gender.options[3].selected = true;
    break;
  case 3:
    select_gender.options[4].selected = true;
    break;
}

