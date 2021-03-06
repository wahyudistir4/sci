$PBExportHeader$w_arrep04.srw
forward
global type w_arrep04 from window
end type
type st_4 from statictext within w_arrep04
end type
type em_to from editmask within w_arrep04
end type
type em_from from editmask within w_arrep04
end type
type st_3 from statictext within w_arrep04
end type
type st_2 from statictext within w_arrep04
end type
type ddlb_customer from dropdownlistbox within w_arrep04
end type
type cb_process from commandbutton within w_arrep04
end type
type gb_1 from groupbox within w_arrep04
end type
end forward

global type w_arrep04 from window
string tag = "arrep01"
integer width = 1536
integer height = 720
boolean titlebar = true
string title = "Credit Control"
boolean controlmenu = true
long backcolor = 67108864
string icon = "AppIcon!"
st_4 st_4
em_to em_to
em_from em_from
st_3 st_3
st_2 st_2
ddlb_customer ddlb_customer
cb_process cb_process
gb_1 gb_1
end type
global w_arrep04 w_arrep04

on w_arrep04.create
this.st_4=create st_4
this.em_to=create em_to
this.em_from=create em_from
this.st_3=create st_3
this.st_2=create st_2
this.ddlb_customer=create ddlb_customer
this.cb_process=create cb_process
this.gb_1=create gb_1
this.Control[]={this.st_4,&
this.em_to,&
this.em_from,&
this.st_3,&
this.st_2,&
this.ddlb_customer,&
this.cb_process,&
this.gb_1}
end on

on w_arrep04.destroy
destroy(this.st_4)
destroy(this.em_to)
destroy(this.em_from)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.ddlb_customer)
destroy(this.cb_process)
destroy(this.gb_1)
end on

event open;string &
	ls_custnum, ls_custname

// fill customer list 
ddlb_customer.additem( "*** All Customer ***")

declare customer_cur cursor for  
	select custnum, custname  
	from custmast  
	where custstat <> "X"
	order by custname;
open customer_cur;
do while sqlca.sqlcode = 0
	fetch customer_cur into :ls_custnum, :ls_custname;
	if sqlca.sqlcode = 0 then
		ddlb_customer.additem( trim( ls_custname) + " * " + ls_custnum)
	end if
loop

close customer_cur;
ddlb_customer.selectitem( 1)

em_from.text = string( relativedate(gd_serverdate, -1))
em_to.text = string( relativedate(gd_serverdate, -1))
end event

type st_4 from statictext within w_arrep04
integer x = 754
integer y = 192
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

type em_to from editmask within w_arrep04
integer x = 855
integer y = 184
integer width = 402
integer height = 88
integer taborder = 40
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

type em_from from editmask within w_arrep04
integer x = 347
integer y = 180
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

type st_3 from statictext within w_arrep04
integer x = 78
integer y = 192
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

type st_2 from statictext within w_arrep04
integer x = 9
integer y = 84
integer width = 320
integer height = 60
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

type ddlb_customer from dropdownlistbox within w_arrep04
integer x = 347
integer y = 68
integer width = 1029
integer height = 580
integer taborder = 10
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

type cb_process from commandbutton within w_arrep04
integer x = 443
integer y = 404
integer width = 558
integer height = 96
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&View Report"
end type

event clicked;date &
	ld_from, ld_to
string &
	ls_custnum, ls_custname, ls_customer[]
datastore &
	lds_report_viewer
s_report_viewer &
	lstr_report_viewer
w_report_viewer &
	lw_report_viewer
w_progress	&
	lw_progress
	
em_from.getdata( ld_from)
em_to.getdata( ld_to)

// extract customer code
if ddlb_customer.text = "*** All Customer ***" then
	ls_custnum = "%"	
else
	ls_customer = f_split_string( ddlb_customer.text, "*")
	ls_custnum = trim( ls_customer[2])
	ls_custname = trim( ls_customer[1])
end if

// open report   	
// set report
lds_report_viewer = create datastore
lds_report_viewer.dataobject = "d_arrep04"
lds_report_viewer.settransobject( sqlca )
lds_report_viewer.retrieve( ld_from, ld_to, ls_custnum)
lstr_report_viewer.title = parent.title
lds_report_viewer.object.t_company.text = gs_company_name
lds_report_viewer.object.t_periode.text = string( ld_from, "dd-mmmm-yyyy") + " s.d. " + string( ld_to, "dd-mmmm-yyyy")
lds_report_viewer.object.t_print_by.text = f_print_by( gs_userid, gdt_serverdatetime)
lds_report_viewer.sort()
lds_report_viewer.filter()
lds_report_viewer.getfullstate( lstr_report_viewer.dwdata)
destroy lds_report_viewer
opensheetwithparm( lw_report_viewer, lstr_report_viewer, w_main, 0, layered!)
	
end event

type gb_1 from groupbox within w_arrep04
integer x = 37
integer y = 316
integer width = 1467
integer height = 36
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
end type

