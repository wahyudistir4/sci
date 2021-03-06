$PBExportHeader$w_arrcexport.srw
forward
global type w_arrcexport from window
end type
type cb_view from commandbutton within w_arrcexport
end type
type em_to from editmask within w_arrcexport
end type
type st_1 from statictext within w_arrcexport
end type
type em_from from editmask within w_arrcexport
end type
type st_2 from statictext within w_arrcexport
end type
end forward

global type w_arrcexport from window
integer width = 1289
integer height = 476
boolean titlebar = true
string title = "Export Receive Payment"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_view cb_view
em_to em_to
st_1 st_1
em_from em_from
st_2 st_2
end type
global w_arrcexport w_arrcexport

on w_arrcexport.create
this.cb_view=create cb_view
this.em_to=create em_to
this.st_1=create st_1
this.em_from=create em_from
this.st_2=create st_2
this.Control[]={this.cb_view,&
this.em_to,&
this.st_1,&
this.em_from,&
this.st_2}
end on

on w_arrcexport.destroy
destroy(this.cb_view)
destroy(this.em_to)
destroy(this.st_1)
destroy(this.em_from)
destroy(this.st_2)
end on

event open;em_from.text = string( gd_serverdate)
em_to.text = string( gd_serverdate)
end event

type cb_view from commandbutton within w_arrcexport
integer x = 279
integer y = 212
integer width = 640
integer height = 100
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Proses"
end type

event clicked;string &
    ls_trno , ls_orno, ls_debtor, ls_sman , ls_rem1, ls_rem2, &
	ls_userid , ls_stat , ls_ibank, ls_chqno, ls_rbank, ls_rem3, ls_rem4
string &	
	ls_frcmas,  ls_rcmas,  &
	ls_zipfile, ls_filename, ls_path,  &
	ls_7z, ls_command, ls_values[], ls_file[]
date &
	ld_from, ld_to, ld_rdate, ld_trdate, ld_clrdate,ld_chqdate	
integer &
	li_rcmas, li_terms, li_rc, i, li_max_array
long &
	ll_count
decimal {2} &
	ldc_camt,ldc_unappl
mailSession &
	lms_export
mailReturnCode &
	lmrt_export
mailMessage &
	lmm_export
mailfiledescription &
	lmfd_attchexport
ContextKeyword &
	lcxk_base
OleObject wsh

CONSTANT integer MAXIMIZED = 3
CONSTANT integer MINIMIZED = 2
CONSTANT integer NORMAL = 1
CONSTANT boolean WAIT = TRUE
CONSTANT boolean NOWAIT = FALSE

this.GetContextService("Keyword", lcxk_base)
lcxk_base.GetContextKeywords("TEMP", ls_values)
if Upperbound(ls_values) > 0 then
   ls_Path = ls_values[1]
else
   ls_Path = "*UNDEFINED*"
end if

em_from.getdata( ld_from)
em_to.getdata( ld_to)


/* check data */
ll_count = 0
ll_count = 0
select count(*) into :ll_count
	from rcmas
	where rcstatus ='A' AND 
			( is_exprt = '0' OR is_exprt is null) AND
			rcdate between :ld_from and :ld_to ;
if ll_count = 0 then
	messagebox( "Export", "Tidak ada data di tanggal "+ "~r~n" + &
		string (ld_from, "dd-mmm-yyyy") + " s/d "+ string (ld_to, "dd-mmm-yyyy") + "~r~n" +&
		"Export tidak bisa dilanjutkan")	
	return
end if

/* end - check data */

open( w_busy)
w_busy.st_remark.text = "Sedang memproses data ..."

ls_frcmas = ls_path + "\PBRCMAS.txt"
ls_filename =  "\" + string(ld_from,"ddmmyyyy") + "_" + string(ld_to,"ddmmyyyy") + ".7z"
ls_zipfile = ls_path + ls_filename

/***** Build  File *****/
/* rcmas */
li_rcmas = FileOpen( ls_frcmas, &
	LineMode!, Write!, LockWrite!, Replace!)
declare dorcmascur cursor for
	select rcref, '-', custnum,'OFFICE', rcdate,rcdate, create_by , rcstatus, 
			 rcamt,rcamt, 'TT', '-', rcrem1,rcdate,rcdate, '','','',''
 	from rcmas
 	where	rcstatus ='A' 
	and ( is_exprt = '0' OR is_exprt is null)
 	and rcdate between :ld_from and :ld_to
	order by rcref;	
open dorcmascur;
do while sqlca.sqlcode = 0
	fetch dorcmascur into : ls_trno, :ls_orno, :ls_debtor, :ls_sman, :ld_rdate, :ld_trdate, :ls_userid, :ls_stat, :ldc_camt, 
		:ldc_unappl, :ls_ibank, :ls_chqno, :ls_rbank, :ld_clrdate, :ld_chqdate, :ls_rem1, :ls_rem2, :ls_rem3, :ls_rem4;
	if sqlca.sqlcode = 0 then
		ls_trno = trim( f_check_null_string( ls_trno))
		ls_orno = trim( f_check_null_string( ls_orno))
		ls_debtor = trim( f_check_null_string( ls_debtor))
		ls_sman = trim( f_check_null_string( ls_sman))
		ls_userid = trim( f_check_null_string( ls_userid))
		ls_stat = trim( f_check_null_string( ls_stat))
		ls_ibank = trim( f_check_null_string( ls_ibank))
		ls_chqno = trim( f_check_null_string( ls_chqno))
		ls_rbank = trim( f_check_null_string( ls_rbank))
		ls_rem1 = trim( ls_rem1) 
		ls_rem2 = trim( ls_rem2) 
		ls_rem3 = trim( ls_rem3) 
		ls_rem4 = trim( ls_rem4) 
		
		ls_rcmas = ls_trno + "|" +&
			ls_orno + "|" +&
			ls_debtor + "|" +&
			ls_sman + "|" +&
			string( ld_rdate, "dd/mm/yyyy") + "|" +&
			string( ld_trdate,"dd/mm/yyyy") + "|" +&
			ls_userid + "|" +&
			ls_stat + "|" +&
			string( ldc_camt) + "|" +&
			string( ldc_unappl) + "|" +&
			ls_ibank + "|" +&
			ls_chqno + "|" +&
			ls_rbank + "|" +&
			string( ld_clrdate,"dd/mm/yyyy") + "|" +&
			string( ld_chqdate,"dd/mm/yyyy") + "|" +&
			ls_rem1 + "|" +&
			ls_rem2 + "|" +&
			ls_rem3 + "|" + ls_rem4 
			
		filewrite( li_rcmas, ls_rcmas)
	end if
loop
close dorcmascur;
fileclose( li_rcmas)

/***** end - Build File *****/


/* compress and encrypt */
changedirectory( ls_path)
ls_7z = gst7z_program //"c:\7za.exe"
wsh = CREATE OleObject
li_rc = wsh.ConnectToNewObject( "WScript.Shell" )
//ls_password = "123superduper456"
ls_file[] = {ls_frcmas }
li_max_array = upperbound( ls_file)

for i = 1 to li_max_array	
	ls_command = '"' + ls_7z + '"' + 'a "' + ls_zipfile +&
		'" "' + ls_file[i]  // + '" -p' + ls_password
	li_rc = wsh.Run(ls_command , NORMAL, WAIT)	
next
destroy wsh
/* end - compress and encrypt */



close( w_busy)

// mail it
// Create a mail session
lms_export = create mailSession
lmrt_export = lms_export.mailLogon( mailNewSession!)
if lmrt_export <> mailReturnSuccess! then
 messagebox( "Mail", "Logon failed")
 return
end if
lmm_export.subject = "Data Payment tanggal " + &	
	string( ld_from, "dd-mmmm-yyyy") + " s/d " + &
	string( ld_to, "dd-mmmm-yyyy") 
lmm_export.notetext = "from " + gs_userid

// set file attachment
lmfd_attchexport.filetype = mailattach!
lmfd_attchexport.pathname = ls_zipfile
lmfd_attchexport.filename = ls_filename
lmm_export.attachmentfile[1]= lmfd_attchexport

// Send the mail
lmrt_export = lms_export.mailSend( lmm_export)
if lmrt_export <> mailReturnSuccess! then
 MessageBox("Mail Send",'Mail not sent')
 return
end if
lms_export.mailLogoff()
destroy lms_export	
// update status E -> A

update rcmas 
	set is_exprt ='1'
 where	( is_exprt = '0' OR is_exprt is null)
 	and rcdate between :ld_from and :ld_to;
commit;

// delete file
filedelete (ls_frcmas)
filedelete( ls_zipfile)
end event

type em_to from editmask within w_arrcexport
integer x = 795
integer y = 36
integer width = 375
integer height = 80
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
string text = "none"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
end type

type st_1 from statictext within w_arrcexport
integer x = 667
integer y = 44
integer width = 78
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
string text = "to"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_from from editmask within w_arrcexport
integer x = 247
integer y = 36
integer width = 375
integer height = 80
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
string text = "none"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
end type

type st_2 from statictext within w_arrcexport
integer x = 37
integer y = 44
integer width = 160
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
string text = "From"
alignment alignment = right!
boolean focusrectangle = false
end type

