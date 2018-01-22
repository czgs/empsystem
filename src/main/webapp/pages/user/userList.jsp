<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.2.1.min.js"></script>
<body>
<div id="strongDiv" style="margin: 0 auto;width: 600px;">
    <h2>用户列表</h2>
    <table id="tab" border="1" width="80%" class="layui-table">
        <tr>
        <td>序号</td><td>用户名</td>
        <td>密码</td><td width="100">级别</td>
        <td>管理</td>
        </tr>
       <%-- <s:iterator var="obj" value="bean.result" status="ids">
        <tr>
            <td>${(bean.cpage-1)*bean.showNum+ids.count}</td><td>${obj.u_name}</td>
            <td>${obj.u_pwd}</td><td>${obj.u_status}</td>
            <td><a href="#">修改</a>|<a href="#">删除</a></td>
         </tr>
        </s:iterator>--%>
    </table>
    <div id="showDiv" style="width: 300px;height: 200px;background-color:aqua;border: 1px red solid;display: none; position: fixed;left: 660px;">
        <div id="showDivTitle"></div>
        <div style="position: absolute; top:50px;">
            <form method='post' id='updateUserDiv'>
                <table>
                <tr>
                <td>账号:<input name="user.u_name"/></td>
                </tr>
                <tr>
                <td>密码:<input name="user.u_pwd"/></td>
                </tr>
                <tr>
                <td id="showDivRadio"></td>
                </tr>
                <tr>
                <td>
                    <input type="button" id="showDivBtn" onclick="doUpdateUserBtn()" value="执行修改"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <input type="button" id="showDivCloseBtn" onclick="closeShowDiv()" value="关闭窗口"/>
                </td>
                </tr>
                </table>
            </form>
        </div>
    </div>

    <input type="button" onclick="window.location='${pageContext.request.contextPath}/pages/main.jsp'" value="返回主页">
</div>
</body>
</html>
<script>
    //页面加载时  自动加载
    $(function () {
        loadData();
    })

    //跳转到哪一页的JS方法  num是接收button传过来的值
    function doPage(num) {
        loadData(num);
    }

    //异步将查询到指定用户的信息加载到 showDiv中
    function toUpdate(uno) {
        $("#showDivTitle").html("").empty();
        if($("#showDiv").css("display")=="none"){
            $("#showDiv").show();
            var url="userAction_toUpdateUser?user.u_no="+uno;
            $.get(url,"",function (data) {
                var user = data.user;
                    $("#showDiv input[name='user.u_name']").val(user.u_name);
                    $("#showDiv input[name='user.u_pwd']").val(user.u_pwd);
                    //(user.u_status==2? $("#showDiv input[name='user.u_status']:eq(2)").prop("checked",true):(user.u_status==1?$("#showDiv input[name='user.u_status']:eq(1)").prop("checked",true):$("#showDiv input[name='user.u_status']:eq(0)").prop("checked",true)))
                    //下面是双重3目运算 判断单选框（职位）checked
                    var input ="<input type='hidden' name='user.u_no' value='"+user.u_no+"'/>";
                        (user.u_status==2?input+="<input type='radio' name='user.u_status' value='2' id='radio2' checked=checked /><label for='radio2'>超级管理员</label>" +
                        "" : (user.u_status==1?input+="<input type='radio' name='user.u_status' value='1' id='radio1' checked=checked /><label for='radio1'>主管</label>&nbsp;&nbsp;<input type='radio' name='user.u_status' value='0' id='radio2'/><label for='radio2'>普通员工</label>" +
                        "" : input+="<input type='radio' name='user.u_status' value='1' id='radio1' /><label for='radio1'>主管</label>&nbsp;&nbsp;<input type='radio' name='user.u_status' value='0' id='radio2'  checked=checked/><label for='radio2'>普通员工</label>" ))
                    $("#showDivRadio").append(input);
            });
        }else{
            closeShowDiv();
        }
    }

    //关闭修改框的js
    function closeShowDiv() {
        $("#showDiv").hide();
        $("#showDiv :not(input[name='user.u_status'],input[name='updateUserBtn'],input[id='showDivBtn'],input[id='showDivCloseBtn'])").val("");
        $("#showDiv input[name='user.u_status'],label,input[name='user.u_no']").remove();
        $("#showDiv td[id='showDivRadio']").html("").empty();
    }

    //执行修改用户信息的JS
    function doUpdateUserBtn() {
        $("#showDivTitle").html("").empty();
        var param = $("#updateUserDiv").serialize();
       $.post("userAction_doUpdateUser?date="+new Date().getTime(),param,function (data) {
            var font = null;
            if(data.msg==1){
                font ="<h4>执行修改成功</h4>";
            }else if(data.msg==0){
                font ="<h4>执行修改失败</h4>";
            }
            $("#showDivTitle").append(font);
            loadData(1);
        },"json");

    }

  /*  $("#closeShowDivBtn").click(function () {
        loadData();
        $("#showDiv").hide().empty();  //不要删除  showDivTitle
    });*/

    //异步加载用户的JS
    function loadData(num) {
        //判断是不是第一次页面加载，第一次页面加载 num是没有值得 所以需要三目运算，如果为空，则页数为1。
        num = num==null?1:num;
        $("#tab tr:not(:first)").remove();
        $.get("userAction_findUserList?bean.cpage="+num,"",function (data) {
            $.each(data.bean.result,function (i,v) {
               var tr="<tr>";
                    tr+="<td>"+((data.bean.cpage-1)*data.bean.showNum+i+1)+"</td>";
                    tr+="<td>"+v.u_name+"</td>";
                    tr+="<td>"+v.u_pwd+"</td>";
                    tr+="<td>"+(v.u_status==0?'普通员工':(v.u_status==1?'主管':'老板'))+"</td>";
                    tr+="<td><button onclick='toUpdate("+v.u_no+")'>修改</button> </td>";
                    tr+="</tr>";
                    $("#tab").append(tr);
            },"json");
            //判断用户data.bean.result，这个list里面为不为空
            if(data.bean.result.length>0&&data.bean.result!=null){
                var upPage = data.bean.cpage-1==0?1:data.bean.cpage-1; //上一页
                var downPage = data.bean.cpage+1>data.bean.allPage?data.bean.allPage:data.bean.cpage+1;
                var tr2="<tr><td colspan='5'> " +
                    "共查询了" +data.bean.allNum+"条数据,当前第" +data.bean.cpage+"页" +
                    "<button onclick='doPage(1)'>首页</button>" +
                    "<button onclick='doPage("+upPage+")'>上一页</button>" +
                    "<button onclick='doPage("+downPage+")'>下一页</button>" +
                    "<button onclick='doPage("+data.bean.allPage+")'>尾页</button> " +
                    "</td></tr>";
                    $("#tab").append(tr2);
            }
         });
    }

</script>
