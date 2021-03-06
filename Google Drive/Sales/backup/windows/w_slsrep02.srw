$PBExportHeader$w_slsrep02.srw
forward
global type w_slsrep02 from window
end type
type cb_view from commandbutton within w_slsrep02
end type
type st_2 from statictext within w_slsrep02
end type
type em_date from editmask within w_slsrep02
end type
type gb_1 from groupbox within w_slsrep02
end type
end forward

global type w_slsrep02 from window
integer width = 1234
integer height = 464
boolean titlebar = true
string title = "Monthly Sales Report"
boolean controlmenu = true
long backcolor = 67108864
string icon = "AppIcon!"
cb_view cb_view
st_2 st_2
em_date em_date
gb_1 gb_1
end type
global w_slsrep02 w_slsrep02

on w_slsrep02.create
this.cb_view=create cb_view
this.st_2=create st_2
this.em_date=create em_date
this.gb_1=create gb_1
this.Control[]={this.cb_view,&
this.st_2,&
this.em_date,&
this.gb_1}
end on

on w_slsrep02.destroy
destroy(this.cb_view)
destroy(this.st_2)
destroy(this.em_date)
destroy(this.gb_1)
end on

event open;em_date.text = string( gd_serverdate)
end event

type cb_view from commandbutton within w_slsrep02
integer x = 283
integer y = 240
integer width = 640
integer height = 100
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&View Report"
end type

event clicked;date &
	ld_date, ld_from, ld_to
integer &
	li_month, li_year

datastore &
	lds_report_viewer
s_report_viewer &
	lstr_report_viewer
w_report_viewer &
	lw_report_viewer

em_date.getdata( ld_date)
li_month = month( ld_date)
li_year = year( ld_date)

// generate report
lds_report_viewer = create datastore
lds_report_viewer.dataobject = "d_slsrep02"
lds_report_viewer.settransobject( sqlca)
lds_report_viewer.retrieve( li_month, li_year)
lstr_report_viewer.title = parent.title
lds_report_viewer.object.t_company.text = gs_company_name
lds_report_viewer.object.t_print_by.text = f_print_by( gs_userid, gdt_serverdatetime)
lds_report_viewer.object.t_month_year.text = string( ld_date, "mmmm - yyyy")
lds_report_viewer.object.t_username.text =  gs_username
lds_report_viewer.getfullstate( lstr_report_viewer.dwdata)
destroy lds_report_viewer
opensheetwithparm( lw_report_viewer, lstr_report_viewer, w_main, 0, layered!)

end event

type st_2 from statictext within w_slsrep02
integer x = 73
integer y = 72
integer width = 466
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
string text = "Bulan - Tahun"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_date from editmask within w_slsrep02
integer x = 576
integer y = 64
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
string mask = "mm-yyyy"
end type

type gb_1 from groupbox within w_slsrep02
integer x = 55
integer y = 172
integer width = 1097
integer height = 20
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
end type

