/**
 * Created by d on 2017/5/14.
 */
/*
 * Globalize Culture zh-CN
 *
 * http://github.com/jquery/globalize
 *
 * Copyright Software Freedom Conservancy, Inc.
 * Dual licensed under the MIT or GPL Version 2 licenses.
 * http://jquery.org/license
 *
 * This file was generated by the Globalize Culture Generator
 * Translation: bugs found in this file need to be fixed in the generator
 */

(function( window, undefined ) {

    var Globalize;

    if ( typeof require !== "undefined" &&
        typeof exports !== "undefined" &&
        typeof module !== "undefined" ) {
        // Assume CommonJS
        Globalize = require( "globalize" );
    } else {
        // Global variable
        Globalize = window.Globalize;
    }

    Globalize.addCultureInfo( "zh-CN", "default", {
        name: "zh-CN",
        englishName: "Chinese (Simplified, PRC)",
        nativeName: "中文(中华人民共和国)",
        language: "zh-CHS",
        numberFormat: {
            "NaN": "非数字",
            negativeInfinity: "负无穷大",
            positiveInfinity: "正无穷大",
            percent: {
                pattern: ["-n%","n%"]
            },
            currency: {
                pattern: ["$-n","$n"],
                symbol: "¥"
            }
        },
        calendars: {
            standard: {
                days: {
                    names: ["周日","周一","周二","周三","周四","周五","周六"],
                    namesAbbr: ["周日","周一","周二","周三","周四","周五","周六"],
                    namesShort: ["日","一","二","三","四","五","六"]
                },
                months: {
                    names: ["一月","二月","三月","四月","五月","六月","七月","八月","九月","十月","十一月","十二月",""],
                    namesAbbr: ["一月","二月","三月","四月","五月","六月","七月","八月","九月","十月","十一月","十二月",""]
                },
                AM: ["上午","上午","上午"],
                PM: ["下午","下午","下午"],
                eras: [{"name":"公元","start":null,"offset":0}],
                patterns: {
                    d: "yyyy/M/d",
                    D: "yyyy'年'M'月'd'日'",
                    t: "H:mm",
                    T: "H:mm:ss",
                    f: "yyyy'年'M'月'd'日' H:mm",
                    F: "yyyy'年'M'月'd'日' H:mm:ss",
                    M: "M'月'd'日'",
                    Y: "yyyy'年'M'月'"
                }
            }
        },
        pagerGoToPageString: "跳转:",
        pagerShowRowsString: "每页:",
        pagerRangeString: " 总记录数 ",
        pagerPreviousButtonString: "上一页",
        pagerNextButtonString: "下一页",
        pagerFirstButtonsSring: "首页",
        pagerLastButtonString:"末页",
        emptyDataString:"没有数据",
        loadText: "加载中..."
    });

}( this ));