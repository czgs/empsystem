
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.2.1.min.js"></script>
<body>
    <div id="titelDiv"></div>
    <table border="1" id="tab">
        <tr>
            <td>编号</td><td>头像</td>
            <td>名称</td><td>年龄</td>
            <td>性别</td><td>用户账号</td>
            <td>部门</td><td>基本工资</td>
            <td>职位</td><td>操作</td>
        </tr>
    </table>
    <!--下面是添加员工详细信息的div-->
    <div id="saveEmpInfoDiv" style="display: none">
    <form id="saveEmpInfoFrm">
        <input type="hidden" name="empInfo.emp.e_no"/>
    <table>
        <tr>
            <td>省份</td><td><input name="empInfo.ei_province"/></td>
        </tr>
        <tr>
            <td>城市</td><td><input name="empInfo.ei_city"/></td>
        </tr>
        <tr>
            <td>详细住址</td><td><input name="empInfo.ei_address"/></td>
        </tr>
        <tr>
            <td>民族</td><td><input name="empInfo.ei_nation"/></td>
        </tr>
        <tr>
            <td>身份证</td><td><input name="empInfo.ei_card"/></td>
        </tr>
        <tr>
            <td>入职时间</td><td><input type="date" name="empInfo.ei_date"/></td>
        </tr>
        <tr>
            <td>手机号</td><td><input name="empInfo.ei_tel"/></td>
        </tr>
        <tr>
            <td>QQ号</td><td><input name="empInfo.ei_qq"/></td>
        </tr>
        <tr>
            <td>微信号</td><td><input name="empInfo.ei_wechar"/></td>
        </tr>
        <tr>
            <td>爱好</td><td><input name="empInfo.ei_hobby"/></td>
        </tr>
        <tr>
            <td>座右铭</td><td><input name="empInfo.ei_motto"/></td>
        </tr>
        <tr>
            <td><input type="button" onclick="doSaveEmpInfo()" value="添加详细信息"/></td>
        </tr>
    </table>
    </form>
    </div>
    <!--下面是修改员工查看员工所有详细信息的div-->
    <div id="findEmpInfoDiv" style="display: none;">
        <form id="findEmpInfoFrm">
                    <input type="hidden" name="empInfo.ei_no"/>
                    <input type="hidden" name="emp.e_no"/>
                    <input type="hidden" name="user.u_no"/>
                    <input type="hidden" name="hiddenImage"/>
            <table>
                <tr>
                    <td>员工头像:</td>
                    <td>
                        <img src="" id="empImageImgById" style="width: 80px;height: 80px;display: none;"/>
                        <input type="file" name="empImage" id="empImageInputById"/>
                    </td>
                </tr>
                <tr>
                    <td>员工姓名:</td><td><input placeholder="请输入姓名" name="emp.e_name"></td>
                </tr>
                <tr>
                    <td>员工年龄:</td><td><input name="emp.e_age"/></td>
                </tr>
                <tr>
                    <td>员工性别:</td>
                    <td id="empInfoSexRaidoTd">
                    </td>
                </tr>
                <tr>
                    <td>所属部门:</td>
                    <td>
                        <select id="deptSelect" name="emp.dept.d_no">
                            <option value="">选择部门</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>基本工资:</td>
                    <td>
                        <select id="salarySelect" name="emp.salary.s_no">
                            <option value="">选择工资</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>账号</td>
                    <td>
                        <input name="user.u_name"/><div id="userNameDiv"></div>
                    </td>
                </tr>
                <tr>
                    <td>密码</td>
                    <td>
                        <input  name="user.u_pwd"/>
                    </td>
                </tr>
                <tr>
                    <td>职位</td>
                    <td id="empInfoStatusRaidoTd">
                    </td>
                </tr>
                <!--下面是详细资料信息-->
                <tr>
                    <td>省份</td><td><input name="empInfo.ei_province"/></td>
                </tr>
                <tr>
                    <td>城市</td><td><input name="empInfo.ei_city"/></td>
                </tr>
                <tr>
                    <td>详细住址</td><td><input name="empInfo.ei_address"/></td>
                </tr>
                <tr>
                    <td>民族</td><td><input name="empInfo.ei_natio"/></td>
                </tr>
                <tr>
                    <td>身份证</td><td><input name="empInfo.ei_card"/></td>
                </tr>
                <tr>
                    <td>入职时间</td><td><input type="date" name="empInfo.ei_date"/></td>
                </tr>
                <tr>
                    <td>手机号</td><td><input name="empInfo.ei_tel"/></td>
                </tr>
                <tr>
                    <td>QQ号</td><td><input name="empInfo.ei_qq"/></td>
                </tr>
                <tr>
                    <td>微信号</td><td><input name="empInfo.ei_wechar"/></td>
                </tr>
                <tr>
                    <td>爱好</td><td><input name="empInfo.ei_hobby"/></td>
                </tr>
                <tr>
                    <td>座右铭</td><td><input name="empInfo.ei_motto"/></td>
                </tr>
                <tr>
                    <td><input type="button" id="doUpdateEmpInfoBtn" onclick="doUpdateEmpInfo()" value="执行修改信息"/></td>
                </tr>
            </table>
        </form>
    </div>
</body>
</html>
<script>
    $(function () {
        loadData();
    })


    //执行修改员工所有详细信息
    function doUpdateEmpInfo() {
        $("#titelDiv").html("").empty();
        //使用FormData方法，传入表单，获取表单信息
        var form = new FormData(document.getElementById("findEmpInfoFrm"));
        //使用异步
        $.ajax({
            url:"empAction_updateEmpInfo",
            type:"post",
            //这里的data相当于post方法的param
            data:form,
            //这两个极为重要，必须要设置为false
            processData:false,
            contentType:false,
            success:function (data) {
                if(data.msg==1){
                    var font ="<h3>修改员工详细信息成功</h3>";
                    $("#titelDiv").append(font);
                    loadData();
                    closeFindEmpInfo();
                }else{
                    var font ="<h3>修改员工详细信息失败</h3>";
                    $("#titelDiv").append(font);
                }
            }
        });
    }

    //下面是上传并预览图片的操作
     $("#empImageInputById").change(function () {
            var objUrl = getObjectURL(this.files[0]);
            console.log("objUrl = "+objUrl );
            if(objUrl){
                $("#empImageImgById").attr("src",objUrl);
                $("#empImageImgById").show();
            }
     });
    //建立一個可存取到該file的url
    function getObjectURL(file) {
        var url = null;
        if(window.createObjectURL!=undefined){
            url = window.createObjectURL(file) ;
        }else if (window.URL!=undefined)
        {
            url = window.URL.createObjectURL(file) ;
        }else if (window.webkitURL!=undefined) {
            url = window.webkitURL.createObjectURL(file) ;
        }
        return url ;
    }

    //加载所有员工基本信息
    function loadData() {
        $("#tab tr:not(:first)").remove();
        $.get("empAction_findEmpList","",function (data) {
            $.each(data.empList,function (i,v) {
                var tr="<tr>";
                    tr+="<td>"+i+"</td>";

                    if(v[0].e_image!=null&&v[0].e_image.length>0){
                        tr+="<td><img style='width:50px;height:50px;' src='${pageContext.request.contextPath}/images/"+v[0].e_image+"'/></td>";
                    }else{
                        tr+="<td>未上传图片</td>";
                    }
                    tr+="<td>"+v[0].e_name+"</td>";
                    tr+="<td>"+v[0].e_age+"</td>";
                    tr+="<td>"+v[0].e_sex+"</td>";
                    tr+="<td>"+v[0].user.u_name+"</td>";
                    tr+="<td>"+v[0].dept.d_name+"</td>";
                    tr+="<td>"+v[0].salary.s_salary+"</td>";
                    tr+="<td>"+v[0].user.u_status+"</td>";
                    if(v[1]==null){
                        tr+="<td><input type='button' onclick='toSaveEmpInfo("+v[0].e_no+")' value='完善详细资料'/></td>";
                    }else{
                        tr+="<td><input type='button' onclick='findEmpInfo("+v[1].ei_no+")' value='查看所有资料'/></td>";
                    }
                    tr+="</tr>";
                    $("#tab").append(tr);
            })
        },"json")
    }

    //去到添加所有员工详细信息
    function toSaveEmpInfo(eno) {
        if($("#saveEmpInfoDiv").css("display")=="none"){
            $("#saveEmpInfoDiv").show();
            $("#saveEmpInfoFrm input[name='empInfo.emp.e_no']").val(eno);
        }else{
            closeSaveEmpInfo();
        }
    }
    //执行完善
    function doSaveEmpInfo() {
       var param = $("#saveEmpInfoFrm").serialize();
       $.post("empAction_addEmpInfo",param,function (data) {
           if(data.msg==1){
               alert("完善信息成功");
               loadData();
               closeSaveEmpInfo();
           }else if(data.msg==0){
               alert("完善信息失败");
           }
       });
    }
    //关闭完善详细信息的div
    function closeSaveEmpInfo() {
        $("#saveEmpInfoDiv").val("");
        $("#saveEmpInfoDiv").hide();
    }

    //查看员工个人所有详细信息
    function findEmpInfo(ei_no){
        if($("#findEmpInfoDiv").css("display")=="none"){
            deptSelect();   //启动加载部门js方法
            salarySelect(); //启动加载工资js方法
            $("#findEmpInfoDiv").show();
            $.get("empAction_findEmpInfoById?empInfo.ei_no="+ei_no,"",function (data) {
                var empInfo = data.empInfo;
                var dno = empInfo.emp.dept.d_no; //部门编号
                var salary = empInfo.emp.salary.s_no;   //工资编号
                var image = " ${pageContext.request.contextPath}/images/"+empInfo.emp.e_image;   //头像地址
                $("#findEmpInfoDiv select[name='emp.dept.d_no']").val(dno);     //选中部门
                $("#findEmpInfoDiv select[name='emp.salary.s_no']").val(salary); //选中工资
                //判断有没有头像,有的话就显示头像
                if(image!=null&&image.length>=0){
                    $("#empImageImgById").show();
                    $("#empImageImgById").attr("src",image);
                }
                $("#findEmpInfoDiv input[name='empInfo.ei_no']").val(empInfo.ei_no);            //绑定员工详细信息的编号
                $("#findEmpInfoDiv input[name='emp.e_no']").val(empInfo.emp.e_no);              //绑定员工编号
                $("#findEmpInfoDiv input[name='user.u_no']").val(empInfo.emp.user.u_no);        //绑定员工用户编号
                $("#findEmpInfoDiv input[name='hiddenImage']").val(empInfo.emp.e_image);        //将图片的地址用隐藏于保存到后台，赋值
                $("#findEmpInfoDiv input[name='emp.e_name']").val(empInfo.emp.e_name);  //绑定员工姓名
                $("#findEmpInfoDiv input[name='emp.e_age']").val(empInfo.emp.e_age);    //绑定员工年龄
                $("#findEmpInfoDiv input[name='user.u_name']").val(empInfo.emp.user.u_name); //绑定员工账号
                $("#findEmpInfoDiv input[name='user.u_pwd']").val(empInfo.emp.user.u_pwd);   //绑定员工密码
                $("#findEmpInfoDiv input[name='empInfo.ei_province']").val(empInfo.ei_province);    //绑定员工省份
                $("#findEmpInfoDiv input[name='empInfo.ei_city']").val(empInfo.ei_city);            //绑定员工城市
                $("#findEmpInfoDiv input[name='empInfo.ei_address']").val(empInfo.ei_address);      //绑定员工详细住址
                $("#findEmpInfoDiv input[name='empInfo.ei_natio']").val(empInfo.ei_natio);        //绑定员工民主
                $("#findEmpInfoDiv input[name='empInfo.ei_card']").val(empInfo.ei_card);            //绑定员工身份证
                $("#findEmpInfoDiv input[name='empInfo.ei_date']").val(empInfo.ei_date.substring(0,10));//绑定员工入职时间
                $("#findEmpInfoDiv input[name='empInfo.ei_tel']").val(empInfo.ei_tel);  //绑定员工手机号
                $("#findEmpInfoDiv input[name='empInfo.ei_qq']").val(empInfo.ei_qq);    //绑定员工QQ号
                $("#findEmpInfoDiv input[name='empInfo.ei_wechar']").val(empInfo.ei_wechar);    //绑定员工微信号
                $("#findEmpInfoDiv input[name='empInfo.ei_hobby']").val(empInfo.ei_hobby);  //绑定员工爱好
                $("#findEmpInfoDiv input[name='empInfo.ei_motto']").val(empInfo.ei_motto);  //绑定员工座右铭

                //设置性别 职位 单选框选中
                var input="";
                var inputTwo="";
                var sex = empInfo.emp.e_sex;
                var status = empInfo.emp.user.u_status;
                if(sex=='男'){
                    input+="<input type='radio' name='emp.e_sex' id='checkRadioSex' value='男' checked/><label for='checkRadioSex'>男</label>";
                    input+="<input type='radio' name='emp.e_sex' id='checkRadioSexTwo' value='女'/><label for='checkRadioSexTwo'>女</label>";
                }else if(sex=='女'){
                    input+="<input type='radio' name='emp.e_sex' id='checkRadioSex' value='男' /><label for='checkRadioSex'>男</label>";
                    input+="<input type='radio' name='emp.e_sex' id='checkRadioSexTwo' value='女' checked/><label for='checkRadioSexTwo'>女</label>";
                }

                if(status==1){
                    inputTwo+="<input type='radio' name='user.u_status' id='checkRadioStatus' value='1' checked/><label for='checkRadioStatus'>主管</label>";
                    inputTwo+="<input type='radio' name='user.u_status' id='checkRadioStatus' value='0' /><label for='checkRadioStatus'>普通员工</label>";
                }else if(status==0){
                    inputTwo+="<input type='radio' name='user.u_status' id='checkRadioStatus' value='1' /><label for='checkRadioStatus'>主管</label>";
                    inputTwo+="<input type='radio' name='user.u_status' id='checkRadioStatus' value='0' checked/><label for='checkRadioStatus'>普通员工</label>";
                }


                $("#empInfoSexRaidoTd").append(input);
                $("#empInfoStatusRaidoTd").append(inputTwo);
            },"json")
        }else{
            closeFindEmpInfo();
        }
    }
    


    //关闭查询个人所有详细信息窗口
    function closeFindEmpInfo() {
        $("#findEmpInfoDiv").hide();
        $("#findEmpInfoDiv input[name='empInfo.emp.e_sex'],label,input[name='empInfo.emp.user.u_status']").remove();
        $("#findEmpInfoDiv td[id='empInfoSexRaidoTd'],td[id='empInfoStatusRaidoTd'],select").html("").val("").empty();
        $("#findEmpInfoDiv :not(input[id='doUpdateEmpInfoBtn'])").val("");
    }

    //加载部门到select
    function deptSelect() {
        $.get("deptAction_findDeptList","",function (data) {
            $.each(data.deptList,function (i,v) {
                var option = "<option value='"+v.d_no+"'>"+v.d_name+"</option>";
                $("#deptSelect").append(option);
            })
        },"json");
    }

    //加载工资到select
    function salarySelect() {
        $.get("salaryAction_findSalaryList","",function (data) {
            $.each(data.salaryList,function (i,v) {
                var option = "<option value='"+v.s_no+"'>"+v.s_salary+"元</option>";
                $("#salarySelect").append(option);
            })
        },"json");
    }

</script>