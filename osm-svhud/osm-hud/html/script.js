var options = {
	fontSize: "0px",
	fontFamily: "Arial",
	fontFillStyle: "white",
	drawShadow: false,
	drawText: false,
	drawPercentageSign: false,
	drawBubbles: false,
	size: 50,
	borderWidth: 0.0000000000000000000000000001,
	backgroundColor: "#2b2b2b",
	foregroundColor: "#000000",
	foregroundFluidLayer: {
	  fillStyle: "rgb(34,139,34)",
	  angularSpeed: 0,
	  maxAmplitude: 4,
	  frequency: 30,
	  horizontalSpeed: -150
	},
	backgroundFluidLayer: {
	  fillStyle: "rgb(34,139,34)",
	  angularSpeed: 0,
	  maxAmplitude: 1,
	  frequency: 30,
	  horizontalSpeed: 150
	}
}

var health = new FluidMeter();
health.init({
  targetContainer: document.getElementById("healthliq"),
  fillPercentage: 0,
  options: options
});

var armor = new FluidMeter();
options.foregroundFluidLayer.fillStyle = "rgb(0,66,225)";
options.backgroundFluidLayer.fillStyle = "rgb(0, 116, 225)";
armor.init({
  targetContainer: document.getElementById("shieldliq"),
  fillPercentage: 0,
  options: options
});

var hunger = new FluidMeter();
options.foregroundFluidLayer.fillStyle = "rgb(249,121,6)";
options.backgroundFluidLayer.fillStyle = "rgb(249, 176, 6)";
hunger.init({
  targetContainer: document.getElementById("hungerliq"),
  fillPercentage: 0,
  options: options
});

var thirst = new FluidMeter();
options.foregroundFluidLayer.fillStyle = "rgb(25,130,158)";
options.backgroundFluidLayer.fillStyle = "rgb(25, 87, 158)";
thirst.init({
  targetContainer: document.getElementById("thirstliq"),
  fillPercentage: 0,
  options: options
});

var oxygen = new FluidMeter();
options.foregroundFluidLayer.fillStyle = "rgb(22,155,139)";
options.backgroundFluidLayer.fillStyle = "rgb(22, 155, 120)";
oxygen.init({
  targetContainer: document.getElementById("oxygenliq"),
  fillPercentage: 0,
  options: options
});

options.drawBubbles = false;

var stress = new FluidMeter();
options.foregroundFluidLayer.fillStyle = "rgb(193,39,45)";
options.backgroundFluidLayer.fillStyle = "rgb(201, 40, 47)";
stress.init({
  targetContainer: document.getElementById("stressliq"),
  fillPercentage: 0,
  options: options
});

var speakcolor = "rgb(40, 255, 3)";
var whispercolor = "rgb(251, 255, 0)";
var loudcolor = "rgb(255, 68, 0)";
var voice = new FluidMeter();
options.foregroundFluidLayer.fillStyle = speakcolor;
options.backgroundFluidLayer.fillStyle = speakcolor;
options.voice = true;
voice.init({
  targetContainer: document.getElementById("voiceliq"),
  fillPercentage: 0,
  options: options
});

var mph = new FluidMeter();
options.foregroundFluidLayer.fillStyle = "rgb(0, 81, 255)";
options.backgroundFluidLayer.fillStyle = "rgb(0, 132, 255)";
options.size = 70;
options.voice = false;
options.mph = true;
mph.init({
  targetContainer: document.getElementById("mphliq"),
  fillPercentage: 0,
  options: options
});

options.size = 50;
options.mph = false;

var gas = new FluidMeter();
options.foregroundFluidLayer.fillStyle = "rgb(255, 42, 0)";
options.backgroundFluidLayer.fillStyle = "rgb(255, 87, 54)";
gas.init({
  targetContainer: document.getElementById("gasliq"),
  fillPercentage: 0,
  options: options
});

var nos = new FluidMeter();
options.foregroundFluidLayer.fillStyle = "rgb(0, 132, 255)";
options.backgroundFluidLayer.fillStyle = "rgb(69, 165, 255)";
nos.init({
  targetContainer: document.getElementById("nosliq"),
  fillPercentage: 0,
  options: options
});

var c2left = {};
var c2leftCur = 0;
var c2bottom = {};
var c2bottomCur = 0;
var horizontalDist = 0;
var verticalDist = 0;

function handleAdjust(field, value) {
	if(field == "left") {
		c2leftCur = value;
		$(".healthveh, .shieldveh, .hungerveh, .thirstveh, .oxygenveh, .stressveh").each(function() {
			if(!c2left[$(this).attr("class")]) c2left[$(this).attr("class")] = parseFloat($(this).css("left"));
			$(this).css("left", ((c2left[$(this).attr("class")] + c2leftCur) - horizontalDist) + "px");
		});
		
		$(".mphholder, .gasholder, .nosholder, .voiceveh").each(function() {
			if(!c2left[$(this).attr("class")]) c2left[$(this).attr("class")] = parseFloat($(this).css("left"));
			$(this).css("left", ((c2left[$(this).attr("class")] + c2leftCur) + horizontalDist) + "px");
		});
	}
	
	if(field == "bottom") {
		$(".healthveh, .shieldveh, .hungerveh, .thirstveh, .oxygenveh, .stressveh, .mphholder, .gasholder, .nosholder, .voiceveh").each(function() {
			if(!c2bottom[$(this).attr("class")]) c2bottom[$(this).attr("class")] = parseFloat($(this).css("bottom"));
			c2bottomCur = value;
			$(this).css("bottom", (c2bottom[$(this).attr("class")] + c2bottomCur + value) + "px");
		});
	}
	
	if(field == "horizontal") {
		horizontalDist = value;
		$(".healthveh, .shieldveh, .hungerveh, .thirstveh, .oxygenveh, .stressveh").each(function() {
			if(!c2left[$(this).attr("class")]) c2left[$(this).attr("class")] = parseFloat($(this).css("left"));
			$(this).css("left", ((c2left[$(this).attr("class")] + c2leftCur) - horizontalDist) + "px");
		});
		
		$(".mphholder, .gasholder, .nosholder, .voiceveh").each(function() {
			if(!c2left[$(this).attr("class")]) c2left[$(this).attr("class")] = parseFloat($(this).css("left"));
			$(this).css("left", ((c2left[$(this).attr("class")] + c2leftCur) + horizontalDist) + "px");
		});
	}
}

window.addEventListener('message', function (event) {

	switch (event.data.action) {
		case 'adjust':
			handleAdjust(event.data.field, event.data.value);
			break;
		case 'postvalues':
			var healthx = $(".healthveh").css("left");
			var healthy = $(".healthveh").css("bottom");
			var shieldx = $(".shieldveh").css("left");
			var shieldy = $(".shieldveh").css("bottom");
			var hungerx = $(".hungerveh").css("left");
			var hungery = $(".hungerveh").css("bottom");
			var thirstx = $(".thirstveh").css("left");
			var thirsty = $(".thirstveh").css("bottom");
			var oxygenx = $(".oxygenveh").css("left");
			var oxygeny = $(".oxygenveh").css("bottom");
			var stressx = $(".stressveh").css("left");
			var stressy = $(".stressveh").css("bottom");
			var voicex  = $(".voiceveh").css("left");
			var voicey  = $(".voiceveh").css("bottom");
			var mphx    = $(".mphholder").css("left");
			var mphy    = $(".mphholder").css("bottom");
			var gasx    = $(".gasholder").css("left");
			var gasy    = $(".gasholder").css("bottom");
			var nosx    = $(".nosholder").css("left");
			var nosy    = $(".nosholder").css("bottom");
			
			$.post(`https://${scriptName}/postValues`, JSON.stringify({
				health: {x: healthx, y: healthy},
				shield: {x: shieldx, y: shieldy},
				hunger: {x: hungerx, y: hungery},
				thirst: {x: thirstx, y: thirsty},
				oxygen: {x: oxygenx, y: oxygeny},
				stress: {x: stressx, y: stressy},
				voice:  {x: voicex,  y: voicey},
				mph:    {x: mphx,    y: mphy},
				gas:    {x: gasx, y: gasy},
				nos:    {x: nosx, y: nosy},
			}));
			
			break;
		case 'readvalues':
			$(".healthveh").css("left", event.data.values.health.x);
			$(".healthveh").css("bottom", event.data.values.health.y);
			$(".shieldveh").css("left", event.data.values.shield.x);
			$(".shieldveh").css("bottom", event.data.values.shield.y);
			$(".hungerveh").css("left", event.data.values.hunger.x);
			$(".hungerveh").css("bottom", event.data.values.hunger.y);
			$(".thirstveh").css("left", event.data.thirst.x);
			$(".thirstveh").css("bottom", event.data.thirst.y);
			$(".oxygenveh").css("left", event.data.oxygen.x);
			$(".oxygenveh").css("bottom", event.data.oxygen.y);
			$(".stressveh").css("left", event.data.stress.x);
			$(".stressveh").css("bottom", event.data.stress.y);
			$(".voiceveh").css("left", event.data.voice.x);
			$(".voiceveh").css("bottom", event.data.voice.y);
			$(".mphholder").css("left", event.data.mph.x);
			$(".mphholder").css("bottom", event.data.mph.y);
			$(".gasholder").css("left", event.data.gas.x);
			$(".gasholder").css("bottom", event.data.gas.y);
			$(".nosholder").css("left", event.data.nos.x);
			$(".nosholder").css("bottom", event.data.nos.y);
			
			break;
        case 'updateStatusHud':
            $("body").css("display", event.data.show ? "block" : "none");
            if(event.data.health != undefined) health.setPercentage(event.data.health);
            if(event.data.armour != undefined) armor.setPercentage(event.data.armour);
            if(event.data.hunger != undefined) hunger.setPercentage(event.data.hunger);
            if(event.data.thirst != undefined) thirst.setPercentage(event.data.thirst);
            if(event.data.oxygen != undefined) oxygen.setPercentage(event.data.oxygen);
            if(event.data.stress != undefined) stress.setPercentage(event.data.stress);
			if(event.data.gas != undefined) gas.setPercentage(event.data.gas);
			if(event.data.mph != undefined) {
				mph.setPercentage(event.data.mph);
				$("#currentmph").text("" + event.data.mph);
			}
			if(event.data.nos != undefined) nos.setPercentage(event.data.nos);
			break;
		case 'hudCarPos':
			$("#healthliq").stop().fadeOut(500);
			$("#shieldliq").stop().fadeOut(500);
			$("#hungerliq").stop().fadeOut(500);
			$("#thirstliq").stop().fadeOut(500);
			$("#oxygenliq").stop().fadeOut(500);
			$("#stressliq").stop().fadeOut(500);
			$("#voiceliq").stop().fadeOut(500, function() {
				$(".healthveh").append($("#healthliq"));
				$(".shieldveh").append($("#shieldliq"));
				$(".hungerveh").append($("#hungerliq"));
				$(".thirstveh").append($("#thirstliq"));
				$(".oxygenveh").append($("#oxygenliq"));
				$(".stressveh").append($("#stressliq"));
				$(".voiceveh").append($("#voiceliq"));
				
				$("#healthliq").stop().fadeIn(500);
				$("#shieldliq").stop().fadeIn(500);
				$("#hungerliq").stop().fadeIn(500);
				$("#thirstliq").stop().fadeIn(500);
				$("#oxygenliq").stop().fadeIn(500);
				$("#stressliq").stop().fadeIn(500);
				$("#voiceliq").stop().fadeIn(500);
			});
			break;
		case 'regularPos':
			$("#healthliq").stop().fadeOut(500);
			$("#shieldliq").stop().fadeOut(500);
			$("#hungerliq").stop().fadeOut(500);
			$("#thirstliq").stop().fadeOut(500);
			$("#oxygenliq").stop().fadeOut(500);
			$("#stressliq").stop().fadeOut(500);
			$("#mphliq").stop().fadeOut(500);
			$("#gasliq").stop().fadeOut(500);
			$("#nosliq").stop().fadeOut(500);
			$("#voiceliq").stop().fadeOut(500, function() {
				$("#healthreg").append($("#healthliq"));
				$("#shieldreg").append($("#shieldliq"));
				$("#hungerreg").append($("#hungerliq"));
				$("#thirstreg").append($("#thirstliq"));
				$("#oxygenreg").append($("#oxygenliq"));
				$("#stressreg").append($("#stressliq"));
				$("#voicereg").append($("#voiceliq"));
				
				$("#healthliq").stop().fadeIn(500);
				$("#shieldliq").stop().fadeIn(500);
				$("#hungerliq").stop().fadeIn(500);
				$("#thirstliq").stop().fadeIn(500);
				$("#oxygenliq").stop().fadeIn(500);
				$("#stressliq").stop().fadeIn(500);
				$("#voiceliq").stop().fadeIn(500);
			});
			break;
		case 'voicemode':
			if(event.data.mode == "whisper") voice.setBothFluidColors(whispercolor);
			else if(event.data.mode == "speak") voice.setBothFluidColors(speakcolor);
			else if(event.data.mode == "loud") voice.setBothFluidColors(loudcolor);
		
			$(".voiceic").attr("src", event.data.mode + ".png");
			break;
		case 'voicestate':
			if(event.data.state == 1) {
				voice.setPercentage(100);
			} else {
				voice.setPercentage(0);
			}
			break;
		case 'toggleCarHud':
			if(event.data.toggle) {
				$("#mphliq").stop().fadeIn(500);
				$("#gasliq").stop().fadeIn(500);
				$("#nosliq").stop().fadeIn(500);
			} else {
				$("#mphliq").stop().fadeOut(500);
				$("#gasliq").stop().fadeOut(500);
				$("#nosliq").stop().fadeOut(500);
			}
			break;
    }
});

function widthHeightSplit(value, ele) {
    let height = 25.5;
    let eleHeight = (value / 100) * height;
    let leftOverHeight = height - eleHeight;

    ele.css("height", eleHeight + "px");
    ele.css("top", leftOverHeight + "px");
};