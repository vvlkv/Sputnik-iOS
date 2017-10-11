var bestPath = new Array();
var currentPath = new Array();
var currentLengthPath = new Array();
var bestPathLenths = new Array();
var arraysWhereWeWere = new Array();

var SearchByPoints = false;
var srcRoom;
var dstRoom;
var source;
var destination;

var destInd;
var destArray;

var bestPathLength = 0;
var curPathLength = 0;

var SVGRoot;
var lastStartAudit, lastEndAudit;

function InitPathFinder(inSVGroot)
{
	SVGRoot = inSVGroot;
	InitArrays();
	lastAudit = null;
};

function ShowCustomAlert(text)
{
	ShowCustomAlert(text);
};

function SetNewAudFromAndroid(isSrcAud, newVal)
{
	if (isSrcAud)
		srcRoom = newVal;
	else
		dstRoom = newVal;
};

function ClearLastResult()
{
	if (bestPath.length)
	{		
		for (var i=0;i<bestPath.length;i++)
		{
			segmentHide(bestPath[i]);
		}
		bestPath = [];
		destArray = [];
		startArray = [];
		currentPath = [];
		bestPathLenths = [];
		arraysWhereWeWere = [];
		currentLengthPath = [];
		bestPathLength = 0;
		curPathLength = 0;
	}
	
	if (lastStartAudit!=null)
		lastStartAudit.style.opacity = 0;
	if (lastEndAudit!=null)
		lastEndAudit.style.opacity = 0;
};

function RoomFinder(isTwoPointsSearch)
{
	ClearLastResult();

	dstRoom = dstRoom.replace(' ','').toLowerCase();
	if (dstRoom.length<1)
	{
		ShowCustomAlert("Введите конечную аудиторию!");
		return;
	}
	else
		if ((dstRoom .indexOf("-")==2)&&(dstRoom .length==5))
		{
			dstRoom = dstRoom .replace('-','');
		}
	
	lastStartAudit = null;
	lastEndAudit = null;
	var curInd;
	
	if (isTwoPointsSearch)
	{
		srcRoom = srcRoom.replace(' ','').toLowerCase();
		if (srcRoom .length<1)
		{
			ShowCustomAlert("Введите начальную аудиторию!");
			return;
		}
		if ((srcRoom.indexOf("-")==2)&&(srcRoom.length==5))
		{
			srcRoom = srcRoom.replace('-','');
		}
		for (var i=0;i<allParts.length;++i)
			{
				for (var j=0;j<allParts[i].length;++j)
				{
					if (allParts[i][j].name.indexOf(srcRoom) > -1)
					{
						var element = SVGRoot.getElementById("aud" + srcRoom);
						lastStartAudit = element;
					}
					if (allParts[i][j].name.indexOf(dstRoom) > -1)
					{
						var element = SVGRoot.getElementById("aud" + dstRoom);
						lastEndAudit = element;
					}
					if ((lastEndAudit != null)&&(lastStartAudit != null))
						break;
				}
				if ((lastEndAudit != null)&&(lastStartAudit != null))
					break;			
			}
			
			
			if (lastStartAudit == null)
			{
				//alert("Error: start room is not defined in SVG!");
				ShowCustomAlert("Source auditorium is not defined in SVG!");
				return 0;
			}
			else
			{
				lastStartAudit.style.display = 'block';
				NavigateToElementOnScreen(lastStartAudit);
			}
			
			if (lastEndAudit == null)
			{
				//alert("Error: end room is not defined in SVG!");
				ShowCustomAlert("Destination auditorium is not defined in SVG!");
				return 0;
			}
			else
				lastEndAudit.style.display = 'block';
	}
	else
	{
		if (dstRoom=="")
		{
			dstRoom = srcRoom.replace(' ','').toLowerCase();
			if (dstRoom.length<1)
			{
				ShowCustomAlert("Введите конечную аудиторию!");
				return;
			}
			else if ((dstRoom .indexOf("-")==2)&&(dstRoom .length==5))
				{
					dstRoom = dstRoom .replace('-','');
				}
			for (var i=0;i<allParts.length;++i)
			{
				for (var j=0;j<allParts[i].length;++j)
				{
					if (allParts[i][j].name.indexOf(dstRoom) > -1)
					{
						var element = SVGRoot.getElementById("aud" + dstRoom);
						lastStartAudit = element;
					}
				}
				if (lastStartAudit!=null)
					break;
			}
			if (lastStartAudit == null)
			{
				//alert("Error: start room is not defined in SVG!");			
				ShowCustomAlert("Source auditorium is not defined in SVG!");
				return 0;
			}
			else
			{
				lastStartAudit.style.display = 'block';
				NavigateToElementOnScreen(lastStartAudit);
			}
		}
		else
		{
			for (var i=0;i<allParts.length;++i)
			{
				for (var j=0;j<allParts[i].length;++j)
				{
					if (allParts[i][j].name.indexOf(dstRoom) > -1)
					{
						var element = SVGRoot.getElementById("aud" + dstRoom);
						lastEndAudit = element;
					}
				}
				if (lastEndAudit!=null)
					break;
			}
			if (lastEndAudit == null)
			{
				//alert("Error: start room is not defined in SVG!");			
				ShowCustomAlert("Destination auditorium is not defined in SVG!");
				return 0;
			}
			else
			{
				lastEndAudit.style.display = 'block';
				NavigateToElementOnScreen(lastEndAudit);
			}
		}	
	}
	
	return 1;
};

function FindPath()
{	
	if (!RoomFinder(true))
		return;
	var startArray;
	
	destArray = null;
	startArray = null;
	if (SearchByPoints)
	{
		for (var i=0;i<allParts.length;++i)
		{
			for (var j=0;j<allParts[i].length;++j)
			{
				if (allParts[i][j].svgNum == source)
				{
					startArray = allParts[i];
				}
				if (allParts[i][j].svgNum == destination)
				{
					destInd = i;
					destArray = allParts[i];
				}
				if ((startArray != null)&&(destArray != null))
					break;
			}			
		}
	}
	else
	{
		var curInd;
		for (var i=0;i<allParts.length;++i)
		{
			for (var j=0;j<allParts[i].length;++j)
			{
				if ((curInd = allParts[i][j].name.indexOf(srcRoom)) > -1)
				{
					if ((curInd!=0)&&(allParts[i][j].name[curInd-1]!=' '))
						continue;
					source = allParts[i][j].svgNum;
					startArray = allParts[i];
				}
				if ((curInd =allParts[i][j].name.indexOf(dstRoom)) > -1)
				{
					if ((curInd!=0)&&(allParts[i][j].name[curInd-1]!=' '))
						continue;
					destination = allParts[i][j].svgNum;
					destInd = i;
					destArray = allParts[i];
				}
				if ((startArray != null)&&(destArray != null))
					break;
			}			
		}		
	}
	if (startArray == null)
	{
		ShowCustomAlert("Неизвестно, в каком корпусе находится начальная аудитория!");
		return 0;
	}
	if (destArray == null)
	{
		ShowCustomAlert("Неизвестно, в каком корпусе находится конечная аудитория!");
		return 0;
	}
	BWSA(startArray,getIndexOf(startArray,source));
	
	for (var i=0;i<bestPath.length;i++)
	{
		segmentShow(bestPath[i]);
	}	
};

function segmentShow(segNum)
{
	if ((segNum.indexOf("_p")>-1)||(segNum.indexOf("SrvPnt")>-1))
	{
		return;
	}
	var segment = SVGRoot.getElementById("path"+segNum);
	if (segment==null)
		segment = SVGRoot.getElementById(segNum);
	
	segment.style.opacity = 1;	
};

function segmentHide(segNum)
{
	if ((segNum.indexOf("_p")>-1)||(segNum.indexOf("SrvPnt")>-1))
	{
		return;
	}
	var segment = SVGRoot.getElementById("path"+segNum);
	if (segment==null)
		segment = SVGRoot.getElementById(segNum);
	
	segment.style.opacity = 0;	
};

//Both Way Search Array
function BWSA(array,indStart)
{		
	if ((curPathLength > bestPathLength)&&(bestPathLength!=0))
		return 0;
	
	var tmpLength, startLength;
	var delNum = 0;
	var delFirstLine = 0;
	
	arraysWhereWeWere.push(array);	
	
	startLength = curPathLength;
	if (OPC(array, indStart,0))
		delFirstLine++;	
	
	tmpLength = curPathLength;
	for(var i = indStart+1; i < array.length; i++)
		if (OPC(array, i,1))
			delNum++;
		else break;
	curPathLength = startLength;
	currentPath.splice(currentPath.length - delNum , delNum);
	currentLengthPath.splice(currentLengthPath.length - delNum , delNum);
	
	delNum = 0;
	tmpLength = curPathLength;
	for(var i = indStart-1; i >= 0; i--)
		if (OPC(array, i,0))
			delNum++;
		else break;
	curPathLength = tmpLength;			
	currentPath.splice(currentPath.length - delNum - delFirstLine, delNum+delFirstLine);
	currentLengthPath.splice(currentLengthPath.length - delNum - delFirstLine, delNum+delFirstLine);
	
	arraysWhereWeWere.pop();
};

function DoesArrayContain(array,element)
{
	for (var i = array.length - 1; i >= 0; i--)
		if (array[i] == element)
				return 1;
	return 0;
};

//One Point Check
function OPC(array, ind, fromLeft)
{
	currentPath.push(array[ind].svgNum);
	currentLengthPath.push(array[ind].length);
	curPathLength += array[ind].length;
	
	if (destArray == array)
	{
		if (array[ind].svgNum == destination)
		{
			if ((bestPathLength > curPathLength)||(bestPathLength==0))
			{
				if ((fromLeft)||(ind == 0))
				{
					bestPathLength = curPathLength;
					bestPath = currentPath.slice(0);
					bestPathLenths = currentLengthPath.slice(0);
				}
				else
				{
					bestPathLength = curPathLength - array[ind].length;
					bestPath = currentPath.slice(0, currentPath.length);
					bestPathLenths = currentLengthPath.slice(0, currentLengthPath.length);
				}
				curPathLength -= array[ind].length;
				currentPath.pop();
				currentLengthPath.pop();
				return 0;
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
					continue;
				
				currentPath.push(array[ind].transitReferences[i].TransitElement);
				currentLengthPath.push(array[ind].transitReferences[i].TransitLength);
				curPathLength += array[ind].transitReferences[i].TransitLength;
				
				BWSA(array[ind].transitReferences[i].ToWhatArrayTransit,			
				array[ind].transitReferences[i].ToWhatIndexTransit);
				
				currentPath.pop();
				currentLengthPath.pop();
				curPathLength -= array[ind].transitReferences[i].TransitLength;
			}
		}
	}
	return 1;
};

function getIndexOf(array, svgNum)
{
	for (var i = array.length - 1; i >= 0; i--)
		if (array[i].svgNum == svgNum)
			return i;
	
	return -1;
};