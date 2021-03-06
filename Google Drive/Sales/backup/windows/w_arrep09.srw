$PBExportHeader$w_arrep09.srw
forward
global type w_arrep09 from window
end type
type st_import from statictext within w_arrep09
end type
type cb_importcollmas from commandbutton within w_arrep09
end type
type cb_close from commandbutton within w_arrep09
end type
type hpb_import from hprogressbar within w_arrep09
end type
type st_status from statictext within w_arrep09
end type
type gb_1 from groupbox within w_arrep09
end type
end forward

global type w_arrep09 from window
integer width = 2359
integer height = 664
boolean titlebar = true
string title = "Import Collmas"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
st_import st_import
cb_importcollmas cb_importcollmas
cb_close cb_close
hpb_import hpb_import
st_status st_status
gb_1 gb_1
end type
global w_arrep09 w_arrep09

on w_arrep09.create
this.st_import=create st_import
this.cb_importcollmas=create cb_importcollmas
this.cb_close=create cb_close
this.hpb_import=create hpb_import
this.st_status=create st_status
this.gb_1=create gb_1
this.Control[]={this.st_import,&
this.cb_importcollmas,&
this.cb_close,&
this.hpb_import,&
this.st_status,&
this.gb_1}
end on

on w_arrep09.destroy
destroy(this.st_import)
destroy(this.cb_importcollmas)
destroy(this.cb_close)
destroy(this.hpb_import)
destroy(this.st_status)
destroy(this.gb_1)
end on

type st_import from statictext within w_arrep09
integer x = 46
integer y = 180
integer width = 1774
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean focusrectangle = false
end type

type cb_importcollmas from commandbutton within w_arrep09
integer x = 137
integer y = 428
integer width = 416
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Import Data"
end type

event clicked;
/**********************************************************************************/ 
/*     QUERY EXPORT collmas from mini : export DBPATH=/data/brd                   */
/**********************************************************************************/
/*
unload to /public/llcolmas.txt
select
debtor, rdate, stat,trno, camt,0.00,0.00, rbank,'-','-','-', userid,'1'       
from
collmas
where rdate between '01072014' and '20072014'
order by rdate,trno
*/
/**********************************************************************************/ 
/*     QUERY EXPORT collmas from mini : export DBPATH=/data/brd                   */
/**********************************************************************************/

string &
	ls_docpath, ls_docname, ls_arrdata[], ls_crdata, ls_data, &	
	ls_temp[], ls_temp_path, ls_7z, ls_command, ls_temp_dir, &
	ls_rcvnum,ls_custnum,ls_rcstatus,ls_rcref,ls_rcrem1,ls_rcrem2,ls_rcrem3,ls_rcrem4, &
	ls_create_by,ls_is_exprt,ls_fcollmas	      
           

date &	
	ld_rcdate,ld_create_date, ld_update_date	

integer &
	li_return, li_rc, li_collmas,li_terms

decimal {2} &
	ldc_rcamt,ldc_rcbank_inch, ldc_rcbank_outch
	
long &
	ll_count, ll_progress
boolean lb_exists

OleObject wsh
ContextKeyword lcxk_base


CONSTANT integer MAXIMIZED = 3
CONSTANT integer MINIMIZED = 2
CONSTANT integer NORMAL = 1
CONSTANT boolean WAIT = TRUE
CONSTANT boolean NOWAIT = FALSE

// get temp dir
this.GetContextService("Keyword", lcxk_base)
lcxk_base.getContextKeywords("TEMP", ls_temp)
ls_temp_path = ls_temp[1]

//open file 7z
li_return = GetFileOpenName("Select File [tempcollmas.7z]", &
    ls_docpath, ls_docname, "7z", "Export Files (*.7z) ,*.7z", & 
    ls_temp_path, 18)

if li_return = 0 then
	return
end if 

// extract file
ls_7z = gst7z_program //"c:\7za.exe"
wsh = CREATE OleObject
li_rc= wsh.ConnectToNewObject( "WScript.Shell" )	
//ls_password = "123superduper546"
ls_command = '"' + ls_7z + '"' + ' x "' + ls_docpath +&
	'" -o"' + ls_temp_path + '" -y' //-p' + ls_password
li_rc = wsh.Run(ls_command , NORMAL, WAIT)

st_status.text = "Exctracting files ..."
ls_fcollmas = ls_temp_path + "\tempcollmas.txt"
ls_temp_dir = ls_temp_path + "\tempcollmas.txt"

if lb_exists   = FILEEXISTS (ls_fcollmas) then 
		messagebox ("Error", "Data file "+ ls_fcollmas +" tidak ada" )
	else
	hpb_import.maxposition = 100
	hpb_import.position = 1
	ll_progress = 0
	
	li_collmas = FileOpen( ls_fcollmas)
	do while true
		hpb_import.SetRange(0, ll_progress)
		hpb_import.SetStep = 1	
		hpb_import.offsetpos(1)
		li_return = fileread( li_collmas, ls_fcollmas)
		if li_return = -100 then
			exit
		end if
		
		// progress 
		yield()
		ll_progress ++
		st_status.text = "Importing rcmas data ... [ " + string(ll_progress) + " ]"
		st_import.text = ""
		
		ls_arrdata[] = f_split_string( ls_fcollmas, "|")
		ls_custnum      = ls_arrdata[1]
		ld_rcdate       = date(ls_arrdata[2])
		ls_rcstatus     = ls_arrdata[3]
		ls_rcref        = trim(ls_arrdata[4])
		ldc_rcamt       = dec(ls_arrdata[5])
		ldc_rcbank_inch  = dec(ls_arrdata[6])
		ldc_rcbank_outch = dec(ls_arrdata[7])
		ls_rcrem1       = ls_arrdata[8]
		ls_rcrem2       = ls_arrdata[9]
		ls_rcrem3       = ls_arrdata[10]
		ls_rcrem4       = ls_arrdata[11]
		ls_create_by    = ls_arrdata[12]
		ld_create_date  = date(ls_arrdata[2])
		ls_is_exprt     = ls_arrdata[13]
			
		ll_count = 0
		select count(rcref) into :ll_count
			from rcmas 
			where rcref =:ls_rcref;
		if ll_count > 0 then
	
	//		continue
			st_import.text = "Update rcmas data ... [ " + string(ls_rcref) + " ]"
	
			UPDATE rcmas SET
				custnum      =:ls_custnum,      
				rcdate       =:ld_rcdate,       
				rcstatus     =:ls_rcstatus,     					        
				rcamt        =:ldc_rcamt,       
				rcbank_inch  =:ldc_rcbank_inch, 
				rcbank_outch =:ldc_rcbank_outch,
				rcrem1       =:ls_rcrem1,       
				rcrem2       =:ls_rcrem2,       
				rcrem3       =:ls_rcrem3,       
				rcrem4       =:ls_rcrem4,       
				is_exprt     =:ls_is_exprt
			WHERE
				rcref =:ls_rcref;
				
			commit;				
			
		else
				st_import.text = "Inserting rcmas data ... [ " + string(ls_rcref) + " ]"
				ls_rcvnum = f_get_trnum( "ARRC", "NUMARRC");
				insert into rcmas(
						rcnum,									
						custnum,      
						rcdate,       
						rcstatus,     
						rcref,        
						rcamt,        
						rcbank_inch,  
						rcbank_outch, 
						rcrem1,       
						rcrem2,       
						rcrem3,       
						rcrem4,      
						create_by,    
						create_date,  
						is_exprt  )      
				values(            
						:ls_rcvnum,       
						:ls_custnum,
						:ld_rcdate,
						:ls_rcstatus,
						:ls_rcref,
						:ldc_rcamt,
						:ldc_rcbank_inch,
						:ldc_rcbank_outch,
						:ls_rcrem1,
						:ls_rcrem2,
						:ls_rcrem3,
						:ls_rcrem4,
						:ls_create_by,
						:ld_create_date,
						:ls_is_exprt      
						); 
			
					commit;
			end if
			 
			if sqlca.sqlcode <> 0 then
				messagebox ("Error", "Import Error~r~n" + sqlca.sqlerrtext)
				fileclose( li_collmas)
				return
			end if	
		
	loop
	fileclose(li_collmas)
	
	FileDelete(ls_temp_dir)

	messagebox( "Import", "done !!!")	
end if	




end event

type cb_close from commandbutton within w_arrep09
integer x = 562
integer y = 432
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Close"
end type

event clicked;close(parent)
end event

type hpb_import from hprogressbar within w_arrep09
integer x = 50
integer y = 300
integer width = 2235
integer height = 68
unsignedinteger maxposition = 20
integer setstep = 10
end type

type st_status from statictext within w_arrep09
integer x = 46
integer y = 72
integer width = 1774
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Status Data Import"
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_arrep09
integer width = 2336
integer height = 572
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

