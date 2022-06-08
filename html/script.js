$(".purchase-container").hide()
$(".sale-container").hide()
$("#confirm-transaction").hide()
$("#confirm-transaction-sale").hide()

$("#modified-qtty").keyup(function() {
    var modifiedInputQtty = $("#modified-qtty").val();

    if (modifiedInputQtty.length > 0) {
        $("#confirm-transaction").fadeIn(500);
    } else {
        $("#confirm-transaction").fadeOut(500);
    }
});

$("#modified-qtty-sale").keyup(function() {
    var modifiedInputQtty = $("#modified-qtty-sale").val();

    if (modifiedInputQtty.length > 0) {
        $("#confirm-transaction-sale").fadeIn(500);
    } else {
        $("#confirm-transaction-sale").fadeOut(500);
    }
});

$(".return-button").click(function() {
    $(".purchase-container").fadeOut(200);
    $(".coins-container").fadeIn(200);
});

$(".return-button-sale").click(function() {
    $(".sale-container").fadeOut(200);
    $(".coins-container").fadeIn(200);
});

$("#purchase-redirect").click(function() {
    $(".coins-container").fadeOut(200);
    $(".purchase-container").fadeIn(200);
});

$("#sale-redirect").click(function() {
    $(".coins-container").fadeOut(200);
    $(".sale-container").fadeIn(200);
});