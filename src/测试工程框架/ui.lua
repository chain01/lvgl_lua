module(..., package.seeall)
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
    btn0 = lvgl.btn_create(scr0, nil)
    --lvgl.obj_set_opa_scale_enable(btn0,1)
    --lvgl.obj_set_opa_scale(btn0,125)
    --创建一个按钮对象
    lvgl.obj_set_size(btn0, 50, 30)
    lvgl.disp_load_scr(scr0)
end
sys.taskInit(
    function()
        local i = 1
        local addr
        sys.wait(5000)
        while true do
            if i > 9 then
                i = 1
            end
            log.debug("子对象个数", lvgl.obj_count_children(scr0))
            btn1 = lvgl.btn_create(scr0, btn0)
            --创建新的按钮对象，复制btn0的属性
            btn1_label = lvgl.label_create(btn1, nil)
            lvgl.label_set_text(btn1_label, "复制")
            log.debug("子对象个数", lvgl.obj_count_children(scr0))
            log.debug("递归对象个数", lvgl.obj_count_children_recursive(scr0))

            lvgl.obj_align(btn0, nil, lv_align_t[i], 0, 0)
            i = i + 1
            sys.wait(1000)
            lvgl.obj_del(btn1)
            --删除对象
        end
    end
)
lvgl.init(create)
