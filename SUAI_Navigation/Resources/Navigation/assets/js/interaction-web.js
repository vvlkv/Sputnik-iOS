function IndependentInit()
{
    CreateInfoBase();
};


function GetMap_BM()
{
    $.get('./resources/bm-v.min.svg', function(data){
		$("#mainDiv").prepend(data);
		InitSVGMap();
	}, 'text');
}

function HidePreloader()
{
    $("#preloader").fadeOut("slow");
	$('.barlittle').removeClass('stop');	    
	$('.triggerBar').click(function() {
			$('.barlittle').toggleClass('stop');
	});
}

function AddClearableClasses()
{
    return;
}


function InitAutocomplete()
{
	var dates=[];
	
	for (var i=0;i<dataBase.length;++i)
	{
		if (dataBase[i].corp=="Б.М.")
		{
			dates.push(dataBase[i].aud);
			
			if (dataBase[i].type===1)
			{	
				dict_auds[("Деканат " + dataBase[i].name).toLowerCase()]=dataBase[i].aud;
				dates.push("Деканат " + dataBase[i].name);
				
				dict_auds[("Деканат " + dataBase[i].unitNumber + " института").toLowerCase()]=dataBase[i].aud;
				dates.push("Деканат " + dataBase[i].unitNumber + " института");
			}
			
			if (dataBase[i].type===2)
			{
				dict_auds[(dataBase[i].name).toLowerCase()]=dataBase[i].aud;
				dates.push(dataBase[i].name);
				
				dict_auds[("Кафедра " + dataBase[i].unitNumber).toLowerCase()]=dataBase[i].aud;
				dates.push("Кафедра " + dataBase[i].unitNumber);
				
				dict_auds[(dataBase[i].unitNumber + " кафедра").toLowerCase()]=dataBase[i].aud;
				dates.push(dataBase[i].unitNumber + " кафедра");
			}
			
			if (dataBase[i].type===3)
			{	
				dict_auds[(dataBase[i].name).toLowerCase()]=dataBase[i].aud;
				dates.push(dataBase[i].name);
			}
		}
	}
	
};

function CreateInfoBase()
{
	$.getJSON( './resources/information_unauth.json', function( data ) {
		var items = [];
		for (var i=0;i<data.informationsuai.faculties.facult.length;++i)
		{
			var newEl = new Object();
			var curJSONel = data.informationsuai.faculties.facult[i];
			
			newEl.type = 1;	//Деканат
			newEl.unitNumber = curJSONel._number;
			newEl.corp = curJSONel.Dean.Header._pos;
			newEl.aud = curJSONel.Dean.Header._aud;
			newEl.name = curJSONel._name;
			newEl.time = "Пн-Пт: 10:00 - 17:00";
			newEl.phone = curJSONel.Dean.Header._phone;
			newEl.wlink = curJSONel.Dean.Link._site;
			newEl.wmail = curJSONel.Dean.Link._mail;
			newEl.person = curJSONel.Dean.Header._name;
			newEl.person_status = " Декан";
			newEl.icon = curJSONel._icon;
			dataBase.push(newEl);

			if (curJSONel.Department!=null)
				for (var j=0;j<curJSONel.Department.length;++j)
				{
					newEl = new Object();
					newEl.type = 2;	//Кафедра
					newEl.unitNumber = curJSONel.Department[j]._number;
					newEl.corp = curJSONel.Department[j].Header._pos;
					newEl.aud = curJSONel.Department[j].Header._aud;
					newEl.time = "Пн-Пт: 10:00 - 17:00";
					newEl.name = curJSONel.Department[j]._name;
					newEl.wlink = curJSONel.Department[j].Link._site;
					newEl.wmail = curJSONel.Department[j].Link._mail;
					newEl.phone = curJSONel.Department[j].Header._phone;
					newEl.person = curJSONel.Department[j].Header._name;
					newEl.person_status = " Зав.каф. №" + curJSONel.Department[j]._number;
					newEl.icon = curJSONel._icon;
					dataBase.push(newEl);
				}
		}
		
		for (var i=0;i<data.informationsuai.others.length;++i)
		{
			var newEl = new Object();
			var curJSONel = data.informationsuai.others[i];
			
			newEl.type = 3;
			newEl.corp = curJSONel._pos;
			newEl.aud = curJSONel._aud;
			if (curJSONel._time!=null)
			{
				newEl.time = curJSONel._time;
			}
			else
			{
				newEl.time = "Пн-Пт: 10:00 - 17:00";
			}
			newEl.name = curJSONel._name;
			dataBase.push(newEl);
		}
		
		InitAutocomplete();
	});
	
	
	$.getJSON ( './resources/sinonims.json', function( data ) {		
		for (var i=0;i<Object.keys(data).length;++i)
		{
			var newEl = new Object();
			var curJSONel = Object.values(data)[i];
			
			newEl.svgEl_Name = Object.keys(data)[i];
			newEl.sinonims = Object.values(data)[i];
			BMAudsSinonims.push(newEl);
		}
	});
};

function ShowInfo(inName)
{
	var realName = inName.replace('aud_','');
	
	var flag = false;
	for (var i=0;i<dataBase.length;++i)
		{
			if (dataBase[i].aud === realName)
			{
				flag = true;
				selectedAud = realName;
				$('#info-card-classnum').text(dataBase[i].name);
				if ((dataBase[i].type===1)||(dataBase[i].type===2))
				{
					if (dataBase[i].icon!="")
					{
						$('#info-card-icon').attr("src",dataBase[i].icon);
					}
					else
					{
						$('#info-card-icon').attr("src",'./resources/icons/guap-main.png');
					}
					$('#info-card-classphone-div').show();
					$('#info-card-classphone').text(dataBase[i].phone);
					$('#info-card-classlink-div').show();
					$('#info-card-classlink').text(dataBase[i].wlink);
					$('#info-card-classlink').attr('href',dataBase[i].wlink);
					if (dataBase[i].wmail!="")
					{
						$('#info-card-classmail').text(dataBase[i].wmail);
						$('#info-card-classmail-div').show();
					}
					else
					{
						$('#info-card-classmail-div').hide();
					}
					$('#info-card-person-div').show();
					$('#info-card-person').text(dataBase[i].person);
					$('#info-card-person-status-div').show();
					$('#info-card-person-status').text(dataBase[i].person_status);
					$('#info-card-classtime').text(dataBase[i].time);
				}
				if (dataBase[i].type===3)
				{
					$('#info-card-classtime').text(dataBase[i].time);
					$('#info-card-icon').attr("src",'./resources/icons/guap-main.png');
					$('#info-card-classphone-div').hide();
					$('#info-card-classlink-div').hide();
					$('#info-card-classlink-div').hide();
					$('#info-card-classmail-div').hide();
					$('#info-card-person-div').hide();
					$('#info-card-person-status-div').hide();
				}
			}
		}
	
	if (!flag)
	{
		return;
	}
	
	$('#info-card').css('display', 'block');	
};

function CloseInfoCard()
{
	$('#info-card').css('display', 'none');
}
