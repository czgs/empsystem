<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
        <h2>用户登录</h2>
        <div style="color:red">
            <s:actionerror/>
        </div>
        <s:form method="POST" action="userAction_doLogin">
            用户名：<s:textfield name="user.u_name"/><br/>
            密码: <s:password name="user.u_pwd"/><br/>
                <s:submit value="登录"/>
        </s:form>
</body>
</html>
