<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
    <meta charset="utf-8">
    <title>预约图书</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/lib/layui-v2.5.5/css/layui.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/public.css" media="all">
    <style>
        body {
            background-color: #ffffff;
        }
    </style>
</head>
<body>
<div class="layui-form layuimini-form">
    <input type="hidden" name="bookId"   value="${info.bookId}">
    <div class="layui-form-item">
        <label class="layui-form-label required">图书名称</label>
        <div class="layui-input-block">
            <input type="text" readonly name="name" lay-verify="required"  value="${info.name}" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label required">图书编号</label>
        <div class="layui-input-block">
            <input type="text" readonly name="isbn" lay-verify="required"value="${info.isbn}"  class="layui-input">
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label required">图书作者</label>
        <div class="layui-input-block">
            <input type="text" readonly name="author" lay-verify="required" value="${info.author}"   class="layui-input">
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label required">图书出版社</label>
        <div class="layui-input-block">
            <input type="text" readonly name="publish" lay-verify="required" value="${info.publish}"   class="layui-input">
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label required">姓名</label>
        <div class="layui-input-block">
            <input type="text" readonly name="realName"  value="${info.realName}"   class="layui-input">
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label required">联系方式</label>
        <div class="layui-input-block">
            <input type="text" readonly name="tel"  value="${info.tel}"   class="layui-input">
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">预约开始日期</label>
        <div class="layui-input-block">
            <input type="text" name="startTime" id="date"
                   lay-verify="date" autocomplete="off" class="layui-input"/>
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">预约结束日期</label>
        <div class="layui-input-block">
            <input type="text" name="endTime" id="date2"
                   lay-verify="date" autocomplete="off" class="layui-input"/>
        </div>
    </div>

    <div class="layui-form-item">
        <div class="layui-input-block">
            <button class="layui-btn layui-btn-normal" lay-submit lay-filter="saveBtn">确认预约</button>
        </div>
    </div>
</div>
<script src="${pageContext.request.contextPath}/lib/layui-v2.5.5/layui.js" charset="utf-8"></script>
<script>
    layui.use(['form','laydate'], function () {
        var form = layui.form,
            layer = layui.layer,
            laydate=layui.laydate,
            $ = layui.$;

        //日期
        laydate.render({
            elem: '#date',
            trigger:'click'
        });
        //日期
        laydate.render({
            elem: '#date2',
            trigger:'click'
        });


        //监听提交
        form.on('submit(saveBtn)', function (data) {
            var datas=data.field;//form单中的数据信息
            //向后台发送数据提交添加
            $.ajax({
                url:"addBookReader",
                type:"POST",
                // data:datas,
                contentType:'application/json',
                data:JSON.stringify(datas),
                success:function(result){
                    if(result.code==0){//如果成功
                        layer.msg('预约成功',{
                            icon:6,
                            time:500
                        },function(){
                            parent.window.location.reload();
                            var iframeIndex = parent.layer.getFrameIndex(window.name);
                            parent.layer.close(iframeIndex);
                        })
                    }else{
                        layer.msg(result.msg);
                    }
                }
            })
            return false;
        });
    });
</script>
</body>
</html>

