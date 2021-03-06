$PBExportHeader$w_arcn.srw
forward
global type w_arcn from w_master_1
end type
end forward

global type w_arcn from w_master_1
string tag = "m_arcn"
integer width = 2885
integer height = 1552
string title = "Credit Note"
end type
global w_arcn w_arcn

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
	ls_number = f_get_trnum( "ARCN", "NUMARCN")
	ll_row = dw_master.getrow()
	dw_master.setitem( ll_row, "cnnum", ls_number)
	dw_master.setitem( ll_row, "cnstatus", "A")
end if
f_track_record( dw_master, gd_serverdate, gs_userid)

end subroutine

public function string wf_delete ();string &
	ls_cnnum

ls_cnnum = dw_master.getitemstring( dw_master.getrow(), "cnnum")

update cnmas set cnstatus = "X"
	where cnnum = :ls_cnnum;

if sqlca.sqlcode = 0 then
	return "Receive Nomor " + ls_cnnum + " sudah dibatalkan"
else
	return sqlca.sqlerrtext
end if
end function

public function string wf_check_delete ();long &
	ll_currow
string &
	ls_cnnum, ls_cnstatus

ll_currow=dw_master.getrow()
ls_cnnum = dw_master.getitemstring( dw_master.getrow(), "cnnum")
if isnull( ls_cnnum) then
	return "Cannot Delete Record"
else
	dw_master.reselectrow( ll_currow)
	ls_cnstatus = dw_master.getitemstring( ll_currow, "cnstatus")
	if ls_cnstatus <> "A" then
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
	ls_cnnum, ls_cnstatus

ll_currow=dw_master.getrow()
ls_cnnum = dw_master.getitemstring( dw_master.getrow(), "cnnum")
if isnull( ls_cnnum) then
	return "Cannot Edit Record"
else
	dw_master.reselectrow( ll_currow)
	ls_cnstatus = dw_master.getitemstring( ll_currow, "cnstatus")
	if ls_cnstatus <> "A" then
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
	ldbl_cnamt
date &
	ld_cndate

ll_currow = dw_master.getrow()
ls_custnum = dw_master.getitemstring( ll_currow, "custnum")
if is_mode = "add" then
	ls_custnum = dw_master.getitemstring( ll_currow, "custnum")
	if isnull(ls_custnum) or trim(ls_custnum) = ""  then
		return "customer tidak boleh kosong"
	end if 
	
	ld_cndate = dw_master.getitemdate( ll_currow, "cndate")
	if isnull(ld_cndate)  then
		return "tanggal tidak boleh kosong"
	end if 
	
	ldbl_cnamt = dw_master.getitemnumber( ll_currow, "cnamt")
	if ldbl_cnamt<=0  then
		return "amount tidak boleh nol/minus"
	else
		return""
	end if 

else
	if is_mode = "edit" then
		ld_cndate = dw_master.getitemdate( ll_currow, "cndate")
		if isnull(ld_cndate)  then
			return "tanggal tidak boleh kosong"
		end if
		
		ldbl_cnamt = dw_master.getitemnumber( ll_currow, "cnamt")
		if ldbl_cnamt<=0  then
			return "amount tidak boleh nol/minus"
		else
			return ""
		end if 
		
	end if
end if 

return ""
end function

public function string wf_post_add ();dw_master.setitem(dw_master.getrow(),"cnamt",0)
return ""
end function

on w_arcn.create
int iCurrent
call super::create
end on

on w_arcn.destroy
call super::destroy
end on

type uo_buttons from w_master_1`uo_buttons within w_arcn
integer x = 46
integer y = 1088
end type

type dw_master from w_master_1`dw_master within w_arcn
string tag = "arcn"
integer y = 16
integer width = 2766
integer height = 944
string title = "Credit Note"
string dataobject = "d_cnmas"
end type

type gb_1 from w_master_1`gb_1 within w_arcn
integer y = 992
integer width = 2766
end type

