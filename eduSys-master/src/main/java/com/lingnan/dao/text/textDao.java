package com.lingnan.dao.text;

import com.lingnan.bean.Teacher;
import com.lingnan.bean.Text;

import java.util.List;

public interface textDao {
    Text findById(String text_id);
    List<Text> findAll();
    int delById(String text_id);
    int addText(Text text);
    int updateText(Text text);

}
