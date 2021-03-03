# flutter_image_map
A simple but useful(hopefully) package that implemented the image map in HTML.
+ Now come alone with a ROI(Region of interest) selecting tool!</br>
--ROI select tool link: http://www.jiayizhang.me--
Website down. Source code of the tool is in this repo (index.html in root folder). Just open it in browser should be fine.

## How to use ROI selecting tool
1. Select an image
![image](https://i.imgur.com/WNBpgcK.png)
2. Click on the image to add vertices of ROIs
![image](https://i.imgur.com/DuefciJ.png)
3. If you want to create a new ROI, click on "New Polygon"
![image](https://i.imgur.com/FmvfmX6.png)
4. When you are done, press "Export"
![image](https://i.imgur.com/UIZO6kp.png)
5. It will pop up a dialog
![image](https://i.imgur.com/Dkk6S2C.png)

The format of the data is:</br>
List<List<int>>, each sub-list describes a polygon. To adjacent numbers represent a position.</br>
e.g.</br>
[</br>
  [x1,y1,x2,y2,x3,y3,...],//Polygon 1</br>
  [x1,y1,x2,y2,x3,y3,...],//Polygon 2</br>
  [x1,y1,x2,y2,x3,y3,...],//Polygon 3</br>
]</br>
