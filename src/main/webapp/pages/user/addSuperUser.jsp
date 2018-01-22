<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="/struts-tags" prefix="s" %>
<html>
<head>
    <title>Title</title>
</head>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.2.1.min.js"></script>
<body>
<%--<h2>注册老板账号</h2>
<s:if test="#parameters.msg[0]==1">
    <div style="color:green; font-weight:700;">
        注册成功!<br/>
    </div>
</s:if>
<s:elseif test="#parameters.msg[0]==0">
    <div style="color:red; font-weight:700;">
        注册失败!不能有重复的用户名<br/>
    </div>
</s:elseif>
<s:form method="post" action="userAction_doAddUser">
    <s:hidden name="user.u_status" value="2"/>
    用户名:<s:textfield name="user.u_name"/><br/>
    密码:<s:textfield name="user.u_pwd"/><br/>
    <s:submit value="注册"/>
</s:form>
<input type="button" onclick="window.location='${pageContext.request.contextPath}/pages/main.jsp'" value="返回主页">--%>
    <form class="layui-form" action="" style="margin: 0 auto;width: 50%;">
        <input type="hidden" name="user.u_status" value="2">
        <div class="layui-form-item">
            <label class="layui-form-label">账号：</label>
            <div class="layui-input-inline">
                <input type="text" name="user.u_name" required  lay-verify="required" placeholder="请输入账号" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">密码：</label>
            <div class="layui-input-inline">
                <input type="password" name="user.u_pwd" required lay-verify="required" placeholder="请输入密码" autocomplete="off" class="layui-input">
            </div>
            <div class="layui-form-mid layui-word-aux">辅助文字</div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-block">
                <div class="layui-btn" lay-submit lay-filter="userSubmit">立即注册</div>
                <button type="reset" id="resetBtn" class="layui-btn layui-btn-primary">重置</button>
            </div>
        </div>
    </form>
</body>
<script src="${pageContext.request.contextPath}/layui/layui.js"></script>
</html>
<script>
    form.on('submit(userSubmit)', function(data){
        //layer.msg(JSON.stringify(data.field));
        $.post("userAction_doAddUser",data.field,function (data) {
            if(data.msg==1){
                layer.msg("添加成功");
                $("#resetBtn").click();
            }else if (data.msg==0){
                layer.msg("添加失败");
            }
        },"json");
    });
</script>

