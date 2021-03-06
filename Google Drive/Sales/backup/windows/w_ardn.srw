$PBExportHeader$w_ardn.srw
forward
global type w_ardn from w_master_1
end type
end forward

global type w_ardn from w_master_1
string tag = "m_ardn"
integer width = 2949
integer height = 1516
string title = "Debit Note"
end type
global w_ardn w_ardn

forward prototypes
public subroutine wf_pre_update ()
public function string wf_delete ()
public function string wf_check_delete ()
public function string wf_check_edit ()
public function string wf_check_fields ()
public function string wf_post_add ()
end prototypes

public subroutine wf_pre_update ();long &
	ll_row
string &
	ls_number

if is_mode = "add" then
	ls_number = f_get_trnum( "ARDN", "NUMARDN")
	ll_row = dw_master.getrow()
	dw_master.setitem( ll_row, "dnnum", ls_number)
	dw_master.setitem( ll_row, "dnstatus", "A")
end if

f_track_record( dw_master, gd_serverdate, gs_userid)
end subroutine

public function string wf_delete ();string &
	ls_dnnum

ls_dnnum = dw_master.getitemstring( dw_master.getrow(), "dnnum")

update dnmas set dnstatus = "X"
	where dnnum = :ls_dnnum;

if sqlca.sqlcode = 0 then
	return "Receive Nomor " + ls_dnnum + " sudah dibatalkan"
else
	return sqlca.sqlerrtext
end if
end function

public function string wf_check_delete ();long &
	ll_currow
string &
	ls_dnnum, ls_dnstatus

ll_currow=dw_master.getrow()
ls_dnnum = dw_master.getitemstring( dw_master.getrow(), "dnnum")
if isnull( ls_dnnum) then
	return "Cannot Delete Record"
else
	dw_master.reselectrow( ll_currow)
	ls_dnstatus = dw_master.getitemstring( ll_currow, "dnstatus")
	if ls_dnstatus <> "A" then
		return "Hanya bisa menghapus data dengan status masih 'A'"
	else 
		return ""
	end if
end if
return ""

end function

public function string wf_check_edit ();long &
	ll_currow
string &
	ls_dnnum, ls_dnstatus

ll_currow=dw_master.getrow()
ls_dnnum = dw_master.getitemstring( dw_master.getrow(), "dnnum")
if isnull( ls_dnnum) then
	return "Cannot Edit Record"
else
	dw_master.reselectrow( ll_currow)
	ls_dnstatus = dw_master.getitemstring( ll_currow, "dnstatus")
	if ls_dnstatus <> "A" then
		return "Hanya bisa edit data dengan status masih 'A'"
	else 
		return ""
	end if
end if
return ""

end function

public function string wf_check_fields ();long  &
	ll_currow
string &
	ls_custnum
double &
	ldbl_dnamt
date &
	ld_dndate

ll_currow = dw_master.getrow()
ls_custnum = dw_master.getitemstring( ll_currow, "custnum")
if is_mode = "add" then
	ls_custnum = dw_master.getitemstring( ll_currow, "custnum")
	if isnull(ls_custnum) or trim(ls_custnum) = ""  then
		return "customer tidak boleh kosong"
	end if 
	
	ld_dndate = dw_master.getitemdate( ll_currow, "dndate")
	if isnull(ld_dndate)  then
		return "tanggal tidak boleh kosong"
	else
		return ""
	end if 
	
	ldbl_dnamt = dw_master.getitemnumber( ll_currow, "dnamt")
	if ldbl_dnamt<=0  then
		return "amount tidak boleh nol/minus"
	end if 
	
else
	if is_mode = "edit" then
		ld_dndate = dw_master.getitemdate( ll_currow, "dndate")
		if isnull(ld_dndate)  then
			return "tanggal tidak boleh kosong"
		end if 
		
		ldbl_dnamt = dw_master.getitemnumber( ll_currow, "dnamt")
		if ldbl_dnamt<=0 then
			return "amount tidak boleh nol/minus"
		end if 
		
	end if
end if 

return ""
end function

public function string wf_post_add ();dw_master.setitem(dw_master.getrow(),"dnamt",0)
return ""
end function

on w_ardn.create
int iCurrent
call super::create
end on

on w_ardn.destroy
call super::destroy
end on

type uo_buttons from w_master_1`uo_buttons within w_ardn
integer x = 64
integer y = 1072
end type

type dw_master from w_master_1`dw_master within w_ardn
integer x = 37
integer y = 24
integer width = 2816
integer height = 928
string dataobject = "d_dnmas"
end type

type gb_1 from w_master_1`gb_1 within w_ardn
integer x = 37
integer y = 952
integer width = 2816
end type

