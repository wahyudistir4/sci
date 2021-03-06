$PBExportHeader$w_arrep08.srw
forward
global type w_arrep08 from window
end type
type st_insert from statictext within w_arrep08
end type
type cb_importcustmast from commandbutton within w_arrep08
end type
type cb_close from commandbutton within w_arrep08
end type
type hpb_import from hprogressbar within w_arrep08
end type
type st_status from statictext within w_arrep08
end type
type gb_1 from groupbox within w_arrep08
end type
end forward

global type w_arrep08 from window
integer width = 2377
integer height = 680
boolean titlebar = true
string title = "Import Customer"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
st_insert st_insert
cb_importcustmast cb_importcustmast
cb_close cb_close
hpb_import hpb_import
st_status st_status
gb_1 gb_1
end type
global w_arrep08 w_arrep08

on w_arrep08.create
this.st_insert=create st_insert
this.cb_importcustmast=create cb_importcustmast
this.cb_close=create cb_close
this.hpb_import=create hpb_import
this.st_status=create st_status
this.gb_1=create gb_1
this.Control[]={this.st_insert,&
this.cb_importcustmast,&
this.cb_close,&
this.hpb_import,&
this.st_status,&
this.gb_1}
end on

on w_arrep08.destroy
destroy(this.st_insert)
destroy(this.cb_importcustmast)
destroy(this.cb_close)
destroy(this.hpb_import)
destroy(this.st_status)
destroy(this.gb_1)
end on

type st_insert from statictext within w_arrep08
integer x = 46
integer y = 160
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

type cb_importcustmast from commandbutton within w_arrep08
integer x = 114
integer y = 412
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

event clicked;/**********************************************************************************/ 
/*     QUERY EXPORT custmast from mini : export DBPATH=/data/brd                  */
/**********************************************************************************/
/*
unload to /public/unload-rph/tempcustmast.txt
select custnum,custname,'-','1','O',addr1,addr2,addr3,
		terr,terr,postcode,tel,fax,contact,terms,userid,
		'19/04/2015','','19/04/2015'
from custmast
where
1=1
and (
   custnum[3] ='A' 
OR custnum[3] ='B' 
OR custnum[3] ='C' 
OR custnum[3] ='D')
order by custnum;

unload to /public/unload-rph/tempsubdept.txt
select a.custnum,a.subcode,a.subdesc,a.addr1,
	    a.addr2,a.addr3,a.area,a.tel,
		 a.fax,a.contact,1,b.newcode
from subdept a,tmp_customer b
where a.custnum = b.oldcode
and b.created_date between '28102014' and '28112014';

*/
/**********************************************************************************/ 
/*     QUERY EXPORT custmast from mini : export DBPATH=/data/brd                  */
/**********************************************************************************/



string &
	ls_docpath, ls_docname, ls_arrdata[], ls_crdata, ls_data, &	
	ls_temp[], ls_temp_path, ls_7z, ls_command,ls_temp_dir, &
	ls_custnum, ls_custname,ls_custstat,ls_addr1,ls_addr2, ls_addr3,ls_area,ls_tel,ls_fax,ls_contact, &
	ls_city,ls_postcode,ls_update_by, ls_create_by, ls_title, ls_op_in, &
	ls_fcustmast, &
	ls_subcode,ls_subdesc, ls_status,ls_fsubdept
	
           

date &	
	ld_create_date, ld_update_date	

integer &
	li_return, li_rc, li_custmast,li_terms, li_subdept

decimal {2} &
	ldc_uprice
	 
long &
	ll_count, ll_progress

BOOLEAN lb_exists	
	
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
li_return = GetFileOpenName("Select File[tempcustmast.7z]", &
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


st_insert.text = ""
st_status.text = "Exctracting files ..."

ls_fcustmast = ls_temp_path + "\tempcustmast.txt"
ls_temp_dir = ls_temp_path + "\tempcustmast.txt"



if lb_exists   = FILEEXISTS (ls_fcustmast) then 
		messagebox ("Error", "Data file "+ ls_fcustmast +" tidak ada" )
else
		
	hpb_import.maxposition = 1
	hpb_import.position = 1
	ll_progress = 0
	
	li_custmast = FileOpen( ls_fcustmast)
	do while true
		li_return = fileread( li_custmast, ls_fcustmast)
		if li_return = -100 then
			exit
		end if
		
		// progress 
		yield()
		ll_progress ++
		st_status.text = "Importing custmast data ... [ " + string(ll_progress) + " ]"
				
		ls_arrdata[] = f_split_string( ls_fcustmast, "|")
		ls_custnum     = ls_arrdata[1] 
		ls_custname    = ls_arrdata[2]+"." 
		ls_title       = ls_arrdata[3] 
		ls_custstat    = ls_arrdata[4] 
		ls_op_in       = ls_arrdata[5] 
		ls_addr1       = ls_arrdata[6] 
		ls_addr2       = ls_arrdata[7] 
		ls_addr3       = ls_arrdata[8] 
		ls_city        = ls_arrdata[9] 
		ls_area        = ls_arrdata[10]
		ls_postcode    = ls_arrdata[11]
		ls_tel         = ls_arrdata[12]
		ls_fax         = ls_arrdata[13]
		ls_contact     = ls_arrdata[14]
		li_terms       = integer(ls_arrdata[15])
		ls_create_by   = ls_arrdata[16]
		ld_create_date = date(gd_serverdate) // date(ls_arrdata[17])
		ls_update_by   = ls_arrdata[18]
		ld_update_date = date(gd_serverdate) // date(ls_arrdata[19])
	
		
		ll_count = 0
		select count(custnum) into :ll_count
			from custmast 
			where custnum =:ls_custnum;
		if ll_count > 0 then
			continue
		else
			st_insert.text = "Insert custmast data ... [ " + string(ls_custnum) + " ]"
			insert into custmast(
					custnum,           
					custname,          
					title,             
					custstat,          
					op_in,             
					addr1,             
					addr2,             
					addr3,             
					city,              
					area,              
					postcode,          
					tel,               
					fax,               
					contact,           
					terms,             
					create_by,         
					create_date,       
					update_by,         
					update_date )      
			values(            
					:ls_custnum,       
					:ls_custname,      
					:ls_title,         
					:ls_custstat,      
					:ls_op_in,         
					:ls_addr1,         
					:ls_addr2,         
					:ls_addr3,         
					:ls_city,          
					:ls_area,          
					:ls_postcode,      
					:ls_tel,           
					:ls_fax,           
					:ls_contact,       
					:li_terms,         
					:ls_create_by,     
					:ld_create_date,   
					:ls_update_by,     
					:ld_update_date ); 
		
				commit;
				
				if sqlca.sqlcode <> 0 then
					messagebox ("Error", "Import Error~r~n" + sqlca.sqlerrtext)
					fileclose( li_custmast)
					return
				end if	
		end if	
	loop
	fileclose(li_custmast)

	FileDelete(ls_temp_dir)
	
end if


ls_fsubdept = ls_temp_path + "\tempsubdept.txt"
ls_temp_dir = ls_temp_path + "\tempsubdept.txt"
if lb_exists   = FILEEXISTS (ls_fsubdept) then 
		messagebox ("Error", "Data file "+ ls_fsubdept +" tidak ada" )
else
		
	hpb_import.maxposition = 2
	hpb_import.position = 2
	ll_progress = 0
	
	li_subdept = FileOpen( ls_fsubdept)
	do while true
		li_return = fileread( li_subdept, ls_fsubdept)
		if li_return = -100 then
			exit
		end if
		
		// progress 
		yield()
		ll_progress ++
		st_status.text = "Importing subdept data ... [ " + string(ll_progress) + " ]"
				
		ls_arrdata[] = f_split_string( ls_fsubdept, "|")
		ls_custnum   = ls_arrdata[12] 
		ls_subcode   = ls_arrdata[2]
		ls_subdesc   = ls_arrdata[3] 
		ls_addr1     = ls_arrdata[4] 
		ls_addr2     = ls_arrdata[5] 
		ls_addr3     = ls_arrdata[6] 
		ls_city      = ls_arrdata[7] 
		ls_area      = ls_arrdata[7] 
		ls_tel       = ls_arrdata[8] 
		ls_fax       = ls_arrdata[9] 
		ls_contact   = ls_arrdata[10]
		ls_status	 = ls_arrdata[11]

		ls_create_by   = '' //ls_arrdata[16]
		ld_create_date = date(gd_serverdate) // date(ls_arrdata[17])
		ls_update_by   = '' // ls_arrdata[18]
		ld_update_date = date(gd_serverdate) // date(ls_arrdata[19])
	
		
		ll_count = 0
		select count(custnum) into :ll_count
			from subdept 
			where custnum =:ls_custnum and subcode=:ls_subcode ;
		if ll_count > 0 then
			continue
		else
			st_insert.text = "Insert subdept data ... [ " + string(ls_custnum) +" subcode :"+string(ls_subcode)+ " ]"
			insert into subdept(
					custnum,
					subcode,
					subdesc,
					addr1,  
					addr2,  
					addr3,  
					city,   
					area,   
					tel,    
					fax,    
					contact,
					status,             
					create_by,         
					create_date,       
					update_by,         
					update_date )      
			values(            
					:ls_custnum,
					:ls_subcode,
					:ls_subdesc,
					:ls_addr1,  
					:ls_addr2,  
					:ls_addr3,  
					:ls_city,   
					:ls_area,   
					:ls_tel,    
					:ls_fax,    
					:ls_contact,
					:ls_status,          
					:ls_create_by,     
					:ld_create_date,   
					:ls_update_by,     
					:ld_update_date ); 
		
				commit;
				
				if sqlca.sqlcode <> 0 then
					messagebox ("Error", "Import Error~r~n" + sqlca.sqlerrtext)
					fileclose( li_subdept)
					return
				end if	
		end if	
	loop
	fileclose(li_subdept)

	FileDelete(ls_temp_dir)
	
	messagebox( "Import", "done !!!")	
end if


end event

type cb_close from commandbutton within w_arrep08
integer x = 539
integer y = 416
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

type hpb_import from hprogressbar within w_arrep08
integer x = 27
integer y = 284
integer width = 2235
integer height = 68
unsignedinteger maxposition = 100
integer setstep = 10
end type

type st_status from statictext within w_arrep08
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
string text = "status"
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_arrep08
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

