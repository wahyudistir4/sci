$PBExportHeader$w_arrep05.srw
forward
global type w_arrep05 from window
end type
type st_4 from statictext within w_arrep05
end type
type em_to from editmask within w_arrep05
end type
type em_from from editmask within w_arrep05
end type
type st_3 from statictext within w_arrep05
end type
type st_2 from statictext within w_arrep05
end type
type ddlb_customer from dropdownlistbox within w_arrep05
end type
type cb_process from commandbutton within w_arrep05
end type
type gb_1 from groupbox within w_arrep05
end type
end forward

global type w_arrep05 from window
string tag = "arrep01"
integer width = 1536
integer height = 720
boolean titlebar = true
string title = "Payment to invoice Evaluation"
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
global w_arrep05 w_arrep05

forward prototypes
public function double wf_get_invnett (date ld_invdate, string as_custnum)
public function decimal wf_get_invqty (date ad_invdate, string as_custnum)
end prototypes

public function double wf_get_invnett (date ld_invdate, string as_custnum);double &
	ldbl_doam
	
ldbl_doam = 0

select sum( (d.uprice+d.trspt) * d.qty) into :ldbl_doam
	from sdomas h, sdodet d, supmast s
	where h.donum = d.donum
	and h.scode = s.scode
	and h.custnum = :as_custnum
	and h.dodate = :ld_invdate
	and h.dostat in ( 'L', 'E')
	and s.balcalc = 1;

ldbl_doam = f_check_null_number( ldbl_doam)					

return ldbl_doam

end function

public function decimal wf_get_invqty (date ad_invdate, string as_custnum);decimal &
	ldc_qty

ldc_qty = 0

select sum( d.qty) into :ldc_qty
	from sdomas h, sdodet d, supmast s
	where h.donum = d.donum
	and h.scode = s.scode
	and h.custnum = :as_custnum
	and h.dodate = :ad_invdate
	and h.dostat in ( 'L', 'E')
	and s.balcalc = 1;

ldc_qty = f_check_null_number( ldc_qty)					

return ldc_qty

end function

on w_arrep05.create
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

on w_arrep05.destroy
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
ddlb_customer.additem( "-- Open Market --")

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

type st_4 from statictext within w_arrep05
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

type em_to from editmask within w_arrep05
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

type em_from from editmask within w_arrep05
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

type st_3 from statictext within w_arrep05
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

type st_2 from statictext within w_arrep05
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

type ddlb_customer from dropdownlistbox within w_arrep05
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

type cb_process from commandbutton within w_arrep05
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

event clicked;string &
	ls_customer[], ls_custnum, ls_custname, &
	ls_sql, ls_sql2
integer &
	li_terms, li_reccount, li_count
double &
	ldbl_rcam, ldbl_cnam, ldbl_dnam, ldbl_invam, &
	ldbl_doam, ldbl_bal, ldbl_invunpaid, ldbl_paid, ldbl_runningrc
date &
	ld_from, ld_to, ld_rcdate, ld_begin, &
	ld_invdate, ld_baldate, ld_runningdate
boolean &
	lb_first
decimal{2} &
	ldc_invqty

w_progress &
	lw_progress	
datastore &
	lds_report_viewer
s_report_viewer &
	lstr_report_viewer
w_report_viewer &
	lw_report_viewer, lw_report_viewer2

	
// extract customer code
if ddlb_customer.text = "-- Open Market --" then
	ls_sql2 = " where op_in = 'O'"
else
	ls_customer = f_split_string( ddlb_customer.text, "*")
	ls_custnum = trim( ls_customer[2])
	ls_custname = trim( ls_customer[1])
	ls_sql2 = " where custnum = '" + trim( ls_custnum) + "'"
end if

// get date
em_from.getdata( ld_from)
em_to.getdata( ld_to)
ld_begin = date( 1900, 1, 1)

// development
/*
ls_sql2 = " where custnum ='S001'"
ls_sql = "select custnum, custname, terms from custmast " +&
	ls_sql2
ld_from = date( 2010, 1, 1) 
ld_to = date( 2010, 1, 15) 
*/

ls_sql = "select count(*) as count from custmast" + ls_sql2
declare custcount_cur dynamic cursor for sqlsa;
prepare sqlsa from :ls_sql;
open dynamic custcount_cur;
fetch custcount_cur into :li_reccount;

ls_sql = "select custnum, custname, terms from custmast" + ls_sql2

declare customer_cur dynamic cursor for sqlsa;
prepare sqlsa from :ls_sql;
open dynamic customer_cur;


/*
 * create temp table	
 *
 */
 
// report temp table
ls_sql = "create temp table tmp_arrep01 (" + &
	"custnum char(8)," + &
	"custname char(30)," + &
	"term  integer," + &
	"dodate date," + &
	"r_clear_date date," + &
	"invamt decimal(16,2)," + &
	"invunpaid decimal(16,2)," + &
	"alloc_pay decimal(16,2)," + &
	"r_amt decimal(16,2)," + &
	"invqty decimal(16,2));"
execute immediate :ls_sql;

// do list temp table
ls_sql = "create temp table tmp_dolist (" +&
	"invam decimal(16,2)," +&
	"invunpaid decimal(16,2)," +&
	"invdate date," +&
	"invqty decimal(16,2));"
execute immediate :ls_sql;

// invoice date list temp table
ls_sql = "create temp table tmp_datelist (" +&
	"invdate date);"
execute immediate :ls_sql;

/*
 * end temp table creation
 *
 */

// setup progress bar
open( lw_progress)
lw_progress.hpb_status.position = 0
lw_progress.hpb_status.maxposition = li_reccount

li_count = 0
do while sqlca.sqlcode = 0
	fetch customer_cur into :ls_custnum, :ls_custname, :li_terms;
	if sqlca.sqlcode = 0 then
		// set progress bar
		yield()
		if isvalid( lw_progress) then
			li_count ++
			lw_progress.hpb_status.position = li_count
		else
			close customer_cur;
			execute immediate "drop table tmp_arrep01";
			execute immediate "drop table tmp_dolist";
			execute immediate "drop table date_dolist";
			return
		end if
				
		lw_progress.st_status.text = "Processing Cust. Code " + ls_custnum +  " ... "
		
		// get payment 
		declare payment_cur cursor for 
			select sum( rcamt), rcdate
			from rcmas
			where rcdate between :ld_from and :ld_to
			and custnum = :ls_custnum and rcstatus <> "X"
			group by 2 order by 2;
		open payment_cur;
		
		// isi invoice date list
		execute immediate "delete from tmp_datelist";
		ls_sql = "insert into tmp_datelist " +&
			"select distinct dodate " +&
			"from sdomas " +&
			"where custnum = ? and dostat <> 'X' " +&
			"and dodate <= ?;"
		prepare sqlsa from :ls_sql;
		execute sqlsa using :ls_custnum, :ld_to;								
		
		do while sqlca.sqlcode = 0
			fetch payment_cur into :ldbl_rcam, :ld_rcdate;
			if sqlca.sqlcode = 0 then //******************************//
				// cari hutang per tanggal pembayaran
				ld_baldate = ld_rcdate
				ldbl_bal = f_get_balance( ld_begin, ld_baldate, ls_custnum)
				
				ldbl_bal = ldbl_bal + ldbl_rcam
				
				// untuk uang lebih
				//if ldbl_bal - ldbl_rcam < 0 then
				if ldbl_bal <= 0 then
					ldbl_bal = ldbl_bal + ldbl_rcam
					ldbl_runningrc = ldbl_rcam
					ld_runningdate = ld_rcdate
					lb_first = true
					do while ldbl_runningrc > 0
						lw_progress.st_status.text = &
							"Processing Cust. Code " + &
							ls_custnum +  " ... " + &
							"Transaction " + string( ld_runningdate)
						ldbl_invam = wf_get_invnett( ld_runningdate, ls_custnum) 
						ldc_invqty = wf_get_invqty( ld_runningdate, ls_custnum) 
						ldbl_invunpaid = ldbl_invam		
						
						if ldbl_invam > 0 then
							// hanya tampilkan rc amount pada saat loop pertama
							if lb_first then
								lb_first = false
							else
								setnull( ldbl_rcam)
							end if

							if ldbl_runningrc >= ldbl_invam then
								ldbl_paid = ldbl_invam
							else
								ldbl_paid = ldbl_runningrc
							end if
							// insert into temp table
							ls_sql = "INSERT INTO tmp_arrep01 " + &
								" VALUES (?,?,?,?,?,?,?,?,?,?);"
							prepare sqlsa from :ls_sql;
							execute sqlsa using &
								:ls_custnum, :ls_custname, :li_terms, &
								:ld_runningdate, :ld_rcdate, :ldbl_invam, &
								:ldbl_invunpaid, :ldbl_paid, &
								:ldbl_rcam, :ldc_invqty;						
							ldbl_runningrc = ldbl_runningrc - ldbl_invam						
						end if						
						ld_runningdate = relativedate( ld_runningdate, 1)
						
						if daysafter( ld_rcdate, ld_runningdate) > 30 then
							exit
						end if
					loop												
					continue
				end if			
				// akhir blok uang lebih

				execute immediate "delete from tmp_dolist";
				
				ls_sql = "select invdate from tmp_datelist " +&
					"where invdate <= ? order by 1 desc;"
				declare invdate_cur dynamic cursor for sqlsa;
				prepare sqlsa from :ls_sql;
				open dynamic invdate_cur using :ld_baldate;
				
				do while sqlca.sqlcode = 0
					fetch invdate_cur into :ld_invdate;
					if sqlca.sqlcode = 0 then
						lw_progress.st_status.text = &
							"Processing Cust. Code " + &
							ls_custnum +  " ... " + &
							"Transaction " + string( ld_invdate)						
						ldbl_invam = wf_get_invnett( ld_invdate, ls_custnum)
						ldc_invqty = wf_get_invqty( ld_invdate, ls_custnum) 
						ldbl_invunpaid = ldbl_invam
						if ( ldbl_bal - ldbl_invam) < 0 then
							ldbl_invunpaid = ldbl_bal
						end if
						
						ldbl_bal = ldbl_bal - ldbl_invam						
						
						// insert into temp table
						ls_sql = "INSERT INTO tmp_dolist " + &
							" VALUES (?,?,?,?);"
						prepare sqlsa from :ls_sql;
						execute sqlsa using :ldbl_invam, &
							:ldbl_invunpaid, :ld_invdate, :ldc_invqty;
						
						if ldbl_bal <= 0 then
							exit
						end if
						
					end if
				loop						
				close invdate_cur;
					
				ls_sql = "select invam, invunpaid, invdate, invqty " +&
					"from tmp_dolist " +&
					"order by invdate;"
				declare inv_cur dynamic cursor for sqlsa;
				prepare sqlsa from :ls_sql;
				open dynamic inv_cur;
					
				ldbl_paid = ldbl_rcam				
				lb_first = true
				do while sqlca.sqlcode = 0
					fetch inv_cur into :ldbl_invam, :ldbl_invunpaid, &
						:ld_invdate, :ldc_invqty;
					if sqlca.sqlcode = 0 then
						// hanya tampilkan rc amount pada saat loop pertama
						if lb_first then
							lb_first = false
						else
							setnull( ldbl_rcam)
						end if
						
						if ( ldbl_paid - ldbl_invunpaid) <= 0 then
							// insert into temp table
							ls_sql = "INSERT INTO tmp_arrep01 " + &
								" VALUES (?,?,?,?,?,?,?,?,?,?);"
							prepare sqlsa from :ls_sql;
							execute sqlsa using &
								:ls_custnum, :ls_custname, :li_terms, &
								:ld_invdate, :ld_rcdate, :ldbl_invam, &
								:ldbl_invunpaid, :ldbl_paid, :ldbl_rcam, :ldc_invqty;						
							exit
						end if
						
						if ldbl_paid > ldbl_invunpaid then
							// insert into temp table
							ls_sql = "INSERT INTO tmp_arrep01 " + &
								" VALUES (?,?,?,?,?,?,?,?,?,?);"
							prepare sqlsa from :ls_sql;
							execute sqlsa using &
								:ls_custnum, :ls_custname, :li_terms, &
								:ld_invdate, :ld_rcdate, :ldbl_invam, &
								:ldbl_invunpaid, :ldbl_invunpaid, &
								:ldbl_rcam, :ldc_invqty;						
						else
							// insert into temp table
							ls_sql = "INSERT INTO tmp_arrep01 " + &
								" VALUES (?,?,?,?,?,?,?,?,?,?);"
							prepare sqlsa from :ls_sql;
							execute sqlsa using &
								:ls_custnum, :ls_custname, :li_terms, &
								:ld_invdate, :ld_rcdate, :ldbl_invam, &
								:ldbl_invunpaid, :ldbl_paid, &
								:ldbl_rcam, :ldc_invqty;						
						end if
												
						ldbl_paid = ldbl_paid - ldbl_invunpaid
						
					end if
				loop
				close inv_cur;
								
			end if
		loop
		close payment_cur;
		
	end if
loop
close customer_cur;
close( lw_progress)

ls_sql = " select * from tmp_arrep01";

// generate report detail
lds_report_viewer = create datastore
lds_report_viewer.dataobject = "d_arrep05"
lds_report_viewer.object.datawindow.table.select = ls_sql
lds_report_viewer.settransobject( sqlca)
lds_report_viewer.retrieve()
lstr_report_viewer.title = "Invoice Payment Detail"
lds_report_viewer.object.t_company.text = gs_company_name
lds_report_viewer.object.t_date.text = "For date : " + string( ld_from, "dd-mmm-yyyy") + " to " + string( ld_to, "dd-mmm-yyyy")
lds_report_viewer.object.t_print_by.text = f_print_by( gs_userid, gdt_serverdatetime)
lds_report_viewer.getfullstate( lstr_report_viewer.dwdata)
opensheetwithparm( lw_report_viewer, lstr_report_viewer, w_main, 0, layered!)
destroy lds_report_viewer

// generate report summary
lds_report_viewer = create datastore
lds_report_viewer.dataobject = "d_arrep05b"
lds_report_viewer.object.datawindow.table.select = ls_sql
lds_report_viewer.settransobject( sqlca)
lds_report_viewer.retrieve()
lstr_report_viewer.title = "Invoice Payment Summary"
lds_report_viewer.object.t_company.text = gs_company_name
lds_report_viewer.object.t_date.text = "For date : " + string( ld_from, "dd-mmm-yyyy") + " to " + string( ld_to, "dd-mmm-yyyy")
lds_report_viewer.object.t_print_by.text = f_print_by( gs_userid, gdt_serverdatetime)
lds_report_viewer.getfullstate( lstr_report_viewer.dwdata)
opensheetwithparm( lw_report_viewer2, lstr_report_viewer, w_main, 0, layered!)
destroy lds_report_viewer


// drop temp table
execute immediate "drop table tmp_arrep01";
execute immediate "drop table tmp_dolist";
execute immediate "drop table tmp_datelist";
	



end event

type gb_1 from groupbox within w_arrep05
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

