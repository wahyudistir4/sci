$PBExportHeader$w_arrep07.srw
forward
global type w_arrep07 from window
end type
type st_status from statictext within w_arrep07
end type
type cb_close from commandbutton within w_arrep07
end type
type cb_import from commandbutton within w_arrep07
end type
type hpb_import from hprogressbar within w_arrep07
end type
type gb_1 from groupbox within w_arrep07
end type
end forward

global type w_arrep07 from window
integer width = 2149
integer height = 1132
boolean titlebar = true
string title = "Import Debtor List"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 12632256
string icon = "AppIcon!"
boolean center = true
st_status st_status
cb_close cb_close
cb_import cb_import
hpb_import hpb_import
gb_1 gb_1
end type
global w_arrep07 w_arrep07

forward prototypes
public function boolean f_get_createtemptable ()
end prototypes

public function boolean f_get_createtemptable ();string &
	ls_sql


// drop temp table

execute immediate "drop table temptrader";
execute immediate "drop table temparimas";
execute immediate "drop table tempdnmas";
execute immediate "drop table tempchqrmas";
execute immediate "drop table temparfmas";
execute immediate "drop table temprcmas";
execute immediate "drop table tempcnmas";

/*
 * create temp table	
 *
 */
 
// temp trader
ls_sql = "create temp table temptrader (" + &
"trd_no               char(8)," + &
"trd_type             char(1)," + &
"trd_mode             char(8)," + &
"trd_name             char(30)," + &
"trd_addr1            char(30)," + &
"trd_addr2            char(30)," + &
"trd_addr3            char(30)," + &
"trd_postcode         char(6)," + &
"trd_phone            char(12)," + &
"trd_fax              char(12)," + &
"trd_telex            char(18)," + &
"trd_contact          char(20)," + &
"trd_currency         char(3)," + &
"trd_glcode           char(8)," + &
"trdc_class           char(1)," + &
"trdc_addr1_ship      char(30)," + &
"trdc_addr2_ship      char(30)," + &
"trdc_addr3_ship      char(30)," + &
"trdc_pcode_ship      char(6)," + &
"trdc_salesman        char(6)," + &
"trdc_territory       char(6)," + &
"trdc_cr_days         smallint," + &
"trdc_stmt_type       char(1) ," + &
"trdc_cr_limit        money(16,2)," + &
"trdc_iv_billed_amt   money(16,2)," + &
"trdc_iv_rcpt_amt     money(16,2)," + &
"trdc_iv_rem_no       integer ," + &
"trdc_iv_lett_ref     char(28)," + &
"trdc_iv_lett_date    date," + &
"trdc_dn_billed_amt   money(16,2)," + &
"trdc_dn_rcpt_amt     money(16,2)," + &
"trdc_rf_amt          money(16,2)," + &
"trdc_unapplied_amt   money(16,2)," + &
"trdc_balance         money(16,2)," + &
"trdc_supply_ind      char(1)," + &
"trdc_ind_reason      char(20)," + &
"trds_class           char(1)," + &
"trds_purchaser       char(6)," + &
"trds_territory       char(6)," + &
"trds_cr_days         smallint," + &
"trds_stmt_type       char(1)," + &
"trds_cr_limit        money(16,2)," + &
"trds_iv_billed_amt   money(16,2)," + &
"trds_iv_rcpt_amt     money(16,2)," + &
"trds_iv_lett_ref     char(28)," + &
"trds_iv_lett_date    date," + &
"trds_dn_billed_amt   money(16,2)," + &
"trds_dn_rcpt_amt     money(16,2)," + &
"trds_coll_amt        money(16,2)," + &
"trds_unapplied_amt   money(16,2)," + &
"trds_balance         money(16,2)," + &
"trds_purchase_ind    char(1)," + &
"trds_ind_reason      char(20));" 
execute immediate :ls_sql;

// temp table arimas


ls_sql = "create temp table temparimas (" + &
"inv_cust_no    char(8) ," + &
"inv_op_code    char(6) ," + &
"inv_no         char(8) ," + &
"inv_ref        char(8) ," + &
"inv_date       date ," + &
"inv_user_id    char(8) ," + &
"inv_curr       char(3) ," + &
"inv_ex_rate    decimal(10,6) ," + &
"inv_desc       char(30) ," + &
"inv_desc2      char(30) ," + &
"inv_amt        money(16,2) ," + &
"inv_os_amt     money(16,2) ," + &
"inv_due_date   date ," + &
"inv_int_rate   decimal(5,2) ," + &
"inv_status     char(1) ," + &
"inv_touch_date date );"

execute immediate :ls_sql;


ls_sql = "create temp table tempdnmas (" + &
"dr_cust_no     char(8)," + &
"dr_no          char(8)," + &
"dr_ref         char(8)," + &
"dr_op_code     char(6)," + &
"dr_curr        char(3)," + &
"dr_ex_rate     decimal(10,5) ," + &
"dr_date        date," + &
"dr_user_id     char(8) ," + &
"dr_amt         money(16,2) ," + &
"dr_status      char(1)," + &
"dr_os_amt      money(16,2) ," + &
"dr_due_date    date ," + &
"dr_touch_date  date ," + &
"dr_rem1        char(30)," + &
"dr_rem2        char(30)," + &
"dr_rem3        char(30)," + &
"dr_rem4        char(30)) ;"


execute immediate :ls_sql;


ls_sql = "create temp table tempchqrmas (" + &
"r_cust_no      char(8)," + &
"r_no           char(8)," + &
"r_ref          char(8)," + &
"r_op_code      char(6)," + &
"r_date         date," + &
"r_user_id      char(8)," + &
"r_desc         char(30)," + &
"r_amt          money(16,2)," + &
"r_bank_code    char(8)," + &
"r_curr         char(3)," + &
"r_ex_rate      decimal(10,5) ," + &
"r_cheque_no    char(12)," + &
"r_bank_from    char(8)," + &
"r_trn_code     char(6)," + &
"r_clear_date   date," + &
"r_cheque_date  date," + &
"r_status       char(1));"

execute immediate :ls_sql;


ls_sql = "create temp table temparfmas (" + &
"f_cust_no            char(8)," + &
"f_no                 char(8)," + &
"f_ref                char(8)," + &
"f_op_code            char(6)," + &
"f_date               date," + &
"f_user_id            char(8)," + &
"f_desc               char(30)," + &
"f_amt                money(16,2)  ," + &
"f_bank_code          char(8)," + &
"f_curr               char(3)," + &
"f_ex_rate            decimal(10,5)," + &
"f_cheque_no          char(12)," + &
"f_trn_code           char(6)," + &
"f_clear_date         date," + &
"f_cheque_date        date," + &
"f_bank_outch         money(16,2)," + &
"f_os_amt             money(16,2)," + &
"f_status             char(1)," + &
"f_touch_date         date );"


execute immediate :ls_sql;

ls_sql = "create temp table temprcmas (" + &
"r_cust_no       char(8)," + &
"r_no            char(8)," + &
"r_ref           char(8)," + &
"r_op_code       char(6)," + &
"r_date          date ," + &
"r_user_id       char(8)," + &
"r_desc          char(30)," + &
"r_amt           money(16,2)," + &
"r_bank_code     char(8)," + &
"r_curr          char(3)," + &
"r_ex_rate       decimal(10,5)," + &
"r_cheque_no     char(12)," + &
"r_bank_from     char(8)," + &
"r_trn_code      char(6)," + &
"r_clear_date    date," + &
"r_cheque_date   date," + &
"r_bank_inch     money(16,2)," + &
"r_bank_outch    money(16,2)," + &
"r_unappl_amt    money(16,2)," + &
"r_status        char(1));"

execute immediate :ls_sql;


ls_sql = "create temp table tempcnmas (" + &
"cr_cust_no     char(8)," +&
"cr_no          char(8)," +&
"cr_op_code     char(6)," +&
"cr_curr        char(3)," +&
"cr_ex_rate     decimal(10,5)," +&
"cr_date        date ," +&
"cr_user_id     char(8)," +&
"cr_ref         char(8)," +&
"cr_amt         money(16,2)," +&
"cr_status      char(1)," +&
"cr_unappl_amt  money(16,2)," +&
"cr_rem1        char(30)," +&
"cr_rem2        char(30)," +&
"cr_rem3        char(30)," +&
"cr_rem4        char(30));"

execute immediate :ls_sql;

return true


/*
 * end temp table creation
 *
 */
end function

on w_arrep07.create
this.st_status=create st_status
this.cb_close=create cb_close
this.cb_import=create cb_import
this.hpb_import=create hpb_import
this.gb_1=create gb_1
this.Control[]={this.st_status,&
this.cb_close,&
this.cb_import,&
this.hpb_import,&
this.gb_1}
end on

on w_arrep07.destroy
destroy(this.st_status)
destroy(this.cb_close)
destroy(this.cb_import)
destroy(this.hpb_import)
destroy(this.gb_1)
end on

event open;st_status.text = ""
end event

type st_status from statictext within w_arrep07
integer x = 187
integer y = 256
integer width = 1774
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "status"
boolean focusrectangle = false
end type

type cb_close from commandbutton within w_arrep07
integer x = 727
integer y = 524
integer width = 402
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Close"
end type

event clicked;close(parent)
end event

type cb_import from commandbutton within w_arrep07
integer x = 178
integer y = 516
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Import Data"
end type

event clicked;string &
	ls_docpath, ls_docname, ls_arrdata[], ls_crdata, ls_data, &	
	ls_temp[], ls_temp_path, ls_7z, ls_command, &
	ls_trd_no, ls_trd_type, ls_trd_mode, ls_trd_name, ls_trd_addr1, ls_trd_addr2, ls_trd_addr3, &
	ls_trd_postcode, ls_trd_phone, ls_trd_fax,ls_trd_telex,ls_trd_contact,ls_trd_currency,ls_trd_glcode, &
	ls_trdc_class,ls_trdc_addr1_ship,ls_trdc_addr2_ship,ls_trdc_addr3_ship ,ls_trdc_pcode_ship ,ls_trdc_salesman, &
	ls_trdc_territory , ls_trdc_stmt_type, ls_trdc_iv_lett_ref,ls_trdc_supply_ind,ls_trdc_ind_reason,ls_trds_class, &
	ls_trds_purchaser, ls_trds_territory, ls_trds_stmt_type, ls_trds_iv_lett_ref,ls_trds_purchase_ind,ls_trds_ind_reason, &
	ls_inv_cust_no, ls_inv_op_code, ls_inv_no,ls_inv_ref, ls_inv_user_id, ls_inv_curr, ls_inv_desc, ls_inv_desc2,ls_inv_status, &
	ls_dr_cust_no, ls_dr_no,ls_dr_ref, ls_dr_op_code, ls_dr_curr,ls_dr_user_id,ls_dr_status,ls_dr_rem1, ls_dr_rem2, ls_dr_rem3,ls_dr_rem4, & 
	ls_r_cust_no ,ls_r_no, ls_r_ref, ls_r_op_code,ls_r_user_id,ls_r_desc,ls_r_bank_code, ls_r_curr, ls_r_cheque_no, ls_r_bank_from, ls_r_trn_code,ls_r_status, &  
	ls_f_cust_no,ls_f_no,ls_f_ref,ls_f_op_code,ls_f_user_id,ls_f_desc,ls_f_bank_code,ls_f_curr,ls_f_cheque_no,ls_f_trn_code,ls_f_status, &
	ls_cr_cust_no,ls_cr_no,ls_cr_op_code,ls_cr_curr,ls_cr_user_id ,ls_cr_ref, ls_cr_status, ls_cr_rem1,ls_cr_rem2,ls_cr_rem3,ls_cr_rem4, & 
	ls_ftrader, ls_farimas, ls_fdnmas, ls_fchqrmas, ls_farfmas, ls_frcmas, ls_fcnmas, &
	ls_donum, ls_refnum, ls_userid, ls_dostat, ls_custnum, ls_pack, ls_custstat, ls_slsman, ls_invnum, ls_instat, ls_delito, &
	ls_dorem, ls_invrem, ls_invcurr, ls_exrate, ls_link, ls_flag, ls_curr, ls_subdesc, ls_area, ls_addr1, ls_addr2, ls_addr3, &
	ls_tel, ls_fax, ls_telex, ls_contact, ls_dodata, ls_exp, ls_dept, ls_subcode, ls_item, &
	ls_custname, ls_create_by, ls_type, ls_post, ls_blist, ls_cls, ls_trate, &
	ls_SQL,ls_donum2,ls_item2

date &	
	ld_duedate, ld_dodate, ld_regdate, &
	ld_trdc_iv_lett_date, ld_trds_iv_lett_date, &
	ld_inv_date, ld_inv_due_date, ld_inv_touch_date, &
	ld_dr_date,ld_dr_due_date, ld_dr_touch_date, &
	ld_r_date,ld_r_clear_date, ld_r_cheque_date, &
	ld_f_date,ld_f_clear_date,ld_f_cheque_date, ld_f_touch_date, &
	ld_cr_date

integer &
	li_frperiod, li_toperiod, li_filenum, li_return, li_rc, &
	li_qty, li_tax_percent, li_terms, &
	li_trader, li_arimas, li_dnmas, li_chqrmas, li_arfmas, li_rcmas, li_cnmas, &
	li_trdc_cr_days,li_trdc_iv_rem_no, li_trds_cr_days

decimal {2} &
	ldc_uprice, ldc_qty, ldc_invamt, ldc_osamt, ldc_qtywght,&
	ldc_packwght, ldc_mortwght, ldc_spoiwght, ldc_crdlimit, &
	ldc_trdc_cr_limit, ldc_trdc_iv_billed_amt, ldc_trdc_iv_rcpt_amt ,ldc_trdc_dn_billed_amt , ldc_trdc_dn_rcpt_amt, &
	ldc_trdc_rf_amt, ldc_trdc_unapplied_amt, ldc_trdc_balance, ldc_trds_cr_limit, ldc_trds_iv_billed_amt, ldc_trds_iv_rcpt_amt, &
	ldc_trds_dn_billed_amt, ldc_trds_dn_rcpt_amt, ldc_trds_coll_amt, ldc_trds_unapplied_amt, ldc_trds_balance, &	
	ldc_inv_ex_rate, ldc_inv_amt, ldc_inv_os_amt, ldc_inv_int_rate, &
	ldc_dr_ex_rate, ldc_dr_amt,ldc_dr_os_amt, ldc_r_amt,ldc_r_ex_rate, ldc_f_amt,ldc_f_ex_rate,ldc_f_bank_outch,ldc_f_os_amt , &
	ldc_r_bank_inch,ldc_r_bank_outch,ldc_r_unappl_amt, &
	ldc_cr_ex_rate,ldc_cr_amt,ldc_cr_unappl_amt
	
long &
	ll_count, ll_progress
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
ls_7z = gst7z_program //"c:\7za.exe"
//ls_7z = "c:\7za.exe"
wsh = CREATE OleObject
li_rc= wsh.ConnectToNewObject( "WScript.Shell" )	
//ls_password = "123superduper546"
ls_command = '"' + ls_7z + '"' + ' x "' + ls_docpath +&
	'" -o"' + ls_temp_path + '" -y' //-p' + ls_password
li_rc = wsh.Run(ls_command , NORMAL, WAIT)



st_status.text = "Exctracting files ..."


hpb_import.maxposition = 7

hpb_import.position = 1
ls_ftrader = ls_temp_path + "\temptrader.txt"
hpb_import.position = 2
ls_farimas = ls_temp_path + "\temparimas.txt"
hpb_import.position = 3
ls_fdnmas = ls_temp_path + "\tempdnmas.txt"
hpb_import.position = 4
ls_fchqrmas = ls_temp_path + "\tempchqrmas.txt"
hpb_import.position = 5
ls_farfmas = ls_temp_path + "\temparfmas.txt"
hpb_import.position = 6
ls_frcmas = ls_temp_path + "\temprcmas.txt"
hpb_import.position = 7
ls_fcnmas = ls_temp_path + "\tempcnmas.txt"

// call create table
f_get_CreateTempTable()

hpb_import.maxposition = 7
hpb_import.position = 1
ll_progress = 0

li_trader = FileOpen( ls_ftrader)
do while true
	li_return = fileread( li_trader, ls_ftrader)
	if li_return = -100 then
		exit
	end if
	
	// progress 
	yield()
	ll_progress ++
	st_status.text = "Importing trader data ... [ " + string(ll_progress) + " ]"
			
	ls_arrdata[] = f_split_string( ls_ftrader, "|")
	ls_trd_no               = ls_arrdata[1]
	ls_trd_type             = ls_arrdata[2]
	ls_trd_mode             = ls_arrdata[3]
	ls_trd_name             = ls_arrdata[4]
	ls_trd_addr1            = ls_arrdata[5]
	ls_trd_addr2            = ls_arrdata[6]
	ls_trd_addr3            = ls_arrdata[7]
	ls_trd_postcode         = ls_arrdata[8]
	ls_trd_phone            = ls_arrdata[9]
	ls_trd_fax              = ls_arrdata[10]
	ls_trd_telex            = ls_arrdata[11]
	ls_trd_contact          = ls_arrdata[12]
	ls_trd_currency         = ls_arrdata[13]
	ls_trd_glcode           = ls_arrdata[14]
	ls_trdc_class           = ls_arrdata[15]
	ls_trdc_addr1_ship      = ls_arrdata[16]
	ls_trdc_addr2_ship      = ls_arrdata[17]
	ls_trdc_addr3_ship      = ls_arrdata[18]
	ls_trdc_pcode_ship      = ls_arrdata[19]
	ls_trdc_salesman        = ls_arrdata[20]
	ls_trdc_territory       = ls_arrdata[21]
	li_trdc_cr_days         = integer(ls_arrdata[22])
	ls_trdc_stmt_type       = ls_arrdata[23]
	ldc_trdc_cr_limit       = dec(ls_arrdata[24])
	ldc_trdc_iv_billed_amt  = dec(ls_arrdata[25])
	ldc_trdc_iv_rcpt_amt    = dec(ls_arrdata[26])
	li_trdc_iv_rem_no       = integer(ls_arrdata[27])
	ls_trdc_iv_lett_ref     = ls_arrdata[28]
	ld_trdc_iv_lett_date    = date(ls_arrdata[29])
	ldc_trdc_dn_billed_amt  = dec(ls_arrdata[30])
	ldc_trdc_dn_rcpt_amt    = dec(ls_arrdata[31])
	ldc_trdc_rf_amt         = dec(ls_arrdata[32])
	ldc_trdc_unapplied_amt  = dec(ls_arrdata[33])
	ldc_trdc_balance        = dec(ls_arrdata[34])
	ls_trdc_supply_ind      = ls_arrdata[35]
	ls_trdc_ind_reason      = ls_arrdata[36]
	ls_trds_class           = ls_arrdata[37]
	ls_trds_purchaser       = ls_arrdata[38]
	ls_trds_territory       = ls_arrdata[39]
	li_trds_cr_days         = integer(ls_arrdata[40])
	ls_trds_stmt_type       = ls_arrdata[41]
	ldc_trds_cr_limit       = dec(ls_arrdata[42])
	ldc_trds_iv_billed_amt  = dec(ls_arrdata[43])
	ldc_trds_iv_rcpt_amt    = dec(ls_arrdata[44])
	ls_trds_iv_lett_ref     = ls_arrdata[45]
	ld_trds_iv_lett_date    = date(ls_arrdata[46])
	ldc_trds_dn_billed_amt  = dec(ls_arrdata[47])
	ldc_trds_dn_rcpt_amt    = dec(ls_arrdata[48])
	ldc_trds_coll_amt       = dec(ls_arrdata[49])
	ldc_trds_unapplied_amt  = dec(ls_arrdata[50])
	ldc_trds_balance        = dec(ls_arrdata[51])
	ls_trds_purchase_ind    = ls_arrdata[52]
	ls_trds_ind_reason      = ls_arrdata[53]
	
	ll_count = 0
	select count(trd_no) into :ll_count
		from temptrader 
		where trd_no =:ls_trd_no 
		  and trd_type =:ls_trd_type
		  and trd_mode =:ls_trd_mode;
	if ll_count > 0 then
		continue
	end if
	
	insert into temptrader (
			trd_no,   
			trd_type,   
			trd_mode,   
			trd_name,   
			trd_addr1,   
			trd_addr2,   
			trd_addr3,   
			trd_postcode,   
			trd_phone,   
			trd_fax,   
			trd_telex,   
			trd_contact,   
			trd_currency,   
			trd_glcode,   
			trdc_class,   
			trdc_addr1_ship,   
			trdc_addr2_ship,   
			trdc_addr3_ship,   
			trdc_pcode_ship,   
			trdc_salesman,   
			trdc_territory,   
			trdc_cr_days,   
			trdc_stmt_type,   
			trdc_cr_limit,   
			trdc_iv_billed_amt,   
			trdc_iv_rcpt_amt,   
			trdc_iv_rem_no,   
			trdc_iv_lett_ref,   
			trdc_iv_lett_date,   
			trdc_dn_billed_amt,   
			trdc_dn_rcpt_amt,   
			trdc_rf_amt,   
			trdc_unapplied_amt,   
			trdc_balance,   
			trdc_supply_ind,   
			trdc_ind_reason,   
			trds_class,   
			trds_purchaser,   
			trds_territory,   
			trds_cr_days,   
			trds_stmt_type,   
			trds_cr_limit,   
			trds_iv_billed_amt,   
			trds_iv_rcpt_amt,   
			trds_iv_lett_ref,   
			trds_iv_lett_date,   
			trds_dn_billed_amt,   
			trds_dn_rcpt_amt,   
			trds_coll_amt,   
			trds_unapplied_amt,   
			trds_balance,   
			trds_purchase_ind,   
			trds_ind_reason )
	values (
			:ls_trd_no,
			:ls_trd_type,
			:ls_trd_mode,
			:ls_trd_name,
			:ls_trd_addr1,
			:ls_trd_addr2,
			:ls_trd_addr3,
			:ls_trd_postcode,
			:ls_trd_phone,
			:ls_trd_fax,
			:ls_trd_telex,
			:ls_trd_contact,
			:ls_trd_currency,
			:ls_trd_glcode,
			:ls_trdc_class,
			:ls_trdc_addr1_ship,
			:ls_trdc_addr2_ship,
			:ls_trdc_addr3_ship,
			:ls_trdc_pcode_ship,
			:ls_trdc_salesman,
			:ls_trdc_territory,
			:li_trdc_cr_days,
			:ls_trdc_stmt_type,
			:ldc_trdc_cr_limit,
			:ldc_trdc_iv_billed_amt, 
			:ldc_trdc_iv_rcpt_amt,
			:li_trdc_iv_rem_no,
			:ls_trdc_iv_lett_ref,
			:ld_trdc_iv_lett_date,
			:ldc_trdc_dn_billed_amt, 
			:ldc_trdc_dn_rcpt_amt,
			:ldc_trdc_rf_amt,
			:ldc_trdc_unapplied_amt, 
			:ldc_trdc_balance,
			:ls_trdc_supply_ind,
			:ls_trdc_ind_reason,
			:ls_trds_class,
			:ls_trds_purchaser,
			:ls_trds_territory,
			:li_trds_cr_days,
			:ls_trds_stmt_type,
			:ldc_trds_cr_limit,
			:ldc_trds_iv_billed_amt, 
			:ldc_trds_iv_rcpt_amt,
			:ls_trds_iv_lett_ref,
			:ld_trds_iv_lett_date,
			:ldc_trds_dn_billed_amt, 
			:ldc_trds_dn_rcpt_amt,
			:ldc_trds_coll_amt,
			:ldc_trds_unapplied_amt, 
			:ldc_trds_balance,
			:ls_trds_purchase_ind,
			:ls_trds_ind_reason );
		commit;
		
		if sqlca.sqlcode <> 0 then
			messagebox ("Error", "Import Error~r~n" + sqlca.sqlerrtext)
			fileclose( li_trader)
			return
		end if	
	
loop
fileclose(li_trader)


select count(*) into :ll_count
from temptrader ;
messagebox ("Information", ll_count )

// arimas
hpb_import.position = 2
ll_progress = 0

li_arimas = FileOpen( ls_farimas)
do while true
	
	li_return = fileread( li_arimas, ls_farimas)
	if li_return = -100 then
		exit
	end if		
	
	// progress 
	yield()
	ll_progress ++
	st_status.text = "Importing arimas data ... [ " + string(ll_progress) + " ]"
		
	ls_arrdata[] = f_split_string( ls_farimas, "|")
	ls_inv_cust_no     = ls_arrdata[1]       
	ls_inv_op_code     = ls_arrdata[2]       
	ls_inv_no          = ls_arrdata[3]       
	ls_inv_ref         = ls_arrdata[4]       
	ld_inv_date        = date(ls_arrdata[5] )
	ls_inv_user_id     = ls_arrdata[6]       
	ls_inv_curr        = ls_arrdata[7]       
	ldc_inv_ex_rate    = dec(ls_arrdata[8])  
	ls_inv_desc        = ls_arrdata[9]       
	ls_inv_desc2       = ls_arrdata[10]      
	ldc_inv_amt        = dec(ls_arrdata[11]) 
	ldc_inv_os_amt     = dec(ls_arrdata[12]) 
	ld_inv_due_date    = date(ls_arrdata[13])
	ldc_inv_int_rate   = dec(ls_arrdata[14]) 
	ls_inv_status      = ls_arrdata[15]      
	ld_inv_touch_date  = date(ls_arrdata[16])
	
	
	ll_count = 0
	select count(inv_cust_no) into :ll_count
		from temparimas 
		where inv_cust_no =:ls_inv_cust_no   
		  and inv_op_code =:ls_inv_op_code   
		  and inv_no =:ls_inv_no
		  and inv_ref =:ls_inv_ref
		  and inv_date =:ld_inv_date;
	if ll_count > 0 then
		continue
	end if

	insert into temparimas (
			inv_cust_no,
			inv_op_code,
			inv_no,
			inv_ref,
			inv_date,
			inv_user_id,
			inv_curr,
			inv_ex_rate,
			inv_desc,
			inv_desc2,
			inv_amt,
			inv_os_amt,
			inv_due_date,
			inv_int_rate,
			inv_status,
			inv_touch_date,
			) 
	values(
			:ls_inv_cust_no,
			:ls_inv_op_code,
			:ls_inv_no,
			:ls_inv_ref,
			:ld_inv_date,
			:ls_inv_user_id,
			:ls_inv_curr,
			:ldc_inv_ex_rate,
			:ls_inv_desc,
			:ls_inv_desc2,
			:ldc_inv_amt,
			:ldc_inv_os_amt,
			:ld_inv_due_date,
			:ldc_inv_int_rate,
			:ls_inv_status,
			:ld_inv_touch_date);
	commit;
	if sqlca.sqlcode <> 0 then
		messagebox ("Error", "Import Error~r~n" + sqlca.sqlerrtext)
		fileclose( li_arimas)
		return
	end if	
	
loop
fileclose (li_arimas)



// dnmas
hpb_import.position = 3
ll_progress = 0

li_dnmas = FileOpen( ls_fdnmas)
do while true
	
	li_return = fileread( li_dnmas, ls_fdnmas)
	if li_return = -100 then
		exit
	end if		
	
	// progress 
	yield()
	ll_progress ++
	st_status.text = "Importing dnmas data ... [ " + string(ll_progress) + " ]"
	
	ls_arrdata[] = f_split_string( ls_fdnmas, "|")	                                              
	ls_dr_cust_no     = ls_arrdata[1]            
	ls_dr_no          = ls_arrdata[2]            
	ls_dr_ref         = ls_arrdata[3]            
	ls_dr_op_code     = ls_arrdata[4]            
	ls_dr_curr        = ls_arrdata[5]            
	ldc_dr_ex_rate    = dec(ls_arrdata[6])       
	ld_dr_date        = date(ls_arrdata[7])      
	ls_dr_user_id     = ls_arrdata[8]            
	ldc_dr_amt        = dec(ls_arrdata[9])       
	ls_dr_status      = ls_arrdata[10]           
	ldc_dr_os_amt     = dec(ls_arrdata[11])      
	ld_dr_due_date    = date(ls_arrdata[12])     
	ld_dr_touch_date  = date(ls_arrdata[13])     
	ls_dr_rem1        = ls_arrdata[14]           
	ls_dr_rem2        = ls_arrdata[15]           
	ls_dr_rem3        = ls_arrdata[16]           
	ls_dr_rem4        = ls_arrdata[17]           

	ll_count = 0
	select count(dr_cust_no) into :ll_count
	  from tempdnmas 
	 where donum = :ls_donum and item = :ls_item and uprice = :ldc_uprice;
	if ll_count > 0 then
		continue
	end if
	
	insert into tempdnmas (
		dr_cust_no,
		dr_no,
		dr_ref,
		dr_op_code,
		dr_curr,
		dr_ex_rate,
		dr_date,
		dr_user_id,
		dr_amt,
		dr_status,
		dr_os_amt,
		dr_due_date,
		dr_touch_date,
		dr_rem1,
		dr_rem2,
		dr_rem3,
		dr_rem4)
	values(
		:ls_dr_cust_no,     
		:ls_dr_no,     
		:ls_dr_ref,     
		:ls_dr_op_code,     
		:ls_dr_curr,     
		:ldc_dr_ex_rate,     
		:ld_dr_date,     
		:ls_dr_user_id,     
		:ldc_dr_amt,     
		:ls_dr_status,     
		:ldc_dr_os_amt,     
		:ld_dr_due_date,     
		:ld_dr_touch_date,     
		:ls_dr_rem1,     
		:ls_dr_rem2,     
		:ls_dr_rem3,     
		:ls_dr_rem4);
	commit;
	if sqlca.sqlcode <> 0 then
		messagebox ("Error", "Import Error~r~n" + sqlca.sqlerrtext)
		fileclose( li_dnmas)
		return
	end if	
	
loop
fileclose (li_dnmas)


// chqrmas
hpb_import.position = 4
ll_progress = 0

li_chqrmas = FileOpen( ls_fchqrmas)
do while true
	
	li_return = fileread( li_chqrmas, ls_fchqrmas)
	if li_return = -100 then
		exit
	end if
	
	// progress 
	yield()
	ll_progress ++
	st_status.text = "Importing chqrmas data ... [ " + string(ll_progress) + " ]"
	
	ls_arrdata[] = f_split_string( ls_fchqrmas, "|")
	ls_r_cust_no     = ls_arrdata[1]
	ls_r_no          = ls_arrdata[2]
	ls_r_ref         = ls_arrdata[3]
	ls_r_op_code     = ls_arrdata[4]
	ld_r_date        = date(ls_arrdata[5])
	ls_r_user_id     = ls_arrdata[6]
	ls_r_desc        = ls_arrdata[7]
	ldc_r_amt        = dec(ls_arrdata[8])
	ls_r_bank_code   = ls_arrdata[9]
	ls_r_curr        = ls_arrdata[10]
	ldc_r_ex_rate    = dec(ls_arrdata[11])
	ls_r_cheque_no   = ls_arrdata[12]
	ls_r_bank_from   = ls_arrdata[13]
	ls_r_trn_code    = ls_arrdata[14]
	ld_r_clear_date  = date(ls_arrdata[15])
	ld_r_cheque_date = date(ls_arrdata[16])
	ls_r_status      = ls_arrdata[17]
	
	ll_count = 0
	select count(dr_cust_no) into :ll_count
	  from tempchqrmas 
	 where r_cust_no = :ls_r_cust_no 
	 	and r_no = :ls_r_no 
		and r_op_code = :ls_r_op_code;
	if ll_count > 0 then
		continue
	end if
	
	insert into tempchqrmas (
			r_cust_no,
			r_no,
			r_ref,
			r_op_code,
			r_date,
			r_user_id,
			r_desc,
			r_amt,
			r_bank_code,
			r_curr,
			r_ex_rate,
			r_cheque_no,
			r_bank_from,
			r_trn_code,
			r_clear_date,
			r_cheque_date,
			r_status) 
	values (
			:ls_r_cust_no,
			:ls_r_no,
			:ls_r_ref,
			:ls_r_op_code,
			:ld_r_date,
			:ls_r_user_id,
			:ls_r_desc,
			:ldc_r_amt,
			:ls_r_bank_code,
			:ls_r_curr,
			:ldc_r_ex_rate,
			:ls_r_cheque_no,
			:ls_r_bank_from,
			:ls_r_trn_code,
			:ld_r_clear_date,
			:ld_r_cheque_date,
			:ls_r_status );
	commit;
	if sqlca.sqlcode <> 0 then
		messagebox ("Error", "Import Error~r~n" + sqlca.sqlerrtext)
		fileclose( li_chqrmas)
		return		
	end if			
loop
fileclose (li_chqrmas)



// arfmas
hpb_import.position = 5
ll_progress = 0

li_arfmas = FileOpen( ls_farfmas)
do while true
	
	li_return = fileread( li_arfmas, ls_farfmas)
	if li_return = -100 then
		exit
	end if

	// progress 
	yield()
	ll_progress ++
	st_status.text = "Importing arfmas data ... [ " + string(ll_progress) + " ]"
	
	ls_arrdata[] = f_split_string( ls_farfmas, "|")	
	ls_f_cust_no     = ls_arrdata[1]      
	ls_f_no          = ls_arrdata[2]      
	ls_f_ref         = ls_arrdata[3]      
	ls_f_op_code     = ls_arrdata[4]      
	ld_f_date        = date(ls_arrdata[5]) 
	ls_f_user_id     = ls_arrdata[6]      
	ls_f_desc        = ls_arrdata[7]      
	ldc_f_amt        = dec(ls_arrdata[8])
	ls_f_bank_code   = ls_arrdata[9]      
	ls_f_curr        = ls_arrdata[10]      
	ldc_f_ex_rate    = dec(ls_arrdata[11])
	ls_f_cheque_no   = ls_arrdata[12]      
	ls_f_trn_code    = ls_arrdata[13]      
	ld_f_clear_date  = date(ls_arrdata[14])
	ld_f_cheque_date = date(ls_arrdata[15])
	ldc_f_bank_outch = dec(ls_arrdata[16]) 
	ldc_f_os_amt     = dec(ls_arrdata[17])
	ls_f_status      = ls_arrdata[18]      
	ld_f_touch_date  = date(ls_arrdata[19])

	ll_count = 0
	select count( f_cust_no) into :ll_count
		from temparfmas 
		where f_cust_no = :ls_f_cust_no
		and f_no = :ls_f_no
		and f_ref =:ls_f_ref
		and f_op_code =:ls_f_op_code
		and f_date =:ld_f_date;
	if ll_count > 0 then
		continue
	else
		insert into temparfmas (
				f_cust_no,
				f_no  ,
				f_ref ,
				f_op_code,
				f_date,
				f_user_id,
				f_desc,
				f_amt ,
				f_bank_code,
				f_curr,
				f_ex_rate,
				f_cheque_no,
				f_trn_code,
				f_clear_date,
				f_cheque_date,
				f_bank_outch,
				f_os_amt,
				f_status,
				f_touch_date  
				)
		values(
				:ls_f_cust_no,      
				:ls_f_no  ,      
				:ls_f_ref ,      
				:ls_f_op_code,      
				:ld_f_date,      
				:ls_f_user_id,      
				:ls_f_desc,      
				:ldc_f_amt,      
				:ls_f_bank_code,      
				:ls_f_curr,      
				:ldc_f_ex_rate,      
				:ls_f_cheque_no,      
				:ls_f_trn_code,      
				:ld_f_clear_date,      
				:ld_f_cheque_date,      
				:ldc_f_bank_outch,      
				:ldc_f_os_amt,      
				:ls_f_status,      
				:ld_f_touch_date); 	
			commit;
		if sqlca.sqlcode <> 0 then
			messagebox ("Error", "Import Error~r~n" + sqlca.sqlerrtext)
			fileclose( li_arfmas)
			return
		end if	
			
	end if			
loop
fileclose (li_arfmas)

// rcmas
hpb_import.position = 6
ll_progress = 0

li_rcmas = FileOpen( ls_frcmas)
do while true
	
	li_return = fileread( li_rcmas, ls_frcmas)
	if li_return = -100 then
		exit
	end if

	// progress 
	yield()
	ll_progress ++
	st_status.text = "Importing rcmas data ... [ " + string(ll_progress) + " ]"
	
	ls_arrdata[] = f_split_string( ls_frcmas, "|")	
	ls_r_cust_no     = ls_arrdata[1]
	ls_r_no          = ls_arrdata[2]
	ls_r_ref         = ls_arrdata[3]
	ls_r_op_code     = ls_arrdata[4]
	ld_r_date        = date(ls_arrdata[5])
	ls_r_user_id     = ls_arrdata[6]
	ls_r_desc        = ls_arrdata[7]
	ldc_r_amt        = dec(ls_arrdata[8])
	ls_r_bank_code   = ls_arrdata[9]
	ls_r_curr        = ls_arrdata[10]
	ldc_r_ex_rate    = dec(ls_arrdata[11])
	ls_r_cheque_no   = ls_arrdata[12]
	ls_r_bank_from   = ls_arrdata[13]
	ls_r_trn_code    = ls_arrdata[14]
	ld_r_clear_date  = date(ls_arrdata[15])
	ld_r_cheque_date = date(ls_arrdata[16])
	ldc_r_bank_inch  = dec(ls_arrdata[17])
	ldc_r_bank_outch = dec(ls_arrdata[18])
	ldc_r_unappl_amt = dec(ls_arrdata[19])
	ls_r_status      = ls_arrdata[20]

	ll_count = 0
	select count( r_cust_no) into :ll_count
		from temprcmas 
		where r_cust_no = :ls_r_cust_no
		and r_no = :ls_r_no
		and r_ref =:ls_f_ref
		and r_op_code =:ls_r_op_code
		and r_date =:ld_r_date;
	if ll_count > 0 then
		continue
	else
		insert into temprcmas (
				f_cust_no,
				f_no  ,
				f_ref ,
				f_op_code,
				f_date,
				f_user_id,
				f_desc,
				f_amt ,
				f_bank_code,
				f_curr,
				f_ex_rate,
				f_cheque_no,
				f_trn_code,
				f_clear_date,
				f_cheque_date,
				f_bank_outch,
				f_os_amt,
				f_status,
				f_touch_date  
				)
		values(
				:ls_f_cust_no,      
				:ls_f_no  ,      
				:ls_f_ref ,      
				:ls_f_op_code,      
				:ld_f_date,      
				:ls_f_user_id,      
				:ls_f_desc,      
				:ldc_f_amt,      
				:ls_f_bank_code,      
				:ls_f_curr,      
				:ldc_f_ex_rate,      
				:ls_f_cheque_no,      
				:ls_f_trn_code,      
				:ld_f_clear_date,      
				:ld_f_cheque_date,      
				:ldc_f_bank_outch,      
				:ldc_f_os_amt,      
				:ls_f_status,      
				:ld_f_touch_date); 	
			commit;
		if sqlca.sqlcode <> 0 then
			messagebox ("Error", "Import Error~r~n" + sqlca.sqlerrtext)
			fileclose( li_rcmas)
			return
		end if	
			
	end if			
loop
fileclose (li_rcmas)


// cnmas
hpb_import.position = 7
ll_progress = 0

li_cnmas = FileOpen( ls_fcnmas)
do while true
	
	li_return = fileread( li_cnmas, ls_fcnmas)
	if li_return = -100 then
		exit
	end if		
	
	// progress 
	yield()
	ll_progress ++
	st_status.text = "Importing cnmas data ... [ " + string(ll_progress) + " ]"
	
	ls_arrdata[] = f_split_string( ls_fcnmas, "|")	                                              
	ls_cr_cust_no    = ls_arrdata[1]
	ls_cr_no         = ls_arrdata[2]
	ls_cr_op_code    = ls_arrdata[3]
	ls_cr_curr       = ls_arrdata[4]
	ldc_cr_ex_rate   = dec(ls_arrdata[5])
	ld_cr_date       = date(ls_arrdata[6])
	ls_cr_user_id    = ls_arrdata[7]
	ls_cr_ref        = ls_arrdata[8]
	ldc_cr_amt       = dec(ls_arrdata[9])
	ls_cr_status     = ls_arrdata[10]
	ldc_cr_unappl_amt= dec(ls_arrdata[11])
	ls_cr_rem1       = ls_arrdata[12]
	ls_cr_rem2       = ls_arrdata[13]
	ls_cr_rem3       = ls_arrdata[14]
	ls_cr_rem4       = ls_arrdata[15]          

	ll_count = 0
	select count(dr_cust_no) into :ll_count
	  from tempcnmas 
	 where cr_cust_no = :ls_cr_cust_no
	   and cr_no = :ls_cr_no 
	   and cr_op_code = :ls_cr_op_code
	   and cr_date =:ld_cr_date;
	if ll_count > 0 then
		continue
	end if
	
	insert into tempcnmas (
			cr_cust_no,
			cr_no,
			cr_op_code,
			cr_curr,
			cr_ex_rate,
			cr_date,
			cr_user_id,
			cr_ref,
			cr_amt,
			cr_status,
			cr_unappl_amt,
			cr_rem1,
			cr_rem2,
			cr_rem3,       
			cr_rem4)
	values(
			:ls_cr_cust_no,
			:ls_cr_no,
			:ls_cr_op_code,
			:ls_cr_curr,
			:ldc_cr_ex_rate,
			:ld_cr_date,
			:ls_cr_user_id,
			:ls_cr_ref,
			:ldc_cr_amt,
			:ls_cr_status,
			:ldc_cr_unappl_amt,
			:ls_cr_rem1,
			:ls_cr_rem2,
			:ls_cr_rem3,
			:ls_cr_rem4);

	commit;
	if sqlca.sqlcode <> 0 then
		messagebox ("Error", "Import Error~r~n" + sqlca.sqlerrtext)
		fileclose( li_cnmas)
		return
	end if	
	
loop
fileclose (li_cnmas)

messagebox( "Import", "done !!!")	
end event

type hpb_import from hprogressbar within w_arrep07
integer x = 187
integer y = 388
integer width = 1600
integer height = 68
unsignedinteger maxposition = 100
integer setstep = 10
end type

type gb_1 from groupbox within w_arrep07
integer x = 82
integer y = 168
integer width = 1925
integer height = 536
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

