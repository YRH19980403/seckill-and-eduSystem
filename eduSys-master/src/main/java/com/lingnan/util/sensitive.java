package com.lingnan.util;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

public class sensitive {
    //设置敏感词汇库
    private static final String filepath="C:\\Users\\Administrator\\Desktop\\敏感词汇.txt ";
    private static Set<String> words=new HashSet<String>();//保存敏感词汇的集合
    private static HashMap<String,String> wordMap;
    private static final int mainType=1;//最低检测敏感词汇的字符数
    private static final int maxType=5;//检测的字符中敏感词汇的最大长度
    public static void getBadwords() throws IOException {
        //读取敏感词汇
        BufferedReader br=new BufferedReader(new InputStreamReader(new FileInputStream(filepath),"utf-8"));
        String line="";
        while((line=br.readLine())!=null) {
            words.add(line);

        }
    }
    @SuppressWarnings("rawTypes")//镇压警告
    public static void addWordToHashMap() {
        //运用DFA算法将敏感词汇读取到敏感词汇库中
        wordMap=new HashMap<String,String>(words.size());//容器初始化长度
        String key=null;
        Map nowMap=null;
        Map<String,String> newWordMap=null;
        java.util.Iterator<String> it=words.iterator();//获取迭代器
        while(it.hasNext()) {//判断是否存在下一个元素
            key=it.next();
            nowMap=wordMap;
            for(int i=0;i<key.length();i++) {
                char keyChar=key.charAt(i);//获取每个字符
                Object wordMap=nowMap.get(keyChar);
                if(wordMap!=null) {
                    nowMap=(Map) wordMap;
                }else {
                    newWordMap=new HashMap<String,String>();
                    newWordMap.put("isEnd","0");
                    nowMap.put(keyChar,newWordMap);
                    nowMap=newWordMap;


                }
                if(i==key.length()-1) {
                    nowMap.put("isEnd", "1");
                }
            }

        }
    }
    public static Set<String> getBadWordsToSet(String tex,int maxType){//list集合有序不唯一，set集合相反
        //tex为待检测字符串，返回字符串中敏感词汇集合
        Set<String> set=new HashSet<String>();
        for(int i=0;i<tex.length();i++) {//一个一个字符遍历检测，检测敏感词汇并返回长度
            int length=	checkBadWord(tex,i,maxType);
            if(length>0) {
                set.add(tex.substring(i,i+length));//将敏感词汇装入set集合中
                i=i+length-1;//for循环要加一次
            }

        }
        return set;//0表示没有敏感词汇，3表示敏感词汇从下标i开始+3个长度是这一段字符的敏感词汇
    }

    public static int checkBadWord(String tex,int begin,int maxType) {
        boolean flag=false;//标志位，标志是否是敏感词汇
        char word=0;
        int maxFlag=0;//表示已经匹配了多少位
        Map nowMap=wordMap;//用一个中间变量保存敏感词汇Map集合
        for(int i=begin;i<tex.length();i++) {
            word=tex.charAt(i);//拿出匹配的第一个字符
            nowMap=(Map)nowMap.get(word);//在map集合中搜索有没有以word字符为键的键值对,有则将其value值保存在中间变量中
            if(nowMap!=null) {//找到了以word为key的键值对，nowMap指向value集合
                maxFlag++;//匹配的字符增加一位
                if(nowMap.get("isEnd").equals("1")) {//字符串相等用equals,==是比较对象的地址
                    flag=true;//表示结束了
                    if(maxType<=maxFlag) {
                        break;
                    }
                }

            }else {
                break;
            }


        }
        if(!flag) {
            maxFlag=0;
        }



        return maxFlag;
    }
    //用*替换敏感词汇
    //replace
    public static String replacedBadWords(String tex,int maxType,String replaceChar) {
        StringBuffer resultText=new StringBuffer(tex);//字符串中字符经常做改变时用StringBuffer
        for(int i=0;i<resultText.length();i++) {
            int length=checkBadWord(tex,i,maxType);
            if(length>0) {
                String chars="";
                for(int j=0;j<length;j++) {
                    chars+=replaceChar;
                }
                resultText.replace(i, i+length, chars);

                i=i+length-1;
            }
        }
        return resultText.toString();
    }

    static {
        try {
            getBadwords();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        addWordToHashMap();
    }
    public static void main(String args[]) throws IOException {

        //System.out.println(words);

        //System.out.println(wordMap);
        String str="qushi不要脸oummptiannaFucknnnn";
        Set<String> set=getBadWordsToSet(str,maxType);
        System.out.println(set);
        System.out.println(replacedBadWords(str,maxType,"*"));
    }

}
