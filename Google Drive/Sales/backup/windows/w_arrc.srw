$PBExportHeader$w_arrc.srw
forward
global type w_arrc from w_master_1
end type
type cb_arrcexport from commandbutton within w_arrc
end type
type cb_import from commandbutton within w_arrc
end type
end forward

global type w_arrc from w_master_1
string tag = "m_arrc"
integer width = 3090
integer height = 1728
string title = "Receive Payment"
cb_arrcexport cb_arrcexport
cb_import cb_import
end type
global w_arrc w_arrc

forward prototypes
public subroutine wf_pre_update ()
public function string wf_delete ()
public function string wf_check_delete ()
public function string wf_check_edit ()
public function string wf_check_fields ()
public function string wf_post_add ()
end prototypes

public subroutine wf_pre_update ();long &
	ll_row, ll_currow
string &
	ls_number,ls_rcnum
	

if is_mode = "add" then
	ls_number = f_get_trnum( "ARRC", "NUMARRC")
	ll_row = dw_master.getrow()
	dw_master.setitem( ll_row, "rcnum", ls_number)
	dw_master.setitem( ll_row, "rcstatus", "A")
end if

if is_mode = "edit" then
  ll_currow=dw_master.getrow()
  ls_rcnum = trim(dw_master.getitemstring( dw_master.getrow(), "rcnum"))
	update rcmas set is_exprt='0' where rcnum =:ls_rcnum;
   commit;

end if


f_track_record( dw_master, gd_serverdate, gs_userid)
end subroutine

public function string wf_delete ();string &
	ls_rcnum

ls_rcnum = dw_master.getitemstring( dw_master.getrow(), "rcnum")

update rcmas set rcstatus = "X"
	where rcnum = :ls_rcnum;

if sqlca.sqlcode = 0 then
	return "Receive Nomor " + ls_rcnum + " sudah dibatalkan"
else
	return sqlca.sqlerrtext
end if
end function

public function string wf_check_delete ();long &
	ll_currow
string &
	ls_rcnum, ls_rcstatus

ll_currow=dw_master.getrow()
ls_rcnum = dw_master.getitemstring( dw_master.getrow(), "rcnum")
if isnull( ls_rcnum) then
	return "Cannot Delete Record"
else
	dw_master.reselectrow( ll_currow)
	ls_rcstatus = dw_master.getitemstring( ll_currow, "rcstatus")
	if ls_rcstatus <> "A" then
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
	ls_rcnum, ls_rcstatus

ll_currow=dw_master.getrow()
ls_rcnum = dw_master.getitemstring( dw_master.getrow(), "rcnum")
if isnull( ls_rcnum) then
	return "Cannot Edit Record"
else
	dw_master.reselectrow( ll_currow)
	ls_rcstatus = dw_master.getitemstring( ll_currow, "rcstatus")
	if ls_rcstatus <> "A" then
		return "Hanya bisa edit data dengan status masih 'A'"
	else 
		return ""
	end if
end if
return ""

end function

public function string wf_check_fields ();long  &
	ll_currow, ll_jml
string &
	ls_custnum, ls_rcref,ls_tmpcustnum, ls_blist,ls_custname
double &
	ldbl_rcamt
date &
	ld_rcdate, ld_tmprcdate

ll_currow = dw_master.getrow()
ls_custnum = dw_master.getitemstring( ll_currow, "custnum")
if is_mode = "add" then
	ls_custnum = dw_master.getitemstring( ll_currow, "custnum")
	if isnull(ls_custnum) or trim(ls_custnum) = ""  then
		return "customer tidak boleh kosong"
	end if 

	ls_rcref = trim(dw_master.getitemstring( ll_currow, "rcref")	)
	select custnum,rcdate,count(*) 
		into : ls_tmpcustnum, :ld_tmprcdate, :ll_jml
	from rcmas 
	where rcref =:ls_rcref
	group by custnum,rcdate;
	
	if ll_jml > 0 then
		return "No TTS sudah pernah di inputkan ~r~nNo.Cust :  " +ls_tmpcustnum + &
				  "~r~nTanggal :  " + string( ld_tmprcdate, "dd/mm/yyyy")
	end if 
	
	select blist, custname
	into :ls_blist, :ls_custname
	from custmast
	where custnum = :ls_custnum;

	if upper(ls_blist) ='Y' then
		return "Customer : " + trim(ls_custname) + " dalam Black List"
	end if
	
	ld_rcdate = dw_master.getitemdate( ll_currow, "rcdate")
	if isnull(ld_rcdate)  then
		return "tanggal tidak boleh kosong"
	end if 
		
	ldbl_rcamt = dw_master.getitemnumber( ll_currow, "rcamt")
	if ldbl_rcamt<=0  then
		return "amount tidak boleh nol/minus"
	end if 
	
else
	if is_mode = "edit" then
		ld_rcdate = dw_master.getitemdate( ll_currow, "rcdate")
		if isnull(ld_rcdate)  then
			return "tanggal tidak boleh kosong"
		end if 
	
		ldbl_rcamt = dw_master.getitemnumber( ll_currow, "rcamt")
		if ldbl_rcamt <=0 then
			return "amount tidak boleh nol/minus"
		end if 
		
	end if
end if 

return ""
end function

public function string wf_post_add ();dw_master.setitem(dw_master.getrow(),"rcamt",0)
return ""
end function

on w_arrc.create
int iCurrent
call super::create
this.cb_arrcexport=create cb_arrcexport
this.cb_import=create cb_import
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_arrcexport
this.Control[iCurrent+2]=this.cb_import
end on

on w_arrc.destroy
call super::destroy
destroy(this.cb_arrcexport)
destroy(this.cb_import)
end on

event open;call super::open;if gs_userid <> 'dba' then
	cb_import.visible = false
end if
end event

type uo_buttons from w_master_1`uo_buttons within w_arrc
integer x = 64
integer y = 1276
end type

type dw_master from w_master_1`dw_master within w_arrc
integer x = 27
integer y = 32
integer width = 2962
integer height = 1168
string dataobject = "d_rcmas"
end type

type gb_1 from w_master_1`gb_1 within w_arrc
integer x = 27
integer y = 1196
integer width = 2962
end type

type cb_arrcexport from commandbutton within w_arrc
integer x = 2464
integer y = 1284
integer width = 549
integer height = 112
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Exp. Rec. Payment"
end type

event clicked;open(w_arrcexport)
end event

type cb_import from commandbutton within w_arrc
integer x = 2469
integer y = 1424
integer width = 558
integer height = 120
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Imp. Rec. Payment"
end type

event clicked;open(w_arrep09)
end event

