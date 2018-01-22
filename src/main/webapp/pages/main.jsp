<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="s" uri="/struts-tags" %>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>layout 后台大布局 - Layui</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css"/>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.2.1.min.js"></script>
</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
    <div class="layui-header">
        <div class="layui-logo">layui 后台布局</div>
        <!-- 头部区域（可配合layui已有的水平导航） -->
        <ul class="layui-nav layui-layout-left">
            <li class="layui-nav-item"><a href="">控制台</a></li>
            <li class="layui-nav-item"><a href="">用户</a></li>
            <li class="layui-nav-item">
                <a href="javascript:;">其它系统</a>
                <dl class="layui-nav-child">
                    <dd><a href="">邮件管理</a></dd>
                    <dd><a href="">消息管理</a></dd>
                    <dd><a href="">授权管理</a></dd>
                </dl>
            </li>
        </ul>
        <ul class="layui-nav layui-layout-right">
            <li class="layui-nav-item">
                <a href="javascript:;">
                    <img src="http://t.cn/RCzsdCq" class="layui-nav-img">
                    贤心
                </a>
                <dl class="layui-nav-child">
                    <dd><a href="">基本资料</a></dd>
                    <dd><a href="">安全设置</a></dd>
                </dl>
            </li>
            <li class="layui-nav-item"><a href="">退了</a></li>
        </ul>
    </div>
    <!----------------------------------------------------管理员显示的内容------------------------------------------------->
    <s:if test="#session.loginUser.u_status==2">
    <div class="layui-side layui-bg-black">
        <div class="layui-side-scroll">
            <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
            <ul class="layui-nav layui-nav-tree"  lay-filter="test">
                <li class="layui-nav-item">
                    <a class="" href="javascript:;">公告管理</a>
                    <dl class="layui-nav-child">
                        <dd><a href="javascript:loadMethod('addNotice');">发布公告</a></dd>
                        <dd><a href="javascript:loadMethod('noticeList');">查询所有公告&管理</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item">
                    <a class="" href="javascript:;">用户管理</a>
                    <dl class="layui-nav-child">
                        <dd><a href="javascript:loadMethod('addSuperUser');">添加老板用户</a></dd>
                        <dd><a href="javascript:loadMethod('userList');">所有用户&管理</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item">
                    <a href="javascript:;">部门管理</a>
                    <dl class="layui-nav-child">
                        <dd><a href="javascript:loadMethod('addDept');">添加部门</a></dd>
                        <dd><a href="javascript:loadMethod('deptList');">部门列表</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item">
                    <a href="javascript:;">基本工资</a>
                    <dl class="layui-nav-child">
                        <dd><a href="javascript:loadMethod('addSalary');">工资添加</a></dd>
                        <dd><a href="javascript:loadMethod('salaryList');">查询基本工资</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item">
                    <a href="javascript:;">员工管理</a>
                    <dl class="layui-nav-child">
                        <dd><a href="javascript:loadMethod('addEmp');">添加员工</a></dd>
                        <dd><a href="javascript:loadMethod('empList');">查询员工&管理</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item">
                    <a href="javascript:;">员工奖罚工资</a>
                    <dl class="layui-nav-child">
                        <dd><a href="javascript:loadMethod('addSalaryInfo');">添加员工奖罚</a></dd>
                        <dd><a href="javascript:loadMethod('realSalaryList');">查询考勤实际记录</a></dd>
                    </dl>
                </li>
            </ul>
        </div>
    </div>
    </s:if>
    <s:elseif test="#session.loginUser.u_status==0">
        <div class="layui-side layui-bg-black">
            <div class="layui-side-scroll">
                <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
                <ul class="layui-nav layui-nav-tree"  lay-filter="test">
                    <li class="layui-nav-item">
                        <a class="" href="javascript:;">公告管理</a>
                        <dl class="layui-nav-child">
                            <dd><a href="javascript:loadMethod('noticeList');">查询所有公告</a></dd>
                        </dl>
                    </li>
                </ul>
            </div>
        </div>
    </s:elseif>

    <div class="layui-body">
        <!-- 内容主体区域 -->
        <div style="padding: 15px;" id="box">内容主体区域</div>
    </div>

    <div class="layui-footer">
        <!-- 底部固定区域 -->
        © layui.com - 底部固定区域
    </div>
</div>
<script src="${pageContext.request.contextPath}/layui/layui.js"></script>
<script>
    var form;
    var laydate;
    //JavaScript代码区域
    layui.use(['element','form','laydate'], function(){
        var element = layui.element;
        form = layui.form;
        laydate = layui.laydate;
    });

    function loadMethod(location) {
        if(location=='addSuperUser'){
            $("#box").html("").load("${pageContext.request.contextPath}/pages/user/addSuperUser.jsp");
        }else if(location=='userList'){
            $("#box").html("").load("${pageContext.request.contextPath}/pages/user/userList.jsp");
        }else if(location=='addDept'){
            $("#box").html("").load("${pageContext.request.contextPath}/pages/dept/addDept.jsp");
        }else if(location=='deptList'){
            $("#box").html("").load("${pageContext.request.contextPath}/pages/dept/deptList.jsp");
        }else if(location=='addSalary'){
            $("#box").html("").load("${pageContext.request.contextPath}/pages/salary/addSalary.jsp");
        }else if(location=='salaryList'){
            $("#box").html("").load("${pageContext.request.contextPath}/pages/salary/salaryList.jsp");
        }else if(location=='addEmp'){
            $("#box").html("").load("${pageContext.request.contextPath}/pages/emp/addEmp.jsp");
        }else if(location=='empList'){
            $("#box").html("").load("${pageContext.request.contextPath}/pages/emp/empList.jsp");
        }else if(location=='addSalaryInfo'){
            $("#box").html("").load("${pageContext.request.contextPath}/pages/salaryInfo/addSalaryInfo.jsp");
        }else if(location=='realSalaryList'){
            $("#box").html("").load("${pageContext.request.contextPath}/pages/realSalary/realSalaryList.jsp");
        }else if(location=='addNotice'){
            $("#box").html("").load("${pageContext.request.contextPath}/pages/notice/addNotice.jsp");
        }else if(location=='noticeList'){
            $("#box").html("").load("${pageContext.request.contextPath}/pages/notice/noticeList.jsp");
        }
    }
</script>
</body>
</html>

<%--<html>
<head>
    <title>Title</title>
</head>
<body>
    <h3>员工管理系统</h3>
    <s:if test="#session.loginUser!=null">
    <h4>
        用户:${loginUser.u_name}，身份：
        <s:if test="#session.loginUser.u_status==2">
            超级管理员
        </s:if>
        <s:elseif test="#session.loginUser.u_status==1">
            普通管理员
        </s:elseif>
        <s:elseif test="#session.loginUser.u_status==0">
            普通员工
        </s:elseif>
    </h4>
    </s:if>

    <s:if test="#session.loginUser.u_status==2">
        <h4>用户管理</h4>
        <ul>
            <li><a href="${pageContext.request.contextPath}/pages/user/addSuperUser.jsp">添加老板用户</a></li>
            <li><a href="${pageContext.request.contextPath}/pages/user/userList.jsp">用户列表</a></li>
        </ul>
        <h4>部门管理</h4>
        <ul>
            <li><a href="${pageContext.request.contextPath}/pages/dept/addDept.jsp">部门添加</a></li>
            <li><a href="${pageContext.request.contextPath}/pages/dept/deptList.jsp">部门列表</a></li>
        </ul>
        <h4>基本工资</h4>
        <ul>
            <li><a href="${pageContext.request.contextPath}/pages/salary/addSalary.jsp">工资添加</a></li>
            <li><a href="${pageContext.request.contextPath}/pages/salary/salaryList.jsp">工资列表查询</a></li>
        </ul>
        <h4>公告管理</h4>
        <ul>
            <li><a href="${pageContext.request.contextPath}/pages/notice/addNotice.jsp">发布公告</a></li>
            <li><a href="${pageContext.request.contextPath}/pages/notice/noticeList.jsp">查询所有公告</a></li>
        </ul>
        <h4>员工添加</h4>
        <ul>
            <li><a href="${pageContext.request.contextPath}/pages/emp/addEmp.jsp">添加员工</a></li>
            <li><a href="${pageContext.request.contextPath}/pages/emp/empList.jsp">查询所有员工</a></li>
        </ul>
        <h4>员工奖罚工资变动</h4>
        <ul>
            <li><a href="${pageContext.request.contextPath}/pages/salaryInfo/addSalaryInfo.jsp">添加员工奖罚</a></li>
            <li><a href="${pageContext.request.contextPath}/pages/realSalary/realSalaryList.jsp">查询考勤实际记录</a></li>
        </ul>
    </s:if>
    <s:elseif test="#session.loginUser.u_status==0">
        <h4>公告查询</h4>
        <ul>
            <li><a href="${pageContext.request.contextPath}/pages/notice/noticeList.jsp">查询所有公告</a></li>
        </ul>
    </s:elseif>
</body>
</html>--%>

