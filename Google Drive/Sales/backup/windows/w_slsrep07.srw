$PBExportHeader$w_slsrep07.srw
forward
global type w_slsrep07 from window
end type
type st_1 from statictext within w_slsrep07
end type
type ddlb_sup from dropdownlistbox within w_slsrep07
end type
type ddlb_area from dropdownlistbox within w_slsrep07
end type
type st_2 from statictext within w_slsrep07
end type
type st_3 from statictext within w_slsrep07
end type
type em_from from editmask within w_slsrep07
end type
type em_to from editmask within w_slsrep07
end type
type cb_view from commandbutton within w_slsrep07
end type
type rb_both from radiobutton within w_slsrep07
end type
type rb_open from radiobutton within w_slsrep07
end type
type rb_internal from radiobutton within w_slsrep07
end type
type gb_1 from groupbox within w_slsrep07
end type
type gb_2 from groupbox within w_slsrep07
end type
end forward

global type w_slsrep07 from window
integer width = 1298
integer height = 848
boolean titlebar = true
string title = "Sales by Customer"
boolean controlmenu = true
long backcolor = 67108864
string icon = "AppIcon!"
st_1 st_1
ddlb_sup ddlb_sup
ddlb_area ddlb_area
st_2 st_2
st_3 st_3
em_from em_from
em_to em_to
cb_view cb_view
rb_both rb_both
rb_open rb_open
rb_internal rb_internal
gb_1 gb_1
gb_2 gb_2
end type
global w_slsrep07 w_slsrep07

on w_slsrep07.create
this.st_1=create st_1
this.ddlb_sup=create ddlb_sup
this.ddlb_area=create ddlb_area
this.st_2=create st_2
this.st_3=create st_3
this.em_from=create em_from
this.em_to=create em_to
this.cb_view=create cb_view
this.rb_both=create rb_both
this.rb_open=create rb_open
this.rb_internal=create rb_internal
this.gb_1=create gb_1
this.gb_2=create gb_2
this.Control[]={this.st_1,&
this.ddlb_sup,&
this.ddlb_area,&
this.st_2,&
this.st_3,&
this.em_from,&
this.em_to,&
this.cb_view,&
this.rb_both,&
this.rb_open,&
this.rb_internal,&
this.gb_1,&
this.gb_2}
end on

on w_slsrep07.destroy
destroy(this.st_1)
destroy(this.ddlb_sup)
destroy(this.ddlb_area)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.em_from)
destroy(this.em_to)
destroy(this.cb_view)
destroy(this.rb_both)
destroy(this.rb_open)
destroy(this.rb_internal)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event open;string &
	ls_scode, ls_sname, ls_area

// Add list Supplier	
declare supcur cursor for
	select scode, sname
from supmast;
open supcur;
ddlb_sup.additem( "All")
do while sqlca.sqlcode = 0
	fetch supcur into :ls_scode, :ls_sname;
	if sqlca.sqlcode = 0 then
		ddlb_sup.additem( ls_scode + "|" + ls_sname)
	end if
loop
close supcur;
ddlb_sup.selectitem(1)

// Add list area
declare areacur cursor for 
	select area 
	from custmast
	group by 1;
open areacur;
ddlb_area.additem( "All")
do while sqlca.sqlcode = 0
	fetch areacur into :ls_area;
	if sqlca.sqlcode = 0 then
		ddlb_area.additem( ls_area)
	end if
loop
close areacur;
ddlb_area.selectitem(1)	
	
end event

type st_1 from statictext within w_slsrep07
integer y = 236
integer width = 297
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
string text = "Supplier :"
alignment alignment = right!
boolean focusrectangle = false
end type

type ddlb_sup from dropdownlistbox within w_slsrep07
integer x = 315
integer y = 224
integer width = 905
integer height = 352
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type ddlb_area from dropdownlistbox within w_slsrep07
integer x = 315
integer y = 324
integer width = 910
integer height = 352
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_slsrep07
integer x = 46
integer y = 340
integer width = 251
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
string text = "Area :"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_3 from statictext within w_slsrep07
integer x = 46
integer y = 440
integer width = 251
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
string text = "From :"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_from from editmask within w_slsrep07
integer x = 315
integer y = 428
integer width = 402
integer height = 88
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

event modified;if keydown( keyenter!) then
	em_to.setfocus()
end if 
end event

type em_to from editmask within w_slsrep07
integer x = 823
integer y = 432
integer width = 402
integer height = 88
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

event modified;if keydown( keyenter!) then
	cb_view.setfocus()
end if
end event

type cb_view from commandbutton within w_slsrep07
integer x = 402
integer y = 608
integer width = 475
integer height = 96
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&View Report"
end type

event clicked;integer &
	i
date &
	ld_from, ld_to
string &
	ls_market, ls_sql, ls_filter, ls_cust[], ls_scode[], ls_area
datastore &
	lds_report_viewer
s_report_viewer &
	lstr_report_viewer
w_report_viewer &
	lw_report_viewer
	
em_from.getdata(ld_from)
em_to.getdata(ld_to)

if trim(ddlb_area.text) = "All" then
	ls_area = "%"
else
	ls_area = ddlb_area.text
end if

if trim(ddlb_sup.text) = "All" then
	ls_scode[1] = "%"
	ls_scode[3] = "All"
else
	ls_scode = f_split_string(ddlb_sup.text, "|")
	ls_scode[3] = trim(ls_scode[1]) + " - " + &
		trim(ls_scode[2])
end if

if rb_internal.checked = true then
	ls_sql = "select custnum from custmast " + &
		"where op_in = 'I'"
	ls_market = "Internal Market"
else
	if rb_open.checked = true then
		ls_sql = "select custnum from custmast " + &
			"where op_in = 'O'"
		ls_market = "Open Market"
	else
		ls_sql = "select custnum from custmast "
		ls_market = "Both Market"
	end if
end if

declare custcur dynamic cursor for sqlsa;
prepare sqlsa from :ls_sql;
open dynamic custcur;
i = 0
do while sqlca.sqlcode = 0
	i = i + 1
	fetch custcur into :ls_cust[i];
loop
close custcur;

// generate report
lds_report_viewer = create datastore
lds_report_viewer.dataobject = "d_slsrep07"
lds_report_viewer.settransobject( sqlca)
lds_report_viewer.retrieve( ld_from, ld_to, ls_cust[], ls_scode[1], ls_area)
lstr_report_viewer.title = parent.title
lds_report_viewer.object.t_area.text = ddlb_area.text
lds_report_viewer.object.t_company.text = gs_company_name
lds_report_viewer.object.t_supplier.text = ls_scode[3]
lds_report_viewer.object.t_market.text = ls_market
lds_report_viewer.object.t_print_by.text = f_print_by( gs_userid, gdt_serverdatetime)
lds_report_viewer.getfullstate( lstr_report_viewer.dwdata)
destroy lds_report_viewer
opensheetwithparm( lw_report_viewer, lstr_report_viewer, w_main, 0, layered!)
end event

type rb_both from radiobutton within w_slsrep07
integer x = 919
integer y = 96
integer width = 219
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
string text = "&Both"
end type

event clicked;if rb_both.checked = true then
	em_from.setfocus()
end if
end event

type rb_open from radiobutton within w_slsrep07
integer x = 110
integer y = 96
integer width = 256
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
string text = "&Open"
end type

event clicked;if rb_open.checked = true then
	em_from.setfocus()
end if
end event

type rb_internal from radiobutton within w_slsrep07
integer x = 475
integer y = 96
integer width = 329
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
string text = "&Internal"
end type

event clicked;if rb_internal.checked = true then
	em_from.setfocus()
end if
end event

type gb_1 from groupbox within w_slsrep07
integer x = 41
integer y = 32
integer width = 1198
integer height = 176
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
string text = "Market"
end type

type gb_2 from groupbox within w_slsrep07
integer x = 37
integer y = 544
integer width = 1243
integer height = 32
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
end type

