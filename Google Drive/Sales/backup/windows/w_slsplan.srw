$PBExportHeader$w_slsplan.srw
forward
global type w_slsplan from w_master_detail_1
end type
end forward

global type w_slsplan from w_master_detail_1
string tag = "m_slsplan"
integer width = 3616
integer height = 2028
string title = "Planning Order"
end type
global w_slsplan w_slsplan

type variables
datawindowchild &
	idwc_subcode
end variables

forward prototypes
public function string wf_post_add ()
public subroutine wf_pre_update ()
public function string wf_check_fields ()
public function string wf_check_edit ()
public function string wf_check_delete ()
public function string wf_delete ()
end prototypes

public function string wf_post_add ();integer &
	i

for i = 1 to 10
	dw_detail.insertrow(0)
next

return ""
end function

public subroutine wf_pre_update ();long &
	ll_rowcount, n, ll_currow
string &
	ls_plan_num
	
ll_currow = dw_master.getrow()

f_track_record( dw_master, gd_serverdate, gs_userid)

if is_mode = "add" then
	ls_plan_num = f_get_trnum( "SLSPLAN", "NUMSLSPLAN")
	dw_master.setitem( ll_currow, "status", "A")
	dw_master.setitem( ll_currow, "plan_num", ls_plan_num)
end if

ll_rowcount = dw_detail.rowcount()
ls_plan_num = dw_master.getitemstring( ll_currow, "plan_num")

for n = 1 to ll_rowcount
	dw_detail.setitem( n, "plan_num", ls_plan_num)		
	dw_detail.setitem( n, "custnum", dw_detail.getitemstring(n,"custnum"))
	dw_detail.setitem( n, "subcode", dw_detail.getitemstring(n,"subcode"))
next
end subroutine

public function string wf_check_fields ();long &
	ll_currow, ll_rowcount, i, n, ll_qty, ll_row, ll_duplicate
date &
	ld_plan_dt
string &
	ls_custnum, ls_subcode

// detail check
ll_rowcount = dw_detail.rowcount()
for n = 1 to ll_rowcount
	ls_custnum = dw_detail.getitemstring( n, "custnum")
	ls_subcode = dw_detail.getitemstring( n, "subcode")
	ll_qty = dw_detail.getitemnumber( n, "qty")
	ld_plan_dt = dw_detail.getitemdate( n, "plan_det_plan_dt")

	if isnull( ls_custnum) then 
		dw_detail.deleterow( n)
		n = n - 1
		ll_rowcount = ll_rowcount - 1
	else
		if ll_qty <= 0 then			
			return  "Quantity tidak boleh Nol atau Minus"
			exit
		end if
		
		if isnull( ld_plan_dt) then
			return "Tanggal Planning Order tidak boleh kosong"
		end if
	
		// check for duplicate subcode
		ll_duplicate = 0
		for i = 1 to ll_rowcount
			if ls_subcode = dw_detail.getitemstring( i, "subcode") &
				and ls_custnum = dw_detail.getitemstring( i, "custnum") &
				and ld_plan_dt = dw_detail.getitemdate( i, "plan_det_plan_dt") then
				ll_duplicate ++
			end if
			
			if ll_duplicate > 1 then
				// duplicate found
				return "Duplicate subdept number found!"
			end if			
		next
	end if
next

return ""

end function

public function string wf_check_edit ();string &
	ls_status, ls_plan_num

ls_plan_num = dw_master.getitemstring( dw_master.getrow(), "plan_num")

setnull( ls_status)
select status into :ls_status
	from plan_hdr 
	where plan_num = :ls_plan_num;

if isnull(ls_plan_num) or (ls_plan_num)="" then
	return "Cannot Edit Record"
end if

if ls_status = "P" then
	return "Tidak bisa edit data yang sudah di print"
else
	return ""	
end if
	

end function

public function string wf_check_delete ();string &
	ls_status, ls_plan_num

ls_plan_num = dw_master.getitemstring( dw_master.getrow(), "plan_num")

setnull( ls_status)
select status into :ls_status
	from plan_hdr 
	where plan_num = :ls_plan_num;

if isnull(ls_plan_num) or (ls_plan_num)="" then
	return "Cannot Delete Record"
end if

if ls_status = "X" then
	return "Tidak bisa hapus data yang sudah di hapus"
else
	return ""	
end if
	

end function

public function string wf_delete ();string &
	ls_status, ls_plan_num

ls_plan_num = dw_master.getitemstring( dw_master.getrow(), "plan_num")

update plan_hdr set status = "X" 
	where plan_num = :ls_plan_num;
if sqlca.sqlcode = 0 then
	delete from plan_det where plan_num = :ls_plan_num;
	if sqlca.sqlcode = 0 then
		dw_detail.reset()
		return "Data Nomor " + trim( ls_plan_num) + " telah dihapus"		
	end if
else
	return ""
end if

	

end function

on w_slsplan.create
int iCurrent
call super::create
end on

on w_slsplan.destroy
call super::destroy
end on

event ue_retrieve_detail;call super::ue_retrieve_detail;string &
	ls_plan_num
long &
	ll_row

ll_row = message.longparm

if is_mode = "display" and ib_query = false then
	if dw_master.rowcount() > 0 then
		ls_plan_num = dw_master.getitemstring( ll_row, "plan_num")
		dw_detail.retrieve( ls_plan_num)
	end if
end if
end event

event open;call super::open;dw_detail.getchild( "custmast_custname", idwc_subcode)
idwc_subcode.settransobject( sqlca)

end event

event ue_print;call super::ue_print;string &
	ls_plan_num, ls_print_by, ls_printer
integer &
	li_print_conf
w_report_viewer &
	lw_report_viewer
s_report_viewer &
	lstr_report_viewer
datastore &
	lds_report

ls_plan_num = dw_master.getitemstring( dw_master.getrow(), "plan_num")

li_print_conf= messagebox( "Print", "Print preview?", &
	exclamation!,yesno!)
	
lds_report = create datastore
lds_report.dataobject = "d_slsplan_print"
lds_report.settransobject( sqlca)
lds_report.retrieve( ls_plan_num)
lds_report.object.t_print_by.text = f_print_by ( gs_userid, gdt_serverdatetime)
lstr_report_viewer.title = "Sales Discount Memo"

if li_print_conf = 1 then
	lds_report.getfullstate( lstr_report_viewer.dwdata)
	destroy lds_report
	opensheetwithparm( lw_report_viewer, lstr_report_viewer, w_main, 0, layered!)	
	lw_report_viewer.cb_print.visible = false
else
	lds_report.print( )

	update plan_hdr set status = 'P' 
		where plan_num = :ls_plan_num;
	commit;
	dw_master.setitem( dw_master.getrow(), "status", "P")

	if sqlca.sqlcode <> 0 then
		messagebox( "Update", "Update Status Error")
	end if
	
	ls_printer = lds_report.describe( "datawindow.printer")
	messagebox( "Print", ls_plan_num + " Printed to printer : " + ls_printer)	

end if




end event

type cb_deleterow from w_master_detail_1`cb_deleterow within w_slsplan
integer x = 1879
integer y = 1748
end type

type cb_insertrow from w_master_detail_1`cb_insertrow within w_slsplan
integer x = 1879
integer y = 1636
end type

type uo_buttons from w_master_detail_1`uo_buttons within w_slsplan
integer x = 18
integer y = 1628
end type

type dw_detail from w_master_detail_1`dw_detail within w_slsplan
event ue_test pbm_dwnitemchange
integer x = 37
integer width = 3538
integer height = 960
string dataobject = "d_slsplandet"
end type

event dw_detail::itemchanged;call super::itemchanged;string &
	ls_custnum
long &
	ll_row
	
choose case dwo.name 
	case "custmast_custname"
		ll_row = idwc_subcode.getrow( )		
		dw_detail.setitem( row, "custnum", &
			idwc_subcode.getitemstring( ll_row, "custmast_custnum"))
		dw_detail.setitem( row, "subcode", &
			idwc_subcode.getitemstring( ll_row, "subdept_subcode"))
		dw_detail.setitem( row, "subdept_subdesc", &
			idwc_subcode.getitemstring( ll_row, "subdept_subdesc"))
end choose
end event

type dw_master from w_master_detail_1`dw_master within w_slsplan
integer width = 2597
integer height = 532
string dataobject = "d_slsplanhdr"
end type

type gb_1 from w_master_detail_1`gb_1 within w_slsplan
integer y = 1572
integer width = 3296
end type

type gb_2 from w_master_detail_1`gb_2 within w_slsplan
integer y = 560
integer width = 3296
end type

