<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.2.1.min.js"></script>
<body>
<%--<div id="responseDiv"></div>
<div>
    <form id="addNoticeForm">
        <input name="notice.user.u_no" type="hidden" value="${loginUser.u_no}">
    <table>
        <tr>
            <td>标题:</td><td><input placeholder="请输入标题" name="notice.n_titel"></td>
        </tr>
        <tr>
            <td>详细内容:</td><td><textarea rows="5" cols="60" name="notice.n_content"></textarea></td>
        </tr>
        <tr>
            <td>创建时间:</td><td><input type="date" name="notice.n_date"/></td>
        </tr>
        <tr>
            <td rowspan="2"><input type="button" id="addNoticeBtn" value="发布" /></td>
        </tr>

    </table>
    </form>
    <input type="button" onclick="window.location='${pageContext.request.contextPath}/pages/main.jsp'" value="返回主页">
</div>--%>
<form class="layui-form" action="" style="margin: 0 auto;width: 50%;">
    <input name="notice.user.u_no" type="hidden" value="${loginUser.u_no}">
    <div class="layui-form-item">
        <label class="layui-form-label">标&nbsp;题&nbsp;：</label>
        <div class="layui-input-inline">
            <input type="text" name="notice.n_titel" required  lay-verify="required" placeholder="请输入标题" autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item layui-form-text">
        <label class="layui-form-label">详细内容：</label>
        <div class="layui-input-block" style="width: 500px;">
            <textarea name="notice.n_content" lay-verify="required" placeholder="请输入内容" class="layui-textarea"></textarea>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">创建时间：</label>
        <div class="layui-inline"> <!-- 注意：这一层元素并不是必须的 -->
            <input type="text" name="notice.n_date" lay-verify="required" placeholder="点击选择时间" class="layui-input" id="noticeInputDateId">
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-input-block">
            <div class="layui-btn" lay-submit lay-filter="formDemo">立即提交</div>
            <button type="reset" id="resetBtn" class="layui-btn layui-btn-primary">重置</button>
        </div>
    </div>
</form>

</body>
</html>
<script src="${pageContext.request.contextPath}/layui/layui.js"></script>
<script>
    //layui开始--------------------------------------------------------------------
    laydate.render({
        elem: '#noticeInputDateId'
    });
    form.on('submit(formDemo)', function(data){
        //layer.msg(JSON.stringify(data.field));
        $.post("${pageContext.request.contextPath}/noticeAction_addNotice",data.field,function (data) {
            if(data.msg==1){
                layer.msg("添加成功");
                $("#resetBtn").click();
            }else if (data.msg==0){
                layer.msg("添加失败");
            }
        },"json");
    });
    //layui结束--------------------------------------------------------------------
    /*$("#addNoticeBtn").click(function () {
        var param = $("#addNoticeForm").serialize();
        console.log(param);
        $("#responseDiv").empty();
        $.post("noticeAction_addNotice",param,function (data) {
            var font ="";
            if(data.msg==1){
                font+="<h3>添加公告成功</h3>";
            }else if (data.msg==0){
                font+="<h3 style='color:red;'>添加失败</h3>"
            }
            $("#responseDiv").append(font);
        },"json")
    });*/
</script>
