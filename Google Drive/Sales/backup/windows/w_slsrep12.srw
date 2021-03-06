$PBExportHeader$w_slsrep12.srw
forward
global type w_slsrep12 from window
end type
type em_date from editmask within w_slsrep12
end type
type st_2 from statictext within w_slsrep12
end type
type cb_view from commandbutton within w_slsrep12
end type
type gb_1 from groupbox within w_slsrep12
end type
end forward

global type w_slsrep12 from window
integer width = 1408
integer height = 588
boolean titlebar = true
string title = "DOC SALES REPORT"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
em_date em_date
st_2 st_2
cb_view cb_view
gb_1 gb_1
end type
global w_slsrep12 w_slsrep12

on w_slsrep12.create
this.em_date=create em_date
this.st_2=create st_2
this.cb_view=create cb_view
this.gb_1=create gb_1
this.Control[]={this.em_date,&
this.st_2,&
this.cb_view,&
this.gb_1}
end on

on w_slsrep12.destroy
destroy(this.em_date)
destroy(this.st_2)
destroy(this.cb_view)
destroy(this.gb_1)
end on

type em_date from editmask within w_slsrep12
integer x = 521
integer y = 32
integer width = 265
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

type st_2 from statictext within w_slsrep12
integer x = 18
integer y = 40
integer width = 466
integer height = 68
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

type cb_view from commandbutton within w_slsrep12
integer x = 229
integer y = 208
integer width = 576
integer height = 100
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&View Report"
end type

event clicked;string &
	ls_custnum,ls_customer, ls_area,ls_grade,ls_temp,ls_sub_desc, &
	ls_sql, ls_where_ptk, ls_where_nptk
date &
	ld_date, print_date
integer &
	li_month, li_year, ls_len
	
double &
	ldbl_qty,ldbl_doamt,ldbl_average, ls_subtot_qty,ls_subtot_amt, &
	ls_subtot_avg,ll_sum_qty,ll_sum_average, ll_sum_doamt 
long &
	 ll_currow	

datastore &
	lds_report_viewer
s_report_viewer &
	lstr_report_viewer
w_report_viewer &
	lw_report_viewer

em_date.getdata( ld_date)
li_month = month( ld_date)
li_year = year( ld_date)

print_date = Date (Year(ld_date) , Month (ld_date)+1, Day (ld_date))

// generate report
lds_report_viewer = create datastore
lds_report_viewer.dataobject = "d_slsrep12"
lds_report_viewer.settransobject( sqlca)
lds_report_viewer.retrieve( li_month, li_year)
lstr_report_viewer.title = parent.title
//lds_report_viewer.object.t_print_by.text = f_print_by( gs_userid, gdt_serverdatetime)

lds_report_viewer.object.t_month_year.text = "DOC BROILER SALES REPORT PER "+upper(string(ld_date, "mmmm  yyyy"))
lds_report_viewer.object.t_print_date.text = "Jakarta, "+string(print_date, "dd mmmm  yyyy")

 ls_where_ptk = " and ( year( sdomas.dodate) ="+string(li_year)+" and month(sdomas.dodate) ="+string(li_month)+" ) " +&
					 " and ( custmast.area = 'PTK' ) "+& 		
					 " GROUP BY   custmast.custnum, custmast.custname, area "+&
					 " ORDER BY custmast.custname"
ls_where_nptk = " and ( year( sdomas.dodate) ="+string(li_year)+" and month(sdomas.dodate) ="+string(li_month)+" ) " +&
					 " and ( custmast.area <> 'PTK' OR  custmast.area is null) "+& 		
					 " GROUP BY   custmast.custnum, custmast.custname, area "+&
					 " ORDER BY custmast.custname"					 
ls_sql =	" SELECT custmast.custnum,custmast.custname ,(select area.areadesc from area where  custmast.area = area.areanum) area, " +&
		  	" SUM(sdodet.qty) qty ,SUM(sdodet.uprice*sdodet.qty) amount,SUM(sdodet.uprice*sdodet.qty)/sum(sdodet.qty) averag " +&
		  	" FROM custmast ,sdodet ,sdomas ,itemast " +&
		  	" WHERE ( sdodet.donum = sdomas.donum ) " +&
		  	" and ( custmast.custnum = sdomas.custnum ) and ( itemast.icode = sdodet.icode ) " +&		  
		  	" and ( sdomas.dostat in ('E', 'L') ) " +&
		  	" and ( itemast.icode IN ('CH000001','CH000002','CH000003','CH000004','CH000005')) "


/** print market else pontianak **/



ls_where_nptk = ls_sql + ls_where_nptk

declare do_cur dynamic cursor for sqlsa;
prepare sqlsa from :ls_where_nptk;
open dynamic do_cur;

ls_grade =''
do while sqlca.sqlcode = 0
	fetch do_cur into :ls_custnum,:ls_customer, :ls_area, :ldbl_qty, :ldbl_doamt, :ldbl_average;
	if sqlca.sqlcode = 0 then
				
		ls_grade = f_get_grade_doc(ls_custnum,li_year,li_month)
		
		ll_currow = lds_report_viewer.insertrow( 0)
		lds_report_viewer.setitem( ll_currow, "tr_customer", ls_customer)
		lds_report_viewer.setitem( ll_currow, "tr_area", trim(ls_area) )
		lds_report_viewer.setitem( ll_currow, "tr_qty", ldbl_qty)
		lds_report_viewer.setitem( ll_currow, "tr_amount", ldbl_doamt)
		lds_report_viewer.setitem( ll_currow, "tr_average", ldbl_average)
		lds_report_viewer.setitem( ll_currow, "tr_grade", ls_grade)
	end if
	ls_grade = '';
loop
close do_cur;


// add one row
ll_currow = lds_report_viewer.insertrow( 0)
lds_report_viewer.setitem( ll_currow, "tr_customer", "")
lds_report_viewer.setitem( ll_currow, "tr_area", "")
lds_report_viewer.setitem( ll_currow, "tr_qty", "")
lds_report_viewer.setitem( ll_currow, "tr_amount", "")
lds_report_viewer.setitem( ll_currow, "tr_average", "")
lds_report_viewer.setitem( ll_currow, "tr_grade", "")

/**  print  market pontianak */
/* declare dnptk_cur cursor for  
		SELECT FROM ;
	open dnptk_cur;
*/

ls_where_ptk = ls_sql + ls_where_ptk

declare dnptk_cur dynamic cursor for sqlsa;
prepare sqlsa from :ls_where_ptk;
open dynamic dnptk_cur;

ls_grade =''
do while sqlca.sqlcode = 0
	fetch dnptk_cur into :ls_custnum,:ls_customer, :ls_area, :ldbl_qty, :ldbl_doamt, :ldbl_average;
	if sqlca.sqlcode = 0 then
		
		ls_grade = f_get_grade_doc(ls_custnum,li_year,li_month)
		
		ll_currow = lds_report_viewer.insertrow( 0)
		lds_report_viewer.setitem( ll_currow, "tr_customer", ls_customer)
		lds_report_viewer.setitem( ll_currow, "tr_area", trim(ls_area) )
		lds_report_viewer.setitem( ll_currow, "tr_qty", ldbl_qty)
		lds_report_viewer.setitem( ll_currow, "tr_amount", ldbl_doamt)
		lds_report_viewer.setitem( ll_currow, "tr_average", ldbl_average)
		lds_report_viewer.setitem( ll_currow, "tr_grade", ls_grade)
	end if
	ls_grade = '';
loop
close dnptk_cur;


// add one row
ll_currow = lds_report_viewer.insertrow( 0)
lds_report_viewer.setitem( ll_currow, "tr_customer", "")
lds_report_viewer.setitem( ll_currow, "tr_area", "")
lds_report_viewer.setitem( ll_currow, "tr_qty", "")
lds_report_viewer.setitem( ll_currow, "tr_amount", "")
lds_report_viewer.setitem( ll_currow, "tr_average", "")
lds_report_viewer.setitem( ll_currow, "tr_grade", "")


/** print subtotal **/
ll_sum_qty = 0
ll_sum_doamt = 0
ll_sum_average = 0
declare sub_cur cursor for  
	SELECT		
		itemast.desc area,
		SUM(sdodet.qty) qty ,
		SUM(sdodet.uprice*sdodet.qty) amount,
		SUM(sdodet.uprice*sdodet.qty)/sum(sdodet.qty) averag
	 FROM custmast ,sdodet ,sdomas ,itemast
	WHERE ( sdodet.donum = sdomas.donum )
	  and ( custmast.custnum = sdomas.custnum )
	  and ( itemast.icode = sdodet.icode )
	  and ( year( sdomas.dodate) =:li_year and month(sdomas.dodate) =:li_month )
	  and ( sdomas.dostat in ('E', 'L') )
     and ( itemast.icode IN ('CH000001','CH000002','CH000003','CH000004','CH000005'))
GROUP BY itemast.desc
ORDER BY itemast.desc;
open sub_cur;

do while sqlca.sqlcode = 0
	fetch sub_cur into :ls_sub_desc, :ls_subtot_qty, :ls_subtot_amt, :ls_subtot_avg;
	if sqlca.sqlcode = 0 then
	   ls_temp = "Sub Total " + trim( ls_sub_desc)
		ll_sum_qty = ll_sum_qty + ls_subtot_qty
		ll_sum_doamt = ll_sum_doamt + ls_subtot_amt
		ll_sum_average = ll_sum_average + ls_subtot_avg
		
		ll_currow = lds_report_viewer.insertrow( 0)
		lds_report_viewer.setitem( ll_currow, "tr_customer", "")
		lds_report_viewer.setitem( ll_currow, "tr_area", ls_temp)
		lds_report_viewer.setitem( ll_currow, "tr_qty", ls_subtot_qty)
		lds_report_viewer.setitem( ll_currow, "tr_amount", ls_subtot_amt)
		lds_report_viewer.setitem( ll_currow, "tr_average", ls_subtot_avg)
		lds_report_viewer.setitem( ll_currow, "tr_grade", ls_sub_desc)
	end if
loop
close sub_cur;

lds_report_viewer.object.t_qty_summ.text = string( ll_sum_qty, "#,##0" )
lds_report_viewer.object.t_doamt_sum.text = string( ll_sum_doamt, "#,##0")
lds_report_viewer.object.t_average_sum.text = string(ll_sum_average , "#,##0")

lds_report_viewer.object.tr_hatchery.text =" PT. MF tetas di Hatchery Subang, Purwakarta, Cisaga, Lampung"


lds_report_viewer.sort()
lds_report_viewer.getfullstate( lstr_report_viewer.dwdata)
destroy lds_report_viewer
opensheetwithparm( lw_report_viewer, lstr_report_viewer, w_main, 0, layered!)



end event

type gb_1 from groupbox within w_slsrep12
integer y = 140
integer width = 1097
integer height = 20
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
end type

