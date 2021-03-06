$PBExportHeader$w_arrep02.srw
forward
global type w_arrep02 from window
end type
type st_3 from statictext within w_arrep02
end type
type em_from from editmask within w_arrep02
end type
type em_to from editmask within w_arrep02
end type
type st_4 from statictext within w_arrep02
end type
type cb_viewreport from commandbutton within w_arrep02
end type
type st_1 from statictext within w_arrep02
end type
type ddlb_customer from dropdownlistbox within w_arrep02
end type
type gb_1 from groupbox within w_arrep02
end type
end forward

global type w_arrep02 from window
integer width = 1577
integer height = 656
boolean titlebar = true
string title = "Customer Monthly trans."
boolean controlmenu = true
long backcolor = 67108864
string icon = "AppIcon!"
st_3 st_3
em_from em_from
em_to em_to
st_4 st_4
cb_viewreport cb_viewreport
st_1 st_1
ddlb_customer ddlb_customer
gb_1 gb_1
end type
global w_arrep02 w_arrep02

on w_arrep02.create
this.st_3=create st_3
this.em_from=create em_from
this.em_to=create em_to
this.st_4=create st_4
this.cb_viewreport=create cb_viewreport
this.st_1=create st_1
this.ddlb_customer=create ddlb_customer
this.gb_1=create gb_1
this.Control[]={this.st_3,&
this.em_from,&
this.em_to,&
this.st_4,&
this.cb_viewreport,&
this.st_1,&
this.ddlb_customer,&
this.gb_1}
end on

on w_arrep02.destroy
destroy(this.st_3)
destroy(this.em_from)
destroy(this.em_to)
destroy(this.st_4)
destroy(this.cb_viewreport)
destroy(this.st_1)
destroy(this.ddlb_customer)
destroy(this.gb_1)
end on

event open;string &
	ls_custnum, ls_custname

// fill customer list 
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

end event

type st_3 from statictext within w_arrep02
integer x = 133
integer y = 156
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

type em_from from editmask within w_arrep02
integer x = 407
integer y = 148
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

type em_to from editmask within w_arrep02
integer x = 914
integer y = 152
integer width = 402
integer height = 88
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

type st_4 from statictext within w_arrep02
integer x = 814
integer y = 160
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

type cb_viewreport from commandbutton within w_arrep02
integer x = 434
integer y = 376
integer width = 617
integer height = 100
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "View Report"
end type

event clicked;string &
	ls_customer[], ls_custnum, &
	ls_tr_desc, ls_custname, &
	ls_sname, ls_icode
date &
	ld_tr_date, ld_begin, ld_from, ld_to
double &
	ldbl_doamt,	ldbl_balance, ldbl_cnamt, ldbl_dnamt, ldbl_rcamt, &
	ldbl_tr_weight, ldbl_tr_debet, ldbl_tr_credit
long &
	ll_qty, ll_sum_qty, ll_currow
datastore &
	lds_report_viewer
w_report_viewer &
	lw_report_viewer
s_report_viewer &
	lstr_report_viewer

// get month and year
em_from.getdata( ld_from)
em_to.getdata( ld_to)
ld_begin = date( 1900,1,1)

// extract customer code
ls_customer = f_split_string( ddlb_customer.text, "*")
ls_custnum = trim( ls_customer[2])
ls_custname = trim( ls_customer[1])

// set report
lds_report_viewer = create datastore
lds_report_viewer.dataobject = "d_arrep02"
lstr_report_viewer.title = parent.title
lds_report_viewer.object.t_company.text = gs_company_name
lds_report_viewer.object.t_period.text = string( ld_from, "dd-mmmm-yyyy") + " s.d. " + string( ld_to, "dd-mmmm-yyyy")
lds_report_viewer.object.t_customer.text = trim( ls_custname) + " [ " + ls_custnum + " ] "
lds_report_viewer.object.t_print_date.text = "Tanggal Cetak " + string( gd_serverdate, "dd-mmmm-yyyy")
lds_report_viewer.object.t_print_by.text = f_print_by( gs_userid, gdt_serverdatetime)

ld_from = relativedate( ld_from, -1)
// get first balance
ldbl_balance = f_get_balance( ld_begin, ld_from, ls_custnum)

ll_currow = lds_report_viewer.insertrow( 0)
lds_report_viewer.setitem( ll_currow, "tr_order", "a")
lds_report_viewer.setitem( ll_currow, "tr_desc", "*** Saldo per tanggal " + string( ld_from, "dd-mmmm-yyyy"))
if ldbl_balance > 0 then
	lds_report_viewer.setitem( ll_currow, "tr_debet", ldbl_balance)
	lds_report_viewer.setitem( ll_currow, "tr_credit", 0)
else
	ldbl_balance = ldbl_balance * -1
	lds_report_viewer.setitem( ll_currow, "tr_debet", 0)
	lds_report_viewer.setitem( ll_currow, "tr_credit", ldbl_balance)
end if
ld_from = relativedate( ld_from, 1)

/***** currrent month transaction *****/

ldbl_doamt = 0
ldbl_cnamt = 0
ldbl_dnamt = 0
ldbl_rcamt = 0

// delivery order 
declare do_cur cursor for  
select a.dodate, b.icode, s.sname, sum((b.uprice+b.trspt)*b.qty), sum(b.qty)
	from sdomas a, sdodet b, supmast s
	where a.donum=b.donum
	and a.scode = s.scode
	and a.custnum = :ls_custnum
	and a.dodate between :ld_from and :ld_to
	and dostat in ("E","L")
	and s.balcalc = 1
	group by 1,2,3;
open do_cur;

ll_sum_qty = 0
do while sqlca.sqlcode = 0
	fetch do_cur into :ld_tr_date, :ls_icode, :ls_sname, :ldbl_doamt, :ll_qty;
	if sqlca.sqlcode = 0 then
		ls_tr_desc = "Pembelian " +&
			trim( ls_icode) + ",dari " +&
			trim( ls_sname) + "," + string( ll_qty) + " Box"
		ll_sum_qty = ll_sum_qty + ll_qty
		
		// insert data
		ll_currow = lds_report_viewer.insertrow( 0)
		lds_report_viewer.setitem( ll_currow, "tr_date", ld_tr_date)
		lds_report_viewer.setitem( ll_currow, "tr_order", "b")
		lds_report_viewer.setitem( ll_currow, "tr_desc", ls_tr_desc)
		lds_report_viewer.setitem( ll_currow, "tr_debet", ldbl_doamt)
		lds_report_viewer.setitem( ll_currow, "tr_credit", 0)
	end if
loop
close do_cur;

// Debit note
declare dn_cur cursor for  
select dndate, dnnum, dnamt
	from dnmas
	where custnum = :ls_custnum
	and dndate between :ld_from and :ld_to
	and dnstatus <> 'X';
open dn_cur;

do while sqlca.sqlcode = 0
	fetch dn_cur into :ld_tr_date, :ls_tr_desc, :ldbl_dnamt;
	if sqlca.sqlcode = 0 then
		ls_tr_desc = "Debit Note, No. " + trim( ls_tr_desc)

		// insert data
		ll_currow = lds_report_viewer.insertrow( 0)
		lds_report_viewer.setitem( ll_currow, "tr_date", ld_tr_date)
		lds_report_viewer.setitem( ll_currow, "tr_order", "c")
		lds_report_viewer.setitem( ll_currow, "tr_desc", ls_tr_desc)
		lds_report_viewer.setitem( ll_currow, "tr_debet", ldbl_dnamt)
		lds_report_viewer.setitem( ll_currow, "tr_credit", 0)
	end if
loop
close dn_cur;

// Credit note
declare cn_cur cursor for  
select cndate, cnnum, cnamt
	from cnmas
	where custnum = :ls_custnum
	and cndate between :ld_from and :ld_to
	and cnstatus <> 'X';
open cn_cur;

do while sqlca.sqlcode = 0
	fetch cn_cur into :ld_tr_date, :ls_tr_desc, :ldbl_cnamt;
	if sqlca.sqlcode = 0 then
		ls_tr_desc = "Credit Note, No. " + trim( ls_tr_desc)

		// insert data
		ll_currow = lds_report_viewer.insertrow( 0)
		lds_report_viewer.setitem( ll_currow, "tr_date", ld_tr_date)
		lds_report_viewer.setitem( ll_currow, "tr_order", "d")
		lds_report_viewer.setitem( ll_currow, "tr_desc", ls_tr_desc)
		lds_report_viewer.setitem( ll_currow, "tr_debet", 0)
		lds_report_viewer.setitem( ll_currow, "tr_credit", ldbl_cnamt)
	end if
loop
close cn_cur;
	
// Payment
declare rc_cur cursor for  
select rcdate, rcnum, rcamt
	from rcmas
	where custnum = :ls_custnum
	and rcdate between :ld_from and :ld_to
	and rcstatus <> 'X';
open rc_cur;

do while sqlca.sqlcode = 0
	fetch rc_cur into :ld_tr_date, :ls_tr_desc, :ldbl_rcamt;
	if sqlca.sqlcode = 0 then
		ls_tr_desc = "Pembayaran, No. " + trim( ls_tr_desc)

		// insert data
		ll_currow = lds_report_viewer.insertrow( 0)
		lds_report_viewer.setitem( ll_currow, "tr_date", ld_tr_date)
		lds_report_viewer.setitem( ll_currow, "tr_order", "e")
		lds_report_viewer.setitem( ll_currow, "tr_desc", ls_tr_desc)
		lds_report_viewer.setitem( ll_currow, "tr_debet", 0)
		lds_report_viewer.setitem( ll_currow, "tr_credit", ldbl_rcamt)
	end if
loop
close rc_cur;

lds_report_viewer.object.t_qty_summ.text = &
	"Total pengambilan periode " &
	+ string( date( ld_from), "dd-mmmm-yyyy")  + " s.d. " + &
	+ string( date( ld_to), "dd-mmmm-yyyy") &	
	+ " = " + string( ll_sum_qty, "#,##0") + " Box"
lds_report_viewer.object.t_last_bal.text = "*** Saldo akhir per tanggal " + string( ld_to, "dd-mmmm-yyyy")
lds_report_viewer.sort()
lds_report_viewer.getfullstate( lstr_report_viewer.dwdata)
destroy lds_report_viewer
opensheetwithparm( lw_report_viewer, lstr_report_viewer, w_main, 0, layered!)

end event

type st_1 from statictext within w_arrep02
integer x = 64
integer y = 56
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

type ddlb_customer from dropdownlistbox within w_arrep02
integer x = 411
integer y = 40
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

type gb_1 from groupbox within w_arrep02
integer x = 46
integer y = 292
integer width = 1417
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

