# flutter_image_map

[![pub version](https://img.shields.io/pub/v/flutter_image_map.svg)](https://pub.dev/packages/flutter_image_map)

A simple but (hopefully) useful package that implements the HTML image map standard.

## What is an Image Map?
Originally introduced in HTML 3.2 as a replacement for server side imagemaps. Server side image maps were clunky requiring a round trip to the web server to determine where to go based on the coordinates clicked in the image. Thus client side image-maps were born!

An imagemap is a graphic image where a user can click on different parts of the image and be directed to different destinations. imagemaps are made by defining each of the hot areas in terms of their x and y coordinates (relative to the top left hand corner). With each set of coordinates, you specify a link that users will be directed to when they click within the area.

As an example, say you have a map of the World that you wish to act as an image map. Each country could have their hot areas defined on the map to take you to different pages.

## Examples
Check out the Example project for a full example code of all the differents ways to define image map regions.

## Tools
+ https://www.image-map.net/ makes it extremely easy to create free HTML based image maps.
+ There is also a ROI(Region of interest) selecting tool in this project!</br>
~~ROI select tool link: http://www.jiayizhang.me~~
Website down. Source code of the tool is in this repo (index.html in root folder). Just open it in browser should be fine.

### How to use ROI selecting tool

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
