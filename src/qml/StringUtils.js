/*
 * This file is part of Kalk
 *
 * Copyright (C) 2021 Rui Wang  <wangrui@jingos.com>
 *
 * $BEGIN_LICENSE:GPL3+$
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * $END_LICENSE$
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
