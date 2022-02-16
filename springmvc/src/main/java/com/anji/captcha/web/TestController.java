/*
 *Copyright © 2018 anji-plus
 *安吉加加信息技术有限公司
 *http://www.anji-plus.com
 *All rights reserved.
 */
package com.anji.captcha.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by raodeming on 2019/12/25.
 */
@RequestMapping("/captcha")
@Controller
public class TestController {


    @GetMapping("/index")
    public String index() {
        return "index";
    }
}
