$PBExportHeader$w_arrep06.srw
forward
global type w_arrep06 from window
end type
type cb_report_debtor from commandbutton within w_arrep06
end type
type cb_import_deblist from commandbutton within w_arrep06
end type
end forward

global type w_arrep06 from window
integer width = 1083
integer height = 684
boolean titlebar = true
string title = "Debtor List"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 12632256
string icon = "AppIcon!"
boolean center = true
cb_report_debtor cb_report_debtor
cb_import_deblist cb_import_deblist
end type
global w_arrep06 w_arrep06

on w_arrep06.create
this.cb_report_debtor=create cb_report_debtor
this.cb_import_deblist=create cb_import_deblist
this.Control[]={this.cb_report_debtor,&
this.cb_import_deblist}
end on

on w_arrep06.destroy
destroy(this.cb_report_debtor)
destroy(this.cb_import_deblist)
end on

type cb_report_debtor from commandbutton within w_arrep06
integer x = 279
integer y = 244
integer width = 421
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Report Debtor"
end type

type cb_import_deblist from commandbutton within w_arrep06
integer x = 242
integer y = 56
integer width = 526
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Import File Debtor"
end type

event clicked;open(w_arrep07)
end event

