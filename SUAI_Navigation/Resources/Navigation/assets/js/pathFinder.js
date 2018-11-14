
var curcurSVGRoot;
var bestPath = new Array();
var currentPath = new Array();
var arraysWhereWeWere = new Array();

var srcRoom, srcPoint;
var dstRoom, dstPoint;
var destInd, srcInd;
var startArray, destArray;

var bestPathLength = 0;
var curPathLength = 0;
var lastStartAudits = [], lastEndAudits = [];

var lastActiveStair = null;

function InitPathFinder(inSVGRoot)
{
	curSVGRoot = inSVGRoot;
	InitArrays();
	lastAudit = null;
	lastActiveStair = new Object();
	lastActiveStair.elName = null;
	lastActiveStair.topReady = false;
	lastActiveStair.bottomReady = false;
	lastActiveStair.isStarted = false;
};

function ResetFinder()
{	
	ClearLastResult(true);
};

function ClearLastResult(needToClearPath)
{
	if ((bestPath.length>0) && needToClearPath)
	{		
		for (var i=0;i<bestPath.length;i++)
		{
			if (bestPath[i].indexOf('stair')!=0)
			{
				SegmentHide(bestPath[i]);
			}
			else
			{
				var stairCur = curSVGRoot.getElementById(bestPath[i]);
				stairCur.removeAttribute("onclick"); 
				SegmentHide(bestPath[i] + "_up");
				SegmentHide(bestPath[i] + "_down");
			}
		}
		bestPath = [];
		destArray = [];
		startArray = [];
		currentPath = [];
		arraysWhereWeWere = [];
		bestPathLength = 0;
		curPathLength = 0;
		var deletableElements = document.querySelectorAll("g[tagSuggestion]");
		for (var i = 0; i < deletableElements.length; i++)
		{
			deletableElements[i].parentNode.removeChild(deletableElements[i]);
		}
	}
	
	for (var i=0;i<lastStartAudits.length;++i)
	{
		lastStartAudits[i].style.opacity = 0;
	}
	for (var i=0;i<lastEndAudits.length;++i)
	{
		lastEndAudits[i].style.opacity = 0;
	}
	lastEndAudits=[];
	lastStartAudits=[];
};

function SetRoomName(isSrcPoint, inName)
{
	if (isSrcPoint)
		srcRoom = inName;
	else
		dstRoom = inName;
};

//-0 - OK
//-1 - src aud not found
//-2 - dst aud not found
//-3 - trouble with svgElements
function RoomFinder(isTwoPointsSearch)
{
	ClearLastResult(true);
		
	//console.log(isTwoPointsSearch);
	if (isTwoPointsSearch)
	{
		var dstPoints = CheckForRealNumber(dstRoom);
		var srcPoints = CheckForRealNumber(srcRoom);
		
		if (srcPoints.length == 0)
		{
			return -1;
		}
		if (dstPoints.length == 0)
		{
			return -2;
		}
	
		for (var i=0;i<allParts.length;++i)
		{
			for (var j=0;j<allParts[i].length;++j)
			{
				for (var k=0;k<allParts[i][j].pointAuds.length;++k)
				{
					for (var z=0;z<srcPoints.length;++z)
					{
						if (allParts[i][j].pointAuds[k] == srcPoints[z])
						{
							var lastStartAudit = curSVGRoot.getElementById(allParts[i][j].pointAuds[k]);
							lastStartAudits.push(lastStartAudit);
							srcPoint = allParts[i][j].pointName;
						}
					}
					for (var z=0;z<dstPoints.length;++z)
					{
						if (allParts[i][j].pointAuds[k] == dstPoints[z])
						{
							var lastEndAudit = curSVGRoot.getElementById(allParts[i][j].pointAuds[k]);
							lastEndAudits.push(lastEndAudit);
							dstPoint = allParts[i][j].pointName;
						}
					}
				}
			}	
		}
		
		if (lastStartAudits.length === 0)
		{
			return -3;
		}
		else
		{
			ShowStartAudit();
			NavigateToElementOnScreen(lastStartAudits[0]);
		}
		
		if (lastEndAudits.length === 0)
		{
			return -3;
		}
		else
			ShowEndAudit();
	}
	else
	{	
		var dstPoints = CheckForRealNumber(dstRoom);
		if (dstPoints.length == 0)
		{
			return -2;
		}
		for (var i=0;i<allParts.length;++i)
		{
			for (var j=0;j<allParts[i].length;++j)
			{
				for (var k=0;k<allParts[i][j].pointAuds.length;++k)
				{
					for (var z=0;z<dstPoints.length;++z)
					{
						if (allParts[i][j].pointAuds[k] == dstPoints[z])
						{
							var lastEndAudit = curSVGRoot.getElementById(allParts[i][j].pointAuds[k]);
							lastEndAudits.push(lastEndAudit);
							dstPoint = allParts[i][j].pointName;
						}
					}
				}
			}
		}
				
		if (lastEndAudits.length === 0)
		{
			return -3;
		}
		else
		{
			ShowEndAudit();
			NavigateToElementOnScreen(lastEndAudits[0]);
		}
	}
	
	return 0;
};

function ShowStartAudit()
{
	for (var i=0;i<lastStartAudits.length;++i)
		lastStartAudits[i].style.opacity = 1;
};

function ShowEndAudit()
{
	for (var i=0;i<lastEndAudits.length;++i)
		lastEndAudits[i].style.opacity = 1;
}

function FindPath()
{	
	ResetFinder();
	var errCode = RoomFinder(true);
	if (errCode < 0)
		return errCode;
	
	destArray = null;
	startArray = null;
	//console.log(srcPoint);
	//console.log(dstPoint);
	for (var i=0;i<allParts.length;++i)
	{
		for (var j=0;j<allParts[i].length;++j)
		{
			if (allParts[i][j].pointName == srcPoint)
			{
				srcInd = j;
				startArray = allParts[i];
			}
			if (allParts[i][j].pointName == dstPoint)
			{
				destInd = j;
				destArray = allParts[i];
			}
			if ((startArray != null)&&(destArray != null))
				break;
		}			
	}	
	if (startArray == null)
	{
		return -4;
	}
	if (destArray == null)
	{
		return -4;
	}
	BWSA(startArray,srcInd);
	
	var curFloorInd = 0;
	var startedCorpInd;
	
	if (bestPath.length > 0)
		 curFloorInd = SegmentShow(bestPath[0]);
	
	for (var i=0;i<floorNames.length;++i)
	{
		var tmpEl = curSVGRoot.getElementById(floorNames[i]);
		if (tmpEl.contains(lastStartAudits[0]))
		{
			startedCorpInd = i;
			break;
		}
	}
	if ((bestPath.length > 0) && (bestPath[0].indexOf('stair')==0)){
		if (startedCorpInd>curFloorInd)
		{
			//console.log(bestPath[i-1]+"_up1");
			SegmentShow(bestPath[0]+"_up");
			AddSuggestionToStairs(bestPath[0],'поднимитесь','на этаж выше', floorNames[startedCorpInd]);
		}
		if (startedCorpInd<curFloorInd)
		{
			//console.log(bestPath[i-1]+"_down1");
			SegmentShow(bestPath[0]+"_down");
			AddSuggestionToStairs(bestPath[0],'спуститесь','на этаж ниже', floorNames[startedCorpInd]);
		}
	}

	for (var i=0;i<bestPath.length;i++)
	{
		var newFloorInd = SegmentShow(bestPath[i]);
		//console.log(bestPath[i] + ' ' + curFloorInd);

		if ((newFloorInd!=curFloorInd)&&(bestPath[i-1].indexOf('stair') >= 0))
		{
			if (newFloorInd>curFloorInd )
			{
				SegmentShow(bestPath[i-1]+"_up");
				AddSuggestionToStairs(bestPath[i-1],'поднимитесь','на этаж выше', floorNames[newFloorInd]);				
				//console.log(bestPath[i-1]+"_up!!");
			}else
			if (newFloorInd<curFloorInd)
			{
				SegmentShow(bestPath[i-1]+"_down");
				AddSuggestionToStairs(bestPath[i-1],'спуститесь','на этаж ниже', floorNames[newFloorInd]);
				//console.log(bestPath[i-1]+"_down!!");
			}
			curFloorInd = newFloorInd;
		}
	}
	
	var finishedCorpInd;
	for (var i=0;i<floorNames.length;++i)
	{
		var tmpEl = curSVGRoot.getElementById(floorNames[i]);
		if (tmpEl.contains(lastEndAudits[0]))
		{
			finishedCorpInd = i;
			break;
		}
	}
	if (bestPath.length > 1){
		if (finishedCorpInd>curFloorInd)
		{
			AddSuggestionToStairs(bestPath[bestPath.length-1],'поднимитесь','на этаж выше', floorNames[finishedCorpInd]);
			SegmentShow(bestPath[bestPath.length-1]+"_up");
		}
		if (finishedCorpInd<curFloorInd)
		{
			AddSuggestionToStairs(bestPath[bestPath.length-1],'спуститесь','на этаж ниже', floorNames[finishedCorpInd]);
			SegmentShow(bestPath[bestPath.length-1]+"_down");
		}
	}
	return 0;
};

function RemoveStairsAction()
{
	if (lastActiveStair==null || lastActiveStair.elName==null)
		return;
	
	var stairCur = curSVGRoot.getElementById(lastActiveStair.elName);
	var deletableElements = stairCur.querySelectorAll("g[tagStairAction]");
	for (var i = 0; i < deletableElements.length; i++)
	{
		var type = deletableElements[i].getAttribute('tagStairAction');
		if (type === "top")
		{
			//deletableElements[i].parentNode.removeChild(deletableElements[i]);
			if (lastActiveStair.topReady === false)
			{
				deletableElements[i].parentNode.removeChild(deletableElements[i]);
				lastActiveStair.topReady = false;
				continue;
			}
			var finPosT = lastActiveStair.topY + deletableElements[i].getBBox().height/1.5;

			var timeoutTopD = setTimeout(function moveActionTopDel(element,finPosT)
			{
				if (element===null)
					return;
				
				var xPosT = lastActiveStair.topX;
				var curPosT = lastActiveStair.topY;
				if (curPosT<finPosT-2)
				{
					curPosT += 3;
					lastActiveStair.topY = curPosT;
					element.setAttribute("transform", 'translate('+ xPosT + ',' + curPosT + ')');
					timeoutTopD = setTimeout(moveActionTopDel, 4, element,finPosT);
				}
				else{
					if (element.parentNode!=null)
					{
						element.parentNode.removeChild(element);
						lastActiveStair.topReady = false;
					}
				}
			}, 5, deletableElements[i],finPosT);
		}
		else if (type === "bottom")
		{
			//deletableElements[i].parentNode.removeChild(deletableElements[i]);
			//	console.log(deletableElements[i].getBBox());
			
			var finPosB = lastActiveStair.bottomY - deletableElements[i].getBBox().height/1.5;

			if (lastActiveStair.bottomReady === false)
			{
				deletableElements[i].parentNode.removeChild(deletableElements[i]);
				lastActiveStair.bottomReady = false;
				continue;
			}

			var timeoutBottomD = setTimeout(function moveActionBottomDel(element,finPosB)
			{
				if (element===null)
					return;
				var xPosB = lastActiveStair.bottomX;
				var curPosB = lastActiveStair.bottomY;
				if (curPosB>finPosB+2)
				{
					curPosB -= 3;
					lastActiveStair.bottomY = curPosB;
					element.setAttribute("transform", 'translate('+ xPosB + ',' + curPosB + ')');
					timeoutBottomD = setTimeout(moveActionBottomDel, 4, element,finPosB);
				}
				else{
					if (element.parentNode!=null)
					{
						lastActiveStair.bottomReady = false;
						element.parentNode.removeChild(element);
					}
				}
			}, 5, deletableElements[i],finPosB);
			
		}
	}
};

function AddStairsAction(elName)
{
	var newActiveStair;// = new Object;
	if (lastActiveStair.isStarted === true)
	{
		return;
	}
	
	if (lastActiveStair==null || lastActiveStair.elName != elName)
	{
		RemoveStairsAction();
		newActiveStair = new Object;
		newActiveStair.elName = elName;
		lastActiveStair.elName = elName;
		lastActiveStair.isStarted = true;
	}
	else
	{
		RemoveStairsAction();
		lastActiveStair.elName = null;
		return;
	}

	var tmpEl, curFloor;
	var flag_needTop = false, flag_needBottom = false;
	var dropRadius = 28;
	var textLineHeight = 20;
	var DropStrokeWidth = 2;
	var stairCur = curSVGRoot.getElementById(elName);
	
	for (var i=0;i<floorNames.length;++i)
	{
		tmpEl = curSVGRoot.getElementById(floorNames[i]);
		if (tmpEl.contains(stairCur))
		{
			curFloor = i;
			newActiveStair.flInd = curFloor;
			break;
		}
	}

	tmpEl = curSVGRoot.getElementById(elName+"_up");
	if (tmpEl!=null && tmpEl.firstElementChild!=null)
	{
		flag_needTop = true;
	}
	
	tmpEl = curSVGRoot.getElementById(elName+"_down");
	if (tmpEl!=null && tmpEl.firstElementChild!=null)
	{
		flag_needBottom = true;
	}

	//only first child(stair icon) position
	var parentPos = stairCur.firstElementChild.getBBox();
	
	if (flag_needTop)
	{
		var newElementsGroupTop = document.createElementNS("http://www.w3.org/2000/svg", 'g');
		newElementsGroupTop.setAttribute("tagStairAction","top");
		newElementsGroupTop.setAttribute("onclick","ToNewFloor('" + floorNames[(curFloor+1)] + "');");	
		//stairCur.appendChild(newElementsGroupTop);
		stairCur.firstElementChild.insertBefore(newElementsGroupTop, stairCur.firstElementChild.firstChild);
		var newElementDropTop = document.createElementNS("http://www.w3.org/2000/svg", 'path');
		newElementDropTop.style.stroke = "rgba(120, 120, 120, 0.4)"; 
		newElementDropTop.style.fill = "rgb(255, 255, 255)"; 
		newElementDropTop.style.strokeWidth = DropStrokeWidth + "px"; 	
		var d_pathUp = CreateTopDrop2(0, 0, dropRadius);
		newElementDropTop.setAttribute("d",d_pathUp);
		newElementsGroupTop.appendChild(newElementDropTop);
		//= =
		var newElementText = document.createElementNS("http://www.w3.org/2000/svg", 'text');
		newElementText.setAttribute("alignment-baseline","before-edge");
		newElementText.setAttribute("x",0);
		newElementText.setAttribute("y",(-1.7*dropRadius));
		newElementText.setAttribute("height",textLineHeight);
		newElementText.setAttribute("font-size","12px");
		newElementText.setAttribute("font-family","Verdana, Regular");
		newElementText.innerHTML = "наверх";
		newElementsGroupTop.appendChild(newElementText);
		newElementText.style.strokeWidth = "0px";
		newElementText.setAttribute("x",-(newElementText.getBBox().width)/2);
		var posT1, posT2;
		// Setting suggestion to top
		posT1 = (parentPos.x + parentPos.width/2);
		posT2 = (parentPos.y + 2);	
		var curPosT2 = posT2 + newElementsGroupTop.getBBox().height/1.5;
		newElementsGroupTop.setAttribute("transform", 'translate('+ posT1 +','+ curPosT2 +')');
		newActiveStair.topY = curPosT2;
		newActiveStair.topX = posT1;

		var timeoutTop = setTimeout(function moveActionTop()
		{			
			if (newElementsGroupTop === null)
				return;
			newElementsGroupTop.setAttribute("transform", 'translate('+ posT1 + ',' + curPosT2 + ')');
			if (curPosT2>posT2+2)
			{
				curPosT2 -= 3;
				timeoutTop = setTimeout(moveActionTop, 4);
			}
			else{
				curPosT2 = posT2;
				newElementsGroupTop.setAttribute("transform", 'translate('+ posT1 + ',' + curPosT2 + ')');
				lastActiveStair.topY = newActiveStair.topY;
				lastActiveStair.topX = newActiveStair.topX;
				lastActiveStair.topReady = true;
				lastActiveStair.isStarted = false;
			}
			newActiveStair.topY = curPosT2;
		}, 5);
	}
	
	if (flag_needBottom)
	{
		var newElementsGroupBottom = document.createElementNS("http://www.w3.org/2000/svg", 'g');
		newElementsGroupBottom.setAttribute("tagStairAction","bottom");
		newElementsGroupBottom.setAttribute("onclick","ToNewFloor('" + floorNames[(curFloor-1)] + "');");	
		//stairCur.appendChild(newElementsGroupBottom);
		stairCur.firstElementChild.insertBefore(newElementsGroupBottom, stairCur.firstElementChild.firstChild);
		var newElementDropBottom = document.createElementNS("http://www.w3.org/2000/svg", 'path');
		newElementDropBottom.style.stroke = "rgba(150, 150, 150, 0.4)"; 
		newElementDropBottom.style.fill = "rgb(255, 255, 255)"; 
		newElementDropBottom.style.strokeWidth = DropStrokeWidth + "px"; 	
		var d_pathDown = CreateBottomDrop2(0, 0, dropRadius);
		newElementDropBottom.setAttribute("d",d_pathDown);
		newElementsGroupBottom.appendChild(newElementDropBottom);
		
		var newElementText = document.createElementNS("http://www.w3.org/2000/svg", 'text');
		newElementText.setAttribute("alignment-baseline","before-edge");
		newElementText.setAttribute("x",0);
		newElementText.setAttribute("y",(1.2*dropRadius));
		newElementText.setAttribute("height",textLineHeight);
		newElementText.setAttribute("font-size","12px");
		newElementText.setAttribute("font-family","Verdana, Regular");
		newElementText.innerHTML = "вниз";
		newElementsGroupBottom.appendChild(newElementText);
		newElementText.style.strokeWidth = "0px";
		newElementText.setAttribute("x",-(newElementText.getBBox().width)/2);
		
		var posB1, posB2;
		// Setting suggestion to bottom
		posB1 = (parentPos.x + parentPos.width/2);
		posB2 = (parentPos.y + parentPos.height-2);	
		var curPosB2 = posB2 - newElementsGroupBottom.getBBox().height/1.5;
		newElementsGroupBottom.setAttribute("transform", 'translate('+ posB1 +','+ curPosB2 +')');
		newActiveStair.bottomY = curPosB2;
		newActiveStair.bottomX = posB1;

		var timeoutBottom = setTimeout(function moveActionBottom()
		{
			if (newElementsGroupBottom===null)
				return;

			newElementsGroupBottom.setAttribute("transform", 'translate('+ posB1 + ',' + curPosB2 + ')');
			if (curPosB2<posB2-2)
			{
				curPosB2+=3;
				timeoutBottom = setTimeout(moveActionBottom, 4);
			}
			else{
				curPosB2=posB2;
				newElementsGroupBottom.setAttribute("transform", 'translate('+ posB1 + ',' + posB2 + ')');
				lastActiveStair.bottomY = newActiveStair.bottomY;
				lastActiveStair.bottomX = newActiveStair.bottomX;
				lastActiveStair.bottomReady = true;
				lastActiveStair.isStarted = false;
			}
			newActiveStair.bottomY = curPosB2;
		}, 5);
	}
};

function AddSuggestionToStairs(elName, suggestion_1_line, suggestion_2_line, newStairName)
{
	var stairsWidth = 100, stairsHeight = 100;	
	var suggestionCornerRadius = 10;
	var suggestionWidth = 130-2*suggestionCornerRadius, suggestionHeight = 50-2*suggestionCornerRadius;
	var heightOfTriangle = suggestionHeight/4;
	var suggestionShadowTranslationX = -5, suggestionShadowTranslationY = 5;
	var textLineHeight = 20;
	var stairCur = curSVGRoot.getElementById(elName);
	//stairCur.setAttribute("onclick","ToNewFloor('" + newStairName + "');");
	var parentPos = stairCur.getBBox();
	
	//Dynamically adding group, which will contain all elements
	var newElementsGroup = document.createElementNS("http://www.w3.org/2000/svg", 'g');
	newElementsGroup.setAttribute("width",suggestionWidth+heightOfTriangle);
	newElementsGroup.setAttribute("height",suggestionHeight);
	newElementsGroup.setAttribute("tagSuggestion","stairSuggestion");	
	newElementsGroup.setAttribute("onclick","ToNewFloor('" + newStairName + "');");
	stairCur.appendChild(newElementsGroup);
	
	//Adding shadow as background to main rectangle
	//var newElementShadow = document.createElementNS("http://www.w3.org/2000/svg", 'path');
	
	//var d_path = CreateLeftSuggestionBox(suggestionShadowTranslationX, suggestionShadowTranslationY, suggestionWidth, suggestionHeight, //suggestionCornerRadius, heightOfTriangle);
	//newElementShadow.setAttribute("d",d_path);
	//newElementShadow.style.fill = "rgba(0, 0, 0, 0.35)";
	//newElementShadow.style.strokeWidth = "0px"; 
	//newElementsGroup.appendChild(newElementShadow);
	
	//Adding main rectangle
	var newElementSuggestionBox = document.createElementNS("http://www.w3.org/2000/svg", 'path');
	/*newElementSuggestionBox.setAttribute("width",suggestionWidth);
	newElementSuggestionBox.setAttribute("height",suggestionHeight);
	newElementSuggestionBox.setAttribute("rx",suggestionCornerRadius);
	newElementSuggestionBox.setAttribute("ry",suggestionCornerRadius);
	*/
	newElementSuggestionBox.style.fill = "#FFF";
	newElementSuggestionBox.style.stroke = "rgba(200, 200, 200, 0.35)"; 
	newElementSuggestionBox.style.strokeWidth = "3px"; 	
	var d_path = CreateLeftSuggestionBox(0, 0, suggestionWidth, suggestionHeight, suggestionCornerRadius, heightOfTriangle);
	newElementSuggestionBox.setAttribute("d",d_path);
	newElementsGroup.appendChild(newElementSuggestionBox);
	
	/*var newElementTriangle = document.createElementNS("http://www.w3.org/2000/svg", 'polygon');
	pointsStr = '' + (suggestionWidth-triangleSize) + ',' + (suggestionHeight-suggestionCornerRadius);
	pointsStr += ' ' + (suggestionWidth) + ',' + (suggestionHeight-suggestionCornerRadius);
	pointsStr += ' ' + (suggestionWidth) + ',' + (suggestionHeight+triangleSize) + '';
	newElementTriangle.setAttribute("points", pointsStr);
	newElementTriangle.style.fill = "#FFF";
	newElementTriangle.style.stroke = "rgba(0, 0, 0, 0.35)"; 
	newElementTriangle.style.strokeWidth = "0px"; 
	newElementsGroup.appendChild(newElementTriangle);*/
	
	//Adding text to rectangle
	var newElementText = document.createElementNS("http://www.w3.org/2000/svg", 'text');
	newElementText.setAttribute("alignment-baseline","before-edge");
	newElementText.setAttribute("x",2);
	newElementText.setAttribute("y",6);
	newElementText.setAttribute("height",textLineHeight);
	newElementText.innerHTML = suggestion_1_line;
	newElementsGroup.appendChild(newElementText);
	newElementText.setAttribute("x",(suggestionWidth-newElementText.getBBox().width)/2);
	newElementText.style.strokeWidth = "0px";
	
	var newElementText2 = document.createElementNS("http://www.w3.org/2000/svg", 'text');
	newElementText2.setAttribute("alignment-baseline","before-edge");
	newElementText2.setAttribute("x",2);
	newElementText2.setAttribute("y",5+textLineHeight);
	newElementText2.setAttribute("height",textLineHeight);
	newElementText2.innerHTML = suggestion_2_line;
	newElementsGroup.appendChild(newElementText2);
	newElementText2.setAttribute("x",(suggestionWidth-newElementText2.getBBox().width)/2);
	newElementText2.style.strokeWidth = "0px";
	
	var childrenPos = newElementsGroup.getBBox();
	var pos1, pos2;
	
	// Setting suggestion to top
	//pos1 = (parentPos.x + parentPos.width - stairsWidth) - childrenPos.width/2;
	//pos2 = (parentPos.y + parentPos.height - stairsHeight) - childrenPos.height;
	
	// Setting position to left
	pos1 = (parentPos.x + parentPos.width - stairsWidth) - childrenPos.width + heightOfTriangle*2;
	pos2 = (parentPos.y + parentPos.height - stairsHeight/2) - childrenPos.height/2;
	
	newElementsGroup.setAttribute("transform", 'translate('+ pos1 +','+ pos2 +')');
};

function CreateLeftSuggestionBox(startX, startY, boxWidth, boxHeight, boxCornerRadius, heightOfTriangle)
{
	var d_path="";
	d_path+= "M" + startX + "," + startY + " "; 
	d_path+= "h" + boxWidth + " "; 
	d_path+= "a" + boxCornerRadius + "," + boxCornerRadius + " 0 0 1 " + boxCornerRadius + "," + boxCornerRadius + " "; 
	d_path+= "v" + heightOfTriangle + " "; 
	d_path+= "L" + (boxWidth+heightOfTriangle*3) + " " + (2*heightOfTriangle+boxCornerRadius) + " "; 
	d_path+= "L" + (boxWidth+boxCornerRadius) + " " + (3*heightOfTriangle+boxCornerRadius) + " "; 
	d_path+= "v" + heightOfTriangle + " "; 
	d_path+= "a" + boxCornerRadius + "," + (boxCornerRadius) + " 0 0 1 " + (-boxCornerRadius) + "," + (boxCornerRadius) + " ";
	d_path+= "h" + (-boxWidth) + " ";
	d_path+= "a" + boxCornerRadius + "," + boxCornerRadius + " 0 0 1 " + (-boxCornerRadius) + "," + (-boxCornerRadius) + " ";
	d_path+= "v" + (-boxHeight) + " ";
	d_path+= "a" + boxCornerRadius + "," + boxCornerRadius + " 0 0 1 " + (boxCornerRadius) + "," + (-boxCornerRadius) + " ";
	d_path+= "z";
	return d_path;
};

function CreateBottomSuggestionBox(startX, startY, boxWidth, boxHeight, boxCornerRadius, heightOfTriangle)
{
	var d_path="";
	d_path+= "M" + startX + "," + startY + " "; 
	var lengthOfHorizontalPart = boxWidth/2-heightOfTriangle*2;
	d_path+= "h" + (lengthOfHorizontalPart) + " "; 
	d_path+= "L" + (lengthOfHorizontalPart+heightOfTriangle) + " " + (startY-heightOfTriangle) + " "; 
	d_path+= "L" + (lengthOfHorizontalPart+heightOfTriangle*2) + " " + (startY) + " "; 	
	d_path+= "h" + (lengthOfHorizontalPart) + " "; 
	d_path+= "a" + boxCornerRadius + "," + boxCornerRadius + " 0 0 1 " + boxCornerRadius + "," + boxCornerRadius + " "; 
	d_path+= "v" + boxHeight + " "; 
	d_path+= "a" + boxCornerRadius + "," + (boxCornerRadius) + " 0 0 1 " + (-boxCornerRadius) + "," + (boxCornerRadius) + " ";
	d_path+= "h" + (-boxWidth) + " ";
	d_path+= "a" + boxCornerRadius + "," + boxCornerRadius + " 0 0 1 " + (-boxCornerRadius) + "," + (-boxCornerRadius) + " ";
	d_path+= "v" + (-boxHeight) + " ";
	d_path+= "a" + boxCornerRadius + "," + boxCornerRadius + " 0 0 1 " + (boxCornerRadius) + "," + (-boxCornerRadius) + " ";
	d_path+= "z";
	return d_path;
};

function CreateTopSuggestionBox(startX, startY, boxWidth, boxHeight, boxCornerRadius, heightOfTriangle)
{
	var d_path="";
	d_path+= "M" + startX + "," + startY + " "; 
	d_path+= "h" + boxWidth + " "; 
	d_path+= "a" + boxCornerRadius + "," + boxCornerRadius + " 0 0 1 " + boxCornerRadius + "," + boxCornerRadius + " "; 
	d_path+= "v" + boxHeight + " "; 
	d_path+= "a" + boxCornerRadius + "," + (boxCornerRadius) + " 0 0 1 " + (-boxCornerRadius) + "," + (boxCornerRadius) + " ";
	var lengthOfHorizontalPart = boxWidth/2-heightOfTriangle*2;
	d_path+= "h" + (-lengthOfHorizontalPart) + " ";
	d_path+= "L" + (startX+lengthOfHorizontalPart+heightOfTriangle+boxCornerRadius) + " " + (startY+boxHeight+2*boxCornerRadius+heightOfTriangle) + " "; 
	d_path+= "L" + (startX+lengthOfHorizontalPart) + " " + (startY+boxHeight+2*boxCornerRadius) + " "; 	
	d_path+= "h" + (-lengthOfHorizontalPart) + " "; 
	d_path+= "a" + boxCornerRadius + "," + boxCornerRadius + " 0 0 1 " + (-boxCornerRadius) + "," + (-boxCornerRadius) + " ";
	d_path+= "v" + (-boxHeight) + " ";
	d_path+= "a" + boxCornerRadius + "," + boxCornerRadius + " 0 0 1 " + (boxCornerRadius) + "," + (-boxCornerRadius) + " ";
	d_path+= "z";
	return d_path;
};

function CreateTopDrop(startX, startY, boxRadius)
{
	var d_path="";
	d_path+= "M" + (startX + boxRadius/2) + "," + (startY - boxRadius/2) + " "; 
	d_path+= "A" + (boxRadius) + " "+ (boxRadius) + " 0 1 0" + " "+ (startX - boxRadius/2) + " "+ (startY - boxRadius/2); 
	d_path+= "L" + (startX) + " " + (startY) + " "; 	
	d_path+= "z";
	
	return d_path;
};
function CreateBottomDrop(startX, startY, boxRadius)
{
	var d_path="";
	d_path+= "M" + (startX - boxRadius/2) + "," + (startY + boxRadius/2) + " "; 
	d_path+= "A" + (boxRadius) + " "+ (boxRadius) + " 0 1 0" + " "+ (startX + boxRadius/2) + " "+ (startY + boxRadius/2); 
	d_path+= "L" + (startX) + " " + (startY) + " "; 	
	d_path+= "z";
	
	return d_path;
};
function CreateTopDrop2(startX, startY, boxRadius)
{
	var d_path="";
	var coeff2 = 1.2;
	d_path+= "M" + (startX + boxRadius) + "," + (startY + boxRadius/2) + " "; 
	d_path+= "A" + (boxRadius) + " " + (boxRadius*coeff2) + " 0 0 1" + " " + (startX + boxRadius/coeff2) + " " + (startY - boxRadius/coeff2); 
	//d_path+= "M" + (startX + boxRadius/2) + "," + (startY - boxRadius/2) + " "; 
	d_path+= "A" + (boxRadius) + " " + (boxRadius) + " 0 1 0" + " " + (startX - boxRadius/coeff2) + " " + (startY - boxRadius/coeff2); 
	d_path+= "A" + (boxRadius) + " " + (boxRadius*coeff2) + " 0 0 1" + " " + (startX - boxRadius) + " " + (startY + boxRadius/2); 
	d_path+= "z";
	
	return d_path;
};
function CreateBottomDrop2(startX, startY, boxRadius)
{
	var d_path="";
	var coeff2 = 1.2;
	d_path+= "M" + (startX - boxRadius) + "," + (startY - boxRadius/2) + " ";
	d_path+= "A" + (boxRadius) + " " + (boxRadius*coeff2) + " 0 0 1" + " " + (startX - boxRadius/coeff2) + " " + (startY + boxRadius/coeff2); 
	d_path+= "A" + (boxRadius) + " "+ (boxRadius) + " 0 1 0" + " "+ (startX + boxRadius/coeff2) + " "+ (startY + boxRadius/coeff2);  
	//!!!!
	d_path+= "A" + (boxRadius) + " " + (boxRadius*coeff2) + " 0 0 1" + " " + (startX + boxRadius) + " " + (startY - boxRadius/2); 
	d_path+= "z";
	
	return d_path;
};
function SegmentShow(segName)
{
	var segment = curSVGRoot.getElementById(segName);
	if (segment==null)
		console.log('Not found segment: ' + segName);
	else
	{
		segment.style.opacity = 1;
		for (var i=0;i<floorNames.length;++i)
		{
			var tmpEl = curSVGRoot.getElementById(floorNames[i]);
			if (tmpEl.contains(segment))
			{
				return i;
			}
		}
	}
};

function SegmentHide(segName)
{
	var segment = curSVGRoot.getElementById(segName);
	if (segment!=null)
		segment.style.opacity = 0;
};

//Both Way Search Array
function BWSA(array,indStart)
{		
	if ((curPathLength > bestPathLength)&&(bestPathLength!=0))
	{
		return 0;
	}
	var startLength;
	var delNum = 0;
	var opcRetVal = 0;

	arraysWhereWeWere.push(array);	
	
	startLength = curPathLength;
	opcRetVal = OPC(array, indStart);
	if (opcRetVal)
	{
		arraysWhereWeWere.pop();
		curPathLength = startLength;
		return 1;
	}

	curPathLength = startLength;
	for(var ind = indStart+1; ind < array.length; ind++)
	{
		if (array[ind-1].svgPathElement_length != null)
		{
			curPathLength += array[ind-1].svgPathElement_length;
			currentPath.push(array[ind-1].svgPathElement_name);
			delNum++;			
		}

		opcRetVal = OPC(array, ind);
		
		if (opcRetVal)
		{
			break;
		}
	}
	for (var k=0;k<delNum;++k)
	{		
		var el  = currentPath.pop();
	}
	delNum = 0;
	curPathLength = startLength;
	for(var ind = indStart-1; ind >= 0; ind--)
	{
		if (array[ind].svgPathElement_length != null)
		{
			curPathLength += array[ind].svgPathElement_length;
			currentPath.push(array[ind].svgPathElement_name);
			delNum++;			
		}

		opcRetVal = OPC(array, ind);
		
		if (opcRetVal)
		{
			break;
		}
	}
	curPathLength = startLength;	
	for (var k=0;k<delNum;++k)
	{		
		var el  = currentPath.pop();
	}	
	arraysWhereWeWere.pop();
};

//One Point Check
function OPC(array, ind)
{
	if (destArray == array)
	{
		if (array[ind].pointName === dstPoint)
		{
			if ((bestPathLength > curPathLength)||(bestPathLength==0))
			{
				bestPathLength = curPathLength;
				bestPath = currentPath.slice(0);
				return 1;
			}		
		}
	}
	else
	{
		if (array[ind].transitReferences!=null)
		{		
			for (var i=0;i<array[ind].transitReferences.length;i++)
			{			
				if (arraysWhereWeWere.indexOf(array[ind].transitReferences[i].ToWhatArrayTransit)>-1)
				{
					continue;
				}
				
				currentPath.push(array[ind].transitReferences[i].TransitElement);
				curPathLength += array[ind].transitReferences[i].TransitLength;
				
				BWSA(array[ind].transitReferences[i].ToWhatArrayTransit, array[ind].transitReferences[i].ToWhatIndexTransit);
							
				currentPath.pop();
				curPathLength -= array[ind].transitReferences[i].TransitLength;
			}
		}
	}
	return 0;
};

function CheckForRealNumber(inName)
{
	inName = inName.toLowerCase();
	var inNameNewStyle = '';
	//old style numeration check
	if (inName.indexOf('-')>0)
	{
		inNameNewStyle = inName.replace('-','');
	}
	if (inName.replace('aud_','') in dict_auds)
	{		
		var retArray = [];
		retArray.push('aud_'+dict_auds[inName.replace('aud_','')]);
		return retArray;
	}
	else
	{
		if (inNameNewStyle.length>0 && (inNameNewStyle in dict_auds) )
		{
			var retArray = [];
			retArray.push('aud_'+dict_auds[inNameNewStyle]);
			return retArray;
		}
		else
		{
			var retArray = CheckForSynonim(inName);
			if (retArray.length==0 && inNameNewStyle.length>0)
				return CheckForSynonim(inNameNewStyle);
			else
				return retArray;
		}
	}
};

function CheckForSynonim(inName)
{
	var retArray = [];
	for (var i=0;i<BMAudsSinonims.length;++i)
	{
		for (var j=0;j<BMAudsSinonims[i].sinonims.length;++j)
		{
			if (BMAudsSinonims[i].sinonims[j] == inName)
			{
				retArray.push(BMAudsSinonims[i].svgEl_Name);
				//return ;
			}
		}
	}
	return retArray;
}