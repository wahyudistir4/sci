$PBExportHeader$w_slsrep01.srw
forward
global type w_slsrep01 from window
end type
type st_3 from statictext within w_slsrep01
end type
type sle_1 from singlelineedit within w_slsrep01
end type
type cbx_group_item from checkbox within w_slsrep01
end type
type cb_view from commandbutton within w_slsrep01
end type
type st_2 from statictext within w_slsrep01
end type
type st_1 from statictext within w_slsrep01
end type
type em_date from editmask within w_slsrep01
end type
type ddlb_supplier from dropdownlistbox within w_slsrep01
end type
type gb_1 from groupbox within w_slsrep01
end type
end forward

global type w_slsrep01 from window
integer width = 2711
integer height = 880
boolean titlebar = true
string title = "Daily Sales Report"
boolean controlmenu = true
long backcolor = 67108864
string icon = "AppIcon!"
st_3 st_3
sle_1 sle_1
cbx_group_item cbx_group_item
cb_view cb_view
st_2 st_2
st_1 st_1
em_date em_date
ddlb_supplier ddlb_supplier
gb_1 gb_1
end type
global w_slsrep01 w_slsrep01

on w_slsrep01.create
this.st_3=create st_3
this.sle_1=create sle_1
this.cbx_group_item=create cbx_group_item
this.cb_view=create cb_view
this.st_2=create st_2
this.st_1=create st_1
this.em_date=create em_date
this.ddlb_supplier=create ddlb_supplier
this.gb_1=create gb_1
this.Control[]={this.st_3,&
this.sle_1,&
this.cbx_group_item,&
this.cb_view,&
this.st_2,&
this.st_1,&
this.em_date,&
this.ddlb_supplier,&
this.gb_1}
end on

on w_slsrep01.destroy
destroy(this.st_3)
destroy(this.sle_1)
destroy(this.cbx_group_item)
destroy(this.cb_view)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.em_date)
destroy(this.ddlb_supplier)
destroy(this.gb_1)
end on

event open;string &
	ls_scode, ls_sname

declare supp_curs cursor for
	select scode, sname 
	from supmast;
open supp_curs;

do while sqlca.sqlcode = 0
	fetch supp_curs into :ls_scode, :ls_sname;
	if sqlca.sqlcode = 0 then
		ddlb_supplier.additem( ls_sname + "|" + ls_scode)
	end if
loop
close supp_curs;

ddlb_supplier.selectitem( 1)
em_date.text = string( gd_serverdate)

end event

type st_3 from statictext within w_slsrep01
integer x = 73
integer y = 404
integer width = 343
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
string text = "Remark"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_1 from singlelineedit within w_slsrep01
integer x = 457
integer y = 404
integer width = 2002
integer height = 80
integer taborder = 40
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

type cbx_group_item from checkbox within w_slsrep01
integer x = 457
integer y = 288
integer width = 457
integer height = 64
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
string text = "Group by item"
end type

type cb_view from commandbutton within w_slsrep01
integer x = 544
integer y = 628
integer width = 1001
integer height = 100
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&View Report"
end type

event clicked;date &
	ld_date
string &
	ls_supplier[],ls_remark
datastore &
	lds_report_viewer
s_report_viewer &
	lstr_report_viewer
w_report_viewer &
	lw_report_viewer

em_date.getdata( ld_date)
ls_supplier = f_split_string( ddlb_supplier.text, "|")

ls_remark = sle_1.text
// generate report
lds_report_viewer = create datastore
if cbx_group_item.checked then
	lds_report_viewer.dataobject = "d_slsrep01b"
	lds_report_viewer.object.t_remark.text = ls_remark
else
	lds_report_viewer.dataobject = "d_slsrep01"
	lds_report_viewer.object.t_remark1.text = ls_remark
end if
lds_report_viewer.settransobject( sqlca)
lds_report_viewer.retrieve( ld_date, ls_supplier[2])
lstr_report_viewer.title = parent.title
lds_report_viewer.object.t_company.text = gs_company_name
lds_report_viewer.object.t_supplier.text = trim( ls_supplier[1])
lds_report_viewer.object.t_print_by.text = f_print_by( gs_userid, gdt_serverdatetime)
lds_report_viewer.object.t_username.text =gs_username
lds_report_viewer.getfullstate( lstr_report_viewer.dwdata)
destroy lds_report_viewer
opensheetwithparm( lw_report_viewer, lstr_report_viewer, w_main, 0, layered!)
end event

type st_2 from statictext within w_slsrep01
integer x = 73
integer y = 192
integer width = 343
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
string text = "Tanggal"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_1 from statictext within w_slsrep01
integer x = 73
integer y = 80
integer width = 343
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
string text = "Supplier"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_date from editmask within w_slsrep01
integer x = 457
integer y = 176
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

type ddlb_supplier from dropdownlistbox within w_slsrep01
integer x = 457
integer y = 64
integer width = 1115
integer height = 400
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type gb_1 from groupbox within w_slsrep01
integer x = 73
integer y = 544
integer width = 2400
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

