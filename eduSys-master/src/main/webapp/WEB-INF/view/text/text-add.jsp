<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" pageEncoding="utf-8"%>
<!-- 获取应用的路径  并给与path变量 -->
<c:set var="path" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE HTML>
<html>
<head>
    <meta charset="utf-8">
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <link rel="Bookmark" href="${path}/images/favicon.ico" >
    <link rel="Shortcut Icon" href="${path}/images/favicon.ico" />
    <script type="text/javascript" src="${path}/lib/html5shiv.js"></script>
    <script type="text/javascript" src="${path}/lib/respond.min.js"></script>
    <link rel="stylesheet" type="text/css" href="${path}/static/h-ui/css/H-ui.min.css" />
    <link rel="stylesheet" type="text/css" href="${path}/static/h-ui.admin/css/H-ui.admin.css" />
    <link rel="stylesheet" type="text/css" href="${path}/lib/Hui-iconfont/1.0.8/iconfont.css" />
    <link rel="stylesheet" type="text/css" href="${path}/static/h-ui.admin/skin/default/skin.css" id="skin" />
    <link rel="stylesheet" type="text/css" href="${path}/static/h-ui.admin/css/style.css" />
    <script type="text/javascript" src="${path}/lib/DD_belatedPNG_0.0.8a-min.js" ></script>
    <script>DD_belatedPNG.fix('*');</script>

    <title>新增留言</title>
</head>
<body>
<article class="page-container">
    <form class="form" id="form-text-add">
        <div class="row cl">
            <label class="form-label col-xs-4 col-sm-2"><span class="c-red">*</span>留言编号：</label>
            <div class="formControls col-xs-8 col-sm-9">

                        <input type="text" class="input-text" placeholder="" id="text_id"  name="text_id">
                    </div>
            </div>
        </div>

        <div class="row cl">
            <label class="form-label col-xs-4 col-sm-2"><span class="c-red">*</span>留言内容</label>
            <div class="formControls col-xs-8 col-sm-9">
                <input type="text" class="input-text" value="${text.text}" placeholder="" id="text" name="text">
            </div>
        </div>

        <div class="row cl">
            <div class="col-xs-8 col-sm-9 col-xs-offset-4 col-sm-offset-2">
                <button onClick="" class="btn btn-primary radius" type="submit">
                    <i class="Hui-iconfont">&#xe632;</i> 保存
                </button>
                <button onClick="removeIframe();" class="btn btn-default radius" type="button">&nbsp;&nbsp;取消&nbsp;&nbsp;</button>
            </div>
        </div>
    </form>
</article>

<script type="text/javascript" src="${path}/lib/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="${path}/lib/layer/2.4/layer.js"></script>
<script type="text/javascript" src="${path}/static/h-ui/js/H-ui.min.js"></script>
<script type="text/javascript" src="${path}/static/h-ui.admin/js/H-ui.admin.js"></script> <!--/_footer /作为公共模版分离出去-->

<script type="text/javascript" src="${path}/lib/My97DatePicker/4.8/WdatePicker.js"></script>
<script type="text/javascript" src="${path}/lib/jquery.validation/1.14.0/jquery.validate.js"></script>
<script type="text/javascript" src="${path}/lib/jquery.validation/1.14.0/validate-methods.js"></script>
<script type="text/javascript" src="${path}/lib/jquery.validation/1.14.0/messages_zh.js"></script>
<script type="text/javascript" src="${path}/lib/webuploader/0.1.5/webuploader.min.js"></script>
<script type="text/javascript" src="${path}/lib/ueditor/1.4.3/lang/zh-cn/zh-cn.js"></script>
<script type="text/javascript">

    $(function(){
        $('.skin-minimal input').iCheck({
            checkboxClass: 'icheckbox-blue',
            radioClass: 'iradio-blue',
            increaseArea: '20%'
        });
        //表单验证
        $("#form-text-add").validate({
            rules:{
                text_id:{
                    required:true,
                },
                text:{
                    required:true,
                    minlength:2,
                    maxlength:10
                }
            },
            onkeyup:false,
            focusCleanup:true,
            success:"valid",
            submitHandler:function(form){
                var url = "${path}/text/addText";
                if (${text!=null}){
                    url = "${path}/text/updateText"
                }
                layer.confirm('有敏感词汇，请重新输入！',function(index){
                    var params = $("#form-text-add").serialize();
                    $.ajax({
                        type: 'POST',
                        url: url,
                        data:params,
                        dataType: "text",
                        success: function(data){
                            layer.msg('成功!',{icon:6,time:2000});
                            $('#form-text-add')[0].reset();
                        },
                        error:function(data) {
                            layer.msg('失败!',{icon:5,time:3000});
                        },
                    });
                });
            },
            invalidHandler: function(form, validator) {return false;}
        });
    });
</script>
</body>
</html>