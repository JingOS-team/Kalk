/*
 * Copyright (C) 2021 Beijing Jingling Information System Technology Co., Ltd. All rights reserved.
 *
 * Authors:
 * Bob <pengbo·wu@jingos.com>
 *
 */
var subString= function(string , start , end){
    return string.substring(start , end)
}

var getCharAt = function(string , position){
    return string.charAt(position)
}

var contains = function(string , val){
    return string.contains(val)
}

var getLastIndexOf = function(string , val){
    return string.lastIndexOf(val)
}
