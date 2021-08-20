$(document).on('keydown', function() {
    switch(event.keyCode) {
        case 27: // ESC
            //Inventory.Close();
            break;
    }
});

var moneyTimeout = null;
var CurrentProx = 0;

(() => {
    QBHud = {};

    QBHud.Open = function(data) {
        $(".money-cash").css("display", "block");
        // $(".money-bank").css("display", "block");
        $("#cash").html(data.cash);
        // $("#bank").html(data.bank);
    };

    QBHud.Close = function() {

    };

    QBHud.Show = function(data) {
        if(data.type == "cash") {
            $(".money-cash").fadeIn(150);
            $("#cash").html(data.cash);
            setTimeout(function() {
                $(".money-cash").fadeOut(750);
            }, 3500)
        } 
    };

    QBHud.ToggleSeatbelt = function(data) {
        if (data.seatbelt) {
            $(".car-seatbelt-info img").attr('src', './seatbelt-on.png');
        } else {
            $(".car-seatbelt-info img").attr('src', './seatbelt.png');
        }
    };

    QBHud.CarHud = function(data) {
        if (data.show) {
            $(".ui-car-container").fadeIn();
            $("[data-voicetype='1']").animate({"top": "13.6vh"});
            $("[data-voicetype='2']").animate({"top": "14vh"});
            $("[data-voicetype='3']").animate({"top": "14.8vh"});
            $("[data-voicetype='1']").animate({"left": "3.8vh"});
            $("[data-voicetype='2']").animate({"left": "2.8vh"});
            $("[data-voicetype='3']").animate({"left": "2vh"});

            $('.hp-circle').animate({"top": "17.6vh"});
            $('.armor-circle').animate({"top": "20.5vh"});
            $('.food-circle').animate({"top": "14vh"});
            $('.thirst-circle').animate({"top": "17.5vh"});
            $('.stress-circle').animate({"top": "20.5vh"});

            $('.hp-circle').animate({"left": "30.21vh"});
            $('.armor-circle').animate({"left": "27.5vh"});
            $('.food-circle').animate({"left": "2.9vh"});
            $('.thirst-circle').animate({"left": "4.8vh"});
            $('.stress-circle').animate({"left": "7.5vh"});
        } else {
            $(".ui-car-container").fadeOut();
            $("[data-voicetype='1']").animate({"top": "2.4vh"});
            $("[data-voicetype='2']").animate({"top": "2vh"});
            $("[data-voicetype='3']").animate({"top": "2.4vh"});
            $("[data-voicetype='1']").animate({"left": "2.5vh"});
            $("[data-voicetype='2']").animate({"left": "1.35vh"});
            $("[data-voicetype='3']").animate({"left": ".2vh"});

            $('.food-circle').animate({"top": "21.5vh"});
            $('.thirst-circle').animate({"top": "21.5vh"});
            $('.stress-circle').animate({"top": "21.5vh"});

            $('.hp-circle').animate({"left": "0vh"});
            $('.armor-circle').animate({"left": "5vh"});
            $('.food-circle').animate({"left": "10vh"});
            $('.thirst-circle').animate({"left": "15vh"});
            $('.stress-circle').animate({"left": "20vh"});

            $('.hp-circle').animate({"top": "21.5vh"});
            $('.armor-circle').animate({"top": "21.5vh"});
        }
    };

    QBHud.UpdateHud = function(data) {
        var Show = "block";
        if (data.show) {
            Show = "none";
            $(".ui-container").css("display", Show);
            return;
        }
        $(".ui-container").css("display", Show);

        // HP Bar
        Progress(data.health - 100, ".hp");
        Progress(data.armor, ".armor");
        Progress(data.hunger, ".hunger");
        Progress(data.thirst, ".thirst");
        Progress(data.stress, ".stress");

        $('fuel').fadeIn(450);
        Progress(data.fuel.toFixed(0), ".fuel");
        $("#speed-amount").html(data.speed);

        if (data.seatbelt) {
            $(".car-belt").fadeOut(750);
        } else {
            $(".car-belt").fadeIn(750);
        }

        if (data.talking && data.radio) {
            $(".voice-block").css({"background-color": "#3467d4"}); 
        } else if (data.talking) {
            $(".voice-block").css({"background-color": "white"}); 
        } else {
            $(".voice-block").css({"background-color": "rgb(85, 85, 85)"}); 
        }
    };

    QBHud.UpdateProximity = function(data) {
        if (data.prox == 1) {
            $("[data-voicetype='1']").fadeIn(150);
            $("[data-voicetype='2']").fadeOut(150);
            $("[data-voicetype='3']").fadeOut(150);
        } else if (data.prox == 2) {
            $("[data-voicetype='1']").fadeIn(150);
            $("[data-voicetype='2']").fadeIn(150);
            $("[data-voicetype='3']").fadeOut(150);
        } else if (data.prox == 3) {
            $("[data-voicetype='1']").fadeIn(150);
            $("[data-voicetype='2']").fadeIn(150);
            $("[data-voicetype='3']").fadeIn(150);
        }
        CurrentProx = data.prox;
    }

    QBHud.SetTalkingState = function(data) {
        if (!data.IsTalking) {
            $(".voice-block").animate({"background-color": "rgb(255, 255, 255)"}, 150);
        } else {
            $(".voice-block").animate({"background-color": "#fc4e03"}, 150);
        }
    }

    QBHud.Update = function(data) {
        if(data.type == "cash") {
            $(".money-cash").css("display", "block");
            $("#cash").html(data.cash);
            if (data.minus) {
                $(".money-cash").append('<p class="moneyupdate minus">-<span id="cash-symbol">&euro;&nbsp;</span><span><span id="minus-changeamount">' + data.amount + '</span></span></p>')
                $(".minus").css("display", "block");
                setTimeout(function() {
                    $(".minus").fadeOut(750, function() {
                        $(".minus").remove();
                        $(".money-cash").fadeOut(750);
                    });
                }, 3500)
            } else {
                $(".money-cash").append('<p class="moneyupdate plus">+<span id="cash-symbol">&euro;&nbsp;</span><span><span id="plus-changeamount">' + data.amount + '</span></span></p>')
                $(".plus").css("display", "block");
                setTimeout(function() {
                    $(".plus").fadeOut(750, function() {
                        $(".plus").remove();
                        $(".money-cash").fadeOut(750);
                    });
                }, 3500)
            }
        }
    };

    function Progress(percent, element) {
        var circle = document.querySelector(element);
        var radius = circle.r.baseVal.value;
        var circumference = radius * 2 * Math.PI;
      
        circle.style.strokeDasharray = `${circumference} ${circumference}`;
        circle.style.strokeDashoffset = `${circumference}`;
      
        const offset = circumference - ((-percent * 100) / 100 / 100) * circumference;
        circle.style.strokeDashoffset = -offset;
    }

    window.onload = function(e) {
        window.addEventListener('message', function(event) {
            switch(event.data.action) {
                case "open":
                    QBHud.Open(event.data);
                    break;
                case "close":
                    QBHud.Close();
                    break;
                case "update":
                    QBHud.Update(event.data);
                    break;
                case "show":
                    QBHud.Show(event.data);
                    break;
                case "hudtick":
                    QBHud.UpdateHud(event.data);
                    break;
                case "car":
                    QBHud.CarHud(event.data);
                    break;
                case "seatbelt":
                    QBHud.ToggleSeatbelt(event.data);
                    break;
                case "nitrous":
                    QBHud.UpdateNitrous(event.data);
                    break;
                case "UpdateProximity":
                    QBHud.UpdateProximity(event.data);
                    break;
                case "talking":
                    QBHud.SetTalkingState(event.data);
                    break;
            }
        })
    }

})();