package com.lingnan.service.text;

import com.lingnan.bean.Text;

import java.util.List;

public interface textService {
    List<Text> findAll();
    int delById(String id);
    int addText(Text text);
    int updateText(Text text);
}
