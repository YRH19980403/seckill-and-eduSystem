package com.lingnan.controller.text;

import com.lingnan.bean.College;
import com.lingnan.bean.Major;
import com.lingnan.bean.Text;
import com.lingnan.service.text.textService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("/text")
public class textController {
    @Autowired
    private textService tes;
    @RequestMapping("/getList")
    public String getList(ModelMap map){
        List<Text> all=tes.findAll();
        map.put("textList",all);
        return("text/text-list");


    }
    /*获取添加列表*/
        @RequestMapping("/toAdd")
        public String toAdd() {
            return "text/text-add";
        }
    /*添加*/
    @RequestMapping("/addText")
    @ResponseBody
    public String addText(Text text){
       tes.addText(text);
       return "success";

    }
    @RequestMapping("/delById")
    @ResponseBody
    public String delById(@RequestParam(value = "text_id") String text_id){
        int i=tes.delById(text_id);
        if(i==1){
            return "success";

        }
        return "error";
    }
    @RequestMapping("/updateText")
    @ResponseBody
    public String updateText(Text text){
            int i=tes.updateText(text);
            if(i==1){
                return "success";
            }
            return "error";

    }





}
