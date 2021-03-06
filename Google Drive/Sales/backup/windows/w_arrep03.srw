$PBExportHeader$w_arrep03.srw
forward
global type w_arrep03 from window
end type
type cb_1 from commandbutton within w_arrep03
end type
type st_3 from statictext within w_arrep03
end type
type ddlb_customer from uo_dropdown_sql within w_arrep03
end type
type st_2 from statictext within w_arrep03
end type
type st_1 from statictext within w_arrep03
end type
type em_to from editmask within w_arrep03
end type
type em_from from editmask within w_arrep03
end type
type gb_1 from groupbox within w_arrep03
end type
end forward

global type w_arrep03 from window
integer width = 1810
integer height = 776
boolean titlebar = true
string title = "Receipt Listing"
boolean controlmenu = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_1 cb_1
st_3 st_3
ddlb_customer ddlb_customer
st_2 st_2
st_1 st_1
em_to em_to
em_from em_from
gb_1 gb_1
end type
global w_arrep03 w_arrep03

on w_arrep03.create
this.cb_1=create cb_1
this.st_3=create st_3
this.ddlb_customer=create ddlb_customer
this.st_2=create st_2
this.st_1=create st_1
this.em_to=create em_to
this.em_from=create em_from
this.gb_1=create gb_1
this.Control[]={this.cb_1,&
this.st_3,&
this.ddlb_customer,&
this.st_2,&
this.st_1,&
this.em_to,&
this.em_from,&
this.gb_1}
end on

on w_arrep03.destroy
destroy(this.cb_1)
destroy(this.st_3)
destroy(this.ddlb_customer)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.em_to)
destroy(this.em_from)
destroy(this.gb_1)
end on

event open;

ddlb_customer.popitem( "select custname, custnum from custmast order by 1", "|", sqlca)
ddlb_customer.insertitem( "-- All Customer --", 1)
end event

type cb_1 from commandbutton within w_arrep03
integer x = 622
integer y = 432
integer width = 498
integer height = 112
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&View Report"
boolean default = true
end type

event clicked;date &
	ld_from, ld_to
string &
	ls_customer[], ls_filter, ls_custnum, ls_custrem, ls_date
datastore &
	lds_report_viewer
s_report_viewer &
	lstr_report_viewer
w_report_viewer &
	lw_report_viewer

em_from.getdata( ld_from)
em_to.getdata( ld_to)

ls_date = "Date from " + string( ld_from, "dd-mmm-yyyy") +&
	" until " + string( ld_to, "dd-mmm-yyyy")

if ddlb_customer.text = "-- All Customer --" then
	ls_filter = "%"
	ls_custrem = "Customer : All Customer"
else
	ls_customer = f_split_string( ddlb_customer.text, "|")
	ls_filter = trim( ls_customer[2])
	ls_custrem = "Customer : " + trim( ls_customer[1]) + " [" + trim( ls_customer[2]) + "]"
end if
	
	
// generate report
lds_report_viewer = create datastore
lds_report_viewer.dataobject = "d_arrep03"
lds_report_viewer.settransobject( sqlca)
lds_report_viewer.retrieve( ld_from, ld_to, ls_filter)
lstr_report_viewer.title = parent.title
lds_report_viewer.object.t_company.text = gs_company_name
lds_report_viewer.object.t_customer.text = ls_custrem 
lds_report_viewer.object.t_date.text = ls_date
lds_report_viewer.object.t_print_by.text = f_print_by( gs_userid, gdt_serverdatetime)
lds_report_viewer.getfullstate( lstr_report_viewer.dwdata)
destroy lds_report_viewer
opensheetwithparm( lw_report_viewer, lstr_report_viewer, w_main, 0, layered!)
end event

type st_3 from statictext within w_arrep03
integer x = 123
integer y = 96
integer width = 300
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
string text = "Customer"
alignment alignment = right!
boolean focusrectangle = false
end type

type ddlb_customer from uo_dropdown_sql within w_arrep03
integer x = 453
integer y = 84
integer taborder = 10
end type

type st_2 from statictext within w_arrep03
integer x = 919
integer y = 220
integer width = 100
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
string text = "to"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_1 from statictext within w_arrep03
integer x = 123
integer y = 220
integer width = 300
integer height = 52
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

type em_to from editmask within w_arrep03
integer x = 1038
integer y = 204
integer width = 439
integer height = 80
integer taborder = 30
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

type em_from from editmask within w_arrep03
integer x = 448
integer y = 204
integer width = 439
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
string mask = "[date]"
end type

type gb_1 from groupbox within w_arrep03
integer x = 23
integer y = 356
integer width = 1691
integer height = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
end type

