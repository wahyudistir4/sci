$PBExportHeader$w_slsdoprint.srw
forward
global type w_slsdoprint from window
end type
type rb_land from radiobutton within w_slsdoprint
end type
type rb_port from radiobutton within w_slsdoprint
end type
type ddlb_report from dropdownlistbox within w_slsdoprint
end type
type cb_cancel from commandbutton within w_slsdoprint
end type
type cb_ok from commandbutton within w_slsdoprint
end type
type rb_excel from radiobutton within w_slsdoprint
end type
type rb_pdf from radiobutton within w_slsdoprint
end type
type rb_html from radiobutton within w_slsdoprint
end type
type gb_1 from groupbox within w_slsdoprint
end type
type gb_2 from groupbox within w_slsdoprint
end type
end forward

global type w_slsdoprint from window
integer width = 978
integer height = 1132
boolean titlebar = true
string title = "Save As"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
rb_land rb_land
rb_port rb_port
ddlb_report ddlb_report
cb_cancel cb_cancel
cb_ok cb_ok
rb_excel rb_excel
rb_pdf rb_pdf
rb_html rb_html
gb_1 gb_1
gb_2 gb_2
end type
global w_slsdoprint w_slsdoprint

on w_slsdoprint.create
this.rb_land=create rb_land
this.rb_port=create rb_port
this.ddlb_report=create ddlb_report
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.rb_excel=create rb_excel
this.rb_pdf=create rb_pdf
this.rb_html=create rb_html
this.gb_1=create gb_1
this.gb_2=create gb_2
this.Control[]={this.rb_land,&
this.rb_port,&
this.ddlb_report,&
this.cb_cancel,&
this.cb_ok,&
this.rb_excel,&
this.rb_pdf,&
this.rb_html,&
this.gb_1,&
this.gb_2}
end on

on w_slsdoprint.destroy
destroy(this.rb_land)
destroy(this.rb_port)
destroy(this.ddlb_report)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.rb_excel)
destroy(this.rb_pdf)
destroy(this.rb_html)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event open;ddlb_report.additem( "Sort by Customer")
ddlb_report.additem( "Sort by Product")
ddlb_report.selectitem( 1)
end event

type rb_land from radiobutton within w_slsdoprint
integer x = 187
integer y = 600
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
string text = "Landscape"
boolean checked = true
end type

type rb_port from radiobutton within w_slsdoprint
integer x = 187
integer y = 520
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
string text = "Portrait"
end type

type ddlb_report from dropdownlistbox within w_slsdoprint
integer x = 119
integer y = 716
integer width = 686
integer height = 324
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type cb_cancel from commandbutton within w_slsdoprint
integer x = 475
integer y = 864
integer width = 343
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

event clicked;closewithreturn( parent, 0)
end event

type cb_ok from commandbutton within w_slsdoprint
integer x = 110
integer y = 864
integer width = 343
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

event clicked;s_report &
	lstr_report
	
if rb_html.checked then
	lstr_report.customer = 1
elseif rb_pdf.checked then
	lstr_report.customer = 2
else
	lstr_report.customer = 3
end if	

if ddlb_report.text = "Sort by Customer" then
	lstr_report.report_type = 1
else
	lstr_report.report_type = 2
end if

if rb_port.checked then
	lstr_report.page_type = 1 // portrait
else
	lstr_report.page_type = 2 // landscape
end if
	
closewithreturn( parent, lstr_report)

end event

type rb_excel from radiobutton within w_slsdoprint
integer x = 187
integer y = 288
integer width = 402
integer height = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
string text = "All Market"
end type

type rb_pdf from radiobutton within w_slsdoprint
integer x = 187
integer y = 200
integer width = 485
integer height = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
string text = "Internal Market"
end type

type rb_html from radiobutton within w_slsdoprint
integer x = 187
integer y = 112
integer width = 416
integer height = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
string text = "Open Market"
boolean checked = true
end type

type gb_1 from groupbox within w_slsdoprint
integer x = 119
integer y = 28
integer width = 686
integer height = 396
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
string text = "Print"
end type

type gb_2 from groupbox within w_slsdoprint
integer x = 114
integer y = 432
integer width = 686
integer height = 260
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
string text = "Page Layout"
end type

