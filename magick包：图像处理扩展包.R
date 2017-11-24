# magick包：图像处理扩展包
library(magick)
str(magick::magick_config()) #查看该包支持的图片格式
tiger <- image_read('https://jeroen.github.io/images/tiger.svg')
tiger
image_info(tiger) #查看图片的信息
image_write(tiger7, path = "~/Desktop/tiger.png", format = "png") #输出图片
##剪裁和编辑
(tiger1 <- image_border(tiger, "orange", "20x10")) #加个20x10的橘黄色框
(tiger2 <- image_crop(tiger1, "940x920+50")) #从左边裁掉50个尺寸
(tiger3 <- image_scale(tiger1, "100")) #缩小到100
(tiger4 <- image_flop(tiger)) #反转1
(tiger5 <- image_background(tiger, "pink", flatten = TRUE)) #加个粉色的背景，这个对这个图片没效果
(tiger6 <- image_blur(tiger, 10, 5)) #虚化
(tiger7 <- image_annotate(tiger, "Big Tiger !!!", size = 100, gravity = "southwest", color = "green"))
##管道操作符进行链接
library(magrittr)
image_read('https://jeroen.github.io/images/tiger.svg') %>% 
  image_rotate(270) %>% 
  image_background("pink", flatten = TRUE) %>% 
  image_border("orange", "10x10") %>% 
  image_annotate("Big Tiger !!!", size = 100, gravity = "southwest", color = "green")
  
##图片向量
(earth <- image_read("https://jeroen.github.io/images/earth.gif"))
(earth2 <- image_scale(earth, "200"))
length(earth2)
earth2[2]
print(earth)

##图层叠加
(bigdata <- image_read("https://jeroen.github.io/images/bigdata.jpg"))
(frink <- image_read("https://jeroen.github.io/images/frink.png"))
(logo <- image_read("https://www.r-project.org/logo/Rlogo.png"))
(img <- c(bigdata, logo, frink)) #三个图片会连续轮流播放
(img <- image_scale(img, "300x300"))
image_info(img)
(img1 <- image_mosaic(img)) #叠加三张图片
##组合
(ltr <- image_append(image_scale(img, "x200")))
##扫描文档为图片：将指定文档扫描为图片
manual <- image_read("https://cran.r-project.org/web/packages/magick/magick.pdf", density = "72x72")
image_info(manual)
manual
image_convert(manual[1], "png")
library(pdftools)
bitmap <- pdf_render_page("https://cran.r-project.org/web/packages/magick/magick.pdf", page = 1, dpi = 72, numeric = FALSE)
(pdf <- image_read(bitmap))
image_write(pdf, path = "~/Desktop/pdf.png", format = "png") #输出图片
##制作GIF
image_animate(image_scale(img, "200x200"), fps = 1, dispose = "previous")
newlogo <- image_scale(logo, "x150")
oldlogo <- image_scale(logo, "x150") #一位网络出了问题，只能用两个一样的图标了。
frames <- image_morph(c(oldlogo, newlogo), frames = 10)
image_animate(frames)