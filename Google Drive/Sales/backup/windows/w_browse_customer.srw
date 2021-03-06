$PBExportHeader$w_browse_customer.srw
forward
global type w_browse_customer from window
end type
type dw_subdept from datawindow within w_browse_customer
end type
type tv_customer from treeview within w_browse_customer
end type
end forward

global type w_browse_customer from window
integer width = 4032
integer height = 1408
boolean titlebar = true
string title = "Browse Subdept"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
dw_subdept dw_subdept
tv_customer tv_customer
end type
global w_browse_customer w_browse_customer

on w_browse_customer.create
this.dw_subdept=create dw_subdept
this.tv_customer=create tv_customer
this.Control[]={this.dw_subdept,&
this.tv_customer}
end on

on w_browse_customer.destroy
destroy(this.dw_subdept)
destroy(this.tv_customer)
end on

event open;long &
	ll_lev1, ll_lev2, ll_lev3, ll_lev4, ll_custcount, i
int &
	index
string &
	ls_custname, ls_subdesc, ls_custnum, ls_subcode
w_progress &
	lw_progress	

tv_customer.PictureHeight = 32
tv_customer.PictureWidth = 32


// setup progress bar
select count(*) into :ll_custcount
	from custmast 
	where custstat = "1"; // active
open( lw_progress)
lw_progress.hpb_status.position = 0
lw_progress.hpb_status.maxposition = ll_custcount

declare customer_curs cursor for 
	select custnum, custname 
	from custmast 
	where custstat = "1" // active
	order by custnum; 
open customer_curs;

ll_lev1 = tv_customer.InsertItemLast(0,"Customers",1)
i = 1
do while sqlca.sqlcode = 0
	fetch customer_curs into :ls_custnum, :ls_custname;
	if sqlca.sqlcode = 0 then
		// set progress bar
		yield()
		if isvalid( lw_progress) then
			lw_progress.hpb_status.position = i
		else
			close customer_curs;
			return
		end if
		lw_progress.st_status.text = "Processing Customer " + ls_custname +  " ... "
		i ++
		
		ll_lev2 = tv_customer.InsertItemLast(ll_lev1, &
			 trim( ls_custname) + &
			 " | " + ls_custnum, 2)
		
		declare subdept_curs cursor for
			select subcode, subdesc 
			from subdept
			where custnum = :ls_custnum
			order by subcode;
		open subdept_curs;
		do while sqlca.sqlcode = 0 
			fetch subdept_curs into :ls_subcode, :ls_subdesc;
			if sqlca.sqlcode = 0 then
				ll_lev3 = tv_customer.InsertItemlast(ll_lev2, &  
					 trim( ls_subdesc) + &
					 " | " + trim( ls_subcode) , 3)			
			end if
		loop
		close subdept_curs;
	end if
loop
close customer_curs;
close( lw_progress)

tv_customer.ExpandItem(ll_lev1)

dw_subdept.settransobject( sqlca)

end event

type dw_subdept from datawindow within w_browse_customer
integer x = 951
integer y = 48
integer width = 3026
integer height = 1216
integer taborder = 20
string title = "none"
string dataobject = "d_browse_subdept"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type tv_customer from treeview within w_browse_customer
integer x = 37
integer y = 48
integer width = 878
integer height = 1216
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
long picturemaskcolor = 536870912
long statepicturemaskcolor = 536870912
end type

event selectionchanged;long &
	ll_handle
string &
	ls_subdept[], ls_customer[]
treeviewitem &
	tvi_subdept, tvi_customer


ll_handle = tv_customer.finditem( ParentTreeItem!, newhandle)
tv_customer.getitem( newhandle, tvi_subdept)
tv_customer.getitem( ll_handle, tvi_customer)

if tvi_subdept.level = 3 then
	ls_subdept = f_split_string( tvi_subdept.label, "|")
	ls_customer = f_split_string( tvi_customer.label, "|")
	dw_subdept.reset()
	dw_subdept.retrieve( trim(ls_customer[2]), trim(ls_subdept[2]))
end if

end event

