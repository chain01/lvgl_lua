module(..., package.seeall)
require "lvsym"
require "audio"
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
arc = nil

angles = 0

local function arc_loader()
    angles = angles + 1
    if angles * 3 < 180 then
        lvgl.arc_set_angles(arc, 180 - angles * 3, 180)
    else
        lvgl.arc_set_angles(arc, 540 - angles * 3, 180)
    end
    if angles == 100 then
        angles = 0
    end
    lvgl.label_set_text(arc_label, tostring(angles))
    lvgl.obj_realign(arc_label)
end

function create()
    scr = lvgl.cont_create(nil, nil)
    my_style = lvgl.style_t()
    --创建一个样式库
    lvgl.style_copy(my_style, lvgl.style_plain_color)
    --copy系统样式库
    my_style.body.radius = 10
    --设置圆角
    my_style.body.opa = 100
    --设置透明度0到255
    my_style.body.main_color = lvgl.color_hex(0x000000)
    --对象上半部分颜色
    my_style.body.grad_color = lvgl.color_hex(0x000000)
    --对象下半部分颜色
    my_style.body.border.color = lvgl.color_hex(0xffffff)

    arc_label2 = lvgl.label_create(scr, nil)
    lvgl.label_set_text(arc_label2, lvgl.SYMBOL_BATTERY_3)
    lvgl.obj_align(arc_label2, scr, lv_align_t[3], 0, 0)
    clock = lvgl.label_create(scr, nil)
    lvgl.label_set_text(clock, "00:00")
    lvgl.obj_align(clock, scr, lv_align_t[1], 0, 0)
    user = lvgl.label_create(scr, nil)
    lvgl.label_set_text(user, "当前群组")
    lvgl.obj_align(user, scr, lv_align_t[2], 0, 22)
    label1 = lvgl.label_create(scr, nil)
    lvgl.label_set_long_mode(label1, lvgl.LABEL_LONG_SROLL_CIRC)
    lvgl.obj_set_size(label1, 120, 22)
    --设置对象大小
    lvgl.label_set_anim_speed(label1, 32)
    --设置动画速度
    --开启颜色控制（不建议使用，最好用样式）
    lvgl.label_set_text(label1, "这是一个很长很长的群组名称，这是一个很长很长的群组名称")
    lvgl.obj_align(label1, user, lvgl.ALIGN_OUT_BOTTOM_MID, 0, 2)

    user1 = lvgl.label_create(scr, nil)
    lvgl.label_set_text(user1, "用户名称")
    lvgl.obj_align(user1, label1, lvgl.ALIGN_OUT_BOTTOM_MID, 0, 2)
    label2 = lvgl.label_create(scr, nil)
    lvgl.label_set_long_mode(label2, lvgl.LABEL_LONG_SROLL_CIRC)
    lvgl.obj_set_size(label2, 120, 22)
    --设置对象大小
    lvgl.label_set_anim_speed(label2, 20)
    --设置动画速度
    --开启颜色控制（不建议使用，最好用样式）
    lvgl.label_set_text(label2, "这是一个很长很长的用户名称，这是一个很长很长的用户名称")
    lvgl.obj_align(label2, user1, lvgl.ALIGN_OUT_BOTTOM_MID, 0, 2)
    lvgl.obj_set_style(scr, my_style)
    --设置文本颜色
    lvgl.obj_set_style(label2, my_style)
    lvgl.obj_set_style(label1, my_style)
    lvgl.obj_set_style(user, my_style)
    lvgl.obj_set_style(user1, my_style)
    my_style1 = lvgl.style_t()
    --创建一个样式库
    lvgl.style_copy(my_style1,my_style)
    --copy系统样式库
    btn = lvgl.btn_create(scr, nil)
    btn_label = lvgl.label_create(btn, nil)
    lvgl.label_set_text(btn_label, "按钮")
    lvgl.obj_set_size(btn, 40, 26)
    lvgl.obj_align(btn, scr, lv_align_t[7], 0, 0)
    my_style1.text.color = lvgl.color_hex(0xffffff)
    my_style1.body.radius = 10
    my_style1.body.border.width = 2
    --边框粗细
    my_style.body.border.part = lvgl.BORDER_FULL
    --四面边框
    lvgl.obj_set_style(btn, my_style1)
    --sys.timerLoopStart(arc_loader, 1000)
    lvgl.disp_load_scr(scr)
end
lvgl.init(create)

local function update_time()
    local time = os.date("*t")
    lvgl.label_set_text(clock, string.format("%02d:%02d", time.hour, time.min))
end
sys.timerLoopStart(update_time, 1000)
