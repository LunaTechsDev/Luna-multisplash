/*:
@author LunaTechs - Kino
@plugindesc A plugin that lets you create links through clickable windows<LunaLinks>.

@target MV MZ

@param linkWindows
@text Link Windows
@desc The list of link windows on your title screen.
@type struct<LinkWindow>[]

@help

An RPGMakerMV/MZ plugin that lets you create links to websites through clickable
windows<LunaLinks>.

==== How To Use ====

Simply f ill out your link information in the plugin parameters with the proper
coordinates on the screen. The icon you use for your link will be mapped
to the size of the window.

MIT License
Copyright (c) 2020 LunaTechsDev
Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:
The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE
*/

/*~struct~LinkWindow:
*
* @param link
* @text Link 
* @desc The link for the link window
* @default google.com
*
* @param image
* @text Image Name
* @desc Name of an image in your pictures folder
* @default Actor1_1
*
* @param x
* @text X Position
* @desc The X position of the link window
* @default 0
* 
* @param y
* @text Y Position
* @desc The Y position of the link window
* @default 0
*
* @param width
* @text Width
* @desc The width of the link window
* @default 100
*
* @param height
* @text Height 
* @desc The height of the link window
* @default 100
*
* @param backgroundType
* @text Background Type 0 -> Opaque 1 -> Semitransparent 2 -> Transparent
* @desc The background type of the link window
* @default 2
* 
*/



