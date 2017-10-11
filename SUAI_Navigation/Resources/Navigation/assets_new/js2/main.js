var is_resized;
var SVGRoot;
var is_touch = true;
var WhereWeAre;
var WhereWeAre_element;
var WhereWeAre_matrix;
var browser_x_dif,browser_y_dif,browser_scroll_dif;
var floorGroups = new Array();
var floorNames = new Array();

var first_floor_line;
var first_floor_link;
var second_floor_line;
var second_floor_link;
var mainPage_link;
//var third_floor_line;
//var third_floor_link;
//var fourth_floor_line;
//var fourth_floor_link;

//0-hide,1-aud,2-route
var searchMenuType;
var searchBarHeight;
var isMobileVersion;

var windowHeight, windowWidth;
var isLoaded = false;

window.onload = function()
{
	MainLoadFunc();
}

window.onresize = function()
{
	MainLoadFunc();
}
function MainLoadFunc()
{
	windowWidth = window.innerWidth || document.body.clientWidth;
	windowHeight = window.innerHeight || document.body.clientHeight;
	var ID;
	if (!isLoaded)
	{
		SVGRoot = document.getElementsByTagName('svg')[0];
		WhereWeAre = 'main_map';
		isMobileVersion = true;

		WhereWeAre_element = SVGRoot.getElementById(WhereWeAre);
		WhereWeAre_matrix = WhereWeAre_element.getCTM();
	}

	var footerMenu = document.getElementById('footerMenu');
	var posy = windowHeight - footerMenu.getBoundingClientRect().height;
	placeDiv('footerMenu',posy, 'fixed');
	placeDiv('HelpInfo',posy,'fixed');


	searchBarHeight = 0;
	ResizeMainSVG();
	ToBrowserSize("main_map",100);
	WhereWeAre_matrix = WhereWeAre_element.getCTM();
	var centerH;
	centerH = (windowHeight)/2;
	var rect = WhereWeAre_element.getBoundingClientRect();
	var deltaY;
	deltaY =(centerH - rect.bottom/2);
	MoveSVG(0, deltaY);
	//ToBrowserSize("minimap",30);
	ToBrowserSize("LeftMenuPart",15);
	ToBrowserSize("RightMenuPart",70);
	MoveMinimap();

	if (!isLoaded)
	{
		SetAnimation();

		InitPathFinder(SVGRoot);

		floorNames.push("first_floor");
		floorNames.push("second_floor");
		floorNames.push("third_floor");
		floorNames.push("fourth_floor");

		for (var i=0;i<floorNames.length;++i)
			floorGroups.push(SVGRoot.getElementById(floorNames[i]));

		gettingLinksElements();

		var tmpEl = document.getElementById("loadingScreen");
		tmpEl.style.display = 'none';
		searchMenuType = 0;
		isLoaded = true;
	}
}

function placeDiv(name, y_pos, postype)
{
  var divEl = document.getElementById(name);
  var curHeight = divEl.clientHeight || divEl.offsetHeight;
  divEl.style.height = curHeight;
  divEl.setAttribute("style","display:block;height:" + curHeight + "px;");
  divEl.style.position = postype;
  divEl.style.left = 0+'px';
  divEl.style.top = y_pos+'px';
}

function gettingLinksElements()
{
	//first_floor_line = SVGRoot.getElementById("linkLine1");	
	first_floor_link = SVGRoot.getElementById("pointer1");	

	//second_floor_line = SVGRoot.getElementById("linkLine2");	
	second_floor_link = SVGRoot.getElementById("pointer2");	

	//third_floor_line = SVGRoot.getElementById("linkLine3");	
	third_floor_link = SVGRoot.getElementById("pointer3");	

	//fourth_floor_line = SVGRoot.getElementById("linkLine4");	
	fourth_floor_link = SVGRoot.getElementById("pointer4");	
	
	mainPage_link = SVGRoot.getElementById("pointerMain");
};

function IsTouchDevice()
{
	return 'ontouchstart' in window // works on most browsers 
	|| 'onmsgesturechange' in window; // works on ie10
};

function ResizeMainSVG()
{
	SVGRoot.setAttribute("width", ""+windowWidth+"");
	SVGRoot.setAttribute("height", ""+windowHeight+"");
	return;
}

function MoveMinimap()
{
	//LeftPart
	var curPartName = "LeftMenuPart";
	var curPartElem = SVGRoot.getElementById(curPartName);
	dx = 0;//-curPartElem.getBoundingClientRect().left;
	var matrix =curPartElem.getCTM();
	var s = "matrix(" +(matrix.a) + "," + matrix.b + "," + matrix.c+ "," + (matrix.d)
	+"," +( 15 ) + "," +  ((windowHeight)/2 - curPartElem.getBoundingClientRect().height/2) + ")";
	curPartElem.setAttribute("transform", s);
	
	//RightPart
	curPartName = "RightMenuPart";
	curPartElem = SVGRoot.getElementById(curPartName);
	dx = SVGRoot.getAttribute("width") - curPartElem.getBoundingClientRect().width - 15;
	matrix =curPartElem.getCTM();
	s = "matrix(" +(matrix.a) + "," + matrix.b + "," + matrix.c+ "," + (matrix.d)
	+"," +( dx ) + "," + (searchBarHeight) + ")";
	curPartElem.setAttribute("transform", s);
}

function ToBrowserSize(ID, percent)
{	
	var dx,dy;
	var el_width,el_height;
	g = SVGRoot.getElementById(ID);

	el_width = g.getBoundingClientRect().width;
	el_height = g.getBoundingClientRect().height;
	dx = el_width - windowWidth;
	dy = el_height - windowHeight;

	browser_scroll_dif=0;
	matrix =g.getCTM();
	if ((dx>0)||(dy>0))
	{		
		if (dx>dy)
			browser_scroll_dif = el_width/windowWidth;
		else
			browser_scroll_dif = el_height/windowHeight;
		browser_scroll_dif = browser_scroll_dif / (percent/100);
		var screen_center = windowWidth/2  - (el_width/browser_scroll_dif)/2;

		s = "matrix(" +(matrix.a/browser_scroll_dif) + "," + matrix.b + "," + matrix.c+ "," + (matrix.d/browser_scroll_dif)
		+"," +( Math.abs(screen_center) ) + "," +  (windowHeight/2  - (el_height/browser_scroll_dif)/2) + ")";
		g.setAttribute("transform", s);
		return;		
	}
	if ((dx<0)||(dy<0))
	{
        if ((windowWidth/el_width)<(windowHeight/el_height))
			browser_scroll_dif = windowWidth/el_width;
		else
			browser_scroll_dif = windowHeight/el_height;
		
		browser_scroll_dif = browser_scroll_dif*(percent/100);
		s = "matrix(" +(matrix.a*browser_scroll_dif) + "," + matrix.b + "," + matrix.c+ "," + (matrix.d*browser_scroll_dif)
		+"," +( 0 ) + "," +  (0) + ")";
		g.setAttribute("transform", s);
		return;		
	}
}

function SetAnimation()
{
	var currentCoords = SVGRoot.createSVGPoint();
	var positionCoords = null; 
	var center_x = 0;
	var center_y = 0;	
	var prev_diff_x = 0;
	var prev_diff_y = 0;
	var now_diff_x = 0;
	var now_diff_y = 0;
	var scaleFactor = 1.1;	
	var isMoving = false;
	var matrixXPos=0, matrinxYPos=0;
	//WhereWeAre_element
	//WhereWeAre_matrix
	var pt  = SVGRoot.createSVGPoint();
	var HandleMousedown = function(evt)
	{	
		if (isMoving)
			return;
		evt = evt || window.event;

		positionCoords = SVGRoot.createSVGPoint();
		var evt_touch;
		evt_touch = evt.touches[evt.touches.length-1];
		positionCoords.x = (evt_touch.pageX- Number(WhereWeAre_matrix.e));
		positionCoords.y = (evt_touch.pageY- Number(WhereWeAre_matrix.f));

	}

	var HandleMousemove = function (evt)
	{
		evt.preventDefault();
		evt.returnValue = false;
		isMoving = true;

			// For touch-input
			if (evt.touches != null)
			{
				if (evt.touches.length >1)
				{
					prev_diff_x = now_diff_x;
					prev_diff_y = now_diff_y;

					now_diff_x = Math.abs(evt.touches[0].pageX - evt.touches[1].pageX);
					now_diff_y = Math.abs(evt.touches[0].pageY - evt.touches[1].pageY);

					center_x = (evt.touches[0].pageX + evt.touches[1].pageX)/2;
					center_y = (evt.touches[0].pageY + evt.touches[1].pageY)/2;

					if ((now_diff_x>prev_diff_x)&&(now_diff_y>prev_diff_y))
					{
						HandletouchZoom(0.35);
						isMoving = false;
						return;
					}
					if ((now_diff_x<prev_diff_x)&&(now_diff_y<prev_diff_y))
					{
						HandletouchZoom(-0.35);
						isMoving = false;
						return;
					}
					isMoving = false;
					return;
				}
			}
			
			var evt_touch;
			evt_touch = evt.touches[evt.touches.length-1];
			currentCoords.x = evt_touch.pageX;
			currentCoords.y = evt_touch.pageY;

		if (positionCoords)
		{
			var newX = currentCoords.x - positionCoords.x;
			var newY = currentCoords.y - positionCoords.y;

			var s = "matrix(" + WhereWeAre_matrix.a + "," + WhereWeAre_matrix.b + "," + WhereWeAre_matrix.c + "," + WhereWeAre_matrix.d + "," + ( newX) + "," + ( newY) + ")";
			
			WhereWeAre_element.setAttribute("transform", s);
			WhereWeAre_matrix.e = newX;
			WhereWeAre_matrix.f = newY;
		}
		isMoving = false;
	}

	var HandleMouseup = function(evt)
	{
		positionCoords = null;
	}

	var HandleScroll = function(evt)
	{
		evt.preventDefault();
		evt.returnValue = false;

		var delta = evt.wheelDelta ? evt.wheelDelta/40 : evt.detail ? -evt.detail : 0;
		if (delta)
			zoom(delta);
		return evt.preventDefault() && false;
	}

	var zoom = function(clicks)
	{
		pt.x = currentCoords.x;
		pt.y = currentCoords.y;

		pt = pt.matrixTransform(WhereWeAre_matrix.inverse());
		var z = Math.pow(scaleFactor,clicks);
		var k = SVGRoot.createSVGMatrix().translate(pt.x, pt.y).scale(z).translate(-pt.x, -pt.y);
		var matrix =WhereWeAre_matrix.multiply(k);
		var s = "matrix(" +matrix.a + "," + matrix.b + "," + matrix.c + "," + matrix.d+"," + matrix.e + "," +  matrix.f + ")";
		if (matrix.a>4)
			return;
		if (matrix.a<0.25)
			return;
		WhereWeAre_element.setAttribute("transform", s);       
		WhereWeAre_matrix = matrix;//--WhereWeAre_element.getCTM();
	}  

	var HandletouchZoom = function(clicks)
	{
		pt.x = center_x;
		pt.y = center_y;

		pt = pt.matrixTransform(WhereWeAre_matrix.inverse());
		var z = Math.pow(scaleFactor,clicks);
		var k = SVGRoot.createSVGMatrix().translate(pt.x, pt.y).scale(z).translate(-pt.x, -pt.y);
		var matrix =WhereWeAre_matrix.multiply(k);
		var s = "matrix(" +matrix.a + "," + matrix.b + "," + matrix.c + "," + matrix.d+"," + matrix.e + "," +  matrix.f + ")";
		if ((matrix.a>4)&&(clicks>0))
			return;
		if ((matrix.a<0.25)&&(clicks<0))
			return;
		WhereWeAre_element.setAttribute("transform", s);      
		WhereWeAre_matrix = matrix;//--WhereWeAre_element.getCTM(); 
	}				

	var HandleOrientationChanged = function(evt)
	{
		//from window.onload
		//ResizeFunction();
	};
		document.addEventListener("touchstart", HandleMousedown, false);
		document.addEventListener("touchend", HandleMouseup, false);
		document.addEventListener("touchleave", HandleMouseup, false);
		document.addEventListener("touchmove", HandleMousemove, false);
                var supportsOrientationChange = "onorientationchange" in window;
                //alert(supportsOrientationChange );
                var orientationEvent = supportsOrientationChange ? "orientationchange" : "resize";
		document.addEventListener(orientationEvent , HandleOrientationChanged, false);
}


function HandleButtonZoom(scale)
{
	var currentCoords = SVGRoot.createSVGPoint();
	var positionCoords = null;

	var pt  = SVGRoot.createSVGPoint();
	pt.x = SVGRoot.getBoundingClientRect().width/2;
	pt.y = SVGRoot.getBoundingClientRect().height/2;

	pt = pt.matrixTransform(WhereWeAre_matrix.inverse());
	var z = Math.pow(1.2,scale);
	var k = SVGRoot.createSVGMatrix().translate(pt.x, pt.y).scale(z).translate(-pt.x, -pt.y);
	var matrix =WhereWeAre_matrix.multiply(k);
	var s = "matrix(" +matrix.a + "," + matrix.b + "," + matrix.c + "," + matrix.d+"," + matrix.e + "," +  matrix.f + ")";
	if ((matrix.a>4)&&(scale>0))
		return;
	if ((matrix.a<0.25)&&(scale<0))
		return;
	WhereWeAre_element.setAttribute("transform", s);
	WhereWeAre_matrix = matrix;//--WhereWeAre_element.getCTM();
}

function GiveCorpusMatrix(WhatToShow)
{
	switch (WhatToShow)
	{
		case '1':
			var s = "matrix(" +(0.58) + "," + 0 + "," + 0 + "," + (0.58)+"," + -34+ "," + -870 + ")";
			return s;
			break;
		case '2':
			var s = "matrix(" +0.58 + "," + 0 + "," + 0 + "," + 0.58+"," + -116 + "," + -608 + ")";
			return s;
			break;
		case '3':
			var s = "matrix(" +1.03 + "," + 0 + "," + 0 + "," + 1.03+"," + -382 + "," + -1132 + ")";
			return s;
			break;
		case '4':
			var s = "matrix(" +0.78 + "," + 0 + "," + 0 + "," + 0.78+"," + -50 + "," + -372 + ")";
			return s;
			break;
		case '5':
			var s = "matrix(" +0.58 + "," + 0 + "," + 0 + "," + 0.58+"," + 408 + "," + -571 + ")";
			return s;
			break;
		case '6':
			var s = "matrix(" +0.77 + "," + 0 + "," + 0 + "," + 0.77+"," + -133 + "," + 224 + ")";
			return s;
			break;
	}
}

function ToFirst(WhatCorpus)
{
	ChangingFloors(WhereWeAre,'first_floor');

	WhereWeAre_element.style.display = 'none';
	WhereWeAre='first_floor';
	WhereWeAre_element = SVGRoot.getElementById(WhereWeAre);
	//WhereWeAre_matrix = WhereWeAre_element.getCTM();
	var s = GiveCorpusMatrix(WhatCorpus);
	WhereWeAre_element.setAttribute("transform", s); 
	WhereWeAre_matrix = WhereWeAre_element.getCTM();
	WhereWeAre_element.style.display = 'block';
}

var firstly=1;

function ToNewFloor(ShowID)
{
	if (WhereWeAre==ShowID)
		return;
	ChangingFloors(WhereWeAre, ShowID);
	WhereWeAre_element.style.display = 'none';
	var e1 = document.getElementById(ShowID);
	//var matrNew = e1.getCTM();
	var s;
	if (ShowID=='main_map')
	{
		s = "matrix(" + 1 + "," + 0 + "," + 0 + "," + 1 + "," + 0 + "," + 0 + ")";
		firstly=1;
	}
	else
		if (WhereWeAre=='main_map')
		{
			s= "matrix(" + 0.33 + "," + 0 + "," + 0 + "," + 0.33 +"," + 150 + "," + 0 + ")";
			firstly=1;
		}
		else
		{
			var matrOld = WhereWeAre_matrix;
			if (WhereWeAre == 'first_floor')
			{
				firstly=0;
                s = "matrix(" + matrOld.a + "," + matrOld.b + "," + matrOld.c + "," + matrOld.d + "," + matrOld.e + "," + matrOld.f + ")";
		    }

		    if (WhereWeAre == 'second_floor')
			{
				firstly=0;
		        s = "matrix(" + matrOld.a + "," + matrOld.b + "," + matrOld.c + "," + matrOld.d + "," + matrOld.e + "," + matrOld.f + ")";
		    }

		    if (WhereWeAre == 'third_floor')
			{
				firstly=0;
		        s = "matrix(" + matrOld.a + "," + matrOld.b + "," + matrOld.c + "," + matrOld.d + "," + matrOld.e + "," + matrOld.f + ")";
		    }

		    if (WhereWeAre == 'fourth_floor')
			{
				firstly=0;
		        s = "matrix(" + matrOld.a + "," + matrOld.b + "," + matrOld.c + "," + matrOld.d + "," + matrOld.e + "," + matrOld.f + ")";
		    }
		}
	
	WhereWeAre_element = e1;
	WhereWeAre_element.setAttribute("transform", s); 
	WhereWeAre_element.style.display = 'block';
	
	if (firstly)
		ToBrowserSize(ShowID,100);	
	
	WhereWeAre=ShowID;
	WhereWeAre_matrix = WhereWeAre_element.getCTM();
}

function ChangingFloors(HideID,ShowID)
{
	switch (HideID)
	{
		case 'first_floor':		
		//first_floor_line.style.display='block';
		first_floor_link.style.display='none';
		break;
		case 'second_floor':
		//second_floor_line.style.display='block';
		second_floor_link.style.display='none';
		break;
		case 'third_floor':
		//third_floor_line.style.display = 'block';
		third_floor_link.style.display = 'none';
		break;
		case 'fourth_floor':
		//fourth_floor_line.style.display = 'block';
		fourth_floor_link.style.display = 'none';
		case 'main_map':
		mainPage_link.style.display = 'none';
		break;
	}
	switch (ShowID)
	{
		case 'first_floor':
		//first_floor_line.style.display='none';
		first_floor_link.style.display='block';
		break;
		case 'second_floor':
		//second_floor_line.style.display='none';
		second_floor_link.style.display='block';
		break;
		case 'third_floor':
		//third_floor_line.style.display = 'none';
		third_floor_link.style.display = 'block';
		break;
		case 'fourth_floor':
		//fourth_floor_line.style.display = 'none';
		fourth_floor_link.style.display = 'block';
		break;
		case 'main_map':
		mainPage_link.style.display = 'block';
		break;
	}
	return;
}

function MoveSVG(deltaX,deltaY)
{
	var positionCoords = SVGRoot.createSVGPoint();

	positionCoords.x =Number(WhereWeAre_matrix.e);
	positionCoords.y =Number(WhereWeAre_matrix.f);
	var newX = positionCoords.x + deltaX;
	var newY = positionCoords.y + deltaY;

	var s = "matrix(" + WhereWeAre_matrix.a + "," + WhereWeAre_matrix.b + "," + WhereWeAre_matrix.c + "," + WhereWeAre_matrix.d + "," + (WhereWeAre_matrix.e = newX) + "," + (WhereWeAre_matrix.f = newY) + ")";
	WhereWeAre_element.setAttribute("transform", s);
	WhereWeAre_matrix = WhereWeAre_element.getCTM();
}

function HandleKeyPressed()
{ 
	var delta = 150;
	if (event.keyCode==37)
	{
		event.returnValue = false;
		if(event.preventDefault) event.preventDefault();
		MoveSVG(-delta,0);		
	}
	if (event.keyCode==38)
	{
		event.returnValue = false;
		if(event.preventDefault) event.preventDefault();
		MoveSVG(0,-delta);		
	}
	if (event.keyCode==39)
	{
		event.returnValue = false;
		if(event.preventDefault) event.preventDefault();
		MoveSVG(delta,0);		
	}
	if (event.keyCode==40)
	{	
		event.returnValue = false;
		if(event.preventDefault) event.preventDefault();
		MoveSVG(0,delta);		
	}
	return false;
}

function SVGElementContain(container, element)
{
	
	for (var i=0;i<container.childNodes.length;++i)
	{
		if (container.childNodes[i] == element)
		{
			return true;
		}
		else
			for (var j=0;j<container.childNodes[i].childNodes.length;++j)
			{
				if (SVGElementContain(container.childNodes[i].childNodes[j],element))
					return true;
			}
	}
	return false;
};

function NavigateToElementOnScreen(element)
{	
	for (var i=0;i<floorGroups.length;++i)
		if (floorGroups[i].contains(element))
		{
			ToNewFloor(floorNames[i]);
			break;
		}	
	
	var s = "matrix(" + 1.5 + "," + WhereWeAre_matrix.b + "," + WhereWeAre_matrix.c + "," + 1.5 +"," + 0 + "," +  0 + ")";
	WhereWeAre_element.setAttribute("transform", s); 
	WhereWeAre_matrix = WhereWeAre_element.getCTM();
	
	var centerW,centerH;
	centerW = (window.innerWidth || document.body.clientWidth)/2;
	centerH = (window.innerHeight || document.body.clientHeight)/2;

	var rect = element.getBoundingClientRect();
	var deltaX, deltaY;

	deltaX = centerW - rect.left;
	deltaY = centerH - rect.top;
	MoveSVG(deltaX, deltaY);	
}

var interval, timeout;
function ShowCustomAlert(alertText)
{
	var element  = document.getElementById("openModal");
	element.style.opacity = 1;

	clearInterval(interval);
	clearTimeout(timeout);

	var value = document.getElementById("textNotify");
	value.innerHTML = alertText;
	timeout = setTimeout(function() 
					{
						interval = setInterval(function ()
							{
							element.style.opacity -= .06;
							}, 50);
							setTimeout(function() {
							clearInterval(interval);
							},2500);
					},4000);	
};

function ChangeSrcAndDst()
{
	var srcElement  = document.getElementById("srcRoomBox");
	var srcVal = srcElement.value;
	var dstElement = document.getElementById("dstRoomBox");
	srcElement.value = dstElement.value;
	dstElement.value = srcVal;
};
