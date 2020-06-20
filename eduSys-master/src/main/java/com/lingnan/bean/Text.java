package com.lingnan.bean;

public class Text {
    private  String text_id;
    private  String  text;
    public String getText_id() {
        return text_id;
    }

    public void setText_id(String text_id) {
        this.text_id = text_id;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }
    public Text(){

    }
    public Text(String text_id,String text){
        this.text_id=text_id;
        this.text=text;
    }
    @Override
    public String toString() {
        return "Text{" +
                "text_id=" + text_id +
                ", text='" + text + '\'' +
                '}';
    }


}
