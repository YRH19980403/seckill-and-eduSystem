package com.lingnan.util;

public class grade {
    private String grade_no;
    private String register_no;
    private String work_id;
    private String course_no;
    private String final_grade;
    private String makeup_flag;
    public grade(String grade_no, String register_no, String work_id , String course_no, String final_grade,String makeup_flag) {
        // TODO Auto-generated constructor stub
        super();
        this.grade_no=grade_no;
        this.register_no=register_no;
        this.work_id=work_id;
        this.course_no=course_no;
        this.final_grade=final_grade;
        this.makeup_flag=makeup_flag;
    }

    public String getGrade_no() {
        return grade_no;
    }

    public void setGrade_no(String grade_no) {
        this.grade_no = grade_no;
    }

    public String getRegister_no() {
        return register_no;
    }
    public void setRegister_no(String register_no) {
        this.register_no = register_no;
    }
    public String getWork_id() {
        return work_id;
    }
    public void setWork_id(String work_id) {
        this.work_id = work_id;
    }

    public String getCourse_no() {
        return course_no;
    }
    public void setCourse_no(String course_no) {
        this.course_no = course_no;
    }

    public String getFinal_grade() {
        return final_grade;
    }

    public void setFinal_grade(String final_grade) {
        this.final_grade = final_grade;
    }

    public String getMakeup_flag() {
        return makeup_flag;
    }

    public void setMakeup_flag(String makeup_flag) {
        this.makeup_flag = makeup_flag;
    }
}
