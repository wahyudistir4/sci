$PBExportHeader$w_customer.srw
forward
global type w_customer from w_master_1
end type
type cb_view from commandbutton within w_customer
end type
type cb_import from commandbutton within w_customer
end type
end forward

global type w_customer from w_master_1
string tag = "m_customer"
integer width = 2894
integer height = 1784
string title = "Customer"
cb_view cb_view
cb_import cb_import
end type
global w_customer w_customer

forward prototypes
public subroutine wf_pre_update ()
public function string wf_post_edit ()
public function string wf_check_delete ()
public function string wf_check_edit ()
public function string wf_check_fields ()
public function string wf_post_add ()
public function string wf_delete ()
end prototypes

public subroutine wf_pre_update ();f_track_record( dw_master, gd_serverdate, gs_userid)
end subroutine

public function string wf_post_edit ();dw_master.modify( "custstat.protect=1")
dw_master.modify( "custnum.protect=1")
dw_master.modify( "custname.protect=1")
return ""
end function

public function string wf_check_delete ();long &
	ll_currow
string &
	ls_custnum, ls_custstat

ll_currow=dw_master.getrow()
ls_custnum = dw_master.getitemstring( dw_master.getrow(), "custnum")
if isnull( ls_custnum) then
	return "Cannot Delete Record"
else
	dw_master.reselectrow( ll_currow)
	ls_custstat = dw_master.getitemstring( ll_currow, "custstat")
	if ls_custstat <> "1" then
		return "Hanya bisa menghapus data dengan status masih Active"
	else 
		return ""
	end if
end if
return ""

end function

public function string wf_check_edit ();long &
	ll_currow
string &
	ls_custnum, ls_custstat

ll_currow=dw_master.getrow()
ls_custnum = dw_master.getitemstring( dw_master.getrow(), "custnum")
if isnull( ls_custnum) then
	return "Cannot Edit Record"
else
	dw_master.reselectrow( ll_currow)
	ls_custstat = dw_master.getitemstring( ll_currow, "custstat")
	if ls_custstat <> "1" then
		return "Hanya bisa edit data dengan status masih Active"
	else 
		return ""
	end if
end if
return ""

end function

public function string wf_check_fields ();long  &
	ll_currow
string &
	ls_custnum, ls_custnum1, ls_custname, &
	ls_op_in,ls_kota,ls_area
	

ll_currow = dw_master.getrow()
ls_custnum = dw_master.getitemstring( ll_currow, "custnum")
if isnull( ls_custnum) then
	return "Code tidak boleh kosong"
else
	if is_mode = "add"  then
		setnull( ls_custnum1)
		select custnum into :ls_custnum1
			from custmast
			where custnum = :ls_custnum;
		if not isnull( ls_custnum1) then 
			return "Code sudah ada"
		end if 
		
		ls_custname = dw_master.getitemstring( ll_currow, "custname")
		if isnull(ls_custname) or trim(ls_custname) = ""  then
			return "nama tidak boleh kosong"
		end if 
		
		ls_kota = dw_master.getitemstring( ll_currow, "city")
		if isnull(ls_kota) or trim(ls_kota) = ""  then
			return "Kota tidak boleh kosong"
		end if 
		
		ls_area = dw_master.getitemstring( ll_currow, "area")
		if isnull(ls_area) or trim(ls_area) = ""  then
			return "Area tidak boleh kosong"
		end if 
		
		ls_op_in = dw_master.getitemstring( ll_currow, "op_in")
		if isnull(ls_op_in) or trim(ls_op_in) = ""  then
			return "status tidak boleh kosong"
		end if 
		
	else
		if is_mode = "edit" then
			ls_custname = dw_master.getitemstring( ll_currow, "custname")
			if isnull(ls_custname) or trim(ls_custname) = ""  then
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

public function string wf_post_add ();long &
	ll_row, i
	
ll_row = dw_master.getrow()
dw_master.setitem( ll_row, "custstat", "1")
return ""
end function

public function string wf_delete ();string &
	ls_custnum,ls_custstat 
long &
	ll_row, i
	
ll_row = dw_master.getrow()
ls_custnum = dw_master.getitemstring( dw_master.getrow(),"custnum")
select custstat into :ls_custstat
	from custmast
	where custnum = :ls_custnum;
if trim(ls_custstat ) = "1" then
	update custmast set custstat = "2" where custnum = :ls_custnum and custstat="1";
	dw_master.setitem( ll_row, "custstat", "2")		
	return "Code : " + trim(ls_custnum) + " telah dihapus"
else
	dw_master.reselectrow( ll_row)
	return ""
end if
end function

on w_customer.create
int iCurrent
call super::create
this.cb_view=create cb_view
this.cb_import=create cb_import
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_view
this.Control[iCurrent+2]=this.cb_import
end on

on w_customer.destroy
call super::destroy
destroy(this.cb_view)
destroy(this.cb_import)
end on

event ue_print;call super::ue_print;string &
	ls_custnum, ls_custname
datastore &
	lds_report_viewer
s_report_viewer &
	lstr_report_viewer
w_report_viewer &
	lw_report_viewer

ls_custnum = dw_master.getitemstring (dw_master.getrow(),"custnum")
if isnull (ls_custnum) or (ls_custnum)="" then
	messagebox ("Customer History","Pilih data dahulu!!")
	return
end if


// generate report
lds_report_viewer = create datastore
lds_report_viewer.dataobject = "d_arcusthist_print"
lds_report_viewer.settransobject( sqlca)
lds_report_viewer.retrieve( ls_custnum)
lstr_report_viewer.title = "Customer History"
lds_report_viewer.object.t_company.text = trim(gs_company_name)
lds_report_viewer.object.t_print_by.text = f_print_by (gs_userid,gdt_serverdatetime)
lds_report_viewer.getfullstate( lstr_report_viewer.dwdata)
destroy lds_report_viewer
opensheetwithparm( lw_report_viewer, lstr_report_viewer, w_main, 0, layered!)	


end event

event open;call super::open;if gs_userid <> 'dba' then
	cb_import.visible = false
end if
end event

type uo_buttons from w_master_1`uo_buttons within w_customer
integer x = 55
integer y = 1328
end type

type dw_master from w_master_1`dw_master within w_customer
integer x = 27
integer y = 16
integer width = 2779
integer height = 1224
string dataobject = "d_custmast"
end type

type gb_1 from w_master_1`gb_1 within w_customer
integer x = 27
integer y = 1240
integer width = 2779
end type

type cb_view from commandbutton within w_customer
integer x = 1897
integer y = 1332
integer width = 773
integer height = 96
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "View/Edit Customer History"
end type

event clicked;string &
	ls_custnum, ls_custstat

ls_custstat = dw_master.getitemstring (dw_master.getrow(),"custstat")
if (ls_custstat) = "2" then
	messagebox("Customer History","Status Customer tidak aktif")
	return
end if

ls_custnum = dw_master.getitemstring(dw_master.getrow(), "custnum")
if isnull(ls_custnum) or (ls_custnum) = "" then
	messagebox ("Customer History","Harus pilih data dahulu")
	return
end if

openwithparm(w_arcusthist, ls_custnum)
end event

type cb_import from commandbutton within w_customer
integer x = 1897
integer y = 1460
integer width = 773
integer height = 96
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Import Customer "
end type

event clicked;open(w_arrep08)
end event

