$PBExportHeader$w_area.srw
forward
global type w_area from w_master_1
end type
end forward

global type w_area from w_master_1
integer width = 2272
integer height = 844
string title = "Area"
end type
global w_area w_area

forward prototypes
public function string wf_check_delete ()
public function string wf_check_edit ()
public function string wf_check_fields ()
public function string wf_delete ()
public function string wf_post_add ()
public function string wf_post_edit ()
public subroutine wf_pre_update ()
end prototypes

public function string wf_check_delete ();long &
	ll_currow
string &
	ls_areanum, ls_areastat

ll_currow=dw_master.getrow()
ls_areanum = dw_master.getitemstring( dw_master.getrow(), "areanum")
if isnull( ls_areanum) then
	return "Cannot Delete Record"
else
	dw_master.reselectrow( ll_currow)
	ls_areastat = dw_master.getitemstring( ll_currow, "areastat")
	if ls_areastat <> "A" then
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
	ls_areanum, ls_areastat

ll_currow=dw_master.getrow()
ls_areanum = dw_master.getitemstring( dw_master.getrow(), "areanum")
if isnull( ls_areanum) then
	return "Cannot Edit Record"
else
	dw_master.reselectrow( ll_currow)
	ls_areastat = dw_master.getitemstring( ll_currow, "areastat")
	if ls_areastat <> "A" then
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
	ls_areanum, ls_areanum1, ls_areadesc

ll_currow = dw_master.getrow()
ls_areanum = dw_master.getitemstring( ll_currow, "areanum")
if isnull( ls_areanum) then
	return "Code tidak boleh kosong"
else
	if is_mode = "add"  then
		setnull( ls_areanum1)
		select areanum into :ls_areanum1
		from area
		where areanum = :ls_areanum;
		if not isnull( ls_areanum1) then 
			return "Code sudah ada"
		end if 
	else
		if is_mode = "edit" then
			ls_areadesc = dw_master.getitemstring( ll_currow, "areadesc")
				if isnull(ls_areadesc) or trim(ls_areadesc) = ""  then
				return "nama tidak boleh kosong"
			end if 
		end if 
	end if 
end if 

return ""
end function

public function string wf_delete ();string &
	ls_areanum,ls_areastat 
long &
	ll_row, i
	
ll_row = dw_master.getrow()
ls_areanum = dw_master.getitemstring( dw_master.getrow(),"areanum")
select areastat into :ls_areastat
	from area
	where areanum = :ls_areanum;
if trim(ls_areastat ) = "A" then
	update area set areastat = "X" where areanum = :ls_areanum and areastat="A";
	dw_master.setitem( ll_row, "areastat", "X")		
	return "Code : " + trim(ls_areanum) + " telah dihapus"
else
	dw_master.reselectrow( ll_row)
	return ""
end if
end function

public function string wf_post_add ();long &
	ll_row, i
	
ll_row = dw_master.getrow()
dw_master.setitem( ll_row, "areastat", "A")
return ""
end function

public function string wf_post_edit ();dw_master.modify( "areanum.protect=1")
return ""
end function

public subroutine wf_pre_update ();f_track_record( dw_master, gd_serverdate, gs_userid)
end subroutine

on w_area.create
int iCurrent
call super::create
end on

on w_area.destroy
call super::destroy
end on

type uo_buttons from w_master_1`uo_buttons within w_area
integer y = 460
end type

type dw_master from w_master_1`dw_master within w_area
integer x = 18
integer width = 1998
integer height = 372
string dataobject = "d_area"
end type

type gb_1 from w_master_1`gb_1 within w_area
integer y = 416
integer width = 2098
end type

