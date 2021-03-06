$PBExportHeader$w_supplier.srw
forward
global type w_supplier from w_master_1
end type
end forward

global type w_supplier from w_master_1
string tag = "m_supplier"
integer width = 2071
integer height = 1156
string title = "Supplier"
end type
global w_supplier w_supplier

forward prototypes
public subroutine wf_pre_update ()
public function string wf_post_edit ()
public function string wf_check_delete ()
public function string wf_check_edit ()
public function string wf_check_fields ()
end prototypes

public subroutine wf_pre_update ();f_track_record( dw_master, gd_serverdate, gs_userid)
end subroutine

public function string wf_post_edit ();dw_master.modify( "scode.protect=1")
return ""
end function

public function string wf_check_delete ();long &
	ll_currow
string &
	ls_scode

ll_currow=dw_master.getrow()
ls_scode = dw_master.getitemstring( dw_master.getrow(), "scode")
if isnull( ls_scode) then
	return "Cannot Delete Record"
else
	return "Edit Only"
end if
return ""

end function

public function string wf_check_edit ();long &
	ll_currow
string &
	ls_scode

ll_currow=dw_master.getrow()
ls_scode = dw_master.getitemstring( dw_master.getrow(), "scode")
if isnull( ls_scode) then
	return "Data Tidak Boleh Kosong"
end if
return ""
end function

public function string wf_check_fields ();long  &
	ll_currow
string &
	ls_scode, ls_scode1, ls_sname

ll_currow = dw_master.getrow()
ls_scode = dw_master.getitemstring( ll_currow, "scode")
if isnull( ls_scode) or (ls_scode)="" then
	return "Code tidak boleh kosong"
else
	if is_mode = "add"  then
		setnull( ls_scode1)
		select scode into :ls_scode1
			from supmast
			where scode = :ls_scode;
		if not isnull( ls_scode1) then 
			return "Code sudah ada"
		end if 
		
		ls_sname = dw_master.getitemstring( ll_currow, "sname")
		if isnull(ls_sname) or trim(ls_sname) = ""  then
			return "nama tidak boleh kosong"
		end if 
					
	else
		if is_mode = "edit" then
			ls_scode = dw_master.getitemstring( ll_currow, "scode")
			if isnull(ls_scode) or trim(ls_scode) = ""  then
				return "code tidak boleh kosong"
			end if 
			
			ls_sname = dw_master.getitemstring( ll_currow, "sname")
			if isnull(ls_sname) or trim(ls_sname) = ""  then
				return "nama tidak boleh kosong"
			end if 
					
		end if 
	end if 
end if 

return ""
end function

on w_supplier.create
int iCurrent
call super::create
end on

on w_supplier.destroy
call super::destroy
end on

type uo_buttons from w_master_1`uo_buttons within w_supplier
integer x = 55
integer y = 740
end type

type dw_master from w_master_1`dw_master within w_supplier
integer x = 37
integer y = 32
integer width = 1902
integer height = 628
string dataobject = "d_supplier"
end type

type gb_1 from w_master_1`gb_1 within w_supplier
integer x = 46
integer y = 676
integer width = 1856
end type

