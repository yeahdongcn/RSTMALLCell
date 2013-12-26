RSTMALLCell
===========

![ScreenShot](https://s3.amazonaws.com/cocoacontrols_production/uploads/control_image/image/1844/iOS_Simulator_Screen_shot_Sep_12__2013_9.37.01_AM.png)

Tmall is a well designed application (https://itunes.apple.com/cn/app/tian-mao-tao-bao-shang-cheng/id518966501?l=en&mt=8) and this repo duplicate its feature of showing images on the cell.
On the right of the cell there is a stack of images for the item and could be draged to anywhere, if the distance is close enough to the original position, the image will back to original postion with image, otherwise, the image will fall.
If there is only one image left, after drag, the stack of images will be back with animation. Explore the sample for more.

A little about the usage.

You can have a RSTMALLTableViewController based table view controller, when using Storyboard, use - (id)initWithCoder:(NSCoder *)aDecoder to init the dataArray, otherwise, use the other init functions to get the dataArray ready.

[![ScreenShot](https://raw.github.com/GabLeRoux/WebMole/master/ressources/WebMole_Youtube_Video.png)](http://v.youku.com/v_show/id_XNjA1MjgyNzQw.html)



[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/yeahdongcn/rstmallcell/trend.png)](https://bitdeli.com/free "Bitdeli Badge")

