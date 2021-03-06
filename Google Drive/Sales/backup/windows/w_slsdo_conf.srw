$PBExportHeader$w_slsdo_conf.srw
forward
global type w_slsdo_conf from window
end type
type mle_remark from multilineedit within w_slsdo_conf
end type
type cb_cancel from commandbutton within w_slsdo_conf
end type
type cb_ok from commandbutton within w_slsdo_conf
end type
type st_1 from statictext within w_slsdo_conf
end type
end forward

global type w_slsdo_conf from window
integer width = 1413
integer height = 740
boolean titlebar = true
string title = "Aktivasi SO"
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean toolbarvisible = false
boolean center = true
mle_remark mle_remark
cb_cancel cb_cancel
cb_ok cb_ok
st_1 st_1
end type
global w_slsdo_conf w_slsdo_conf

type variables
string &
	is_donum
end variables

on w_slsdo_conf.create
this.mle_remark=create mle_remark
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.st_1=create st_1
this.Control[]={this.mle_remark,&
this.cb_cancel,&
this.cb_ok,&
this.st_1}
end on

on w_slsdo_conf.destroy
destroy(this.mle_remark)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.st_1)
end on

event open;is_donum = message.stringparm
end event

type mle_remark from multilineedit within w_slsdo_conf
integer x = 251
integer y = 68
integer width = 1079
integer height = 248
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
end type

type cb_cancel from commandbutton within w_slsdo_conf
integer x = 722
integer y = 412
integer width = 425
integer height = 100
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Cancel"
end type

event clicked;closewithreturn( parent, "batal edit")
end event

type cb_ok from commandbutton within w_slsdo_conf
integer x = 261
integer y = 412
integer width = 425
integer height = 100
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&OK"
end type

event clicked;string &
	ls_remark, ls_message

ls_remark = mle_remark.text
if isnull (ls_remark) or (ls_remark) = "" then
	messagebox ("Informasi","Alasan harus diisi!!!")	
	return 0
else	
	ls_remark = "Aktivasi DO," + trim(ls_remark)	
	if len( ls_remark) > 50 then
		messagebox( "Informasi", "Panjang alasan tidak boleh lebih dari 38 Karakter")
	else
		update sdomas set dostat = "A" where donum = :is_donum and dostat = "E";
		insert into syslog (
			logdate,
			userid,
			modul,
			trannum,
			remark)	values (
			:gdt_serverdatetime,
			:gs_userid,
			"w_slsdo",
			:is_donum,
			:ls_remark);	
		closewithreturn( parent, ls_message)
	end if
end if


end event

type st_1 from statictext within w_slsdo_conf
integer x = 27
integer y = 76
integer width = 206
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
string text = "Alasan"
boolean focusrectangle = false
end type

