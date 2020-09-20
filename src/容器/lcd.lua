--- 模块功能：LCD适配
-- @author openLuat
-- @module ui.lcd
-- @license MIT
-- @copyright openLuat
-- @release 2018.03.27
--根据自己的lcd类型以及使用的spi引脚，打开下面的其中一个文件进行测试
--mono表示黑白屏，color表示彩屏
--std_spi表示使用标准的SPI引脚，lcd_spi表示使用LCD专用的SPI引脚
--i2c表示使用i2c引脚
-- require "mono_std_spi_sh1106"
-- require "mono_std_spi_ssd1306"
-- require "mono_std_spi_st7567"
--require "color_std_spi_st7735"
-- require "color_std_spi_st7735l"
-- require "color_std_spi_ILI9341"
-- require "color_lcd_spi_ILI9341"
-- require "mono_lcd_spi_sh1106"
-- require "mono_lcd_spi_ssd1306"
-- require "mono_lcd_spi_st7567"
--require "lcd_config"
--require "color_lcd_spi_gc9106l"
--require "mono_i2c_ssd1306"
---require "color_lcd_spi_st7735S"
require "color_lcd_spi_ILI9341"
module(..., package.seeall)


--LCD分辨率的宽度和高度(单位是像素)
WIDTH, HEIGHT, BPP = lvgl.disp_get_lcd_info()
--1个ASCII字符宽度为8像素，高度为16像素；汉字宽度和高度都为16像素
CHAR_WIDTH = 8


