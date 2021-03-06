$PBExportHeader$w_slsdo.srw
forward
global type w_slsdo from w_master_detail_1
end type
type cb_export from commandbutton within w_slsdo
end type
type cb_int_ptice from commandbutton within w_slsdo
end type
type cb_slsexport from commandbutton within w_slsdo
end type
type cb_slsimport from commandbutton within w_slsdo
end type
end forward

global type w_slsdo from w_master_detail_1
string tag = "m_slsdo"
integer width = 3337
integer height = 2316
string title = "Sales Order"
cb_export cb_export
cb_int_ptice cb_int_ptice
cb_slsexport cb_slsexport
cb_slsimport cb_slsimport
end type
global w_slsdo w_slsdo

type variables
datawindowchild &
	idwc_subcode
end variables

forward prototypes
public function string wf_check_delete ()
public function string wf_check_edit ()
public function string wf_check_fields ()
public function string wf_delete ()
public subroutine wf_pre_update ()
public function string wf_post_add ()
public function string wf_post_edit ()
public function boolean wf_pre_update_donumact ()
end prototypes

public function string wf_check_delete ();string &
	ls_dostat

ls_dostat = dw_master.getitemstring( dw_master.getrow(), "dostat")

if ls_dostat = "A" then
	return ""
else
	return "Cannot delete record"
end if
end function

public function string wf_check_edit ();string &
	ls_status, ls_custnum, ls_op_in, ls_donum, ls_return
long &
	ll_continue, ll_row
integer &
	li_maxdays, li_age
date &
	ld_dodate
w_slsdo_conf &
	lw_slsdo_conf


li_maxdays = 2

ll_row = dw_master.getrow()	
ls_status = dw_master.getitemstring( &
	ll_row, "dostat")
ls_custnum = trim( dw_master.getitemstring( &
	ll_row, "custnum"))
ls_donum = trim( dw_master.getitemstring( &
	ll_row, "donum"))
ld_dodate = dw_master.getitemdate( ll_row, "dodate")
	
select op_in into :ls_op_in
from custmast
where custnum = :ls_custnum;

if isnull(ls_donum) or (ls_donum)= "" then
	return "Tidak bisa edit data kosong, "+&
		"silahkan pilih data terlebih dahulu"
end if

// Jika status DO sudah di eksport, dan customernya internal
// toleransi untuk edit adalah sesuai yang di set 
// di variabel li_maxdays
li_age = daysafter( ld_dodate, gd_serverdate)
if ls_status = "E" and ls_op_in = "I" and li_age > li_maxdays then
		return &
			"Tidak bisa edit DO Internal yang sudah di export " +&
			"lebih dari " + string( li_maxdays) + " hari~r~n" +&
			"Harus minta aktivasi ke bagian Credit Control"
end if

// DO Open market yang telah di export tidak bisa di edit
if ls_status = "E" and ls_op_in = "O" then
	return "Tidak bisa edit DO Open market yang telah di export~r~n" +&
			"Harus minta aktivasi ke bagian Credit Control"
end if
	
return ""
end function

public function string wf_check_fields ();long &
	ll_currow, ll_rowcount, n, i, ll_qty, ll_row, ll_duplicate
date &
	ld_dodate
string &
	ls_custnum, ls_subcode, ls_icode, ls_donumact,ls_blist,ls_custname
double &
	ldbl_uprice
decimal{2} &
	ldc_trspt

// master check
ll_currow = dw_master.getrow()


//if is_mode ="add" then
//ls_donumact = dw_master.getitemstring( ll_currow, "donumact")
//if isnull( ls_donumact) or trim(ls_donumact)="" then
//	return "Delivery order Number cannot empty"
//end if
//end if 	
ld_dodate = dw_master.getitemdate( ll_currow, "dodate")
if isnull( ld_dodate) then
	return "Delivery order date cannot empty"
end if

ls_custnum = trim(dw_master.getitemstring( ll_currow, "custnum"))
if isnull( ls_custnum) or trim( ls_custnum) = "" then
	return "Customer cannot empty"
end if

select blist, custname
	into :ls_blist, :ls_custname
	from custmast
	where custnum = :ls_custnum;

if upper(ls_blist) ='Y' then
	return "Customer :   " + trim(ls_custname) + " dalam Black List"
end if


ls_subcode = dw_master.getitemstring( ll_currow, "subcode")
if isnull( ls_subcode) or trim( ls_subcode) = "" then
	return "sub dept cannot empty"
end if

// detail check
ll_rowcount = dw_detail.rowcount()
for n = 1 to ll_rowcount
	ls_icode = dw_detail.getitemstring( n, "icode")
	ll_qty = dw_detail.getitemnumber( n, "qty")
	ldbl_uprice = dw_detail.getitemnumber( n, "uprice")
	ldc_trspt = dw_detail.getitemnumber( n, "trspt")
	
	if isnull( ldc_trspt) then
		dw_detail.setitem( n, "trspt", 0)
	end if
	
	if isnull( ls_icode) then 
		dw_detail.deleterow( n)
		n = n - 1
		ll_rowcount = ll_rowcount - 1
	else
		if isnull( ll_qty) or ll_qty <= 0 or &
			isnull(ldbl_uprice) or ldbl_uprice < 0 then
			
			return  "Quantity dan Harga tidak boleh kosong atau nol"
			exit
		end if		
	end if
next

return ""

end function

public function string wf_delete ();string &
	ls_donum
	
ls_donum = dw_master.getitemstring( dw_master.getrow(), "donum")	
	
update sdomas set dostat = "X" where donum = :ls_donum;

if sqlca.sqlcode = 0 then
	delete from sdodet where donum = :ls_donum;
	if sqlca.sqlcode = 0 then
		return "Record Deleted"
	else
		return ""
	end if
else
	return ""
end if




end function

public subroutine wf_pre_update ();long &
	ll_rowcount, n, ll_currow
dwitemstatus &
	ls_status
string &
	ls_donum, ls_custnum
	
ll_currow = dw_master.getrow()
ls_status = dw_master.getitemstatus( ll_currow, 0, primary!)

choose case ls_status
	case newmodified!, new!
		dw_master.setitem( ll_currow, "create_by", &
			gs_userid)
		dw_master.setitem( ll_currow, "create_date", &
			today())
		
	case datamodified!
		dw_master.setitem( ll_currow, "update_by", &
			gs_userid)
		dw_master.setitem( ll_currow, "update_date", &
			today())
end choose 

if is_mode = "add" then
	ls_donum = f_get_trnum( "SLSDO", "NUMSLSDO")
	dw_master.setitem( ll_currow, "dostat", "A")
	dw_master.setitem( ll_currow, "donum", ls_donum)
end if

ll_rowcount = dw_detail.rowcount()
ls_donum = dw_master.getitemstring( ll_currow, "donum")
ls_custnum = dw_master.getitemstring( ll_currow, "custnum")

for n = 1 to ll_rowcount
	
	ls_status = dw_detail.getitemstatus( n, 0, primary!)
	
	choose case ls_status
		case datamodified! 
			dw_detail.setitem( n, "update_by", gs_userid)
			dw_detail.setitem( n, "update_date", today())	
			
		case newmodified!
			dw_detail.setitem( n, "create_by", gs_userid)
			dw_detail.setitem( n, "create_date", today())		
			dw_detail.setitem( n, "donum", &
				dw_master.getitemstring( ll_currow, "donum"))		
					
	end choose
next




end subroutine

public function string wf_post_add ();integer &
	i

for i = 1 to 20
	dw_detail.insertrow(0)
next

dw_master.setitem( dw_master.getrow(), "dodate", gd_serverdate)

return ""
end function

public function string wf_post_edit ();string &
	ls_status, ls_custnum, ls_op_in


ls_status = dw_master.getitemstring( &
	dw_master.getrow(), "dostat")
ls_custnum = trim( dw_master.getitemstring( &
	dw_master.getrow(), "custnum"))
select op_in into :ls_op_in
from custmast
where custnum = :ls_custnum;

if ls_status = "E" and ls_op_in = "I" then
	f_enable_fields( dw_master, false)
	f_enable_fields( dw_detail, false)	
	dw_detail.modify( "uprice.protect=0")
	cb_insertrow.visible = false
	cb_deleterow.visible = false
end if


return ""
end function

public function boolean wf_pre_update_donumact ();	long &
	ll_rowcount, n, ll_currow
string &
	ls_donum, ls_donumact
integer &
	ls_op_in
	
	ll_currow = dw_master.getrow()
	ls_donum = dw_master.getitemstring( ll_currow, "donum")
	ls_donumact = upper(dw_master.getitemstring( ll_currow, 11 ))
	
	select count(*) into :ls_op_in
	from sdomas
	where donumact = :ls_donumact;
	
	if ls_op_in = 0 then
		update sdomas set donumact =:ls_donumact where donum = :ls_donum;
		commit;
		return false
	else 
		return true
	end if                     
	
end function

on w_slsdo.create
int iCurrent
call super::create
this.cb_export=create cb_export
this.cb_int_ptice=create cb_int_ptice
this.cb_slsexport=create cb_slsexport
this.cb_slsimport=create cb_slsimport
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_export
this.Control[iCurrent+2]=this.cb_int_ptice
this.Control[iCurrent+3]=this.cb_slsexport
this.Control[iCurrent+4]=this.cb_slsimport
end on

on w_slsdo.destroy
call super::destroy
destroy(this.cb_export)
destroy(this.cb_int_ptice)
destroy(this.cb_slsexport)
destroy(this.cb_slsimport)
end on

event open;call super::open;dw_master.getchild( "subcode_1", idwc_subcode)
idwc_subcode.settransobject( sqlca)

end event

event ue_print;call super::ue_print;date &
	ld_date
string &
	ls_ver, ls_custnum, ls_scode, ls_sname, ls_tmp_ver,&
	ls_opin
long &
	ll_qty, ll_count, i
datastore &
	lds_report_viewer
s_report_viewer &
	lstr_report_viewer
w_report_viewer &
	lw_report_viewer
w_slsdoprint &
	lw_slsdoprint
s_report &
	lstr_report

ld_date = dw_master.getitemdate( dw_master.getrow(), "dodate")
ls_scode = dw_master.getitemstring( dw_master.getrow(), "scode")
select sname into :ls_sname 
from supmast 
where scode = :ls_scode;
ls_ver = ""

/* disabled
// generate verification number
declare ver_curs cursor for
	select h.custnum, sum( qty)
	from sdomas h, sdodet d
	where h.dodate = :ld_date 
	and h.donum=d.donum
	and h.scode = :ls_scode
	group by 1
	order by 1;
open ver_curs;
ls_ver = string( ld_date, "ddmmyyyy") + "*"
do while sqlca.sqlcode = 0
	fetch ver_curs into :ls_custnum, :ll_qty;
	if sqlca.sqlcode = 0 then
		ls_ver = ls_ver + trim( ls_custnum) + "*" + string( ll_qty) + "*"
	end if
loop
close ver_curs;

// trim last char (*)
ls_ver = left( ls_ver, len( ls_ver) -1)
ls_ver = f_encrypt_do( ls_ver, 1, 2, 3, "-")

// trim long lines
ll_count = 0
for i = 1 to len( ls_ver)
	ll_count ++
	ls_tmp_ver += mid( ls_ver, i, 1)
	if ll_count = 160 then
		ls_tmp_ver += "~r~n"
		ll_count = 0
	end if
next
ls_ver = ls_tmp_ver
*/

// choose market
open( lw_slsdoprint)

lstr_report = message.powerobjectparm
if not isvalid( lstr_report) then
	return
end if
choose case lstr_report.customer
	case 1 // open market
		ls_opin = "O"
	case 2 // internal
		ls_opin = "I"
	case 3 // all
		ls_opin = "%"
end choose

// generate report 
lds_report_viewer = create datastore
if lstr_report.report_type = 1 then // by customer
	if lstr_report.page_type = 1 then // portrait
		lds_report_viewer.dataobject = "d_dolist_c_p"
	else
		lds_report_viewer.dataobject = "d_dolist_c_l"
	end if
else
	if lstr_report.page_type = 1 then // portrait
		lds_report_viewer.dataobject = "d_dolist_i_p"
	else
		lds_report_viewer.dataobject = "d_dolist_i_l"
	end if
end if
lds_report_viewer.settransobject( sqlca)
lds_report_viewer.retrieve( ld_date, ls_scode, ls_opin)
lds_report_viewer.object.t_company.text = gs_company_name + " -- ( DOC ORDERING )"
lds_report_viewer.object.t_sname.text = trim( ls_sname)
//lds_report_viewer.object.t_ver.text = trim( ls_ver)
lds_report_viewer.object.t_print_by.text = f_print_by( gs_userid, gdt_serverdatetime)
lds_report_viewer.getfullstate( lstr_report_viewer.dwdata)
destroy lds_report_viewer
opensheetwithparm( lw_report_viewer, lstr_report_viewer, w_main, 0, layered!)


end event

event ue_retrieve_detail;call super::ue_retrieve_detail;string &
	ls_donum
long &
	ll_row

ll_row = message.longparm

if is_mode = "display" and ib_query = false then
	if dw_master.rowcount() > 0 and ll_row > 0 and ib_fake_insert  = false then
		ls_donum = dw_master.getitemstring( ll_row, "donum")
		dw_detail.retrieve( ls_donum)
	end if
end if
end event

type cb_deleterow from w_master_detail_1`cb_deleterow within w_slsdo
integer x = 1929
integer y = 2012
integer width = 402
end type

type cb_insertrow from w_master_detail_1`cb_insertrow within w_slsdo
integer x = 1929
integer y = 1900
integer width = 402
end type

type uo_buttons from w_master_detail_1`uo_buttons within w_slsdo
integer y = 1892
end type

type dw_detail from w_master_detail_1`dw_detail within w_slsdo
integer y = 760
integer width = 3113
integer height = 1068
string dataobject = "d_sdodet"
end type

type dw_master from w_master_detail_1`dw_master within w_slsdo
integer x = 18
integer y = 16
integer width = 2853
integer height = 712
string dataobject = "d_sdomas"
end type

event dw_master::itemchanged;call super::itemchanged;if is_mode = "add" or is_mode = "edit" then
	choose case dwo.name
		case "custnum"
			idwc_subcode.retrieve( data)
	end choose
end if
end event

event dw_master::rowfocuschanged;call super::rowfocuschanged;string &
	ls_custnum

if currentrow > 0 and is_mode = "display" and ib_fake_insert = false then
	ls_custnum = dw_master.getitemstring( currentrow, "custnum")
	dw_master.getchild( "subcode_1", idwc_subcode)
	idwc_subcode.settransobject( sqlca)
	idwc_subcode.retrieve( ls_custnum)	
end if
end event

type gb_1 from w_master_detail_1`gb_1 within w_slsdo
integer x = 18
integer y = 1832
integer width = 3099
end type

type gb_2 from w_master_detail_1`gb_2 within w_slsdo
integer x = 18
integer y = 676
integer width = 3099
end type

type cb_export from commandbutton within w_slsdo
integer x = 2341
integer y = 1900
integer width = 430
integer height = 100
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "E&xp. to List"
end type

event clicked;long &
	ll_age, ll_terms, ll_currow, ll_count
double &
	ldbl_balance, ldbl_overdue,ldbl_total
string &
	ls_custnum, ls_errmsg, ls_dostat, ls_op_in, ls_scode,ls_donum
date &
	ld_date, ld_from, ld_dodate
integer &
	li_return
boolean &
	lb_baddo, lb_balcalc

ll_currow = dw_master.getrow()

// check unexported previous date DO
ld_dodate = dw_master.getitemdate( ll_currow, "dodate")
select count(*) into :ll_count 
from sdomas
where dostat = 'A'
and dodate < :ld_dodate;
if isnull( ll_count) or ll_count <> 0 then
	messagebox( "Export", "Ada " + string( ll_count) + &
		" DO yang belum di export sebelum tanggal " + &
		string( ld_dodate, "dd-mmmm-yyyy"))
	return
end if	

// check dostat
ls_dostat = dw_master.getitemstring( ll_currow, "dostat")
if ls_dostat <> "A" then
	messagebox( "Export", "Hanya bisa mengeksport Do yang aktif")
	return
end if

li_return = messagebox( "Export DO", "Apakah anda sudah memeriksa semua data?", question!, yesno!)

if li_return = 2 then
	return
end if

// select only open market customer 
// and supplier not from Jakarta ( D002)
ls_custnum = trim( dw_master.getitemstring( ll_currow, "custnum"))
ls_scode = trim( dw_master.getitemstring( ll_currow, "scode"))

select op_in into :ls_op_in
from custmast
where custnum = :ls_custnum;

lb_balcalc = true
select balcalc into :lb_balcalc
from supmast
where scode = :ls_scode;

lb_baddo = false

if ls_op_in = "O" and lb_balcalc = true and gb_blockdo = true then 
	ld_date = gd_serverdate //today()	
	ld_from = date( 1900, 01, 01)

	select terms into :ll_terms 
	from custmast 
	where custnum = :ls_custnum;
	ll_terms = f_check_null_number( ll_terms)
	
	ldbl_balance = f_get_balance( ld_from, ld_date, ls_custnum)
	if ldbl_balance > 0 then
		declare p_get_cust_age procedure for get_cust_age
			(:ldbl_balance, :ld_date, :ls_custnum, :ll_terms);
		execute p_get_cust_age;
		fetch p_get_cust_age into :ll_age, :ldbl_overdue;
		close p_get_cust_age;
	
		if ll_age > ll_terms then
			ls_errmsg = "Jumlah hutang = " + &
			string( ldbl_balance, "###,##0.00") + "~r~n" + &
			" Terms = " + string( ll_terms) + "~r~n" + &
			" Jumlah hutang yang melebihi terms = " + &
			string( ldbl_overdue, "###,##0.00")
			messagebox( "Warning!!", ls_errmsg)		
			lb_baddo = true
		end if
	end if
	
	// Check Customer CBD//
	if ll_terms = 0  then
		ls_donum = dw_master.getitemstring (dw_master.getrow(),"donum")
		select sum((uprice+trspt)*qty) into :ldbl_total
			from sdodet
			where donum = :ls_donum;
			ldbl_balance = ldbl_balance + ldbl_total
			if ldbl_balance > 0 then
				ls_errmsg = "Jumlah hutang = " + &
				string( ldbl_balance, "###,##0.00") + "~r~n" + &
				" Terms = " + string( ll_terms) + "~r~n" + &
				" Jumlah hutang yang melebihi terms = " + &
				string( ldbl_overdue, "###,##0.00")
				messagebox( "Warning!!", ls_errmsg)		
				lb_baddo = true
			end if
	end if
end if

if lb_baddo then
	if f_check_access( "m_slsdo", gs_userid, "group_s1") then
		li_return = messagebox( "Export DO", "Export DO ?", &
			question!, yesno!)
		if li_return = 1 then
			dw_master.setitem( ll_currow, "dostat", "E")
			dw_master.update()
			commit;
		end if
	else
		messagebox("Delivery Order", "Special rights #1 required")
	end if
else
	dw_master.setitem( ll_currow, "dostat", "E")
	dw_master.update()
	commit;
end if





end event

type cb_int_ptice from commandbutton within w_slsdo
integer x = 2341
integer y = 2012
integer width = 430
integer height = 100
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Calc. Int. Price"
end type

event clicked;//Perhitungan harga DOC untuk kemitraan
//DOC Grade A = total penjualan open market / Qty
//DOC Small   = 10 % dari harga DOC Grade A
//DOC Grade B = 15 % dari harga penjualan DOC Grade A

date &
	ld_date
long &
	ll_qty
double &
	ldbl_totsales, ldbl_doc_a, ldbl_doc_s, ldbl_doc_b
string &
	ls_message

ld_date = dw_master.getitemdate( dw_master.getrow(), &
	"dodate")

select sum( d.qty), sum( (d.uprice+d.trspt) * d.qty) into :ll_qty, :ldbl_totsales
from sdomas h, sdodet d, custmast c, supmast s
where h.donum = d.donum 
and h.custnum = c.custnum
and h.scode = s.scode
and c.op_in = 'O' 
and h.dodate = :ld_date
and h.dostat in ( 'E', 'L') // exported or Locked
and s.intprice = 1;

ll_qty = f_check_null_number( ll_qty)
ll_qty = ll_qty * 100 // per ekor
ldbl_totsales = f_check_null_number( ldbl_totsales)

if ll_qty = 0 or ldbl_totsales = 0 then
	messagebox( "Delivery Order", "Tidak ada penjualan open market untuk Tgl. " &
	+ string( ld_date, "dd-mmmm-yyyy"))
	return
end if

ldbl_doc_a = round( ldbl_totsales / ll_qty, 0)
ldbl_doc_b = round( ldbl_doc_a - ( ldbl_doc_a * 0.15), 0) 
ldbl_doc_s = round( ldbl_doc_a - ( ldbl_doc_a * 0.1), 0) 

ldbl_doc_a = ldbl_doc_a * 100
ldbl_doc_b = ldbl_doc_b * 100
ldbl_doc_s = ldbl_doc_s * 100

ls_message = "DOC Price for Internal Market ~r~n" + &
	"--------------------------------------- ~r~n" + &
	"DOC Grade A     = Rp. " + string( ldbl_doc_a, "#,##0") +  "~r~n" + &	
	"DOC Grade B     = Rp. " + string( ldbl_doc_b, "#,##0") +  "~r~n" + &	
	"DOC Grade Small = Rp. " + string( ldbl_doc_s, "#,##0") +  "~r~n" + &	
	"---------------------------------------" + "~r~n" + &	
	"PERIKSA KEMBALI HARGA INI !!"

messagebox( "DOC Internal Price", ls_message)



	
end event

type cb_slsexport from commandbutton within w_slsdo
integer x = 2798
integer y = 1896
integer width = 430
integer height = 100
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Export Sales"
end type

event clicked;open(w_slsexport)
end event

type cb_slsimport from commandbutton within w_slsdo
integer x = 2798
integer y = 2012
integer width = 430
integer height = 100
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "Import Sales"
end type

event clicked;string &
	ls_docpath, ls_docname, ls_arrdata[], ls_crdata, ls_data, &	
	ls_donum, ls_refnum, ls_userid, ls_dostat, ls_custnum, ls_pack, ls_custstat, ls_slsman, ls_invnum, ls_instat, ls_delito, &
	ls_dorem, ls_invrem, ls_invcurr, ls_exrate, ls_link, ls_flag, ls_curr, ls_subdesc, ls_area, ls_addr1, ls_addr2, ls_addr3, &
	ls_tel, ls_fax, ls_telex, ls_contact, ls_dodata, ls_exp, ls_dept, ls_subcode, ls_item, &
	ls_temp[], ls_temp_path, ls_7z, ls_command, &
	ls_fsdomas, ls_fsdodet, ls_fcsdodet, ls_fcustmast, ls_fsubdept, &
	ls_custname, ls_create_by, ls_type, ls_post, ls_blist, ls_cls, ls_trate
date &	
	ld_duedate, ld_dodate, ld_regdate
integer &
	li_frperiod, li_toperiod, li_filenum, li_return, &
	li_qty, li_tax_percent, &
	li_rc, li_sdomas, li_sdodet, li_csdodet, li_subdept, li_custmast, li_terms
decimal {2} &
	ldc_uprice, ldc_qty, ldc_invamt, ldc_osamt, ldc_qtywght,&
	ldc_packwght, ldc_mortwght, ldc_spoiwght, ldc_crdlimit
long &
	ll_count
OleObject wsh
ContextKeyword lcxk_base


CONSTANT integer MAXIMIZED = 3
CONSTANT integer MINIMIZED = 2
CONSTANT integer NORMAL = 1
CONSTANT boolean WAIT = TRUE
CONSTANT boolean NOWAIT = FALSE

// get temp dir
this.GetContextService("Keyword", lcxk_base)
lcxk_base.getContextKeywords("TEMP", ls_temp)
ls_temp_path = ls_temp[1]

//open file 7z
li_return = GetFileOpenName("Select File", &
    ls_docpath, ls_docname, "7z", "Export Files (*.7z) ,*.7z", & 
    ls_temp_path, 18)

if li_return = 0 then
	return
end if

// extract file
ls_7z = "c:\7za.exe"
wsh = CREATE OleObject
li_rc= wsh.ConnectToNewObject( "WScript.Shell" )	
//ls_password = "123superduper546"
ls_command = '"' + ls_7z + '"' + ' x "' + ls_docpath +&
	'" -o"' + ls_temp_path + '" -y' //-p' + ls_password
li_rc = wsh.Run(ls_command , NORMAL, WAIT)

ls_fsdomas = ls_temp_path + "\sdomas.txt"
ls_fsdodet = ls_temp_path + "\sdodet.txt"
ls_fcsdodet = ls_temp_path + "\csdodet.txt"
ls_fcustmast = ls_temp_path + "\custmast.txt"
ls_fsubdept = ls_temp_path + "\subdept.txt"

li_sdomas = FileOpen( ls_fsdomas)
do while true
	
	li_return = fileread( li_sdomas, ls_fsdomas)
	if li_return = -100 then
		exit
	end if
			
	ls_arrdata[] = f_split_string( ls_fsdomas, "|")
	ls_donum = ls_arrdata[1]
	ls_refnum = ls_arrdata[2]
	ls_userid = ls_arrdata[3]
	ls_dostat = ls_arrdata[4]
	ls_custnum = ls_arrdata[5]
	ls_pack = ls_arrdata[6]
	ls_custstat = ls_arrdata[7]
	ls_slsman = ls_arrdata[8]
	ls_invnum = ls_arrdata[9]
	ls_instat =  ls_arrdata[10]
	ld_duedate = date(ls_arrdata[11])
	ld_regdate = date( ls_arrdata[12])
	ld_dodate = date( ls_arrdata[13])
	ls_delito =  ls_arrdata[14]
	ls_invrem =  ls_arrdata[15]
	ls_dorem =  ls_arrdata[16]	
	ldc_qty = dec( ls_arrdata[17])
	ldc_invamt =dec( ls_arrdata[18])
	ldc_osamt =dec( ls_arrdata[19])
	ls_invcurr = ls_arrdata[20]
	ls_exrate = ls_arrdata[21]
	ls_link = ls_arrdata[22]
	ls_flag = ls_arrdata[23]
	ls_exp = ls_arrdata[24]
	ls_curr = ls_arrdata[25]
	li_tax_percent = integer(ls_arrdata[26])			
	
	ll_count = 0
	select count(donum) into :ll_count
		from sdomas 
		where donum = :ls_donum;
	if ll_count > 0 then
		ls_dodata = ls_donum + " sudah ada" + "~r~n"
		messagebox( "Error", "Nomor DO ~r~n" + trim( ls_dodata))		
		continue
	else
		ls_dodata = ls_dodata + "~r~n"
	end if
	insert into sdomas (
		donum,
		refnum,
		userid,
		dostat,			
		cust,
		pack,
		custstat,
		slsman,
		invnum,
		instat,
		duedate,
		regdate,
		dodate,
		delito,
		invrem,
		dorem,
		qty,
		invamt,
		osamt,
		invcurr,
		exrate,
		link,
		flag,
		exp,
		curr,
		tax_percent)
		values (
		:ls_donum ,
		:ls_refnum ,
		:ls_userid ,
		:ls_dostat ,
		:ls_custnum,
		:ls_pack ,
		:ls_custstat,
		:ls_slsman,
		:ls_invnum ,
		:ls_instat,
		:ld_duedate ,
		:ld_regdate,
		:ld_dodate ,
		:ls_delito ,
		:ls_invrem ,
		:ls_dorem ,
		:ldc_qty ,
		:ldc_invamt ,
		:ldc_osamt ,
		:ls_invcurr ,
		:ls_exrate ,
		:ls_link ,
		:ls_flag ,
		:ls_exp ,
		:ls_curr ,
		:li_tax_percent 
		);
		commit;
		
		if sqlca.sqlcode <> 0 then
			messagebox ("Error", "Import Error")
			fileclose( li_sdomas)
			return
		end if	
	
loop
fileclose(li_sdomas)



////sdodet
li_sdodet = FileOpen( ls_fsdodet)
do while true
	
	li_return = fileread( li_sdodet, ls_fsdodet)
	if li_return = -100 then
		exit
	end if		
		
	ls_arrdata[] = f_split_string( ls_data, "|")
	ls_donum = ls_arrdata[1]
	ld_regdate = date(ls_arrdata[2])
	ls_dept = ls_arrdata[3]
	ls_item = ls_arrdata[4]		
	ldc_uprice = dec(ls_arrdata[5])
	ldc_qtywght = dec(ls_arrdata[6])
	ldc_packwght = dec(ls_arrdata[7])
	ldc_mortwght = dec(ls_arrdata[8])
	ldc_spoiwght = dec(ls_arrdata[9])		
	
	insert into sdodet(
		donum,
		regdate,
		dept,
		item,
		uprice,
		qtywght,
		packwght,
		mortwght,
		spoiwght) values (
		:ls_donum ,
		:ld_regdate ,
		:ls_dept,
		:ls_item ,
		:ldc_uprice ,
		:ldc_qtywght,
		:ldc_packwght ,
		:ldc_mortwght ,
		:ldc_spoiwght
		);		
	commit;
loop
fileclose (li_sdodet)



///csdodet
li_csdodet = FileOpen( ls_fcsdodet)
do while true
	
	li_return = fileread( li_csdodet, ls_fcsdodet)
	if li_return = -100 then
		exit
	end if		
		
	ls_arrdata[] = f_split_string( ls_fcsdodet, "|")
	ls_donum = ls_arrdata[1]
	ld_regdate = date(ls_arrdata[2])
	ls_dept = ls_arrdata[3]
	ls_item = ls_arrdata[4]		
	ldc_uprice = dec(ls_arrdata[5])
	ldc_qtywght = dec(ls_arrdata[6])
	
	insert into sdodet(
		donum,
		regdate,
		dept,
		item,
		uprice,
		qty	) values (
		:ls_donum ,
		:ld_regdate ,
		:ls_dept,
		:ls_item ,
		:ldc_uprice ,
		:ldc_qtywght
		);
	commit;
loop
fileclose (li_csdodet)



///subdept
li_subdept = FileOpen( ls_fsubdept)
do while true
	
	li_return = fileread( li_subdept, ls_fsubdept)
	if li_return = -100 then
		exit
	end if
	
	ls_arrdata[] = f_split_string( ls_fsubdept, "|")
	ls_custnum =  ls_arrdata[1]
	ls_subcode =  ls_arrdata[2]
	ls_subdesc = ls_arrdata[3]
	ls_area = ls_arrdata[4]
	ls_addr1 = ls_arrdata[5]
	ls_addr2 = ls_arrdata[6]
	ls_addr3 = ls_arrdata[7]		
	ls_tel = ls_arrdata[8]
	ls_fax = ls_arrdata[9]
	ls_telex = ls_arrdata[10]
	ls_contact = ls_arrdata[11]
	
	// update subdept
	ll_count = 0
	select count( subcode) into :ll_count
		from subdept where custnum = :ls_custnum and subcode = :ls_subcode;
	if ll_count > 0 then
		update subdept set  area= :ls_area,
			addr1 = :ls_addr1,
			addr2 = :ls_addr1,
			addr3 = :ls_addr1,
			tel = :ls_tel,
			fax = :ls_fax,
			telex = :ls_telex,
			contact = :ls_contact
		where custnum = :ls_custnum and subcode = :ls_subcode;
	else
		insert into subdept (
			custnum,
			subcode,
			subdesc,
			area,
			addr1,
			addr2,
			addr3,
			tel,
			fax,
			telex,
			contact) values (
			:ls_custnum,
			:ls_subcode,
			:ls_subdesc,
			:ls_area,
			:ls_addr1,
			:ls_addr2,
			:ls_addr3,
			:ls_tel,
			:ls_fax,
			:ls_telex,
			:ls_contact
			);	
			commit;
	end if			
loop
fileclose (li_subdept)


///custmast
li_custmast = FileOpen( ls_fcustmast)
do while true
	
	li_return = fileread( li_custmast, ls_fcustmast)
	if li_return = -100 then
		exit
	end if
	
	ls_arrdata[] = f_split_string( ls_fcustmast, "|")
	ls_custnum =  ls_arrdata[1]
	ls_custname =  ls_arrdata[2]
	ls_create_by = ls_arrdata[3]
	ls_custstat = ls_arrdata[4]
	ls_type = ls_arrdata[5]
	ls_addr1 = ls_arrdata[6]
	ls_addr2 = ls_arrdata[7]
	ls_addr3 = ls_arrdata[8]	
	ls_post = ls_arrdata[9]
	ls_tel = ls_arrdata[10]
	ls_telex = ls_arrdata[11]	
	ls_fax = ls_arrdata[12]	
	ls_contact = ls_arrdata[13]
	ls_curr = ls_arrdata[14]
	ls_slsman = ls_arrdata[15]
	ls_area = ls_arrdata[16]
	li_terms = integer(ls_arrdata[17])
	ldc_crdlimit = dec(ls_arrdata[18])
	ls_delito = ls_arrdata[19]
	ls_blist = ls_arrdata[20]
	ls_cls = ls_arrdata[21]
	ls_trate = ls_arrdata[22]
	
	
	
	// update custmast
	ll_count = 0
	select count( custnum) into :ll_count
		from custmast where custnum = :ls_custnum;
	if ll_count > 0 then
		continue
	else
		insert into custmast (
			custnum,
			custname,
			create_by,
			custstat ,
			type ,
			addr1,
			addr2 ,
			addr3,
			post,
			tel,
			telex ,
			fax,
			contact,
			curr,
			slsman ,
			area ,
			terms ,
			crdlimit ,
			delito,
			blist,
			cls ,
			trate) values (
			:ls_custnum,
			:ls_custname,
			:ls_create_by,
			:ls_custstat,
			:ls_type,
			:ls_addr1,
			:ls_addr2,
			:ls_addr3,
			:ls_post,
			:ls_tel ,
			:ls_telex ,
			:ls_fax,
			:ls_contact,
			:ls_curr ,
			:ls_slsman ,
			:ls_area ,
			:li_terms,
			:ldc_crdlimit ,
			:ls_delito,
			:ls_blist,
			:ls_cls ,
			:ls_trate
			);	
			commit;
	end if			
loop
fileclose (li_custmast)


messagebox( "Import", "done !!!")	
end event

