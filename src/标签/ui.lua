module(..., package.seeall)
--对象对齐方式列表
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
    ----------标签1，长文本滚动，速度64像素每秒--------------
    label1 = lvgl.label_create(scr0, nil)
    lvgl.label_set_long_mode(label1, lvgl.LABEL_LONG_SROLL_CIRC)
    lvgl.obj_set_size(label1, 240, 50)
    --设置对象大小
    lvgl.label_set_anim_speed(label1, 64)
    --设置动画速度
    lvgl.label_set_recolor(label1, true)
    --开启颜色控制（不建议使用，最好用样式）
    lvgl.label_set_text(label1, "长文本滚动，我的速度是64#ff0000 这是红色# #00ff00 这是绿色# #0000ff 这是蓝色#")
    ----------标签2，长文本滚动，速度64像素每秒--------------
    label2 = lvgl.label_create(scr0, label1)
    lvgl.label_set_anim_speed(label2, 32)
    lvgl.obj_set_pos(label2, 0, 20)
    lvgl.label_set_text(label2, "长文本滚动，我的速度是32#ff0000 这是红色# #00ff00 这是绿色# #0000ff 这是蓝色#")
    ---------标签3，文本区域自动控制大小，不会自动换行--------------------
    label3 = lvgl.label_create(scr0, nil)
    lvgl.label_set_long_mode(label3, lvgl.LABEL_LONG_EXPAND)
    lvgl.obj_set_pos(label3, 0, 40)
    lvgl.label_set_text(label3, "#ff0000 长文本自动区域显示不会换行#")
    lvgl.label_set_recolor(label3, true)
    --------标签4，文本区域自动控制高度，在指定宽度内会自动换行--------------------
    label4 = lvgl.label_create(scr0, nil)
    lvgl.label_set_long_mode(label4, lvgl.LABEL_LONG_BREAK)
    --这个设置必须放在宽度设置前面
    lvgl.obj_set_size(label4, 100, 10)
    --这里的高度无效可以随便填
    lvgl.obj_set_pos(label4, 0, 60)
    lvgl.label_set_text(
        label4,
        "12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
    )
    --------标签5，文本区域强制大小，在指定大小内会自动换行，超出部分显示省略号------------------------
    label5 = lvgl.label_create(scr0, nil)

    lvgl.label_set_body_draw(label5,true)
    lvgl.label_set_style(label5,lvgl.LABEL_STYLE_MAIN,lvgl.style_plain_color)
    --这段代码设置了标签的背景
    lvgl.label_set_long_mode(label5, lvgl.LABEL_LONG_DOT)
    --这个设置必须放在宽度设置前面
    lvgl.obj_set_size(label5, 100, 55)
    lvgl.obj_set_pos(label5, 102, 65)
    lvgl.label_set_text(label5, "长文本演示，这段文字显示不全显示略号，显示不出的文字")
    lvgl.disp_load_scr(scr0)
end

lvgl.init(create)
