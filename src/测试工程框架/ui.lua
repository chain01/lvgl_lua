
module(...,package.seeall)


local function create(  )
    scr0=lvgl.scr_act()
    btn0=lvgl.btn_create(scr0,nil)
    lvgl.obj_set_size(btn0, 80, 60)
    lvgl.disp_load_scr(scr0)
end

lvgl.init(create)