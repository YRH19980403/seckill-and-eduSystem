package com.lingnan.service.text;

import com.lingnan.bean.Text;
import com.lingnan.dao.text.textDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
@Service
public class textServiceImpl implements textService{

    @Autowired
    private textDao ted;


    @Override
    public List<Text> findAll() {
        return ted.findAll();
    }
    @Transactional
    @Override
    public int delById(String id) {
        return ted.delById(id);
    }
    @Transactional
    @Override
    public int addText(Text text) {
        return ted.addText(text);
    }
    @Transactional
    @Override
    public int updateText(Text text) {
        return ted.updateText(text);
    }
}
