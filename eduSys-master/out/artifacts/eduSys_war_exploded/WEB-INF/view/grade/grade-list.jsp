﻿<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 获取应用的路径  并给与path变量 -->
<c:set var="path" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE HTML>
<html>
<head>
    <meta charset="utf-8">
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta name="referrer" content="origin">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
    <meta http-equiv="Cache-Control" content="no-siteapp" />

    <link rel="stylesheet" type="text/css" href="${path}/static/h-ui/css/H-ui.min.css" />
    <link rel="stylesheet" type="text/css" href="${path}/static/h-ui.admin/css/H-ui.admin.css" />
    <link rel="stylesheet" type="text/css" href="${path}/lib/Hui-iconfont/1.0.8/iconfont.css" />
    <link rel="stylesheet" type="text/css" href="${path}/static/h-ui.admin/skin/default/skin.css" id="skin" />
    <link rel="stylesheet" type="text/css" href="${path}/static/h-ui.admin/css/style.css" />

    <title>资讯列表</title>
</head>
<body>
<nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 成绩管理 <span class="c-gray en">&gt;</span> 成绩列表 <a class="btn btn-success radius r" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
<div class="page-container">
    <div class="cl pd-5 bg-1 bk-gray mt-20">
        &nbsp;<button onclick="removeIframe()" class="btn btn-primary radius">关闭选项卡</button>
        <span class="l">
            <a href="javascript:;" onclick="datadel()" class="btn btn-danger radius">
                <i class="Hui-iconfont">&#xe6e2;</i>
                批量删除
            </a>
            <a class="btn btn-primary radius" onclick="grade_add('添加成绩','${path}/grade/toAdd')" href="javascript:;">
                <i class="Hui-iconfont">&#xe600;</i> 添加成绩
            </a>
        </span>
    </div>
    <div class="mt-20">
        <table class="table table-border table-bordered table-bg table-hover table-sort table-responsive">
            <thead>
            <tr class="text-c">
                <th width="40"><input  type="checkbox" value=""></th>
                <th width="80">ID</th>
                <th width="70">学生姓名</th>
                <th width="40">课程教师</th>
                <th width="40">课程名称</th>
                <th width="40">课程成绩</th>
                <th width="60">补考标志</th>
                <th width="60">操作</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${gradeList}" var="grade">

                <tr class="text-c">
                    <td><input name="checkboxs" type="checkbox" value="${grade.grade_no}"></td>
                    <td>${grade.grade_no}</td>
                    <td>${grade.student.s_name}</td>
                    <td>${grade.teacher.t_name}</td>
                    <td>${grade.course.course_name}</td>
                    <td>${grade.final_grade}</td>
                    <td class="td-status">
                        <c:if test="${grade.makeup_flag==1}">
                            <span class="label label-makeup radius" >补考</span>
                        </c:if>
                        <c:if test="${grade.makeup_flag==0}">
                            <span class="label label-success radius">非补考</span>
                        </c:if>
                    </td>

                    <td class="td-manage">

                        <c:if test="${grade.makeup_flag==1}">
                            <a style="text-decoration:none" onClick="grade_nmakeup(this,'${grade.grade_no}')" href="javascript:;" title="非补考">
                                <i class="Hui-iconfont">&#xe631;</i>
                            </a>
                        </c:if>
                        <c:if test="${grade.makeup_flag==0||grade.makeup_flag==null}">
                            <a style="text-decoration:none" onClick="grade_makeup(this,'${grade.grade_no}')" href="javascript:;" title="补考">
                                <i class="Hui-iconfont">&#xe615;</i>
                            </a>
                        </c:if>

                        <a style="text-decoration:none" class="ml-5" onClick="grade_edit('更新成绩','${path}/grade/toUpdate?grade_no=${grade.grade_no}')" href="javascript:;" title="编辑">
                            <i class="Hui-iconfont">&#xe6df;</i>
                        </a>
                        <a style="text-decoration:none" class="ml-5" onClick="grade_del(this,'${grade.grade_no}')" href="javascript:;" title="删除">
                            <i class="Hui-iconfont">&#xe6e2;</i>
                        </a>
                    </td>
                </tr>
            </c:forEach>

            </tbody>
        </table>
    </div>
</div>
</div>
<script type="text/javascript" src="${path}/lib/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="${path}/lib/layer/2.4/layer.js"></script>
<script type="text/javascript" src="${path}/static/h-ui/js/H-ui.min.js"></script>
<script type="text/javascript" src="${path}/static/h-ui.admin/js/H-ui.admin.js"></script>
<script type="text/javascript" src="${path}/lib/My97DatePicker/4.8/WdatePicker.js"></script>
<script type="text/javascript" src="${path}/lib/datatables/1.10.0/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="${path}/lib/laypage/1.2/laypage.js"></script>
<script type="text/javascript">
    $('.table-sort').dataTable({
        "aaSorting": [[ 1, "desc" ]],//默认第几个排序
        "bStateSave": true,//状态保存
        "pading":false,
        "aoColumnDefs": [
            {"orderable":false,"aTargets":[0,7]}// 不参与排序的列
        ]
    });

    function grade_add(title,url){
        var index = layer.open({
            type: 2,
            title: title,
            content: url
        });
        layer.full(index);
    }


    function grade_edit(title,url,w,h){
        layer_show(title,url,w,h);
    }

    function grade_del(obj,id){
        layer.confirm('确认要删除吗?',function(index){
            $.ajax({
                type: 'POST',
                url: '${path}/grade/delById',
                data: {"grade_no":id},
                dataType: 'text',
                success: function(data){
                    $(obj).parents("tr").remove();
                    layer.msg(data,{icon:1,time:1000});
                },
                error:function(data) {
                    layer.msg(data,{icon:5,time:4000});
                },
            });
        });
    }

    <!-- 批量删除课程 -->
    function datadel() {
        layer.confirm('确认要删除吗？',function(index){
            var course_nos = [];
            $("input:checkbox[name = checkboxs]:checked").each(function(i){
                console.log($(this).val());
                course_nos.push( $(this).val() );
            });
            $.ajax({
                traditional: true,
                type: 'POST',
                url: '${path}/grade/delByIds',
                data: {grade_nos:course_nos},
                dataType: "text",
                success: function(data){
                    $("input:checkbox[name = checkboxs]:checked").each(function(i){
                        $(this).parents("tr").remove();
                    });
                    layer.msg("删除成功",{icon:1,time:2000});
                },
                error:function(data) {
                    layer.msg("删除失败",{icon:5,time:4000});
                },
            });
        });
    }

    function grade_nmakeup(obj,id){
        layer.confirm('请确认',function(index){
            $.ajax({
                type: 'POST',
                url: '${path}/grade/updateStatus',
                data: {"grade_no":id,"status":0},
                dataType: "text",
                success: function(data){
                    $(obj).parents("tr").find(".td-manage").prepend('<a onClick="grade_makeup(this,'+data+')" href="javascript:;" title="补考" style="text-decoration:none"><i class="Hui-iconfont">&#xe615;</i></a>');
                    $(obj).parents("tr").find(".td-status").html('<span class="label label-success radius" >非补考</span>');
                    $(obj).remove();
                    layer.msg("更新成功",{icon: 1,time:1000})
                },
                error:function(data) {
                    layer.msg('更新失败!',{icon: 5,time:5000});
                },
            });
            ;
        });
    }

    function grade_makeup(obj,id){
        layer.confirm('请确认',function(index){
            $.ajax({
                type: 'POST',
                url: '${path}/grade/updateStatus',
                data: {"grade_no":id,"status":1},
                dataType: "text",
                success: function(data){
                    $(obj).parents("tr").find(".td-manage").prepend('<a onClick="grade_nmakeup(this,'+data+')" href="javascript:;" title="非补考" style="text-decoration:none"><i class="Hui-iconfont">&#xe631;</i></a>');
                    $(obj).parents("tr").find(".td-status").html('<span class="label label-default radius" >补考</span>');
                    $(obj).remove();
                    layer.msg("操作成功", {icon: 6,time:1000});
                },
                error:function(data) {
                    layer.msg("更新失败!",{icon: 5,time:5000});
                    console.log(data.msg);
                },
            });


        });
    }
</script>
</body>
</html>