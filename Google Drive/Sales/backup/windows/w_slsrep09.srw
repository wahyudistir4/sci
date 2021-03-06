$PBExportHeader$w_slsrep09.srw
forward
global type w_slsrep09 from window
end type
type cb_view from commandbutton within w_slsrep09
end type
type dw_cust from datawindow within w_slsrep09
end type
type st_1 from statictext within w_slsrep09
end type
type em_to from editmask within w_slsrep09
end type
type st_4 from statictext within w_slsrep09
end type
type em_from from editmask within w_slsrep09
end type
type st_3 from statictext within w_slsrep09
end type
type gb_1 from groupbox within w_slsrep09
end type
end forward

global type w_slsrep09 from window
integer width = 2135
integer height = 1000
boolean titlebar = true
string title = "DOC Entering Schedule"
boolean controlmenu = true
long backcolor = 67108864
string icon = "AppIcon!"
cb_view cb_view
dw_cust dw_cust
st_1 st_1
em_to em_to
st_4 st_4
em_from em_from
st_3 st_3
gb_1 gb_1
end type
global w_slsrep09 w_slsrep09

on w_slsrep09.create
this.cb_view=create cb_view
this.dw_cust=create dw_cust
this.st_1=create st_1
this.em_to=create em_to
this.st_4=create st_4
this.em_from=create em_from
this.st_3=create st_3
this.gb_1=create gb_1
this.Control[]={this.cb_view,&
this.dw_cust,&
this.st_1,&
this.em_to,&
this.st_4,&
this.em_from,&
this.st_3,&
this.gb_1}
end on

on w_slsrep09.destroy
destroy(this.cb_view)
destroy(this.dw_cust)
destroy(this.st_1)
destroy(this.em_to)
destroy(this.st_4)
destroy(this.em_from)
destroy(this.st_3)
destroy(this.gb_1)
end on

event open;long &
	ll_row
string &
	ls_custnum, ls_custname

declare int_cust cursor for
	select custnum, custname
		from custmast
		where op_in = "I" and
			custstat = "1"
		order by custname;
open int_cust;
do while sqlca.sqlcode = 0
	fetch int_cust into :ls_custnum, :ls_custname;
	if sqlca.sqlcode = 0 then
		ll_row = dw_cust.insertrow(0)
		dw_cust.setitem( ll_row, "custnum", ls_custnum)
		dw_cust.setitem( ll_row, "custname", ls_custname)
	end if
loop
close int_cust;

end event

type cb_view from commandbutton within w_slsrep09
integer x = 718
integer y = 760
integer width = 498
integer height = 100
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "View Report"
end type

event clicked;string &
	ls_cust[]
long &
	i, ll_rowcount, ll_arr_count
integer &
	li_pick
date &
	ld_from, ld_to
datastore &
	lds_report_viewer
s_report_viewer &
	lstr_report_viewer
w_report_viewer &
	lw_report_viewer

em_from.getdata( ld_from)
em_to.getdata( ld_to)

ll_rowcount = dw_cust.rowcount()
ll_arr_count = 1
for i = 1 to ll_rowcount
	li_pick = dw_cust.getitemnumber( i, "pick")
	if li_pick = 1 then
		ls_cust[ ll_arr_count] = &
			dw_cust.getitemstring( i, "custnum")
		ll_arr_count ++
	end if
next

// generate report
lds_report_viewer = create datastore
lds_report_viewer.dataobject = "d_slsrep09"
lds_report_viewer.settransobject( sqlca)
lstr_report_viewer.title = parent.title
lds_report_viewer.retrieve( ld_from, ld_to, ls_cust[])
lds_report_viewer.object.t_company.text = gs_company_name
lds_report_viewer.object.t_print_by.text = f_print_by( gs_userid, gdt_serverdatetime)
lds_report_viewer.getfullstate( lstr_report_viewer.dwdata)
destroy lds_report_viewer
opensheetwithparm( lw_report_viewer, lstr_report_viewer, w_main, 0, layered!)


end event

type dw_cust from datawindow within w_slsrep09
integer x = 338
integer y = 176
integer width = 1728
integer height = 496
integer taborder = 30
string title = "none"
string dataobject = "d_slsrep09a"
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_slsrep09
integer x = 14
integer y = 184
integer width = 311
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
string text = "Customer :"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_to from editmask within w_slsrep09
integer x = 850
integer y = 68
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

type st_4 from statictext within w_slsrep09
integer x = 750
integer y = 80
integer width = 101
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
alignment alignment = center!
boolean focusrectangle = false
end type

type em_from from editmask within w_slsrep09
integer x = 343
integer y = 68
integer width = 402
integer height = 88
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

type st_3 from statictext within w_slsrep09
integer x = 73
integer y = 80
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

type gb_1 from groupbox within w_slsrep09
integer x = 78
integer y = 704
integer width = 2002
integer height = 8
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
end type

