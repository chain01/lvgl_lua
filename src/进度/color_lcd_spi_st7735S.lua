--- 模块功能：ST 7735驱动芯片LCD命令配置
-- @author openLuat
-- @module ui.color_lcd_spi_st7735
-- @license MIT
-- @copyright openLuat
-- @release 2018.03.27

--[[
注意：disp库目前支持I2C接口和SPI接口的屏，此文件的配置，硬件上使用的是LCD专用的SPI引脚，不是标准的SPI引脚
硬件连线图如下：
Air模块			LCD
GND-------------地
LCD_CS----------片选
LCD_CLK---------时钟
LCD_DATA--------数据
LCD_DC----------数据/命令选择
VDDIO-----------电源
LCD_RST---------复位
]]

module(...,package.seeall)

--[[
函数名：init
功能  ：初始化LCD参数
参数  ：无
返回值：无
]]
local function init()
    local para =
    {
        width = 160, --分辨率宽度，128像素；用户根据屏的参数自行修改
        height = 128, --分辨率高度，160像素；用户根据屏的参数自行修改
        bpp = 16, --位深度，彩屏仅支持16位
        bus = disp.BUS_SPI4LINE, --LCD专用SPI引脚接口，不可修改
        xoffset = 0, --X轴偏移
        yoffset = 0, --Y轴偏移
        freq = 13000000, --spi时钟频率，支持110K到13M（即110000到13000000）之间的整数（包含110000和13000000）
        pinrst = pio.P0_14, --reset，复位引脚
        pinrs = rtos.get_version():find("8955") and pio.P0_15 or pio.P0_18, --rs，命令/数据选择引脚/268开发板为15
        --初始化命令
        --前两个字节表示类型：0001表示延时，0000或者0002表示命令，0003表示数据
        --延时类型：后两个字节表示延时时间（单位毫秒）
        --命令类型：后两个字节命令的值
        --数据类型：后两个字节数据的值
        initcmd =
        {
            --End ST7735S Reset Sequence
            0x11, --Sleep out
            0x00010000+120,--Delay 120ms
            --ST7735S Frame rate
            0xB1,
            0x00030005,
            0x0003003a,
            0x0003003a,
            0xB2,
            0x00030005,
            0x0003003a,
            0x0003003a,
            0xB3,
            0x00030005,
            0x0003003a,
            0x0003003a,
            0x00030005,
            0x0003003a,
            0x0003003a,
            --End ST7735S Frame rate
            0xB4, --Dot inversion
            0x00030003,
            --ST7735S Power Sequence
            0xC0,
            0x00030062,
            0x00030002,
            0x00030004,
            0xC1,
            0x000300C0,
            0xC2,
            0x0003000D,
            0x00030000,
            0xC3,
            0x0003008D,
            0x0003006A,
            0xC4,
            0x0003008D,
            0x000300EE,
            0xC5,
            0x00030012,
            --ST7735S Gamma Sequence
            0xE0,
            0x00030003,
            0x0003001B,
            0x00030012,
            0x00030011,
            0x0003003F,
            0x0003003A,
            0x00030032,
            0x00030034,
            0x0003002F,
            0x0003002B,
            0x00030030,
            0x0003003A,
            0x00030000,
            0x00030001,
            0x00030002,
            0x00030005,
            0xE1,
            0x00030003,
            0x0003001B,
            0x00030012,
            0x00030011,
            0x00030032,
            0x0003002F,
            0x0003002A,
            0x0003002F,
            0x0003002E,
            0x0003002C,
            0x00030035,
            0x0003003F,
            0x00030000,
            0x00030000,
            0x00030001,
            0x00030005,
            0xFC, --MX, MY, RGB mode
            0x0003008c,
            0x3A, --65k mode
            0x00030005,
            0x36, --MX, MY, RGB mode
            0x00030060,--my mx mv ml  0110
            0x29, --Display on
            0x00010000+120,--Delay 120ms
        },
        --休眠命令
        sleepcmd = {
            0x00020010,
        },
        --唤醒命令
        wakecmd = {
            0x00020011,
        }
    }
    disp.init(para)
    disp.clear()
    disp.putimage("/lua/start.png",0,0)
    disp.update()
end

--控制SPI引脚的电压域
pmd.ldoset(rtos.get_version():find("8955") and 7 or 15,pmd.LDO_VLCD)--2g为7
init()

--打开背光
--实际使用时，用户根据自己的lcd背光控制方式，添加背光控制代码
