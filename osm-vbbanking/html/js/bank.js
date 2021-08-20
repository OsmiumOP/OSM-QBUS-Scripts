$(function() {
    window.addEventListener('message', function(event) {
        if (event.data.type === "openGeneral"){
            $('body').fadeIn(500);
        } else if(event.data.type === "balanceHUD") {
            var balance = event.data.balance;
            $('.qb-banking-creditcard-footer-cardholder').html(event.data.player);
            $('.qb-balance-balance').html("$ "+balance);
            $('.qb-banking-tarjetas-mycardcontainer-balance').html("$ "+balance);
            $('.qb-banking-tarjetas-rigthbar-balance').html("$ "+balance);
            $('.qb-banking-myaccount-balance-balance').html("$ "+balance);
            $('.qb-banking-myaccount-faq-balance').html("$ "+balance);
            // if (balance.toString().length >= Number(6)) {
            //     document.getElementById("qb-banking-tarjetas-mycardcontainer-balance").style.fontSize = "28px"
            //     document.getElementById("qb-banking-tarjetas-rigthbar-balance").style.fontSize = "25px"
            //     document.getElementById("qb-banking-depositcontainer-balance").style.fontSize = "25px"
            //     document.getElementById("qb-banking-transferir-container-balance").style.fontSize = "25px"
            //     document.getElementById("qb-banking-transferir-myaccount-balance").style.fontSize = "25px"
            // }
            var playername = event.data.player
            $('.qb-banking-creditcard-cardholder').html(playername);
            var address = event.data.address
            $('.qb-banking-myaccount-info-address').html('<i class="fal fa-map-marker-alt"></i>&nbsp;&nbsp;&nbsp;</i>Address:&nbsp;&nbsp;'+address+'</span>');
            var walletid = event.data.playerid
            $('.qb-banking-myaccount-info-walletid').html('<i class="fal fa-wallet"></i>&nbsp;&nbsp;&nbsp;</i>Wallet ID:&nbsp;&nbsp;'+walletid+'</span>');
        } else if (event.data.type === "closeAll"){
            $('body').fadeOut(500);
        }
    });
});

$(document).on('click','#inicio',function(){
    hideall();
    $(".qb-banking-container-inicio").fadeIn(500);
})

$(document).on('click','#mycards',function(){
    hideall();
    $(".qb-banking-bigcontainertarjetas").fadeIn(500);
})

$(document).on('click','#meterpastica',function(){
    hideall();
    $(".qb-banking-bigcontainerdepositar").fadeIn(500);
})

$(document).on('click','#depositar',function(){
    hideall();
    $(".qb-banking-bigcontainerdepositar").fadeIn(500);
})

$(document).on('click','#transfer',function(){
    hideall();
    $(".qb-banking-bigcontainertransfer").fadeIn(500);
})

$(document).on('click','#myaccount',function(){
    hideall();
    $(".qb-banking-bigcontainermyaccount").fadeIn(500);
})

$(document).on('click','#faq',function(){
    hideall();
    $(".qb-banking-bigcontainerfaq").fadeIn(500);
})

$(document).on('click','#closebanking',function(){
    $('body').fadeOut(500);
    $.post('http://osm-vbbanking/NUIFocusOff', JSON.stringify({}));
})

$(document).on('click','#withdraw',function(e){
    e.preventDefault();
    $.post('https://${GetParentResourceName()}/withdraw', JSON.stringify({
        amountw: $("#withdrawnumber").val()
    }));
    $('body').fadeOut(500);
    $.post('http://osm-vbbanking/NUIFocusOff', JSON.stringify({}));
})

$(document).on('click','#depositarpasta',function(e){
    e.preventDefault();
    $.post('https://${GetParentResourceName()}/deposit', JSON.stringify({
        amount: $("#cantidaddepositar").val()
    }));
    $('body').fadeOut(500);
    $.post('http://osm-vbbanking/NUIFocusOff', JSON.stringify({}));
})

$(document).on('click','#transferirpasta',function(e){
    e.preventDefault();
    $.post('https://${GetParentResourceName()}/transfer', JSON.stringify({
        to: $("#iddestinatario").val(),
        amountt: $("#cantidadtransfer").val()
    }));
    $('body').fadeOut(500);
    $.post('http://osm-vbbanking/NUIFocusOff', JSON.stringify({}));
})

function hideall() {
    $(".qb-banking-container-inicio").hide();
    $(".qb-banking-bigcontainertarjetas").hide();
    $(".qb-banking-bigcontainerdepositar").hide();
    $(".qb-banking-bigcontainertransfer").hide();
    $(".qb-banking-bigcontainermyaccount").hide();
    $(".qb-banking-bigcontainerfaq").hide();
}

document.onkeyup = function(data){
    if (data.which == 27){
        $('body').fadeOut(500);
        $.post('http://osm-vbbanking/NUIFocusOff', JSON.stringify({}));
    }
}
