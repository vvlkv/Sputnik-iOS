
var is_resized;
var SVGRoot;
var SVGRoot_width, SVGRoot_height;
var SVGRoot_alwaysVisibleSize = 50;
//1 - touch
//2 - mouse
//3 - both
var deviceType;
var WhereWeAre;
var WhereWeAre_element;
var WhereWeAre_matrix;
var browser_x_dif,browser_y_dif,browser_scroll_dif;
var floorNames = new Array();

var first_floor_link;
var second_floor_link;
var mainPage_link;
var third_floor_link;
var fourth_floor_link;

//0-hide,1-aud,2-route
var searchMenuType;
var searchBarHeight = 0;
var isMobileVersion;
var wasLastActiveInputType = false;

//element
//	|---type(dean,dep,other)
//	|---name
//	|---auditory
//	|---telephone 	//opt
//	|---time		//opt
//	|---header		//opt
var dataBase = new Array();
var dict_auds = new Object();
var BMAudsSinonims = new Array();

var maxZoom = 0.25, minZoom = 6;
var scale_LeftMenuPart = 13, scale_RightMenuPart = 30;
var currentPageAddr = "http://sputnik.guap.ru/nav";
var currentCorpus = "BM";
var selectedAud = "";
var isLoaded = false;

function InitWebViewContent()
{
	if (!isLoaded)
	{
		GetMap_BM();
		CheckOSType();
//        HidePreloader();    

		searchMenuType = 0;
		IndependentInit();
		isLoaded = true;
	}
	else
	{
		ResizeMainSVG();
		ToBrowserSize("LeftMenuPart",scale_LeftMenuPart);
		ToBrowserSize("RightMenuPart",scale_RightMenuPart);	
		ToBrowserSize("main_map",100);
		MoveMinimap();	

		WhereWeAre_matrix = WhereWeAre_element.getCTM();
		var centerH, centerW;
		centerH = (window.innerHeight || document.body.clientHeight)/2;
		centerW = (window.innerWidth || document.body.clientWidth)/2;
		var rect = WhereWeAre_element.getBoundingClientRect();
		var deltaY, deltaX;
		deltaY = (centerH - rect.bottom/2);
		deltaX = (centerW - rect.right/2);
	}
};

window.onload = function()
{	
	InitWebViewContent();
}

window.onresize = function(evt)
{
	var retVal = true;
	if ((deviceType===1)||(deviceType===3)||isMobileVersion)
	{
		retVal = false;
		evt.preventDefault();
		evt.returnValue = false;
	}
	if (document.activeElement.tagName.toLowerCase() === 'input')
	{
		wasLastActiveInputType = true;
		return retVal;
	}
	if (wasLastActiveInputType)
	{
		if (document.activeElement.tagName.toLowerCase() === 'body')
			return retVal;
		wasLastActiveInputType = false;
		return retVal;
	}
	ResizeMainSVG();
	ToBrowserSize("LeftMenuPart",scale_LeftMenuPart);
	ToBrowserSize("RightMenuPart",scale_RightMenuPart);	
	ToBrowserSize("main_map",100);
	MoveMinimap();	

	WhereWeAre_matrix = WhereWeAre_element.getCTM();
	var centerH, centerW;
	centerH = (window.innerHeight || document.body.clientHeight)/2;
	centerW = (window.innerWidth || document.body.clientWidth)/2;
	var rect = WhereWeAre_element.getBoundingClientRect();
	var deltaY, deltaX;
	deltaY = (centerH - rect.bottom/2);
	deltaX = (centerW - rect.right/2);
	//MoveSVG(deltaX, deltaY);
	return retVal;
};

document.onresize = function(evt)
{
	evt.preventDefault();
	evt.returnValue = false;
	
	if (document.activeElement.tagName.toLowerCase() === 'input')
	{
		wasLastActiveInputType = true;
		return false;
	}
	if (wasLastActiveInputType)
	{
		if (document.activeElement.tagName.toLowerCase() === 'body')
			return false;
		wasLastActiveInputType = false;
		return false;
	}
	
	ToBrowserSize("LeftMenuPart",scale_LeftMenuPart);
	ToBrowserSize("RightMenuPart",scale_RightMenuPart);	
	ToBrowserSize("main_map",100);
	MoveMinimap();	

	WhereWeAre_matrix = WhereWeAre_element.getCTM();
	var centerH;
	centerH = (window.innerHeight || document.body.clientHeight)/2;
	var rect = WhereWeAre_element.getBoundingClientRect();
	var deltaY;
	deltaY =(centerH - rect.bottom/2);
	
	return false;
};

function InitSVGMap()
{
	SVGRoot = document.getElementsByTagName('svg')[0];
	WhereWeAre = 'main_map';		
	
	isMobileVersion = false;	
	
	WhereWeAre_element = SVGRoot.getElementById(WhereWeAre);
	WhereWeAre_matrix = WhereWeAre_element.getCTM();

	deviceType = GetDeviceType();
	ResizeMainSVG();
	NavigateToElementOnScreen(WhereWeAre_element);
	WhereWeAre_matrix = WhereWeAre_element.getCTM();
	var centerH;
	centerH = (window.innerHeight || document.body.clientHeight)/2;
	var rect = WhereWeAre_element.getBoundingClientRect();
	var deltaY;
	deltaY =(centerH - rect.bottom/2);
	MoveSVG(0, deltaY);
	
	minZoom = 0.2;
	maxZoom = minZoom*10;
	//ToBrowserSize("minimap",30);
	ToBrowserSize("LeftMenuPart",scale_LeftMenuPart);
	ToBrowserSize("RightMenuPart",scale_RightMenuPart);
	MoveMinimap();
	
	SetAnimation();

	InitPathFinder(SVGRoot);

	floorNames.push("first_floor");
	floorNames.push("second_floor");
	floorNames.push("third_floor");
	floorNames.push("fourth_floor");

	GetLinksElements();	
	CheckUrlVars();
	var touchablIcons = document.getElementsByClassName("icon_mainAuds");
	for (var i = 0; i < touchablIcons.length; i++)
	{
		touchablIcons[i].addEventListener('click', function()
			{
				var retName = CheckForSynonim(this.getAttribute('id'));
				ClearLastResult(false);
				if (retName.length!=0)
				{
					lastEndAudits.push(SVGRoot.getElementById(retName[0]));
					ShowEndAudit();
					ShowInfo(retName[0]);
				}
			}, false);
	}
	var touchablStairs = document.getElementsByClassName("stairs_icon");
	for (var i = 0; i < touchablStairs.length; i++)
	{
		if (touchablStairs[i].firstChild!=null)
		{
			touchablStairs[i].firstChild.addEventListener('click', function()
				{
					AddStairsAction(this.parentNode.getAttribute('id'));
				}, false);
		}
		else
		{
			touchablStairs[i].addEventListener('click', function()
				{
					AddStairsAction(this.getAttribute('id'));
				}, false);
		}
	}
};

function CheckUrlVars()
{
	//http://sputnik.guap.ru/nav?src=5233&dst=1115
	var vars = [], hash;	
	var tmp = decodeURI(window.location.href);
	var hashes = tmp.slice(tmp.indexOf('?') + 1).split('&');
	for(var i = 0; i < hashes.length; i++)
	{
		hash = hashes[i].split('=');
		vars.push(hash[0]);
		vars[hash[0]] = hash[1];
	}
	var src = vars["src"];
	var dst = vars["dst"];
	// Check is source room exist
	if (src!=null)
	{
		if (dst!=null)
		{
			FindPathDesktop(true);
		}
		else
		{
			FindAudDesktop(true);
		}
	}
	else
	{
		if (dst!=null)
		{
			FindAudDesktop(true);
		}
	}
}

function GetLinksElements()
{
	first_floor_link = SVGRoot.getElementById("floor_1_active");
	second_floor_link = SVGRoot.getElementById("floor_2_active");
	third_floor_link = SVGRoot.getElementById("floor_3_active");
	fourth_floor_link = SVGRoot.getElementById("floor_4_active");
	mainPage_link = SVGRoot.getElementById("plan_active");
	
	first_floor_link.style.display = 'none';
	second_floor_link.style.display = 'none';
	third_floor_link.style.display = 'none';
	fourth_floor_link.style.display = 'none';
};

function GetDeviceType()
{
	//1 - touch
	//2 - mouse
	//3 - both
	var devType = 0;
	// ontouchstart - works on most browsers 
	// onmsgesturechange - works on ie10
	if (('ontouchstart' in window || 'onmsgesturechange' in window) || (window.navigator.msPointerEnabled))
	{
		devType=1;
	}
	if (('onmousemove' in window))
	{
		devType = (devType===1)?3:2;
	}
	return (devType); 
};

function ShareLink()
{
	var sharedLink = currentPageAddr + "?corp=" + currentCorpus + "&&dst=" + selectedAud;
	var copyPastetextArea = document.createElement("textarea");

	copyPastetextArea.style.position = 'fixed';
	copyPastetextArea.style.top = 0;
	copyPastetextArea.style.left = 0;
	copyPastetextArea.style.width = '2em';
	copyPastetextArea.style.height = '2em';
	copyPastetextArea.style.padding = 0;
	copyPastetextArea.style.border = 'none';
	copyPastetextArea.style.outline = 'none';
	copyPastetextArea.style.boxShadow = 'none';
	copyPastetextArea.style.background = 'transparent';
	copyPastetextArea.value = sharedLink;
	document.body.appendChild(copyPastetextArea);
	copyPastetextArea.focus();
	//copyPastetextArea.select();

	var isiOSDevice = navigator.userAgent.match(/ipad|ipod|iphone/i);

	if (isiOSDevice) {
	  
		var editable = copyPastetextArea.contentEditable;
		var readOnly = copyPastetextArea.readOnly;

		copyPastetextArea.contentEditable = true;
		copyPastetextArea.readOnly = false;

		var range = document.createRange();
		range.selectNodeContents(copyPastetextArea);

		var selection = window.getSelection();
		selection.removeAllRanges();
		selection.addRange(range);

		copyPastetextArea.setSelectionRange(0, 999999);
		copyPastetextArea.contentEditable = editable;
		copyPastetextArea.readOnly = readOnly;

	} else {
		copyPastetextArea.select();
	}

	try 
	{
		var successful = document.execCommand('copy');
		var msg = successful ? 'successful' : 'unsuccessful';
		console.log('Copying text command was ' + msg);
	} 
	catch (err)
	{
		console.log('Oops, unable to copy');
	}

	document.body.removeChild(copyPastetextArea);

	var intervalOkCopy, timeoutOkCopy;
	clearInterval(intervalOkCopy);
	clearTimeout(timeoutOkCopy);
	
	var tmpItem = document.getElementById("spanShareOK");
	tmpItem.classList.replace("invisible", "visible");
	timeoutOkCopy = setTimeout(function() 
					{
						var tmpItem = document.getElementById("spanShareOK");
						tmpItem.classList.replace("visible", "invisible");
					},2500);
};

function ResizeMainSVG()
{
	var w1,h1;
	w1 = window.innerWidth || document.body.clientWidth;
	h1 = window.innerHeight || document.body.clientHeight;
	SVGRoot.setAttribute("width", "" + w1 + "");
	SVGRoot.setAttribute("height", "" + h1 + "");
	SVGRoot_width = w1;
	SVGRoot_height = h1;
	SVGRoot_alwaysVisibleSize = (w1>h1)?h1*0.1:w1*0.1;
	return;
}

function MoveMinimap()
{		
	var diff_corners = 8;
	//LeftPart
	var curPartName = "LeftMenuPart";
	var curPartElem = SVGRoot.getElementById(curPartName);
	var y_pos = ((window.innerHeight || document.body.clientHeight)/2 - curPartElem.getBoundingClientRect().height/2) ;
	dx = 0;
	var matrix =curPartElem.getCTM();
	var s = "matrix(" +(matrix.a) + "," + matrix.b + "," + matrix.c+ "," + (matrix.d)
	+"," +( 0 ) + "," +  y_pos + ")";
	curPartElem.setAttribute("transform", s);
	
	//RightPart
	curPartName = "RightMenuPart";
	curPartElem = SVGRoot.getElementById(curPartName);
	dx = SVGRoot.getAttribute("width") - curPartElem.getBoundingClientRect().width - diff_corners;
	matrix =curPartElem.getCTM();
	y_pos = ((window.innerHeight || document.body.clientHeight)/2 - curPartElem.getBoundingClientRect().height/2) ;
	//y_pos=(searchBarHeight)
	s = "matrix(" +(matrix.a) + "," + matrix.b + "," + matrix.c+ "," + (matrix.d)
	+"," +( dx ) + "," + y_pos  + ")";
	curPartElem.setAttribute("transform", s);
}

function ToBrowserSize(ID, percent)
{	
	var dx,dy;
	var w1,h1;
	var el_width,el_height;
	w1 = window.innerWidth || document.body.clientWidth;
	h1 = window.innerHeight || document.body.clientHeight;
	h1 = h1 - searchBarHeight;
	g = SVGRoot.getElementById(ID);

	el_width = g.getBoundingClientRect().width;
	el_height = g.getBoundingClientRect().height;

	dx = el_width/w1;
	dy = el_height/h1;
	var ratio = percent/100;

	browser_scroll_dif=0;
	matrix = g.getCTM();
	if (dx>dy)
	{
		if (dx>1)
		{
			var smallerCoeff = (w1*ratio)/el_width;
			g.setAttribute("transform", "scale("+ matrix.a*smallerCoeff +")");
		}
		else
		{
			var smallerCoeff = (w1*ratio)/el_width;
			g.setAttribute("transform", "scale("+ matrix.a*smallerCoeff +")");
		}
	}
	else
	{
		if (dy>1)
		{
			var smallerCoeff = (h1*ratio)/el_height;
			g.setAttribute("transform", "scale("+ matrix.a*smallerCoeff +")");
		}
		else
		{
			var smallerCoeff = (h1*ratio)/el_height;
			g.setAttribute("transform", "scale("+ matrix.a*smallerCoeff +")");
		}
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
	var isOnMap_touch = false;
	var isOnMap_mouse = false;
	var pt  = SVGRoot.createSVGPoint();
	var HandleMousedown = function(evt)
	{	
		if (!isOnMap_mouse)
		{
			positionCoords = null;
			return;
		}
		//evt.preventDefault();
		//evt.returnValue = false;
		if (isMoving)
			return;
		evt = evt || window.evt;

		positionCoords = SVGRoot.createSVGPoint();
		document.body.style.cursor = 'move';
		positionCoords.x = currentCoords.x - Number(WhereWeAre_matrix.e);
		positionCoords.y = currentCoords.y - Number(WhereWeAre_matrix.f);		
	}
	var HandleTouchdown = function(evt)
	{	
		if (!isOnMap_touch)
			return;
		//if (isMoving)
		//	return;
		evt = evt || window.evt;

		positionCoords = SVGRoot.createSVGPoint();
							
		var evt_touch = evt.touches[evt.touches.length-1];
		positionCoords.x = (evt_touch.pageX- Number(WhereWeAre_matrix.e));
		positionCoords.y = (evt_touch.pageY- Number(WhereWeAre_matrix.f));
	}
	var HandleMousemove = function (evt)
	{	
		//currentCoords.x = evt.clientX||evt.screenX;
		//currentCoords.y = evt.clientY||evt.screenX;
		if (!isOnMap_mouse)
			return;
		
		Move(evt);
	}
	var HandleTouchmove = function (evt)
	{		
		evt.preventDefault();
		evt.returnValue = false;
		//if ((!isOnMap_touch)||(isMoving))
		//	return;
		Move(evt);
		return false;
	}
	
	function Move(evt)
	{
		//**evt.preventDefault();
		evt.returnValue = false;
		isMoving = true;
		currentCoords.x = evt.clientX||evt.screenX;
		currentCoords.y = evt.clientY||evt.screenX;
		if (!(evt.clientX||evt.screenX))
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
					HandletouchZoom(1.1);
					isMoving = false;
					return;
				}
				if ((now_diff_x<prev_diff_x)&&(now_diff_y<prev_diff_y))
				{
					HandletouchZoom(0.9);
					isMoving = false;
					return;
				}
				isMoving = false;
				return;
			}
			var evt_touch = evt.touches[evt.touches.length-1];
			currentCoords.x = evt_touch.pageX;
			currentCoords.y = evt_touch.pageY;
		}
		
		if (positionCoords!=null)
		{
			var newX = currentCoords.x - positionCoords.x;
			var newY = currentCoords.y - positionCoords.y;
			var leftBound, bottomBound;
			
			rightBound = newX + WhereWeAre_element.getBoundingClientRect().width;
			bottomBound = newY + WhereWeAre_element.getBoundingClientRect().height;
			
			//preventing drag-out
			if ((newX > SVGRoot_width - SVGRoot_alwaysVisibleSize) || (rightBound<SVGRoot_alwaysVisibleSize))
				newX = WhereWeAre_matrix.e;
			
			if ((newY > SVGRoot_height - SVGRoot_alwaysVisibleSize) || (bottomBound<SVGRoot_alwaysVisibleSize))
				newY = WhereWeAre_matrix.f;
			
			var s = "matrix(" + WhereWeAre_matrix.a + "," + WhereWeAre_matrix.b + "," + WhereWeAre_matrix.c + "," + WhereWeAre_matrix.d + "," + ( newX) + "," + ( newY) + ")";

			WhereWeAre_element.setAttribute("transform", s);
			WhereWeAre_matrix = WhereWeAre_element.getCTM();
		}
		isMoving = false;
	}

	var HandleMouseup = function(evt)
	{
		if (!isOnMap_mouse)
			return;		
		positionCoords = null;
		document.body.style.cursor = 'default';
	}
	
	var HandleTouchup = function(evt)
	{
		if (!isOnMap_touch)
			return;
		positionCoords = null;
	}
	
	var HandleScroll = function(evt)
	{
		if (!isOnMap_mouse)
			return;
		evt.preventDefault();
		evt.returnValue = false;
		
		currentCoords.x = evt.clientX||evt.screenX;
		currentCoords.y = evt.clientY||evt.screenX;
		
		var delta = evt.wheelDelta ? evt.wheelDelta/40 : evt.detail ? -evt.detail : 0;
		if (delta)
			zoom(delta);
		return evt.preventDefault() && false;
	}

	var zoom = function(clicks)
	{
		pt.x = currentCoords.x;
		pt.y = currentCoords.y;
		var previousZoom = WhereWeAre_matrix.a;

		pt = pt.matrixTransform(WhereWeAre_matrix.inverse());
		var z = Math.pow(scaleFactor,clicks);
		//var matr = "matrix(" + matrix.a*z + "," + matrix.b + "," + matrix.c + "," + matrix.d*z + "," + (matrix.e) + "," + (matrix.f) + ")";
		var k = SVGRoot.createSVGMatrix().translate(pt.x, pt.y).scale(z).translate(-pt.x, -pt.y);
		var matrix = WhereWeAre_matrix.multiply(k);
		
		var s = "matrix(" + matrix.a + "," + matrix.b + "," + matrix.c + "," + matrix.d+"," + matrix.e + "," +  matrix.f + ")";
		var currentZoom = matrix.a;
		
		if ((previousZoom<currentZoom) && (currentZoom>maxZoom))
			return;		
		if ((previousZoom>currentZoom) && (currentZoom<minZoom))
			return;
		
		WhereWeAre_element.setAttribute("transform", s);       
		WhereWeAre_matrix = WhereWeAre_element.getCTM();
	}  

	var HandletouchZoom = function(clicks)
	{
		pt.x = center_x;
		pt.y = center_y;
		var previousZoom = WhereWeAre_matrix.a;

		pt = pt.matrixTransform(WhereWeAre_matrix.inverse());
		var z = clicks;
		var k = SVGRoot.createSVGMatrix().translate(pt.x, pt.y).scale(z).translate(-pt.x, -pt.y);
		var matrix = WhereWeAre_matrix.multiply(k);
		var s = "matrix(" +matrix.a + "," + matrix.b + "," + matrix.c + "," + matrix.d+"," + matrix.e + "," +  matrix.f + ")";
		
		var currentZoom = matrix.a;
		if ((previousZoom<currentZoom) && (currentZoom>maxZoom))
			return;
		if ((previousZoom>currentZoom) && (currentZoom<minZoom))
			return;
		
		WhereWeAre_element.setAttribute("transform", s);      
		WhereWeAre_matrix = WhereWeAre_element.getCTM(); 
	}

	var HandleMouseOver = function(event)
	{
		event.preventDefault();
		event.returnValue = false;
		
		isOnMap_mouse = true;
		return true;
	}
	
	var HandleMouseOut = function(event)
	{
		event.preventDefault();
		event.returnValue = false;
		
		isOnMap_mouse = false;
		isMoving = false;
		positionCoords = null;
		document.body.style.cursor = 'default';
		return false;
	}
	
	if ((deviceType===3)||(deviceType===2))
	{
		document.addEventListener('contextmenu', function (e) {
			e.preventDefault();return false;
		});
		document.getElementById("bm-v").addEventListener('mousedown',HandleMousedown, {passive: true});    
		document.getElementById("bm-v").addEventListener('mousemove',HandleMousemove, {passive: true}); 
		document.getElementById("bm-v").addEventListener('mouseup',HandleMouseup, {passive: true}); 
		document.getElementById("bm-v").addEventListener('DOMMouseScroll',HandleScroll,false);
		document.getElementById("bm-v").addEventListener('mousewheel',HandleScroll,false);
		document.getElementById("bm-v").addEventListener('mouseleave',HandleMouseup,false);
		document.getElementById("bm-v").addEventListener('mouseenter',HandleMouseOver,false);  
		document.getElementById("bm-v").addEventListener('mouseleave',HandleMouseOut,false); 
	}
	if ((deviceType===1)||(deviceType===3))
	{
		isOnMap_touch = true;
		document.getElementById("bm-v").addEventListener("touchstart", HandleTouchdown, {passive: false} );
		document.getElementById("bm-v").addEventListener("touchend", HandleTouchup, {passive: false});
		document.getElementById("bm-v").addEventListener("touchleave", HandleTouchup, {passive: false});
		document.getElementById("bm-v").addEventListener("touchmove", HandleTouchmove, {passive: false});
		document.addEventListener('gesturestart', function (e) {
			e.preventDefault();
		});
	}
}


function HandleButtonZoom(scale)
{
	var currentCoords = SVGRoot.createSVGPoint();
	var positionCoords = null;
	var previousZoom = WhereWeAre_matrix.a;
	
	var pt  = SVGRoot.createSVGPoint();
	pt.x = SVGRoot.getBoundingClientRect().width/2;
	pt.y = SVGRoot.getBoundingClientRect().height/2;

	pt = pt.matrixTransform(WhereWeAre_matrix.inverse());
	var z = Math.pow(1.2,scale);
	var k = SVGRoot.createSVGMatrix().translate(pt.x, pt.y).scale(z).translate(-pt.x, -pt.y);
	var matrix = WhereWeAre_matrix.multiply(k);
	var s = "matrix(" +matrix.a + "," + matrix.b + "," + matrix.c + "," + matrix.d+"," + matrix.e + "," +  matrix.f + ")";
	
	var currentZoom = matrix.a;
	if ((previousZoom<currentZoom) && (currentZoom>maxZoom))
		return;
	if ((previousZoom>currentZoom) && (currentZoom<minZoom))
		return;
	
	WhereWeAre_element.setAttribute("transform", s);
	WhereWeAre_matrix = WhereWeAre_element.getCTM();
}

function ToFirst(WhatCorpus)
{
	ChangingFloors(WhereWeAre,'first_floor');

	WhereWeAre_element.style.display = 'none';
	WhereWeAre='first_floor';
	WhereWeAre_element = SVGRoot.getElementById(WhereWeAre);
	WhereWeAre_element.style.display = 'block';
	NavigateToElementOnScreen(SVGRoot.getElementById('floor1_corp'+WhatCorpus));
	WhereWeAre_matrix = WhereWeAre_element.getCTM();
}

function ToNewFloor(ShowID)
{
	if (WhereWeAre==ShowID)
		return;
	ChangingFloors(WhereWeAre, ShowID);
	RemoveStairsAction();
	WhereWeAre_element.style.display = 'none';
	WhereWeAre_element = document.getElementById(ShowID);
	WhereWeAre_element.style.display = 'block';
	if (ShowID=='main_map')
	{
		NavigateToElementOnScreen(WhereWeAre_element);	
	}
	else
	{	
		var matrOld = WhereWeAre_matrix;
		var s = "matrix(" + matrOld.a + "," + matrOld.b + "," + matrOld.c + "," + matrOld.d + "," + matrOld.e + "," + matrOld.f + ")";
		WhereWeAre_element.setAttribute("transform", s); 
	}
		
	WhereWeAre=ShowID;
	WhereWeAre_matrix = WhereWeAre_element.getCTM();
}

function ChangingFloors(HideID,ShowID)
{
	switch (HideID)
	{
		case 'first_floor':		
			first_floor_link.style.display='none';
			break;
		case 'second_floor':
			second_floor_link.style.display='none';
			break;
		case 'third_floor':
			third_floor_link.style.display = 'none';
			break;
		case 'fourth_floor':
			fourth_floor_link.style.display = 'none';
			break;
		case 'main_map':
			mainPage_link.style.display = 'none';
			break;
	}
	switch (ShowID)
	{
		case 'first_floor':
			first_floor_link.style.display='block';
			break;
		case 'second_floor':
			second_floor_link.style.display='block';
			break;
		case 'third_floor':
			third_floor_link.style.display = 'block';
			break;
		case 'fourth_floor':
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

	positionCoords.x = Number(WhereWeAre_matrix.e);
	positionCoords.y = Number(WhereWeAre_matrix.f);
	var newX = positionCoords.x + deltaX;
	var newY = positionCoords.y + deltaY;

	var s = "matrix(" + WhereWeAre_matrix.a + "," + WhereWeAre_matrix.b + "," + WhereWeAre_matrix.c + "," + WhereWeAre_matrix.d + "," + (WhereWeAre_matrix.e = newX) + "," + (WhereWeAre_matrix.f = newY) + ")";
	WhereWeAre_element.setAttribute("transform", s);
	WhereWeAre_matrix = WhereWeAre_element.getCTM();
}

function HandleKeyPressed()
{ 
	if (document.activeElement.type==='text')
		return true;
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

function NavigateToElementOnScreen(element)
{	
	for (var i=0;i<floorNames.length;++i)
	{
		var tmpEl = SVGRoot.getElementById(floorNames[i]);
			if (tmpEl.contains(element))
			{
				ToNewFloor(floorNames[i]);
			}
	}
	var s = "matrix(" + 1.1 + "," + WhereWeAre_matrix.b + "," + WhereWeAre_matrix.c + "," + 1.1 +"," + 0 + "," +  0 + ")";
	WhereWeAre_element.setAttribute("transform", s); 
	WhereWeAre_matrix = WhereWeAre_element.getCTM();
	
	var centerW,centerH;
	centerW = (window.innerWidth || document.body.clientWidth)/2;
	centerH = (window.innerHeight || document.body.clientHeight)/2;

	var elRect = element.getBoundingClientRect();
	var deltaX, deltaY;

	deltaX = centerW - elRect.left - elRect.width/2;
	deltaY = centerH - elRect.top - elRect.height/2;
	MoveSVG(deltaX, deltaY);
	
	elRect = element.getBoundingClientRect();
	//if size of showable object > screen size => resize SVG map to show full object
	var scale = 0;
	if (elRect.left + elRect.width>centerW*2)
		scale = (elRect.left+elRect.width)/(centerW*2);
	if (elRect.top + elRect.height>centerH*2)
	{
		var tmpScale = (elRect.top+elRect.height)/(centerH*2);
		if (tmpScale>scale)
			scale = tmpScale;
	}
	if ( scale!=0 )
	{
		var currentCoords = SVGRoot.createSVGPoint();
		var positionCoords = null;

		var pt  = SVGRoot.createSVGPoint();
		pt.x = SVGRoot.getBoundingClientRect().width/2;
		pt.y = SVGRoot.getBoundingClientRect().height/2;

		pt = pt.matrixTransform(WhereWeAre_matrix.inverse());
		var z = WhereWeAre_matrix.a/(scale);
		var k = SVGRoot.createSVGMatrix().translate(pt.x, pt.y).scale(1/(2*scale)).translate(-pt.x, -pt.y);
		var matrix = WhereWeAre_matrix.multiply(k);
		var s = "matrix(" +matrix.a + "," + matrix.b + "," + matrix.c + "," + matrix.d+"," + matrix.e + "," +  matrix.f + ")";
		WhereWeAre_element.setAttribute("transform", s);
		WhereWeAre_matrix = WhereWeAre_element.getCTM();
	}
	WhereWeAre_matrix = WhereWeAre_element.getCTM();
}

function ChangeSrcAndDst()
{
	var srcElement  = document.getElementById("srcRoomBox");
	var srcVal = srcElement.value;
};

function ChangeMobileMenuDisplaying(changingType)
{
	if (changingType)
	{
		//var mobileMenu = document.getElementById("block_background");
		//if ((mobileMenu.style.display!='none')&&(searchMenuType==2))
		//{
		//	searchMenuType = 0;
		//	if (isMobileVersion)
		//	{
		//		mobileMenu.style.display = 'none';
		//	}
		//}
		//else
		//{
		//	searchMenuType = 2;
		//	mobileMenu.style.display = 'block';
		//}
		//var firstPart = document.getElementById("searchFirstPart");
		//firstPart.style.visibility = 'visible';
		//var secondPart = document.getElementById("searchSecondPart");
		//secondPart.style.visibility = 'visible';
	}
	else
	{
		//var mobileMenu = document.getElementById("block_background");
		//if ((mobileMenu.style.display!='none')&&(searchMenuType==1))
		//{
		//	searchMenuType = 0;
		//	if (isMobileVersion)
		//	{
		//		mobileMenu.style.display = 'none';
		//	}
		//}
		//else
		//{
		//	searchMenuType = 1;
		//	mobileMenu.style.display = 'block';
		//}
		//var firstPart = document.getElementById("searchFirstPart");
		//firstPart.style.visibility = 'visible';
		//if (isMobileVersion)
		//{
		//	var secondPart = document.getElementById("searchSecondPart");
		//	secondPart.style.visibility = 'hidden';
		//}
	}
};

function CheckOSType()
{
	var ownCookieName = "SputnikSUAIAppSuggestionShown";
	if (document.cookie.replace(/(?:(?:^|.*;\s*)SputnikSUAIAppSuggestionShown\s*\=\s*([^;]*).*$)|^.*$/, "$1") !== "true") {
				
		//expire at 30 days
		var exprDate = new Date();
		exprDate.setTime(exprDate.getTime() + (30*24*60*60*1000));
		var expires = "expires=" + exprDate.toUTCString();
		document.cookie = ownCookieName+ "=true" + "; " + expires;
	}
	
	var userAgent = navigator.userAgent || navigator.vendor || window.opera;

    // Windows Phone must come first because its UA also contains "Android"
    if (/windows phone/i.test(userAgent))
	{
		//Show WinPhone suggestion
		//return "Windows Phone";
    }

    if (/android/i.test(userAgent))
	{
		//Show Android suggestion
    }

    // iOS detection from: http://stackoverflow.com/a/9039885/177710
    if (/iPad|iPhone|iPod/.test(userAgent) && !window.MSStream)
	{
		//Show iOS suggestion
    }

    //not Android or iOS or WinPhone browser
};
