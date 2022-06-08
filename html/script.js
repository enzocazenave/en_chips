$(".coins-container").hide()
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

var panelIsOpen = false

window.addEventListener('message', function(event) {
    var data = event.data;
    if (data.type == 'container') {
        if (data.show) {
            $(".coins-container").show('slow');
            panelIsOpen = true
        } else {
            $(".coins-container").hide('slow');
            $(".purchase-container").hide('slow');
            $(".sale-container").hide('slow');
            panelIsOpen = false
        } 
    }
});

$(document).keyup(function(e) {
    if (panelIsOpen) {
        if (e.key == "Escape") {
            $.post("http://en_chips/closeNui", JSON.stringify({}));
        }
    }
})

function action(type, qtty) {
    $.post("http://en_chips/executeAction", JSON.stringify({type: type, qtty: qtty}));
}

$("#confirm-transaction").click(function() {
    var value = $("#modified-qtty").val()
    
    if ((value > 0 && value != "") && !value.includes("e", 0) && !value.includes("E", 0)) {
        $.post("http://en_chips/executeAction", JSON.stringify({type: "purchase", qtty: value}));
    } else {
        $.post("http://en_chips/notify", JSON.stringify({text: "Debes ingresar un valor numerico"}));
    }
});

$("#confirm-transaction-sale").click(function() {
    var value = $("#modified-qtty-sale").val()
    
    if ((value > 0 && value != "") && !value.includes("e", 0) && !value.includes("E", 0)) {
        $.post("http://en_chips/executeAction", JSON.stringify({type: "sale", qtty: value}));
    } else {
        $.post("http://en_chips/notify", JSON.stringify({text: "Debes ingresar un valor numerico"}));
    }
});
