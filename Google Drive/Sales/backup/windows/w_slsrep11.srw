$PBExportHeader$w_slsrep11.srw
forward
global type w_slsrep11 from window
end type
type em_col_c from editmask within w_slsrep11
end type
type em_col_d from editmask within w_slsrep11
end type
type st_4 from statictext within w_slsrep11
end type
type em_col_b from editmask within w_slsrep11
end type
type em_col_a from editmask within w_slsrep11
end type
type st_5 from statictext within w_slsrep11
end type
type st_3 from statictext within w_slsrep11
end type
type st_2 from statictext within w_slsrep11
end type
type rb_both from radiobutton within w_slsrep11
end type
type rb_internal from radiobutton within w_slsrep11
end type
type rb_open from radiobutton within w_slsrep11
end type
type st_1 from statictext within w_slsrep11
end type
type em_date from editmask within w_slsrep11
end type
type cb_viewreport from commandbutton within w_slsrep11
end type
type gb_1 from groupbox within w_slsrep11
end type
type gb_2 from groupbox within w_slsrep11
end type
type gb_3 from groupbox within w_slsrep11
end type
end forward

global type w_slsrep11 from window
integer width = 1422
integer height = 1104
boolean titlebar = true
string title = "Customer aging"
boolean controlmenu = true
long backcolor = 67108864
string icon = "AppIcon!"
em_col_c em_col_c
em_col_d em_col_d
st_4 st_4
em_col_b em_col_b
em_col_a em_col_a
st_5 st_5
st_3 st_3
st_2 st_2
rb_both rb_both
rb_internal rb_internal
rb_open rb_open
st_1 st_1
em_date em_date
cb_viewreport cb_viewreport
gb_1 gb_1
gb_2 gb_2
gb_3 gb_3
end type
global w_slsrep11 w_slsrep11

on w_slsrep11.create
this.em_col_c=create em_col_c
this.em_col_d=create em_col_d
this.st_4=create st_4
this.em_col_b=create em_col_b
this.em_col_a=create em_col_a
this.st_5=create st_5
this.st_3=create st_3
this.st_2=create st_2
this.rb_both=create rb_both
this.rb_internal=create rb_internal
this.rb_open=create rb_open
this.st_1=create st_1
this.em_date=create em_date
this.cb_viewreport=create cb_viewreport
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_3=create gb_3
this.Control[]={this.em_col_c,&
this.em_col_d,&
this.st_4,&
this.em_col_b,&
this.em_col_a,&
this.st_5,&
this.st_3,&
this.st_2,&
this.rb_both,&
this.rb_internal,&
this.rb_open,&
this.st_1,&
this.em_date,&
this.cb_viewreport,&
this.gb_1,&
this.gb_2,&
this.gb_3}
end on

on w_slsrep11.destroy
destroy(this.em_col_c)
destroy(this.em_col_d)
destroy(this.st_4)
destroy(this.em_col_b)
destroy(this.em_col_a)
destroy(this.st_5)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.rb_both)
destroy(this.rb_internal)
destroy(this.rb_open)
destroy(this.st_1)
destroy(this.em_date)
destroy(this.cb_viewreport)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_3)
end on

event open;em_col_a.text = "00-30"
em_col_b.text = "31-60"
em_col_c.text = "61-90"
em_col_d.text = "90"

em_date.text = string(relativedate( date( year( gd_serverdate), month( gd_serverdate), 1),-1))
end event

type em_col_c from editmask within w_slsrep11
integer x = 987
integer y = 384
integer width = 251
integer height = 80
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
string mask = "##-##"
end type

type em_col_d from editmask within w_slsrep11
integer x = 987
integer y = 480
integer width = 251
integer height = 80
integer taborder = 50
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
string mask = "###"
end type

type st_4 from statictext within w_slsrep11
integer x = 695
integer y = 496
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
string text = "Column D"
boolean focusrectangle = false
end type

type em_col_b from editmask within w_slsrep11
integer x = 402
integer y = 480
integer width = 251
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
string mask = "##-##"
end type

type em_col_a from editmask within w_slsrep11
integer x = 402
integer y = 380
integer width = 251
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
string mask = "##-##"
end type

type st_5 from statictext within w_slsrep11
integer x = 695
integer y = 400
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
string text = "Column C"
boolean focusrectangle = false
end type

type st_3 from statictext within w_slsrep11
integer x = 96
integer y = 496
integer width = 270
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
string text = "Column B"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_2 from statictext within w_slsrep11
integer x = 110
integer y = 400
integer width = 256
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
string text = "Column A"
alignment alignment = right!
boolean focusrectangle = false
end type

type rb_both from radiobutton within w_slsrep11
integer x = 1024
integer y = 128
integer width = 238
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
string text = "Both"
end type

type rb_internal from radiobutton within w_slsrep11
integer x = 517
integer y = 128
integer width = 329
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
string text = "Internal"
end type

type rb_open from radiobutton within w_slsrep11
integer x = 105
integer y = 128
integer width = 329
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
string text = "Open"
boolean checked = true
end type

type st_1 from statictext within w_slsrep11
integer x = 393
integer y = 672
integer width = 137
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
string text = "Date"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_date from editmask within w_slsrep11
integer x = 576
integer y = 656
integer width = 393
integer height = 80
integer taborder = 60
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
string mask = "dd-mm-yyyy"
end type

type cb_viewreport from commandbutton within w_slsrep11
integer x = 402
integer y = 848
integer width = 571
integer height = 100
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&View Report"
end type

event clicked;string &
	ls_custnum, ls_sql, ls_arrrange[], ls_cust, ls_custname
integer &
	li_col_a_from, li_col_a_to, &
	li_col_b_from, li_col_b_to, &
	li_col_c_from, li_col_c_to, &
	li_col_d, li_terms
long &
	ll_reccount, ll_count, ll_row
date &
	ld_aging_date, ld_from
decimal{2} &
	ldc_col_a, ldc_col_b, ldc_col_c, ldc_col_d, ldc_os
datastore &
	lds_report
s_report_viewer &
	lstr_report_viewer
w_report_viewer &
	lw_report_viewer
w_progress &
	lw_progress

em_date.getdata( ld_aging_date)

/* extract age range */
ls_arrrange = f_split_string( em_col_a.text, "-")
li_col_a_from = integer( ls_arrrange[1])
li_col_a_to = integer( ls_arrrange[2])
ls_arrrange = f_split_string( em_col_b.text, "-")
li_col_b_from = integer( ls_arrrange[1])
li_col_b_to = integer( ls_arrrange[2])
ls_arrrange = f_split_string( em_col_c.text, "-")
li_col_c_from = integer( ls_arrrange[1])
li_col_c_to = integer( ls_arrrange[2])
li_col_d = integer( em_col_d.text)

if rb_open.checked = true then
	ls_sql = "select custnum, custname, terms from custmast " +&
		"where custstat <> 'X' and " +&
		"op_in = 'O' order by custnum"
elseif rb_internal.checked = true then
	ls_sql = "select custnum, custname, terms from custmast " +&
		"where custstat <> 'X' and " +&
		"op_in = 'I' order by custnum"
else 	
	ls_sql = "select custnum, custname, terms from custmast " +&
		"where custstat <> 'X'"
end if

declare customer_cur dynamic cursor for sqlsa;
prepare sqlsa from :ls_sql;
open dynamic customer_cur;

// ambil nilai maximum cursor
ll_reccount = 0
do while sqlca.sqlcode = 0 
	fetch customer_cur into :ls_custnum, :ls_custname, :li_terms;
	if sqlca.sqlcode = 0 then
		ll_reccount ++
	end if
loop
close customer_cur;

open( lw_progress)
lw_progress.hpb_status.position = 0
lw_progress.hpb_status.maxposition = ll_reccount

// set report
lds_report = create datastore
lds_report.dataobject = "d_slsrep11"
lstr_report_viewer.title = parent.title
lds_report.object.t_company.text = gs_company_name
lds_report.object.t_date.text = string( ld_aging_date, "dd-mmm-yyyy")
lds_report.object.t_col_a.text = em_col_a.text + " Days"
lds_report.object.t_col_b.text = em_col_b.text + " Days"
lds_report.object.t_col_c.text = em_col_c.text + " Days"
lds_report.object.t_col_d.text = ">" + em_col_d.text + " Days"
lds_report.object.t_print_by.text = f_print_by( gs_userid, gdt_serverdatetime)

ll_count = 0
ld_from = date( "1900-01-01")
open dynamic customer_cur;
do while sqlca.sqlcode = 0 
	fetch customer_cur into :ls_custnum, :ls_custname, :li_terms;
	if sqlca.sqlcode = 0 then
		ll_count ++
		yield()
		if isvalid( lw_progress) then
			lw_progress.hpb_status.position = ll_count
		else
			close customer_cur;
			return
		end if
				
		lw_progress.st_status.text = "Processing Cust. Code " + ls_custnum +  " ... "

		declare p_get_bal procedure for get_cust_aging  
			(:ld_from,:ld_aging_date,:ls_custnum,
			:li_col_a_from, :li_col_a_to,
			:li_col_b_from, :li_col_b_to,
			:li_col_c_from, :li_col_c_to,
			:li_col_d);
		execute p_get_bal;
		fetch p_get_bal into :ldc_col_a, :ldc_col_b, 
			:ldc_col_c, :ldc_col_d, :ldc_os;
		close p_get_bal;
		ll_row = lds_report.insertrow(0)
		lds_report.setitem( ll_row, "custnum", ls_custnum);
		lds_report.setitem( ll_row, "custname", ls_custname);
		lds_report.setitem( ll_row, "terms", li_terms);
		lds_report.setitem( ll_row, "col_a", ldc_col_a);
		lds_report.setitem( ll_row, "col_b", ldc_col_b);
		lds_report.setitem( ll_row, "col_c", ldc_col_c);
		lds_report.setitem( ll_row, "col_d", ldc_col_d);
		lds_report.setitem( ll_row, "os", ldc_os);
		
	end if
loop		

close customer_cur;		
close( lw_progress)

// generate report
lds_report.sort()
lds_report.filter()
lds_report.getfullstate( lstr_report_viewer.dwdata)
destroy lds_report
opensheetwithparm( lw_report_viewer, lstr_report_viewer, w_main, 0, layered!)


end event

type gb_1 from groupbox within w_slsrep11
integer x = 55
integer y = 776
integer width = 1234
integer height = 12
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_2 from groupbox within w_slsrep11
integer x = 55
integer y = 48
integer width = 1243
integer height = 208
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

type gb_3 from groupbox within w_slsrep11
integer x = 55
integer y = 288
integer width = 1243
integer height = 320
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
string text = "Range"
end type

