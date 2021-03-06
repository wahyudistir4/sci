$PBExportHeader$w_slsrep03.srw
forward
global type w_slsrep03 from window
end type
type cb_view from commandbutton within w_slsrep03
end type
type st_2 from statictext within w_slsrep03
end type
type st_1 from statictext within w_slsrep03
end type
type em_date from editmask within w_slsrep03
end type
type ddlb_supplier from dropdownlistbox within w_slsrep03
end type
type gb_1 from groupbox within w_slsrep03
end type
end forward

global type w_slsrep03 from window
integer width = 1765
integer height = 628
boolean titlebar = true
string title = "Daily Report"
boolean controlmenu = true
long backcolor = 67108864
string icon = "AppIcon!"
cb_view cb_view
st_2 st_2
st_1 st_1
em_date em_date
ddlb_supplier ddlb_supplier
gb_1 gb_1
end type
global w_slsrep03 w_slsrep03

on w_slsrep03.create
this.cb_view=create cb_view
this.st_2=create st_2
this.st_1=create st_1
this.em_date=create em_date
this.ddlb_supplier=create ddlb_supplier
this.gb_1=create gb_1
this.Control[]={this.cb_view,&
this.st_2,&
this.st_1,&
this.em_date,&
this.ddlb_supplier,&
this.gb_1}
end on

on w_slsrep03.destroy
destroy(this.cb_view)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.em_date)
destroy(this.ddlb_supplier)
destroy(this.gb_1)
end on

event open;string &
	ls_scode, ls_sname

declare supp_curs cursor for
	select scode, sname 
	from supmast;
open supp_curs;

do while sqlca.sqlcode = 0
	fetch supp_curs into :ls_scode, :ls_sname;
	if sqlca.sqlcode = 0 then
		ddlb_supplier.additem( ls_sname + "|" + ls_scode)
	end if
loop

ddlb_supplier.selectitem( 1)
em_date.text = string( gd_serverdate)
end event

type cb_view from commandbutton within w_slsrep03
integer x = 553
integer y = 376
integer width = 640
integer height = 96
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&View"
end type

event clicked;date &
	ld_date
string &
	ls_supplier[], ls_custnum, ls_scode, ls_area, ls_custname, &
	ls_sql, ls_tmptableid 
integer &
	li_year, i, k
long &
	ll_qty, ll_month_qty, ll_currow, &
	ll_jan, ll_feb, ll_mar, ll_apr, ll_may, ll_jun, &
	ll_jul, ll_aug, ll_sep, ll_oct, ll_nov, ll_dec
datastore &
	lds_report_viewer
s_report_viewer &
	lstr_report_viewer
w_report_viewer &
	lw_report_viewer

em_date.getdata( ld_date)
ls_supplier = f_split_string( ddlb_supplier.text, "|")
ls_scode = trim( ls_supplier[2])
li_year = year( ld_date)

declare cust_curs cursor for
	select a.custnum, a.custname, a.area, sum( c.qty) 
	from custmast a, sdomas b, sdodet c
	where a.custnum=b.custnum and b.donum=c.donum
	and year(b.dodate)=:li_year and b.dostat in ("E","L")
	and b.scode = :ls_scode
	group by 1,2,3;
open cust_curs;

// set report
lds_report_viewer = create datastore
lds_report_viewer.dataobject = "d_slsrep03"
lstr_report_viewer.title = parent.title
lds_report_viewer.object.t_company.text = gs_company_name
lds_report_viewer.object.t_year.text = "Tahun - " + string ( ld_date, "yyyy")
lds_report_viewer.object.t_supplier.text = trim( ls_supplier[1])
lds_report_viewer.object.t_print_by.text = f_print_by( gs_userid, gdt_serverdatetime)
lds_report_viewer.object.t_username.text =  gs_username

do while sqlca.sqlcode = 0
	fetch cust_curs into :ls_custnum, :ls_custname, :ls_area, :ll_qty;
	if sqlca.sqlcode = 0 then
		// proses hanya yang ada transaksi
		if ll_qty > 0 then			
			for i = 1 to 12 
				
				select sum( b.qty) into :ll_month_qty
				from sdomas a, sdodet b
				where a.donum=b.donum
				and a.custnum=:ls_custnum and month(a.dodate)=:i
				and year(a.dodate)=:li_year
				and a.scode = :ls_scode;
				
				if isnull( ll_month_qty) then
					ll_month_qty = 0
				end if
				
				choose case i
					case 1
						ll_jan = ll_month_qty
					case 2
						ll_feb = ll_month_qty
					case 3
						ll_mar = ll_month_qty
					case 4
						ll_apr = ll_month_qty
					case 5
						ll_may = ll_month_qty
					case 6
						ll_jun = ll_month_qty
					case 7
						ll_jul = ll_month_qty
					case 8
						ll_aug = ll_month_qty
					case 9
						ll_sep = ll_month_qty
					case 10
						ll_oct = ll_month_qty
					case 11
						ll_nov = ll_month_qty
					case 12
						ll_dec = ll_month_qty
				end choose
			next
			ll_currow = lds_report_viewer.insertrow(0)			
			lds_report_viewer.setitem( ll_currow, "custnum", ls_custnum)
			lds_report_viewer.setitem( ll_currow, "custname", ls_custname)
			lds_report_viewer.setitem( ll_currow, "area", ls_area)
			lds_report_viewer.setitem( ll_currow, "jan", ll_jan)
			lds_report_viewer.setitem( ll_currow, "feb", ll_feb)
			lds_report_viewer.setitem( ll_currow, "mar", ll_mar)
			lds_report_viewer.setitem( ll_currow, "apr", ll_apr)
			lds_report_viewer.setitem( ll_currow, "may", ll_may)
			lds_report_viewer.setitem( ll_currow, "jun", ll_jun)
			lds_report_viewer.setitem( ll_currow, "jul", ll_jul)
			lds_report_viewer.setitem( ll_currow, "aug", ll_aug)
			lds_report_viewer.setitem( ll_currow, "sep", ll_sep)
			lds_report_viewer.setitem( ll_currow, "oct", ll_oct)
			lds_report_viewer.setitem( ll_currow, "nov", ll_nov)
			lds_report_viewer.setitem( ll_currow, "dec", ll_dec)
		end if
	end if
loop
close cust_curs;

// open report
lds_report_viewer.setsort("area A, custnum A")
lds_report_viewer.sort()
lds_report_viewer.groupcalc( )
lds_report_viewer.getfullstate( lstr_report_viewer.dwdata)
destroy lds_report_viewer
opensheetwithparm( lw_report_viewer, lstr_report_viewer, w_main, 0, layered!)

end event

type st_2 from statictext within w_slsrep03
integer x = 73
integer y = 192
integer width = 343
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
string text = "Tahun"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_1 from statictext within w_slsrep03
integer x = 73
integer y = 80
integer width = 343
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
string text = "Supplier"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_date from editmask within w_slsrep03
integer x = 457
integer y = 176
integer width = 338
integer height = 80
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
string text = "none"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "yyyy"
end type

type ddlb_supplier from dropdownlistbox within w_slsrep03
integer x = 457
integer y = 64
integer width = 1115
integer height = 400
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type gb_1 from groupbox within w_slsrep03
integer x = 73
integer y = 304
integer width = 1554
integer height = 20
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

