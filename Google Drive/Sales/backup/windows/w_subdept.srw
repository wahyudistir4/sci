$PBExportHeader$w_subdept.srw
forward
global type w_subdept from w_master_1
end type
type cb_browse from commandbutton within w_subdept
end type
end forward

global type w_subdept from w_master_1
string tag = "m_subdept"
integer width = 2610
integer height = 1692
string title = "Subdept"
cb_browse cb_browse
end type
global w_subdept w_subdept

forward prototypes
public subroutine wf_pre_update ()
public function string wf_check_delete ()
public function string wf_check_edit ()
public function string wf_check_fields ()
public function string wf_post_edit ()
public function string wf_post_add ()
end prototypes

public subroutine wf_pre_update ();f_track_record( dw_master, gd_serverdate, gs_userid)
end subroutine

public function string wf_check_delete ();long &
	ll_currow
string &
	ls_custnum

ll_currow=dw_master.getrow()
ls_custnum = dw_master.getitemstring( dw_master.getrow(), "custnum")
if isnull( ls_custnum) then
	return "Cannot Delete Record"
else
	return "Edit Only"
end if
return ""

end function

public function string wf_check_edit ();long &
	ll_currow
string &
	ls_custnum

ll_currow=dw_master.getrow()
ls_custnum = dw_master.getitemstring( dw_master.getrow(), "custnum")
if isnull( ls_custnum) then
	return "Cannot Edit Record"
end if

return ""

end function

public function string wf_check_fields ();long  &
	ll_currow
string &
	ls_custnum, ls_subcode, ls_subcode1, &
	ls_subdesc, ls_kota, ls_area

ll_currow = dw_master.getrow()
ls_custnum = dw_master.getitemstring( ll_currow, "custnum")
ls_subcode = dw_master.getitemstring( ll_currow, "subcode")
if isnull( ls_custnum) then
	return "Code tidak boleh kosong"
else
	if is_mode = "add"  then
		setnull( ls_subcode1)
		select subcode into :ls_subcode1
			from subdept
			where custnum = :ls_custnum
			and   subcode = :ls_subcode;
		if not isnull( ls_subcode1) then 
			return "Code sudah ada"
		end if 
		
		ls_subcode = dw_master.getitemstring( ll_currow, "subcode")
		if isnull(ls_subcode) or trim(ls_subcode) = ""  then
			return "code tidak boleh kosong"
		end if 
		
		ls_subdesc = dw_master.getitemstring( ll_currow, "subdesc")
		if isnull(ls_subdesc) or trim(ls_subdesc) = ""  then
			return "nama tidak boleh kosong"
		end if 
		
		ls_kota = dw_master.getitemstring( ll_currow, "city")
		if isnull(ls_kota) or trim(ls_kota) = ""  then
			return "Kota tidak boleh kosong"
		end if 
		
		ls_area = dw_master.getitemstring( ll_currow, "area")
		if isnull(ls_area) or trim(ls_area) = ""  then
			return "Propinsi tidak boleh kosong"
		end if 
		
		if left(ls_subcode,2) <> "XJ" then
			return "Peng-kode-an subdept harus :  'XJ' + initial nama + nomor urut"
		end if
		
	else
		if is_mode = "edit" then
			ls_subcode = dw_master.getitemstring( ll_currow, "subcode")
			if isnull(ls_subcode) or trim(ls_subcode) = ""  then
				return "code tidak boleh kosong"
			end if 
			
			ls_subdesc = dw_master.getitemstring( ll_currow, "subdesc")
			if isnull(ls_subdesc) or trim(ls_subdesc) = ""  then
				return "nama tidak boleh kosong"
			end if 
			
			ls_kota = dw_master.getitemstring( ll_currow, "city")
			if isnull(ls_kota) or trim(ls_kota) = ""  then
				return "Kota tidak boleh kosong"
			end if 
			
		end if 
	end if 
end if 

return ""
end function

public function string wf_post_edit ();dw_master.modify("custnum.protect=1")
dw_master.modify("subcode.protect=1")
dw_master.modify("subdesc.protect=1")
return ""
end function

public function string wf_post_add ();dw_master.setitem( dw_master.getrow(), "status", "1")
return ""
end function

on w_subdept.create
int iCurrent
call super::create
this.cb_browse=create cb_browse
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_browse
end on

on w_subdept.destroy
call super::destroy
destroy(this.cb_browse)
end on

type uo_buttons from w_master_1`uo_buttons within w_subdept
integer y = 1260
end type

type dw_master from w_master_1`dw_master within w_subdept
integer x = 46
integer y = 24
integer width = 2478
integer height = 1128
string dataobject = "d_subdept"
end type

type gb_1 from w_master_1`gb_1 within w_subdept
integer x = 46
integer y = 1152
integer width = 2405
end type

type cb_browse from commandbutton within w_subdept
integer x = 1874
integer y = 1264
integer width = 553
integer height = 100
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Browse Customer"
end type

event clicked;open( w_browse_customer)
end event

