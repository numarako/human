// 現在のログインユーザを取得
var current_user = gon.current_user;
// 投稿者を取得
var content_user = gon.content_user;

const CommentList = document.getElementsByClassName("comment-part");

for (let i = 0; i < CommentList.length; i++) {
  var comment_user = CommentList[i].lastElementChild.attributes.value.value
  if (comment_user == content_user) {
    var phrase = document.getElementById("comment-phrase" + String(i + 1));
    phrase.style.color = '#FF0000';
    var date = document.getElementById("comment-date" + String(i + 1));
    date.style.color = '#FF0000';
  }
}
