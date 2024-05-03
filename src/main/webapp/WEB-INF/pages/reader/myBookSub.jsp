<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<%--<%
    String path=request.getContextPath();
    String basePath=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>--%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>我的预约</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/lib/layui-v2.5.5/css/layui.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/public.css" media="all">
    <script src="${pageContext.request.contextPath}/lib/layui-v2.5.5/layui.js" charset="utf-8"></script>
</head>
<body>
<div class="layuimini-container">
    <div class="layuimini-main">

<%--        <div class="demoTable">--%>
<%--            <div class="layui-form-item layui-form ">--%>
<%--                图书编号：--%>
<%--                <div class="layui-inline">--%>
<%--                    <input class="layui-input" name="isbn" id="isbn" autocomplete="off">--%>
<%--                </div>--%>
<%--                书名：--%>
<%--                <div class="layui-inline">--%>
<%--                    <input class="layui-input" name="name" id="name" autocomplete="off">--%>
<%--                </div>--%>
<%--                图书分类：--%>
<%--                <div class="layui-inline">--%>
<%--                    <select id="typeId" name="typeId" lay-verify="required">--%>
<%--                        <option value="">请选择</option>--%>
<%--                    </select>--%>
<%--                </div>--%>
<%--                <button class="layui-btn" data-type="reload">搜索</button>--%>
<%--            </div>--%>
<%--        </div>--%>

        <!--表单，查询出的数据在这里显示-->
        <table class="layui-hide" id="currentTableId" lay-filter="currentTableFilter"></table>

        <script type="text/html" id="currentTableBar">
            {{# if(d.status==0){ }}
                <a class="layui-btn layui-btn-normal layui-btn-xs data-count-edit" lay-event="getBook">取书</a>
                <a class="layui-btn layui-btn-xs layui-btn-danger data-count-delete" lay-event="removeSub">取消预约</a>
            {{# }else { }}

            {{# } }}

        </script>

    </div>
</div>

<script>
    layui.use(['form', 'table'], function () {
        var $ = layui.jquery,
            form = layui.form,
            table = layui.table;



        table.render({
            elem: '#currentTableId',
            url: '${pageContext.request.contextPath}/bookReaderList',//查询类型数据
            toolbar: '#toolbarDemo',
            defaultToolbar: ['filter', 'exports', 'print', {
                title: '提示',
                layEvent: 'LAYTABLE_TIPS',
                icon: 'layui-icon-tips'
            }],
            cols: [[
                {type: "checkbox", width: 50},
                //{field: 'id', width: 100, title: 'ID', sort: true},
                {field: 'orderNum', width: 140, title: '订单编号'},
                {field: 'isbn', width: 100, title: '图书编号'},
                {field: 'name', width: 100, title: '图书名称'},
                {field: 'author', width: 80, title: '作者'},
                {field: 'publish', width: 160, title: '出版社'},
                {field: 'realName', width: 100, title: '真实姓名'},
                {field: 'tel', width: 140, title: '联系方式'},
                {templet:"<div>{{layui.util.toDateString(d.startTime,'yyyy-MM-dd HH:mm:ss')}}</div>", width: 160, title: '预约开始时间'},
                {templet:"<div>{{layui.util.toDateString(d.endTime,'yyyy-MM-dd HH:mm:ss')}}</div>", width: 160, title: '预约结束时间'},
                {field: 'status', width: 110, title: '状态',templet:function(res){
                        if(res.status==0){
                            return '<span class="layui-badge layui-bg-green">未取书</span>'
                        }else if(res.status==1){
                            return '<span class="layui-badge layui-bg-gray">已取书</span>'

                        }else if(res.status==2) {
                            return '<span class="layui-badge layui-bg-yellow">已取消预约</span>'
                        }
                        }},
                {title: '操作', minWidth: 150, toolbar: '#currentTableBar', align: "center"}
            ]],
            limits: [10, 15, 20, 25, 50, 100],
            limit: 15,  <!--默认显示15条-->
            page: true,
            skin: 'line',
            id:'testReload'
        });

        var $ = layui.$, active = {
            reload: function(){
                var name = $('#name').val();
                var isbn = $('#isbn').val();
                var typeId = $('#typeId').val();
                console.log(name)
                //执行重载
                table.reload('testReload', {
                    page: {
                        curr: 1 //重新从第 1 页开始
                    }
                    ,where: {
                        name: name,
                        isbn:isbn,
                        typeId:typeId
                    }
                }, 'data');
            }
        };

        $('.demoTable .layui-btn').on('click', function(){
            var type = $(this).data('type');
            active[type] ? active[type].call(this) : '';
        });

        /**
         * tool操作栏监听事件
         */
        table.on('tool(currentTableFilter)', function (obj) {
            var data=obj.data;
            if (obj.event === 'getBook') {  // 监听修改操作
                var index = layer.open({
                    title: '取书',
                    type: 2,
                    shade: 0.2,
                    maxmin:true,
                    shadeClose: true,
                    area: ['30%', '30%'],
                    content: '${pageContext.request.contextPath}/getBook?id='+data.id,
                });
                $(window).on("resize", function () {
                    layer.full(index);
                });
            } else if (obj.event === 'removeSub') {  // 监听删除操作
                layer.confirm('确定是否取消', function (index) {
                    //调用删除功能
                    deleteInfoByIds(data.id,index);
                    layer.close(index);
                });
            }
        });

        //监听表格复选框选择
        table.on('checkbox(currentTableFilter)', function (obj) {
            console.log(obj)
        });

        /**
         * 获取选中记录的id信息
         */
        function getCheackId(data){
            var arr=new Array();
            for(var i=0;i<data.length;i++){
                arr.push(data[i].id);
            }
            //拼接id,变成一个字符串
            return arr.join(",");
        };


        /**
         * 提交取消预约功能
         */
        function deleteInfoByIds(ids ,index){
            //向后台发送请求
            $.ajax({
                url: "removeSub",
                type: "POST",
                data: {ids: ids},
                success: function (result) {
                    if (result.code == 0) {//如果成功
                        layer.msg('取消成功', {
                            icon: 6,
                            time: 500
                        }, function () {
                            parent.window.location.reload();
                            var iframeIndex = parent.layer.getFrameIndex(window.name);
                            parent.layer.close(iframeIndex);
                        });
                    } else {
                        layer.msg("取消失败");
                    }
                }
            })
        };

        /**
         * toolbar栏监听事件
         */
        table.on('toolbar(currentTableFilter)', function (obj) {
            if (obj.event === 'add') {  // 监听添加操作
                var index = layer.open({
                    title: '添加图书',
                    type: 2,
                    shade: 0.2,
                    maxmin:true,
                    shadeClose: true,
                    area: ['100%', '100%'],
                    content: '${pageContext.request.contextPath}/bookAdd',
                });
                $(window).on("resize", function () {
                    layer.full(index);
                });
            } else if (obj.event === 'delete') {
                /*
                  1、提示内容，必须删除大于0条
                  2、获取要删除记录的id信息
                  3、提交删除功能 ajax
                */
                //获取选中的记录信息
                var checkStatus=table.checkStatus(obj.config.id);
                var data=checkStatus.data;
                if(data.length==0){//如果没有选中信息
                    layer.msg("请选择要删除的记录信息");
                }else{
                    //获取记录信息的id集合,拼接的ids
                    var ids=getCheackId(data);
                    layer.confirm('确定是否取消', function (index) {
                        //调用删除功能
                        deleteInfoByIds(ids,index);
                        layer.close(index);
                    });
                }
            }
        });

    });
</script>

</body>
</html>
