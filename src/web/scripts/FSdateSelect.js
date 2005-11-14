/*
PRODUCT: 	FS JavaScript Popup Date Selector - version 3.07
COPYRIGHT:	July 2004 (c) Future Shock Ltd.
CONTACT:	post@future-shock.net
COMPATIBILITY:
	PC (WinXP):	Internet Explorer 4/5/5.5/6, Netscape 4.78/7, Mozilla Firefox 0.8, Opera 7
	Mac (OS9):	Internet Explorer 5.1, Netscape 7.1
	Mac (OSX):	Internet Explorer 5.2, Netscape 7.1,Safari 125
	Internet Explorer 4 on PC has a problem displaying more than two date selectors on one page.

This product is NOT freeware or shareware, to use it without licence is breach of copyright and will be prosecuted.
Once a licence is purchased you may amend the CSS and image resources to style the product to your requirements.
*/


var FSaa,FSbb,FSb;var FSc,FSd;var FSintHposOffset,FSintVposOffset;var FSe,FSf,FSg;var FSh,FSi,FSj;var FSk=1;var FSl=60*1000;var FSm=FSl*60;var FSn=FSm*24;var FSo=0;var FSp=0;var FSq=0;var FSr=0;var FSs=0;if(navigator.userAgent.indexOf("\107\145\143\153\157")>0){FSstrBrowser="\107\145\143\153\157";document.onclick=FSfncHideDateSelector}else{FSstrBrowser="\111\105";document.onclick=function(){FSfncHideDateSelector(event)}}if((typeof(HTMLElement)!="\165\156\144\145\146\151\156\145\144")&&(!HTMLElement.prototype.insertAdjacentHTML)){HTMLElement.prototype.insertAdjacentHTML=function(where,htmlStr){var r=this.ownerDocument.createRange();r.setStartBefore(this);var parsedHTML=r.createContextualFragment(htmlStr);this.appendChild(parsedHTML);}}function FSfncShowDateSelector(DateRef,EventRef,DisableNone,LangID,ImagePath,hposOffset,vposOffset){if(FSd){return}else{FSd=true}FSintHposOffset=hposOffset;FSintVposOffset=vposOffset;if(document.getElementById){if(!FSf){FSh=new Date();FSh.setHours(0,0,0,0);FSfncWriteSelectorHTML();FSf=document.getElementById("\106\123\144\141\164\145\123\145\154\145\143\164\157\162");FSg=document.getElementById("\106\123\143\141\154\145\156\144\141\162\101\162\145\141");}FSe=DateRef;FSc=DisableNone;FSbb=LangID;FSb=ImagePath;switch(FSbb){case"\106\122":FSaa='\101\165\143\165\156\145';FSk=1;break;case"\104\105":FSaa='\113\145\151\156';FSk=1;break;case"\105\123":FSaa='\116\151\156\147\165\156\141';FSk=1;break;case"\105\123\125\123":FSaa='\116\151\156\147\165\156\141';FSk=0;break;case"\125\123":FSaa='\116\157\156\145';FSk=0;break;default:FSaa='\116\157\156\145';FSk=1;}FSi=new Date(FSh.getTime()-(FSn*184));FSj=new Date(FSh.getTime()+(FSn*182));FSo=0;if(FSe.value==FSaa){if(FSe.defaultValue==FSaa){var arrCurrentDate=FSfncDateToString(FSh).split("\057");FSp=arrCurrentDate[0+FSk]-1;}else{var arrCurrentDate=FSe.defaultValue.split("\057");FSo=arrCurrentDate[1-FSk];FSp=arrCurrentDate[0+FSk]-1;}}else{var arrCurrentDate=FSe.value.split("\057");FSo=arrCurrentDate[1-FSk];FSp=arrCurrentDate[0+FSk]-1;}FSq=arrCurrentDate[2];FSr=parseInt(FSp,10);FSs=parseInt(FSq,10);FSg.innerHTML=FSfncCreateCalendarArea();if(FSstrBrowser=="\107\145\143\153\157"){FSf.style.left=EventRef.clientX-90+hposOffset;FSf.style.top=EventRef.clientY+8+vposOffset;}else{FSf.style.left=EventRef.clientX-EventRef.offsetX-82+document.body.scrollLeft+document.documentElement.scrollLeft+hposOffset;FSf.style.top=EventRef.clientY-EventRef.offsetY+16+document.body.scrollTop+document.documentElement.scrollTop+vposOffset;}FSf.style.visibility="\166\151\163\151\142\154\145";}}function FSfncHideDateSelector(TheEvent){if(FSf){if(FSstrBrowser=="\107\145\143\153\157"){if(TheEvent){var ThisIcon="\106\123\144\163\111\143\157\156\137"+FSe.name;var rel=TheEvent.target;while(rel){if((rel.id=="\106\123\144\141\164\145\123\145\154\145\143\164\157\162")||(rel.id==ThisIcon)){break}else{rel=rel.parentNode}}}if(!rel){FSf.style.visibility="\150\151\144\144\145\156";FSd=false}return;}else{if((TheEvent)){if((TheEvent.clientX+document.body.scrollLeft+document.documentElement.scrollLeft>FSf.style.posLeft+1)&&(TheEvent.clientX+document.body.scrollLeft+document.documentElement.scrollLeft<FSf.style.posLeft+FSf.style.posWidth+10)&&(TheEvent.clientY+document.body.scrollTop+document.documentElement.scrollTop>FSf.style.posTop+1)&&(TheEvent.clientY+document.body.scrollTop+document.documentElement.scrollTop<FSf.style.posTop+FSf.offsetHeight+2)){return}if((TheEvent.clientX+document.body.scrollLeft+document.documentElement.scrollLeft>FSf.style.posLeft+81-FSintHposOffset)&&(TheEvent.clientX+document.body.scrollLeft+document.documentElement.scrollLeft<FSf.style.posLeft+99-FSintHposOffset)&&(TheEvent.clientY+document.body.scrollTop+document.documentElement.scrollTop>FSf.style.posTop-17-FSintVposOffset)&&(TheEvent.clientY+document.body.scrollTop+document.documentElement.scrollTop<FSf.style.posTop-FSintVposOffset)){return}}FSf.style.visibility="\150\151\144\144\145\156";FSd=false;}}else{FSf=false}}function FSfncCreateCalendarArea(){switch(FSbb){case"\106\122":var arrDayNames=new Array("\114\165\156","\115\141\162","\115\145\162","\112\145\165","\126\145\156","\123\141\155","\104\151\155");var arrMonthNames=new Array("\112\141\156\166\151\145\162","\106\046\145\141\143\165\164\145\073\166\162\151\145\162","\115\141\162\143\150\145","\101\166\162\151\154","\115\141\151","\112\165\151\156","\112\165\151\154\154\145\164","\101\157\046\165\143\151\162\143\073\164","\123\145\160\164\145\155\142\162\145","\117\143\164\157\142\162\145","\116\157\166\145\155\142\162\145","\104\046\145\141\143\165\164\145\073\143\145\155\142\162\145");var strTodayLabel="\101\165\152";var strNoValue="\101\165\143\165\156\145";break;case"\104\105":var arrDayNames=new Array("\115\157\156","\104\151\145","\115\151\164","\104\157\156","\106\162\145","\123\141\155","\123\157\156");var arrMonthNames=new Array("\112\141\156\165\141\162","\106\145\142\162\165\141\162","\115\046\141\165\155\154\073\162\172","\101\160\162\151\154","\115\141\151","\112\165\156\151","\112\165\154\151","\101\165\147\165\163\164","\123\145\160\164\145\155\142\145\162","\117\153\164\157\142\145\162","\116\157\166\145\155\142\145\162","\104\145\172\145\155\142\145\162");var strTodayLabel="\110\145\165\164\145";var strNoValue="\113\145\151\156";break;case"\105\123":case"\105\123\125\123":var arrDayNames=new Array("\114\165\156","\115\141\162","\115\151\046\145\141\143\165\164\145\073","\112\165\145","\126\151\145","\123\046\141\141\143\165\164\145\073\142","\104\157\155");var arrMonthNames=new Array("\105\156\145\162\157","\106\145\142\162\145\162\157","\115\141\162\172\157","\101\142\162\151\154","\115\141\171\157","\112\165\156\151\157","\112\165\154\151\157","\101\147\157\163\164\157","\123\145\160\164\151\145\155\142\162\145","\117\143\164\165\142\162\145","\116\157\166\151\145\155\142\162\145","\104\151\143\151\145\155\142\162\145");var strTodayLabel="\110\157\171";var strNoValue="\116\151\156\147\165\156\141";break;default:var arrDayNames=new Array("\115\157\156","\124\165\145","\127\145\144","\124\150\165","\106\162\151","\123\141\164","\123\165\156");var arrMonthNames=new Array("\112\141\156\165\141\162\171","\106\145\142\162\165\141\162\171","\115\141\162\143\150","\101\160\162\151\154","\115\141\171","\112\165\156\145","\112\165\154\171","\101\165\147\165\163\164","\123\145\160\164\145\155\142\145\162","\117\143\164\157\142\145\162","\116\157\166\145\155\142\145\162","\104\145\143\145\155\142\145\162");var strTodayLabel="\124\157\144\141\171";var strNoValue="\116\157\156\145";}var dtFirstOfMonth=new Date(FSs,FSr,1);var intTimeOffset=FSfncGetTimeOffset();if(Math.abs(intTimeOffset)>8){dtFirstOfMonth.setHours(-intTimeOffset,0,0,0)}switch(dtFirstOfMonth.getDay()){case 0:var OffsetDays=6;break;case 1:var OffsetDays=7;break;default:var OffsetDays=dtFirstOfMonth.getDay()-1;}OffsetDays-=(FSk-1);var dtCalendarStart=new Date(dtFirstOfMonth.getTime()-(FSn*OffsetDays));dtCalendarStart.setHours(12);var dtCalendarEnd=new Date(dtCalendarStart.getTime()+(FSn*41));dtCalendarEnd.setHours(12);strCalendar='\074\124\101\102\114\105\040\102\117\122\104\105\122\075\042\060\042\040\103\105\114\114\120\101\104\104\111\116\107\075\042\062\042\040\103\105\114\114\123\120\101\103\111\116\107\075\042\060\042\040\103\114\101\123\123\075\042\106\123\143\141\154\145\156\144\141\162\042\076';strCalendar+="\074\124\122\040\103\114\101\123\123\075\047\106\123\143\141\154\145\156\144\141\162\124\151\164\154\145\163\047\040\101\114\111\107\116\075\047\143\145\156\164\145\162\047\076";for(var i=0;i<=6;i++){intArrayPointer=i+(FSk-1);if(intArrayPointer<0){intArrayPointer=6}strCalendar+="\074\124\104\040\127\111\104\124\110\075\047\062\062\047\076"+arrDayNames[intArrayPointer]+"\074\057\124\104\076"}strCalendar+="\074\057\124\122\076";for(var i=0;i<=41;i++){if(i%7==0){strCalendar+="\074\124\122\040\101\114\111\107\116\075\047\143\145\156\164\145\162\047\076"}var StyleString="";var dtTheDay=new Date(dtCalendarStart.getTime()+(FSn*i));dtTheDay.setHours(0,0,0,0);if(dtTheDay.getTime()==FSh.getTime()){if((dtTheDay.getMonth()==FSp)&&(dtTheDay.getDate()==FSo)&&(dtTheDay.getFullYear()==FSq)){StyleString+="\142\141\143\153\147\162\157\165\156\144\055\151\155\141\147\145\072\040\165\162\154\050"+FSb+"\164\157\144\141\171\137\163\145\154\145\143\164\145\144\056\147\151\146\051\073\040\142\141\143\153\147\162\157\165\156\144\055\162\145\160\145\141\164\072\156\157\055\162\145\160\145\141\164\073\040"}else{StyleString+="\142\141\143\153\147\162\157\165\156\144\055\151\155\141\147\145\072\040\165\162\154\050"+FSb+"\164\157\144\141\171\056\147\151\146\051\073\040\142\141\143\153\147\162\157\165\156\144\055\162\145\160\145\141\164\072\156\157\055\162\145\160\145\141\164\073\040"}}else if((dtTheDay.getMonth()==FSp)&&(dtTheDay.getDate()==FSo)&&(dtTheDay.getFullYear()==FSq)){StyleString+="\142\141\143\153\147\162\157\165\156\144\055\151\155\141\147\145\072\040\165\162\154\050"+FSb+"\163\145\154\145\143\164\145\144\056\147\151\146\051\073\040\142\141\143\153\147\162\157\165\156\144\055\162\145\160\145\141\164\072\156\157\055\162\145\160\145\141\164\073\040"}if(dtTheDay.getMonth()!=FSr){var LinkClass="\106\123\156\157\164\111\156\115\157\156\164\150"}else{var LinkClass="\106\123\151\156\115\157\156\164\150"}if(((FSi)&&(FSj))&&((dtTheDay<FSi)||(dtTheDay>FSj))){strCalendar+="\074\124\104\040\103\114\101\123\123\075\047\106\123\157\165\164\117\146\122\141\156\147\145\047\040\123\124\131\114\105\075\047"+StyleString+"\047\076"+dtTheDay.getDate()+"\074\057\124\104\076"}else{strCalendar+="\074\124\104\040\123\124\131\114\105\075\047"+StyleString+"\047\076\074\101\040\110\122\105\106\075\047\112\141\166\141\163\143\162\151\160\164\072\040\166\157\151\144\040\106\123\146\156\143\123\145\164\104\141\164\145\050\""+FSfncDateToString(dtTheDay)+"\"\051\047\040\103\114\101\123\123\075\047"+LinkClass+"\047\076"+dtTheDay.getDate()+"\074\057\101\076\074\057\124\104\076"}if(i%7==6){strCalendar+="\074\057\124\122\076"}}strCalendar+="\074\057\124\101\102\114\105\076";switch(FSbb){case"\106\122":var strCellMessage='\104\141\164\145\040\123\145\154\145\143\164\157\162\074\102\122\076\074\101\040\110\122\105\106\075\042\150\164\164\160\072\057\057\163\157\146\164\167\141\162\145\056\146\165\164\165\162\145\055\163\150\157\143\153\056\156\145\164\042\076\106\165\164\165\162\145\040\123\150\157\143\153\040\123\157\146\164\167\141\162\145\074\057\101\076';break;case"\104\105":var strCellMessage='\113\157\163\164\145\156\154\157\163\145\162\040\104\141\164\145\156\141\165\163\167\141\145\150\154\145\162\074\102\122\076\074\101\040\110\122\105\106\075\042\150\164\164\160\072\057\057\163\157\146\164\167\141\162\145\056\146\165\164\165\162\145\055\163\150\157\143\153\056\156\145\164\042\076\106\165\164\165\162\145\040\123\150\157\143\153\040\123\157\146\164\167\141\162\145\074\057\101\076';break;case"\105\123":var strCellMessage='\123\145\154\145\143\143\151\157\156\141\144\157\162\040\144\145\040\106\145\143\150\141\163\040\147\162\141\164\151\163\040\160\157\162\074\102\122\076\074\101\040\110\122\105\106\075\042\150\164\164\160\072\057\057\163\157\146\164\167\141\162\145\056\146\165\164\165\162\145\055\163\150\157\143\153\056\156\145\164\042\076\106\165\164\165\162\145\040\123\150\157\143\153\040\123\157\146\164\167\141\162\145\074\057\101\076';break;case"\105\123\125\123":var strCellMessage='\123\145\154\145\143\143\151\157\156\141\144\157\162\040\144\145\040\106\145\143\150\141\163\040\147\162\141\164\151\163\040\160\157\162\074\102\122\076\074\101\040\110\122\105\106\075\042\150\164\164\160\072\057\057\163\157\146\164\167\141\162\145\056\146\165\164\165\162\145\055\163\150\157\143\153\056\156\145\164\042\076\106\165\164\165\162\145\040\123\150\157\143\153\040\123\157\146\164\167\141\162\145\074\057\101\076';break;default:var strCellMessage='\124\150\151\163\040\151\163\040\164\150\145\040\146\162\145\145\040\166\145\162\163\151\157\156\040\157\146\040\104\141\164\145\040\123\145\154\145\143\164\157\162\040\142\171\040\074\101\040\110\122\105\106\075\042\150\164\164\160\072\057\057\163\157\146\164\167\141\162\145\056\146\165\164\165\162\145\055\163\150\157\143\153\056\156\145\164\042\076\106\165\164\165\162\145\040\123\150\157\143\153\040\123\157\146\164\167\141\162\145\074\057\101\076';break;}if(strCellMessage.charAt(80)==""){return}var strMonthOptions="";var strSelected="";for(var i=0;i<=11;i++){if(i==FSr){strSelected="\040\123\105\114\105\103\124\105\104"}else{strSelected=""}strMonthOptions+='\074\117\120\124\111\117\116'+strSelected+'\076'+arrMonthNames[i]+'\074\057\117\120\124\111\117\116\076';}if(FSc==true){NoneButton='<IMG SRC="'+FSb+FSbb+'/but_none_dis.gif" WIDTH="44" HEIGHT="18" HSPACE="1">'}else{NoneButton='<INPUT TYPE="image" SRC="'+FSb+FSbb+'/but_none.gif" WIDTH="44" HEIGHT="18" HSPACE="1" onClick="FSfncSetDate(\''+strNoValue+'\')">'}strCalendar='<TABLE BORDER="0" CELLPADDING="1" CELLSPACING="0" WIDTH="100%" HEIGHT="100%">'+'<TR HEIGHT="22" CLASS="FSbuttonsRow">'+'<TD WIDTH="30" ALIGN="left"><INPUT TYPE="image" SRC="'+FSb+'but_prev.gif" WIDTH="18" HEIGHT="18" HSPACE="1" onClick="FSfncAdvanceDate(-1)"></TD>'+'<TD><SELECT NAME="FScurrentMonth" CLASS="FSmonthRolldown" onChange="FSfncChangeMonth(this.selectedIndex + 1)">'+strMonthOptions+'</SELECT></TD>'+'<TD><INPUT TYPE="text" NAME="FScurrentYear" VALUE="'+FSs+'" READONLY CLASS="FSyearInput"></TD>'+'<TD><INPUT TYPE="image" SRC="'+FSb+'but_yeard.gif" WIDTH="18" HEIGHT="9" onClick="FSfncAdvanceDate(12)"><BR><INPUT TYPE="image" SRC="'+FSb+'but_yearu.gif" WIDTH="18" HEIGHT="9" onClick="FSfncAdvanceDate(-12)"></TD>'+'<TD WIDTH="30" ALIGN="right"><INPUT TYPE="image" SRC="'+FSb+'but_next.gif" WIDTH="18" HEIGHT="18" HSPACE="1" onClick="FSfncAdvanceDate(1)"></TD>'+'</TR>'+'<TR HEIGHT="133" BGCOLOR="#FFFFFF"><TD COLSPAN="5" ALIGN="center">'+strCalendar+'</TD></TR>'+'<TR HEIGHT="16"><TD COLSPAN="5" ID="FSrangeCell">'+strCellMessage+'</TD></TR>'+'<TR HEIGHT="22" CLASS="FSbuttonsRow">'+'<TD COLSPAN="5">'+'<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" WIDTH="100%">'+'<TR>'+'<TD ALIGN="left"><INPUT TYPE="image" SRC="'+FSb+FSbb+'/but_today.gif" WIDTH="44" HEIGHT="18" HSPACE="1" onClick="FSfncSetDate(FSfncDateToString(FSh))"></TD>'+'<TD ALIGN="center" ID="FSdateToday">'+strTodayLabel+': '+FSfncDateToString(FSh)+'</TD>'+'<TD ALIGN="right">'+NoneButton+'</TD>'+'</TR>'+'</TABLE>'+'</TD>'+'</TR>';return strCalendar;}function FSfncGetTimeOffset(){var rightNow=new Date();var date1=new Date(rightNow.getFullYear(),0,1,0,0,0,0);var temp=date1.toGMTString();var date3=new Date(temp.substring(0,temp.lastIndexOf(" ")-1));return(date1-date3)/FSm;}function FSfncSetDate(TheDate){var tempArray=TheDate.split("/");var resultingDate=new Date(tempArray[2],tempArray[0+FSk]-1,tempArray[1-FSk]);if(((FSi)&&(FSj))&&((resultingDate<FSi)||(resultingDate>FSj))){switch(FSbb){case"FR":alert("Veuillez choisir une d�te dans la gamme specifi�e");break;case"DE":alert("Bitte ein Datum innerhalb des angegebenen Zeitraums w�hlen");break;case"ES":case"ESUS":alert("Por favor, elija una fecha dentro del periodo especificado");break;default:alert("Please select a date in the range specified");}return false;}FSo=0;FSe.value=TheDate;FSfncHideDateSelector();}function FSfncAdvanceDate(Adjuster){if((Adjuster==12)||(Adjuster==-12)){FSs=FSs+(Adjuster/12)}else{FSr=FSr+Adjuster;if(FSr==-1){FSr=11;FSs--}if(FSr==12){FSr=0;FSs++}}FSg.innerHTML=FSfncCreateCalendarArea();}function FSfncChangeMonth(Adjuster){FSr=Adjuster-1;FSg.innerHTML=FSfncCreateCalendarArea();}function FSfncDateToString(TheDate){if(!TheDate){return""}else{if(FSk==1){return(TheDate.getDate()<10?"0"+TheDate.getDate():TheDate.getDate())+"/"+(TheDate.getMonth()<9?"0"+(TheDate.getMonth()+1):(TheDate.getMonth()+1))+"/"+TheDate.getFullYear()}else{return(TheDate.getMonth()<9?"0"+(TheDate.getMonth()+1):(TheDate.getMonth()+1))+"/"+(TheDate.getDate()<10?"0"+TheDate.getDate():TheDate.getDate())+"/"+TheDate.getFullYear()}}}function FSfncMakeDate(TheDay,TheMonth,TheYear){return new Date(TheYear,TheMonth-1,TheDay)}function FSfncCheckDate(thisDateField,LangID){if(!LangID){LangID=FSbb}switch(LangID){case"FR":FSaa='Aucune';FSk=1;var strFailText="Cette date n'est pas valable";break;case"DE":FSaa='Keine';FSk=1;var strFailText="Dieses Datum ist ung�ltig";break;case"ES":FSaa='Ninguna';FSk=1;var strFailText="Esta fecha no es v�lida";break;case"ESUS":FSaa='Ninguna';FSk=0;var strFailText="Esta fecha no es v�lida";break;case"US":FSaa='None';FSk=0;var strFailText="Date is not valid";break;default:FSaa='None';FSk=1;var strFailText="Date is not valid";}if(thisDateField.value==""){thisDateField.value=FSaa}if((thisDateField.value!=FSaa)&&(!FSfncCheckDateFormat(thisDateField.value))){alert(strFailText);thisDateField.value=thisDateField.defaultValue}}function FSfncCheckDateFormat(thisDate){if(thisDate.indexOf("/")==-1){return false}var ArrayDate=thisDate.split("/");if(ArrayDate.length!=3){return false}if((isNaN(ArrayDate[0]))||(ArrayDate[0]=="")){return false}if((isNaN(ArrayDate[1]))||(ArrayDate[1]=="")){return false}if((isNaN(ArrayDate[2]))||(ArrayDate[2]=="")){return false}var daysInMonth=new Array(0,31,29,31,30,31,30,31,31,30,31,30,31);if((parseInt(ArrayDate[1-FSk],10)<1)||(parseInt(ArrayDate[1-FSk],10)>daysInMonth[parseInt(ArrayDate[0+FSk],10)])){return false}if((parseInt(ArrayDate[0+FSk],10)==2)&&(parseInt(ArrayDate[1-FSk],10)>FSfncDaysInFebruary(parseInt(ArrayDate[2],10)))){return false}if((parseInt(ArrayDate[0+FSk],10)<1)||(parseInt(ArrayDate[0+FSk],10)>12)){return false}return true;}function FSfncDaysInFebruary(year){return(((year%4==0)&&((!(year%100==0))||(year%400==0)))?29:28)}function FSfncWriteSelectorHTML(){var selectorHTML=''+'<FORM ACTION="#" METHOD="GET" NAME="FSdateSelectorForm" onSubmit="return false">'+'<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" WIDTH="188" HEIGHT="194" ID="FSdateSelector" STYLE="width:190px; height:196px">'+'<TR><TD ID="FScalendarArea"></TD></TR>'+'</TABLE>'+'</FORM>';document.body.insertAdjacentHTML("BeforeEnd",selectorHTML)}function FSfncWriteFieldHTML(FormName,FieldName,FieldValue,FieldWidth,ImagePath,LangID,DisableNone,UseOnClick,HposOffset,VposOffset){if(!LangID){LangID="EN"}if(!DisableNone){DisableNone=false}if(ImagePath.charAt(ImagePath.length-1)!="/"){ImagePath=ImagePath+"/"}if(!HposOffset){HposOffset=0}if(!VposOffset){VposOffset=0}if(document.getElementById){var FSimg1=new Image();FSimg1.src=ImagePath+"today_selected.gif";var FSimg2=new Image();FSimg2.src=ImagePath+"today.gif";var FSimg3=new Image();FSimg3.src=ImagePath+"selected.gif";var FSimg4=new Image();FSimg4.src=ImagePath+"but_prev.gif";var FSimg5=new Image();FSimg5.src=ImagePath+"but_yearu.gif";var FSimg6=new Image();FSimg6.src=ImagePath+"but_yeard.gif";var FSimg7=new Image();FSimg7.src=ImagePath+"but_next.gif";var FSimg8=new Image();FSimg8.src=ImagePath+LangID+"/but_today.gif";var FSimg9=new Image();FSimg9.src=ImagePath+LangID+"/but_none.gif";var ActionString='FSfncShowDateSelector(document.'+FormName+'.'+FieldName+',event,'+DisableNone+',\''+LangID+'\',\''+ImagePath+'\','+HposOffset+','+VposOffset+')';if(UseOnClick==true){var ActionEvent="onMouseDown="+ActionString;switch(LangID){case"FR":var IconAltText="Cliquez ici pour choisir une date";break;case"DE":var IconAltText="Hier klicken, um ein Datum auszuw�hlen";break;case"ES":case"ESUS":var IconAltText="Haga clic aqu� para seleccionar una fecha";break;default:var IconAltText="Click here to select a date";}}else{var ActionEvent="onMouseOver="+ActionString+" onMouseDown="+ActionString;var IconAltText="";}var formFieldHTML=''+'<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" BGCOLOR="#FFFFFF" CLASS="FSdateSelect" ID="'+FieldName+'FStable" WIDTH="'+FieldWidth+'" HEIGHT="22" STYLE="width:'+FieldWidth+'px">'+'<TR>'+'<TD><INPUT TYPE="text" NAME="'+FieldName+'" VALUE="'+FieldValue+'" CLASS="FSdateField" SIZE="9" MAXLENGTH="10" onChange="FSfncCheckDate(this,\''+LangID+'\')" READONLY></TD>'+'<TD ALIGN="right"><A HREF="JavaScript: void 0" '+ActionEvent+'><IMG SRC="'+ImagePath+'calendar.gif" HEIGHT="16" WIDTH="16" HSPACE="3" BORDER="0" ALT="'+IconAltText+'" ID="FSdsIcon_'+FieldName+'"></A></TD>'+'</TR>'+'</TABLE>';document.write(formFieldHTML);}else{var formFieldHTML='<INPUT TYPE="text" NAME="'+FieldName+'" VALUE="'+FieldValue+'" SIZE="10" MAXLENGTH="10" onChange="FSfncCheckDate(this,\''+LangID+'\')" STYLE="width:'+FieldWidth+'px; height:22px">';document.write(formFieldHTML);}}