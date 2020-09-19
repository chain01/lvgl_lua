module(..., package.seeall)
require "http"
--对象对齐方式列表
local lv_align_t = {
    lvgl.ALIGN_IN_TOP_LEFT,
    lvgl.ALIGN_IN_TOP_MID,
    lvgl.ALIGN_IN_TOP_RIGHT,
    lvgl.ALIGN_IN_LEFT_MID,
    lvgl.ALIGN_CENTER,
    lvgl.ALIGN_IN_RIGHT_MID,
    lvgl.ALIGN_IN_BOTTOM_LEFT,
    lvgl.ALIGN_IN_BOTTOM_MID,
    lvgl.ALIGN_IN_BOTTOM_RIGHT
}
local function create()
    --[[
        默认情况下,littleVGL 会为显示器创建一个 lv_obj 类型的基础对象来作为它的屏幕,即最
        顶层的父类,可以通过 lv_scr_act()接口来获取当前活跃的屏幕对象,通过 lv_scr_load()接口来
        设置一个新的活跃屏幕对象
    --]]
    --获取默认屏幕父类
    scr0 = lvgl.scr_act()
    --原型： lv_obj_t * lv_obj_create(lv_obj_t * parent, const lv_obj_t * copy);
    --lua原型：lvgl.obj_create(parent,copy)
    --参数：
    --parent: 指向父对象,如果传 NULL 的话,则是在创建一个 screen 屏幕
    --copy: 此参数可选,表示创建新对象时,把 copy 对象上的属性值复制过来
    obj1 = lvgl.obj_create(scr0, nil)
    --创建一个对象
    lvgl.obj_set_size(obj1, 80, 50)
    --设置对象大小
    my_style = lvgl.style_t()
    --创建一个样式库
    lvgl.style_copy(my_style, lvgl.style_plain_color)
    --copy系统样式库
    my_style.body.radius = 10
    --设置圆角
    my_style.body.opa = 100
    --设置透明度0到255
    my_style.body.main_color = lvgl.color_hex(0x00ff00)
    --对象上半部分颜色
    my_style.body.grad_color = lvgl.color_hex(0x0000ff)
    --对象下半部分颜色
    my_style.body.border.color = lvgl.color_hex(0x000000)
    --边框颜色
    my_style.body.border.width = 2
    --边框粗细
    my_style.body.border.part = lvgl.BORDER_FULL
    --四面边框
    label1 = lvgl.label_create(obj1, nil)
    lvgl.label_set_text(label1, "透明度")
    lvgl.obj_align(label1, nil, lv_align_t[5], 0, 0)
    my_style.text.color = lvgl.color_hex(0xff0000)
    --设置文本颜色
    lvgl.obj_set_style(obj1, my_style)
    --设置样式

    obj2 = lvgl.obj_create(scr0, obj1)
    lvgl.obj_set_pos(obj2, 100, 0)
    my_style1 = lvgl.style_t()
    lvgl.style_copy(my_style1, my_style)
    my_style1.body.opa = lvgl.OPA_COVER
    --完全不透明
    my_style1.glass = 1
    --子对象不继承父对象样式，可以看文本颜色区别
    --默认当子对象没有样式的时候会继承父对象
    lvgl.obj_set_style(obj2, my_style1)
    label2 = lvgl.label_create(obj2, nil)
    lvgl.label_set_text(label2, "不透明")
    lvgl.obj_align(label2, nil, lv_align_t[5], 0, 0)


    lvgl.disp_load_scr(scr0)
end

lvgl.init(create)
