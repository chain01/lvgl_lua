module(..., package.seeall)
require "lvsym"
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

local function btn_event_cb(btn, event)
    if (btn == nil) then
        return
    end
    if event == lvgl.EVENT_RELEASED then
        if btn == btn2 then
            log.debug("btn2", "点击")
        end
    end
end
local function create()
    --[[
        默认情况下,littleVGL 会为显示器创建一个 lv_obj 类型的基础对象来作为它的屏幕,即最
        顶层的父类,可以通过 lv_scr_act()接口来获取当前活跃的屏幕对象,通过 lv_scr_load()接口来
        设置一个新的活跃屏幕对象
    --]]
    --获取默认屏幕父类
    scr0 = lvgl.scr_act()
    --原型： lv_obj_t * lv_obj_create(lv_obj_t * parent, const lv_obj_t * copy)
    --lua原型：lvgl.obj_create(parent,copy)
    --参数：
    --parent: 指向父对象,如果传 NULL 的话,则是在创建一个 screen 屏幕
    --copy: 此参数可选,表示创建新对象时,把 copy 对象上的属性值复制过来
    my_style = lvgl.style_t()
    lvgl.style_copy(my_style, lvgl.style_plain_color)
    my_style.body.main_color = lvgl.color_hex(0x1e9fff)
    my_style.body.grad_color = my_style.body.main_color
    my_style.body.opa = lvgl.OPA_COVER
    my_style.body.radius = lvgl.RADIUS_CIRCLE
    my_style.body.shadow.color = lvgl.color_hex(0x1e9fff)
    my_style.body.shadow.type = lvgl.SHADOW_FULL
    my_style.body.shadow.width = 3
    my_style.text.color = lvgl.color_hex(0xffffff)
    my_style.body.padding.left = 10
    my_style.body.padding.right = 10

    my_style1 = lvgl.style_t()
    lvgl.style_copy(my_style1, lvgl.style_plain_color)
    my_style1.body.opa = lvgl.OPA_0
    my_style1.body.radius = lvgl.RADIUS_CIRCLE
    my_style1.body.border.color = lvgl.color_hex(0xc9c9c9)
    my_style1.body.border.part = lvgl.BORDER_FULL
    my_style1.body.border.width = 2
    my_style1.body.border.opa = lvgl.OPA_COVER
    my_style1.text.color = lvgl.color_hex(0x000000)
    my_style1.body.padding.left = 10
    my_style1.body.padding.right = 10

    btn1 = lvgl.btn_create(scr0, nil)
    lvgl.obj_set_pos(btn1, 20, 20) --设置坐标
    lvgl.btn_set_ink_in_time(btn1, 3000) --入场动画时长
    lvgl.btn_set_ink_wait_time(btn1, 1000) --维持等待时长
    --出场动画时长,这个出场动画是淡出效果的,请睁大眼睛观看,否则不容易看出效果
    lvgl.btn_set_ink_out_time(btn1, 600)
    -- --3.创建一个 Toggle 切换按钮
    btn2 = lvgl.btn_create(scr0, NULL)
    lvgl.obj_set_size(btn2, 90, 30) --设置大小
    lvgl.obj_align(btn2, btn1, lvgl.ALIGN_OUT_RIGHT_TOP, 20, 0) --设置对齐方式
    lvgl.btn_set_toggle(btn2, true) --设置为 Toggle 按钮
    --设置按钮的起始状态为切换态下的释放状态
    lvgl.btn_set_state(btn2, lvgl.BTN_STATE_TGL_REL)
    --设置按钮切换态下的释放状态样式
    lvgl.btn_set_style(btn2, lvgl.BTN_STYLE_TGL_REL, my_style)
    --设置按钮切换态下的按下状态样式,为了看起来更美观和谐,使其和
    -- lvgl.BTN_STYLE_TGL_REL 的样式值保持一致
    lvgl.btn_set_style(btn2, lvgl.BTN_STYLE_TGL_PR, my_style)
    --设置按钮正常态下释放状态样式
    lvgl.btn_set_style(btn2, lvgl.BTN_STYLE_REL, my_style1)
    --设置按钮正常态下按下状态样式,为了看起来更美观和谐,使其和
    -- lvgl.BTN_STYLE_REL 的样式值保持一致
    lvgl.btn_set_style(btn2, lvgl.BTN_STYLE_PR, my_style1)
    btn2_label = lvgl.label_create(btn2, NULL) --给 btn2 添加 label 子对象
    lvgl.label_set_text(btn2_label, "Toggle")
    --设置按钮 2 的布局方式,使 label 处于正中间,当然了如果不设置的话,默认也是正中
    --间的
    lvgl.btn_set_layout(btn2, lvgl.LAYOUT_CENTER)
    lvgl.obj_set_event_cb(btn2, btn_event_cb) --设置 btn2 的事件回调
    --3.创建一个宽度自适应的正常按钮
    btn3 = lvgl.btn_create(scr0, NULL)
    lvgl.obj_align(btn3, btn1, lvgl.ALIGN_OUT_BOTTOM_LEFT, 0, 20) --设置对齐
    lvgl.obj_set_height(btn3, 30) --只设置高度固定
    --设置宽度只在右边自适应
    lvgl.btn_set_fit4(btn3, lvgl.FIT_NONE, lvgl.FIT_TIGHT, lvgl.FIT_NONE, lvgl.FIT_NONE)
    --设置按钮正常态下释放状态样式
    lvgl.btn_set_style(btn3, lvgl.BTN_STYLE_REL, my_style)

    --设置按钮正常态下按下状态样式
    lvgl.btn_set_style(btn3, lvgl.BTN_STYLE_PR, my_style1)
    btn3_label = lvgl.label_create(btn3, NULL) --给 btn3 添加 label 子对象
    lvgl.label_set_text(btn3_label, "This is long text")
    lvgl.obj_set_event_cb(btn3, btn_event_cb) --设置 btn3 的事件回调
    lvgl.disp_load_scr(scr0)
end
sys.taskInit(
    function()
        sys.wait(5000)
        while true do
           -- lvgl.event_send(btn2, lvgl.EVENT_CLICKED)
           lvgl.btn_set_state(btn2,lvgl.BTN_STATE_PR)
           sys.wait(2000)
           lvgl.btn_set_state(btn2,lvgl.BTN_STATE_REL)
           --lvgl.btn_toggle(btn2)
            sys.wait(2000)
        end
    end
)
lvgl.init(create)
