var dragTarget = null;
var dragOriginal = null;
var inTutorial = false;
$(document).ready(function() {
    window.addEventListener('message', function(event) {
        var data = event.data;


        if (data.open === 2) {
			if(inTutorial) return;

			$(".locations").removeClass("loc_compass");
			$(".time").removeClass("time_compass");
			$(".direction").removeClass("direction_compass");

            if (data.direction) {
                $(".direction").find(".image").attr('style', 'transform: translate3d(' + data.direction + 'px, 0px, 0px)');
                return;
            }

            $(".vehicle").removeClass("hide");

            $(".time").html(data.time);
            //$(".location").html(data.location);
            $(".currentspeed").html(data.speed);
            $(".currentfuel").html(data.fuel);
            $(".bike").show();
            $(".cruise_icon").show();
            $(".nos").show();
            $(".seatbelt").show();
            let beltType = '';
            if(data.belttype == 'harness') {
                $(".seatbelt_icon").hide();
				$(".harness_icon").show();
            } else {
                $(".seatbelt_icon").show();
				$(".harness_icon").hide();
            }

            if (data.seatbelt === true) {
				$(".seatbelt_icon").attr("src", "sb_on.png");
				$(".harness_icon").attr("src", "harness_on.png");
            } else {
				$(".seatbelt_icon").attr("src", "sb_off.png");
				$(".harness_icon").attr("src", "harness_off.png");
            }

            if (data.cruise === true) {
                let colorOff = (data.colorblind) ? 'blue' : 'green';
                $(".cruise").html(`<div class='${colorOff}'>SPEEDLIMIT</div>`);

				$(".cruise_icon").attr("src", "cruise_on.png");
            } else {
                let colorOff = (data.colorblind) ? 'yellow' : 'red';
                $(".cruise").html(`<div class='${colorOff}'>SPEEDLIMIT</div>`);

				$(".cruise_icon").attr("src", "cruise_off.png");
            }

            $(".nos").html("");
            $(".nos2").hide();

            var locationText = data.location;
            if (locationText.length > 54)
              locationText = locationText.substr(0, 54) + '...';
            $(".locations").text(locationText);

            if(data.nos.display) {
                $(".nos").html("" + data.nos.amount);
                $(".nos2").show();
                if(data.nos.active) {
                    var colorOff = (data.colorblind) ? 'red' : 'yellow';
                    $(".nos").removeClass('green');
                    $(".nos").removeClass('blue');
                    $(".nos").removeClass('red');
                    $(".nos").removeClass('yellow');
                    $(".nos").addClass(colorOff);
                }
                else {
                    if(data.nos.amount > 0) {
                        var colorOff = (data.colorblind) ? 'blue' : 'green';
                        $(".nos").removeClass('green');
                        $(".nos").removeClass('blue');
                        $(".nos").removeClass('red');
                        $(".nos").removeClass('yellow');
                        $(".nos").addClass(colorOff);
                    } else if(data.nos.amount == 0) {
                        var colorOff = (data.colorblind) ? 'yellow' : 'red';
                        $(".nos").removeClass('green');
                        $(".nos").removeClass('blue');
                        $(".nos").removeClass('red');
                        $(".nos").removeClass('yellow');
                        $(".nos").addClass(colorOff);
                    }
                }
            }
        }

        if (data.open === 5) {
			if(inTutorial) return;
            if (data.direction) {
                $(".direction").find(".image").attr('style', 'transform: translate3d(' + data.direction + 'px, 0px, 0px)');
                return;
            }

            $(".vehicle").removeClass("hide");
            $(".wrap").removeClass("lower");
            $(".currentfuel").empty();
            $(".time").html(data.time);
            $(".cruise").hide();
            $(".nos").hide();
            //$(".location").html(data.location);
            $(".bike").hide();
            $(".nos2").hide();
            $(".seatbelt").hide();
        }


        if (data.open === 4) {
			if(inTutorial) return;
            $(".vehicle").addClass("hide");
            $(".currentfuel").empty();
            $(".currentspeed").empty();
            //$(".location").empty();
            $(".time").empty();
            $(".time").html(data.time);
			$(".direction").find(".image").attr('style', 'transform: translate3d(' + data.direction + 'px, 0px, 0px)');
			$(".cruise").hide();
			$(".harness_icon").hide();
			$(".seatbelt_icon").hide();
			$(".cruise_icon").hide();
			$(".locations").addClass("loc_compass");
			$(".time").addClass("time_compass");
			$(".direction").addClass("direction_compass");
        }

        if (data.open === 3) {
			if(inTutorial) return;
            $(".hudui").fadeOut(100);
        }

        if (data.open === 1) {
			if(inTutorial) return;
            $(".hudui").fadeIn(100);
        }

        if (data.open === 30) {
            $(document.body).css("visibility", "hidden");
        }

        if (data.open === 31) {
            $(document.body).css("visibility", "visible");
        }
    });
});

$(document.body).ready(function()  {
	var mpX = window.screen.width / 1920 - 1;
	var mpY = window.screen.height / 1080 - 1;

	$(window).on("mousemove", function(e) {
		if(dragTarget) {
			var width = parseFloat(dragTarget.css("width")) / 2;
			var height = parseFloat(dragTarget.css("height")) / 2;
			dragTarget.css(
			{
				"position": "absolute",
				"left": (e.pageX - width) + "px",
				"top": (e.pageY - height) + "px",
				"z-index": "10000000000001"
			});
		}
	});

	$(window).on("mouseup", function(e) {
		if(dragTarget) {
			dragOriginal.css({
				"left": dragTarget.css("left"),
				"top": dragTarget.css("top")
			});
			dragTarget.remove();
			dragTarget = null;
			dragOriginal.show();
		}
	});

	$(window).on("keydown", function(e) {
		if(e.keyCode == 13) {
			if(inTutorial) {
				$(".setuptext").hide();

				var directionx = $(".direction").css("left");
				var directiony = $(".direction").css("top");
				var seatbeltx = $(".seatbelt_icon").css("left");
				var seatbelty = $(".seatbelt_icon").css("top");
				var cruisex = $(".cruise_icon").css("left");
				var cruisey = $(".cruise_icon").css("top");
				var locationx = $(".locations").css("left");
				var locationy = $(".locations").css("top");
				var timex = $(".time").css("left");
				var timey = $(".time").css("top");

				$(".setup").empty();
				$.post("https://qb-carhud/saveCarhudStuff", JSON.stringify({
					direction: {x: directionx, y: directiony},
					seatbelt: {x: seatbeltx, y: seatbelty},
					cruise: {x: cruisex, y: cruisey},
					location: {x: locationx, y: locationy},
					time: {x: timex, y: timey}
				}));

				placedownStuff(directionx, directiony, seatbeltx, seatbelty, cruisex, cruisey, locationx, locationy, timex, timey);
				$(".hudui").hide();
				$(".setup").css("visibility", "hidden");
				$(".setuptext").css("visibility", "hidden");
				inTutorial = false;

			}
		}
	});
});
