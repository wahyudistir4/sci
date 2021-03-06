$PBExportHeader$w_arrep01.srw
forward
global type w_arrep01 from window
end type
type st_4 from statictext within w_arrep01
end type
type em_to from editmask within w_arrep01
end type
type em_from from editmask within w_arrep01
end type
type st_3 from statictext within w_arrep01
end type
type st_2 from statictext within w_arrep01
end type
type ddlb_customer from dropdownlistbox within w_arrep01
end type
type cb_process from commandbutton within w_arrep01
end type
type gb_1 from groupbox within w_arrep01
end type
end forward

global type w_arrep01 from window
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
global w_arrep01 w_arrep01

on w_arrep01.create
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

on w_arrep01.destroy
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

type st_4 from statictext within w_arrep01
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

type em_to from editmask within w_arrep01
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

type em_from from editmask within w_arrep01
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

type st_3 from statictext within w_arrep01
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

type st_2 from statictext within w_arrep01
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

type ddlb_customer from dropdownlistbox within w_arrep01
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

type cb_process from commandbutton within w_arrep01
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
	ld_firstmonth, ld_begindate, &
	ld_yesterday, ld_trdate, ld_from, ld_to
string &
	ls_custnum, ls_custname, ls_customer[]
double &
	ldbl_bf, ldbl_cf, ldbl_overdue, ldbl_balance, &
	ldbl_currsls, ldbl_accsls, ldbl_currdn, ldbl_accdn, &
	ldbl_currrc, ldbl_accrc, ldbl_currcn, ldbl_acccn, &
	ldbl_currbank, ldbl_accbank, &
	ldbl_doamt, ldbl_dnamt, ldbl_debt
integer &
	li_age, li_terms
long &
	ll_currsls_qty, ll_accsls_qty, ll_reccount, &
	ll_count, ll_currow
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

ld_yesterday = relativedate( ld_from, -1)
ld_begindate = date( 1900, 01, 01)
ld_firstmonth = date( year( ld_to), month( ld_to), 1)

// extract customer code
if ddlb_customer.text = "*** All Customer ***" then
	ls_custnum = "%"	
else
	ls_customer = f_split_string( ddlb_customer.text, "*")
	ls_custnum = trim( ls_customer[2])
	ls_custname = trim( ls_customer[1])
end if

declare customer_curs cursor for
	select custnum, custname, terms
	from custmast
	where custstat = '1'//select active customer
	and op_in = 'O'//and open market
	and custnum like :ls_custnum;
open customer_curs;

select count(*) into :ll_reccount
from custmast
where custstat = '1'//select active customer
and op_in = 'O'; //and open market

// show progress to user
lw_progress = w_progress
open( lw_progress)

lw_progress.hpb_status.position = 0
lw_progress.hpb_status.maxposition = ll_reccount

// set report
lds_report_viewer = create datastore
lds_report_viewer.dataobject = "d_arrep01"
lstr_report_viewer.title = parent.title
lds_report_viewer.object.t_company.text = gs_company_name
lds_report_viewer.object.t_date.text = "From " + string( ld_from, "dd-mmmm-yyyy") + " to " + string( ld_to, "dd-mmmm-yyyy")
lds_report_viewer.object.t_print_by.text = f_print_by( gs_userid, gdt_serverdatetime)

ll_count = 0
do while sqlca.sqlcode = 0
	yield()
	if not isvalid( lw_progress) then
		/* clean object */
		close customer_curs;
		return
	end if
	
	fetch customer_curs into :ls_custnum, :ls_custname, :li_terms;	
	if sqlca.sqlcode = 0 then
		ll_count ++
		lw_progress.hpb_status.position = ll_count
		lw_progress.st_status.text = ls_custname + ls_custnum
		
		ldbl_bf = f_get_balance( ld_begindate, ld_yesterday, ls_custnum)
			
		// get current transaction
		ldbl_currsls = f_get_sls( ld_from, ld_to, ls_custnum)
		ll_currsls_qty = f_get_sls_qty( ld_from, ld_to, ls_custnum)
		ldbl_currdn = f_get_dn( ld_from, ld_to, ls_custnum)
		ldbl_currcn = f_get_cn( ld_from, ld_to, ls_custnum)
		ldbl_currrc = f_get_receipt( ld_from, ld_to, ls_custnum)
		ldbl_currbank = f_get_bankchrg( ld_from, ld_to, ls_custnum)

		// get accumulated transaction
		ldbl_accsls = f_get_sls( ld_firstmonth, ld_to, ls_custnum)
		ll_accsls_qty = f_get_sls_qty( ld_firstmonth, ld_to, ls_custnum)
		ldbl_accdn = f_get_dn( ld_firstmonth, ld_to, ls_custnum)
		ldbl_acccn = f_get_cn( ld_firstmonth, ld_to, ls_custnum)
		ldbl_accrc = f_get_receipt( ld_firstmonth, ld_to, ls_custnum)
		ldbl_accbank = f_get_bankchrg( ld_firstmonth, ld_to, ls_custnum)
		
		ldbl_cf = ldbl_bf + ldbl_currdn + ldbl_currsls &
			- ldbl_currcn - ldbl_currrc
		
		// calculate overdue and age
		ldbl_balance = ldbl_cf
		ldbl_overdue = 0
		li_age = 0
		ld_trdate = ld_to
		
		declare p_get_cust_age procedure for get_cust_age
			(:ldbl_balance, :ld_to, :ls_custnum, :li_terms);
		execute p_get_cust_age;
		fetch p_get_cust_age into :li_age, :ldbl_overdue;
		close p_get_cust_age;
		
		// insert data
		ll_currow = lds_report_viewer.insertrow(0)
		lds_report_viewer.setitem( ll_currow, "custnum", ls_custnum)
		lds_report_viewer.setitem( ll_currow, "custname", ls_custname)
		lds_report_viewer.setitem( ll_currow, "terms", li_terms)
		lds_report_viewer.setitem( ll_currow, "bf", ldbl_bf)
		lds_report_viewer.setitem( ll_currow, "curr_sls_qty", ll_currsls_qty)
		lds_report_viewer.setitem( ll_currow, "acc_sls_qty", ll_accsls_qty)
		lds_report_viewer.setitem( ll_currow, "curr_sls", ldbl_currsls)
		lds_report_viewer.setitem( ll_currow, "acc_sls", ldbl_accsls)
		lds_report_viewer.setitem( ll_currow, "curr_rc", ldbl_currrc)
		lds_report_viewer.setitem( ll_currow, "acc_rc", ldbl_accrc)
		lds_report_viewer.setitem( ll_currow, "curr_bank", ldbl_currbank)
		lds_report_viewer.setitem( ll_currow, "acc_bank", ldbl_accbank)
		lds_report_viewer.setitem( ll_currow, "curr_cn", ldbl_currcn)
		lds_report_viewer.setitem( ll_currow, "acc_cn", ldbl_acccn)
		lds_report_viewer.setitem( ll_currow, "curr_dn", ldbl_currdn)
		lds_report_viewer.setitem( ll_currow, "acc_dn", ldbl_accdn)
		lds_report_viewer.setitem( ll_currow, "cf", ldbl_cf)
		lds_report_viewer.setitem( ll_currow, "overdue", ldbl_overdue)
		lds_report_viewer.setitem( ll_currow, "age", li_age)
		
	end if
loop
close customer_curs;
close( lw_progress)

// open report   	
lds_report_viewer.sort()
lds_report_viewer.filter()
lds_report_viewer.getfullstate( lstr_report_viewer.dwdata)
destroy lds_report_viewer
opensheetwithparm( lw_report_viewer, lstr_report_viewer, w_main, 0, layered!)
	
end event

type gb_1 from groupbox within w_arrep01
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

