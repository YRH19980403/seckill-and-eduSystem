package com.lingnan.util;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class Utils {
    public static void main(String args[]) throws IOException {
        //保存一个长为3cm,宽为2cm的矩形
        List<grade> list=new ArrayList<grade>();
        list.add(new grade("125","1456","1","11","90","0"));
        list.add(new grade("126","1457","2","33","85","1"));
        Utils.CSVWrite("C:\\Users\\Administrator\\Desktop\\grade.csv", list);
       // Utils.CSVRead("C:\\Users\\Administrator\\Desktop\\grade.csv");
    }

//    static void CSVRead(String pathfile) throws IOException{
//        BufferedReader br=new BufferedReader(new InputStreamReader(new FileInputStream(pathfile)));
//        String line="";
//        while((line=br.readLine())!=null) {
//            System.out.println(line);
//
//        }
//        br.close();
//    }
    static void CSVWrite(String pathfile,List<grade> list) throws IOException {
        BufferedWriter bw=null;
        bw=new BufferedWriter(new OutputStreamWriter(new FileOutputStream(pathfile)));
        bw.write("grade_no,register_no,work_id,course_no,final_grade,makeup_flag,\r\n");
        for(grade g:list) {
            bw.append(g.getGrade_no()).append(",").append(g.getRegister_no()).append(",")
                    .append(g.getWork_id()).append(",").append(g.getCourse_no()).append(",")
                    .append(g.getFinal_grade()).append(",").append(g.getMakeup_flag()).append("\r\n");
        }
        bw.flush();
        bw.close();

    }

}
