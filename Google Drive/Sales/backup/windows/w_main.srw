$PBExportHeader$w_main.srw
forward
global type w_main from window
end type
type mdi_1 from mdiclient within w_main
end type
end forward

global type w_main from window
integer width = 2533
integer height = 1408
boolean titlebar = true
string title = "Untitled"
string menuname = "m_main"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowtype windowtype = mdi!
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
event ue_exit ( )
mdi_1 mdi_1
end type
global w_main w_main

event ue_exit();integer &
	li_return

li_return = messagebox( "Exit", "Apakah anda yakin ?", question!, yesno!)

if li_return = 1 then
	halt
end if
end event

on w_main.create
if this.MenuName = "m_main" then this.MenuID = create m_main
this.mdi_1=create mdi_1
this.Control[]={this.mdi_1}
end on

on w_main.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.mdi_1)
end on

event close;disconnect using sqlca;
destroy sqlca;
halt

end event

event open;string		ls_securemenu, ls_intmktarr[]
integer		i, a
 
// get menu setting from ini file
ls_securemenu = ProfileString ( "appl.ini", "setting", "securemenu", "yes")

if trim( lower( ls_securemenu)) = "yes" and &
	gs_userid <> "dba" then
	f_disable_menu( m_main, gs_userid)
end if

// get server time
declare time_curs cursor for
select current from sysset;
open time_curs;
fetch time_curs into :gdt_serverdatetime;
close time_curs;
if isnull( gdt_serverdatetime) then
	messagebox( "Date and Time", "Gagal mengambil Tanggal dan waktu di Server, hubungi EDP")
	halt
end if

// get company code for title
select textvl into :gs_company_name
	from sysset
	where moducd = "GLOBAL"
	and settype = "COMPNAME";
gs_company_name = trim( gs_company_name)
this.title = gs_company_name + " | " + gs_userid + " | Version " + gs_version 

gd_serverdate = date( gdt_serverdatetime)
gt_servertime = time( gdt_serverdatetime)

gs_frametitle = this.title + " | Time on Server - " + &
	string( gd_serverdate, "dd-mmmm-yyyy")
this.title = gs_frametitle
timer( 1)

// get block DO setting
select numevl into :a
	from sysset
	where moducd = "SLSDO"
	and settype = "BLOCKDO";
if a = 0 then
	gb_blockdo = false
else
	gb_blockdo = true
end if
end event

event timer;string &
	ls_time
gt_servertime = relativetime( gt_servertime, 1)
gdt_serverdatetime = datetime( gd_serverdate, gt_servertime)
ls_time = string( gt_servertime, "hh:mm:ss")

this.title = gs_frametitle + ", " + ls_time
end event

type mdi_1 from mdiclient within w_main
long BackColor=268435456
end type

