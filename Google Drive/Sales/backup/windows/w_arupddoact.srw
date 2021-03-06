$PBExportHeader$w_arupddoact.srw
forward
global type w_arupddoact from window
end type
type dw_data from datawindow within w_arupddoact
end type
type cb_activate from commandbutton within w_arupddoact
end type
type cb_retrieve from commandbutton within w_arupddoact
end type
type em_dodate from editmask within w_arupddoact
end type
type st_1 from statictext within w_arupddoact
end type
type gb_1 from groupbox within w_arupddoact
end type
end forward

global type w_arupddoact from window
integer width = 3963
integer height = 2048
boolean titlebar = true
string title = "Update DO Aktual"
boolean controlmenu = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
dw_data dw_data
cb_activate cb_activate
cb_retrieve cb_retrieve
em_dodate em_dodate
st_1 st_1
gb_1 gb_1
end type
global w_arupddoact w_arupddoact

type variables

end variables

forward prototypes
public function string wf_check_fields ()
public function string wf_validasi_prefix ()
public function string wf_log_data ()
end prototypes

public function string wf_check_fields ();string &
	ls_donum, ls_donumact, ls_error, ls_donum2, ls_donumact2
long &
	ll_rowcount, i, n, ll_duplicate, ll_count

ll_rowcount = dw_data.rowcount()
ls_error = ""
for i = 1 to ll_rowcount
	ll_duplicate = 0
	ls_donum = dw_data.getitemstring (i, "sdomas_donum")	
	ls_donumact = dw_data.getitemstring (i, "sdomas_donumact")	
	ls_donumact = trim(ls_donumact)
	setnull (ls_donum2)
	setnull (ls_donumact2)
	if ls_donumact <> "" then	
		//get duplicate data from database
		select donum, donumact into :ls_donum2, :ls_donumact2
				from sdomas
				where donumact = :ls_donumact;
		if not isnull (ls_donumact) and ls_donum2 <> ls_donum then			
			ls_error = "No DO : " + trim(ls_donumact) + " sudah pernah diinput"				
		end if	
		
		
		//get duplicate data at
		ll_duplicate = 0
		for n = 1 to ll_rowcount
			if ls_donumact = dw_data.getitemstring (n, "sdomas_donumact") then
				ll_duplicate ++
			end if		
		next	
				
		if ll_duplicate > 1 then
			ls_error = "No DO : " + trim(ls_donumact) + " tidak boleh ganda"
		end if			
		
	end if
next

return ls_error

end function

public function string wf_validasi_prefix ();string &	
	ls_validasi, ls_validasi1, ls_validasi2[], ls_lenght, ls_scode, ls_donumact, ls_1, ls_prefix, ls_error, ls_donumact2
long &
	i

ls_validasi1 =  trim( ProfileString ("appl.ini", "doc","donumact",""))
//validasi donumact prefix
for i = 1 to dw_data.rowcount()
	ls_donumact = dw_data.getitemstring (i, "sdomas_donumact")
	if ls_validasi1 = "yes" and ls_donumact <> "" then	
		ls_scode = dw_data.getitemstring (i, "sdomas_scode")	
		ls_1 = trim( ProfileString ("appl.ini", "doc",ls_scode,""))
		ls_validasi2[] = f_split_string( ls_1 , ",")
		ls_lenght = ls_validasi2[1]
		ls_prefix = ls_validasi2[2]
		ls_validasi = left (trim(ls_donumact), dec (ls_lenght))
		if ls_validasi <> ls_prefix then
			ls_donumact2 = ls_donumact2 + "~r~n" + ls_donumact
		end if			
	end if
next

if ls_donumact2 <> "" then	
	ls_error =  "No DO : " + trim(ls_donumact2) + " ~r~n tidak sesuai format"
end if

return ls_error
end function

public function string wf_log_data ();string &                                                                        
	ls_donum, ls_donumact, ls_error, ls_donum2, ls_donumact2, &
	ls_desc,ls_table,ls_stat,ls_userid,ls_date   
date &
	ld_date
long &                                                                          
	ll_rowcount, i, n,  ll_count                                     
ls_error =""       
ls_userid = gs_userid 
ld_date = date(gd_serverdate)
ls_table = "sdomas"
ls_stat = "UPDATE"
ll_rowcount = dw_data.rowcount()                                                
for i = 1 to ll_rowcount                                                        
	ls_donum = dw_data.getitemstring (i, "sdomas_donum")	                        
	ls_donumact = dw_data.getitemstring (i, "sdomas_donumact")	                  
	ls_donumact = trim(ls_donumact)
	
	select donumact
	into :ls_donumact2
	from sdomas
	where donum = :ls_donum;
	ls_desc = "SoNum :"+ ls_donum + " donumact awal :" + ls_donumact2 + " dirubah menjadi :"+ls_donumact
	insert into syshist 
	values (
			:ls_userid,
			:ld_date,
			:ls_table,
			:ls_stat,
			:ls_desc); 
	commit;                                                                                

next                                                                            

return ls_error                                                                 
end function

on w_arupddoact.create
this.dw_data=create dw_data
this.cb_activate=create cb_activate
this.cb_retrieve=create cb_retrieve
this.em_dodate=create em_dodate
this.st_1=create st_1
this.gb_1=create gb_1
this.Control[]={this.dw_data,&
this.cb_activate,&
this.cb_retrieve,&
this.em_dodate,&
this.st_1,&
this.gb_1}
end on

on w_arupddoact.destroy
destroy(this.dw_data)
destroy(this.cb_activate)
destroy(this.cb_retrieve)
destroy(this.em_dodate)
destroy(this.st_1)
destroy(this.gb_1)
end on

event open;dw_data.settransobject( sqlca)
em_dodate.text= string( gd_serverdate, "dd-mm-yyyy")



	

end event

type dw_data from datawindow within w_arupddoact
integer x = 50
integer y = 264
integer width = 3831
integer height = 1660
integer taborder = 50
string title = "none"
string dataobject = "d_arupddoact"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_activate from commandbutton within w_arupddoact
integer x = 1385
integer y = 80
integer width = 709
integer height = 100
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Update Actual DO Num."
end type

event clicked;long &
	ll_rowcount, i, l
string &	
	ls_error

ll_rowcount = dw_data.rowcount()

if ll_rowcount = 0 then
	messagebox( "Update Actual SO Num. ", "Data SO kosong, "+&
		"silahkan retrieve data terlebih dahulu")
	return
end if

//validasi prefix donum act
ls_error = wf_validasi_prefix ()
if ls_error <> "" then
	messagebox ("error", ls_error)
	return
end if

//validasi donumact ganda
ls_error = wf_check_fields ()
if ls_error <> "" then
	messagebox ("error", ls_error)
	return
end if
// insert log data
//ls_error = wf_log_data ()

dw_data.update()
messagebox( "Update Actual SO Num.", "Update Actual SO Num. telah selesai")

end event

type cb_retrieve from commandbutton within w_arupddoact
integer x = 937
integer y = 80
integer width = 402
integer height = 100
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Retrieve"
end type

event clicked;date &
	ld_dodate
long &
	ll_rowcount

em_dodate.getdata( ld_dodate)
dw_data.retrieve( ld_dodate)
ll_rowcount = dw_data.rowcount()
if ll_rowcount = 0 then
	messagebox( "Data DO", "Tidak ada penjualan untuk tanggal "+&
		string( ld_dodate, "dd-mmmm-yyyy"))
end if
end event

type em_dodate from editmask within w_arupddoact
integer x = 494
integer y = 84
integer width = 402
integer height = 92
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
string mask = "[date]"
end type

type st_1 from statictext within w_arupddoact
integer x = 64
integer y = 100
integer width = 402
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
string text = "SO Date :"
alignment alignment = right!
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_arupddoact
integer x = 50
integer y = 16
integer width = 3831
integer height = 236
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
end type

