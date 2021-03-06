$PBExportHeader$w_itemast.srw
forward
global type w_itemast from w_master_1
end type
end forward

global type w_itemast from w_master_1
string tag = "m_itemast"
integer width = 2057
integer height = 1356
string title = "Item Maintenance"
end type
global w_itemast w_itemast

forward prototypes
public subroutine wf_pre_update ()
public function string wf_post_edit ()
public function string wf_check_delete ()
public function string wf_check_edit ()
public function string wf_check_fields ()
public function string wf_post_add ()
end prototypes

public subroutine wf_pre_update ();f_track_record( dw_master, gd_serverdate, gs_userid)
end subroutine

public function string wf_post_edit ();dw_master.modify( "icode.protect=1")
return ""
end function

public function string wf_check_delete ();long &
	ll_currow
string &
	ls_icode

ll_currow=dw_master.getrow()
ls_icode = dw_master.getitemstring( dw_master.getrow(), "icode")
if isnull( ls_icode) then
	return "Cannot Delete Record"
else
	return "Edit Only"
end if
return ""

end function

public function string wf_check_edit ();long &
	ll_currow
string &
	ls_icode

ll_currow=dw_master.getrow()
ls_icode = dw_master.getitemstring( dw_master.getrow(), "icode")
if isnull( ls_icode) then
	return "Data Tidak Boleh Kosong"
end if
return ""

end function

public function string wf_check_fields ();long  &
	ll_currow
string &
	ls_icode, ls_icode1, ls_desc, &
	ls_umeas, ls_itemtype
double &
	ldbl_upmeas

ll_currow = dw_master.getrow()
ls_icode = dw_master.getitemstring( ll_currow, "icode")
if isnull( ls_icode) or (ls_icode)="" then
	return "Code tidak boleh kosong"
else
	if is_mode = "add"  then
		setnull( ls_icode1)
		select icode into :ls_icode1
			from itemast
			where icode = :ls_icode;
		if not isnull( ls_icode1) then 
			return "Item Code sudah ada"
		end if 
		
		ls_desc = dw_master.getitemstring( ll_currow, "desc")
		if isnull(ls_desc) or trim(ls_desc) = ""  then
			return "Description tidak boleh kosong"
		end if 
		
		ls_umeas = dw_master.getitemstring( ll_currow, "umeas")
		if isnull(ls_umeas) or trim(ls_umeas) = ""  then
			return "UOM tidak boleh kosong"
		end if 
		
		ldbl_upmeas = dw_master.getitemnumber( ll_currow, "upmeas")
		if ldbl_upmeas <= 0 then
			return "Unit/Meas tidak boleh nol/minus"
		end if 
		
		ls_itemtype = dw_master.getitemstring( ll_currow, "itemtype")
		if isnull(ls_itemtype) or trim(ls_itemtype) = ""  then
			return "type tidak boleh kosong"
		end if 
		
	else
		if is_mode = "edit" then
			ls_icode = dw_master.getitemstring( ll_currow, "icode")
			if isnull(ls_icode) or trim(ls_icode) = ""  then
				return "Item Code tidak boleh kosong"
			end if 
			
			ls_desc = dw_master.getitemstring( ll_currow, "desc")
			if isnull(ls_desc) or trim(ls_desc) = ""  then
				return "Description tidak boleh kosong"
			end if 
			
			ls_umeas = dw_master.getitemstring( ll_currow, "umeas")
			if isnull(ls_umeas) or trim(ls_umeas) = ""  then
				return "UOM tidak boleh kosong"
			end if
			
			ldbl_upmeas = dw_master.getitemnumber( ll_currow, "upmeas")
			if ldbl_upmeas <= 0  then
				return "Unit/Meas tidak boleh nol/minus"
			end if 
		
			ls_itemtype = dw_master.getitemstring( ll_currow, "itemtype")
			if isnull(ls_itemtype) or trim(ls_itemtype) = ""  then
				return "type tidak boleh kosong"
			end if 
		
		end if 
	end if 
end if 

return ""
end function

public function string wf_post_add ();dw_master.setitem(dw_master.getrow(),"upmeas",0)
return ""
end function

on w_itemast.create
int iCurrent
call super::create
end on

on w_itemast.destroy
call super::destroy
end on

type uo_buttons from w_master_1`uo_buttons within w_itemast
integer x = 46
integer y = 876
end type

type dw_master from w_master_1`dw_master within w_itemast
integer x = 32
integer y = 16
integer width = 1929
integer height = 800
string dataobject = "d_itemast"
end type

type gb_1 from w_master_1`gb_1 within w_itemast
integer x = 32
integer y = 808
integer width = 1929
end type

