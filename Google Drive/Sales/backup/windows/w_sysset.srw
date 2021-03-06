$PBExportHeader$w_sysset.srw
forward
global type w_sysset from w_master_1
end type
end forward

global type w_sysset from w_master_1
string tag = "m_sysset"
integer width = 2747
integer height = 1308
string title = "System Setting"
end type
global w_sysset w_sysset

forward prototypes
public subroutine wf_pre_update ()
public function string wf_check_fields ()
public function string wf_post_edit ()
end prototypes

public subroutine wf_pre_update ();f_track_record( dw_master, gd_serverdate, gs_userid)
end subroutine

public function string wf_check_fields ();string &
	ls_moducd, ls_settype
long &
	ll_row, ll_count


ll_row = dw_master.getrow()
ls_moducd = dw_master.getitemstring( ll_row, "moducd")
ls_settype = dw_master.getitemstring( ll_row, "settype")

setnull( ll_count)
select count(*) into :ll_count
	from sysset
	where moducd = :ls_moducd 
		and settype = :ls_settype;
if is_mode = "add" and ll_count >= 1 then
	return "Module ID " + trim( ls_moducd) +&
		", dengan type " + trim( ls_settype) + " sudah ada"
end if

return ""
end function

public function string wf_post_edit ();dw_master.object.moducd.protect = 1
dw_master.object.settype.protect = 1
return ""
end function

on w_sysset.create
int iCurrent
call super::create
end on

on w_sysset.destroy
call super::destroy
end on

type uo_buttons from w_master_1`uo_buttons within w_sysset
integer x = 32
integer y = 916
end type

type dw_master from w_master_1`dw_master within w_sysset
integer width = 2642
integer height = 856
string dataobject = "d_sysset"
end type

type gb_1 from w_master_1`gb_1 within w_sysset
integer x = 46
integer y = 868
integer width = 2601
end type

