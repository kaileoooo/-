<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page isELIgnored="false" %>

<html>
<head>
    <meta charset="utf-8">
    <title>会员充值</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/lib/layui-v2.5.5/css/layui.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/public.css" media="all">
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f2f2f2;
        }

        .container {
            max-width: 600px;
            margin: 20px auto;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        h1 {
            text-align: center;
            color: #333;
        }

        .plans {
            display: flex;
            justify-content: space-between;
            margin-top: 20px;
        }

        .plan {
            flex: 1;
            border: 1px solid #ddd;
            padding: 10px;
            text-align: center;
            margin-right: 10px;
        }

        .plan:last-child {
            margin-right: 0;
        }

        .plan-title {
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 10px;
        }

        .plan-price {
            font-size: 24px;
            color: #f00;
            margin-bottom: 10px;
        }

        .plan-description {
            color: #666;
        }

        .select-plan {
            margin-top: 20px;
            text-align: center;
        }

        .select-plan button {
            padding: 10px 20px;
            font-size: 16px;
            color: #fff;
            background-color: #f00;
            border: none;
            cursor: pointer;
        }

        .select-plan button:hover {
            background-color: #d00;
        }
    </style>
</head>
<body>
<div class="layui-form layuimini-form">
    <div class="container">
        <h1>VIP充值页面</h1>
        <div class="plans">
            <div class="plan">
                <div class="plan-title">基础版</div>
                <div class="plan-price">一月</div>
                <input type="radio" name="type" checked value="month" />
            </div>
            <div class="plan">
                <div class="plan-title">高级版</div>
                <div class="plan-price">一季度</div>
                <input type="radio" name="type" value="quarter" />
            </div>
            <div class="plan">
                <div class="plan-title">至尊版</div>
                <div class="plan-price">一年</div>
                <input type="radio" name="type" value="year" />
            </div>
        </div>
        <div class="select-plan layui-form-item">
            <button lay-submit lay-filter="saveBtn">选择计划并充值</button>
        </div>
    </div>

<%--    <div class="layui-form-item">--%>
<%--        <div class="layui-input-block">--%>
<%--            <button class="layui-btn layui-btn-normal" lay-submit lay-filter="saveBtn">确认修改</button>--%>
<%--        </div>--%>
<%--    </div>--%>
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

        //监听提交
        form.on('submit(saveBtn)', function (data) {
            var datas=data.field;//form单中的数据信息
            var radios = document.getElementsByName('type');
            var type;
            for (var i = 0; i < radios.length; i++) {
                if (radios[i].checked) {
                    type=radios[i].value; // 弹出选中的单选框的值
                    break; // 只有一个单选框可以被选中，所以直接退出循环
                }
            }

            //向后台发送数据提交添加
            $.ajax({
                url:"addReaderMemberTime?type="+type,
                type:"get",
                //data:datas,
                contentType:'application/json',
                // data:JSON.stringify(datas),
                success:function(result){
                    if(result.code==0){//如果成功
                        layer.msg('充值成功',{
                            icon:6,
                            time:500
                        },function(){
                            // parent.window.location.reload();
                            // var iframeIndex = parent.layer.getFrameIndex(window.name);
                            // parent.layer.close(iframeIndex);
                        })
                    }else{
                        layer.msg("充值失败");
                    }
                }
            })
            return false;
        });
    });
</script>
</body>
</html>

