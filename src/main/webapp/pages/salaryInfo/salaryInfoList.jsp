<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.2.1.min.js"></script>
<body>
    <!--查询年月所有员工考勤div-->
    <div id="yearMonthSalaryInfoDiv">
        <form id="conditionFrm">
            输入年份：<input name="querys" id="yearQuerys" type="text" placeholder="输入数字年份,如：2018"/><br/>
            选择年月：<input name="querys" id="monthQuerys" type="month"/><br/>
            <input type="reset" value="重新选择"/>
            <input type="button" value="查询" onclick="findSalaryInfoCondition()" />
        </form>
    <table border="1" id="tab">
        <tr>
        <td>编号</td><td>姓名</td><td>部门</td>
        <td>基本工资</td><td>奖罚统计</td>
        <td>实际工资</td><td>操作</td>
        </tr>
    </table>
    </div>

    <!--指定员工考勤年月中的div-->
    <div id="salaryInfoEmpByIdDiv" style="display: none;">
    <table border="1" id="salaryInfoEmpByIdTab">
        <tr>
        <td>编号</td><td>姓名</td><td>类型</td>
        <td>考勤标题</td><td>考勤详细内容</td>
        <td>发表时间</td><td>奖金&罚金</td>
        <td>操作</td>
        </tr>
    </table>
        <input type="button" value="关闭" onclick="closeSalaryInfoEmpByIdDiv()"/>
    </div>

    <!--修改员工考勤的div-->
    <div id="updateSalaryInFoById" style="display: none;">
        <form id="updateSalaryInfoByIdFrm">
            <input type="hidden" name="salaryInfo.si_no"/>
            <input type="hidden" name="salaryInfo.emp.e_no"/>
            <table border="1">
                <tr>
                    <td>员工名称:</td>
                    <td>
                        <input name="salaryInfo.emp.e_name" disabled="disabled"/>
                    </td>
                </tr>
                <tr>
                    <td>标题名:</td><td><input name="salaryInfo.si_titel"/></td>
                </tr>
                <tr>
                    <td>详情内容:</td><td><textarea rows="5" cols="60" name="salaryInfo.si_content"></textarea></td>
                </tr>
                <tr>
                    <td>发表时间:</td><td><input type="date" name="salaryInfo.si_time"/></td>
                </tr>
                <tr>
                    <td>考勤类型:</td>
                    <td>
                        <input type="radio" name="salaryInfo.si_casetype" value="其他" id="caseTypeFiveRadio"/><label for="caseTypeFiveRadio">其他</label>
                        <input type="radio" name="salaryInfo.si_casetype" value="奖励" id="caseTypeFourRadio"/><label for="caseTypeFourRadio">奖励</label>
                        <input type="radio" name="salaryInfo.si_casetype" value="迟到" id="caseTypeOneRadio"/><label for="caseTypeOneRadio">迟到</label>
                        <input type="radio" name="salaryInfo.si_casetype" value="事假" id="caseTypeTwoRadio"/><label for="caseTypeTwoRadio">事假</label>
                        <input type="radio" name="salaryInfo.si_casetype" value="病假" id="caseTypeThreeRadio"/><label for="caseTypeThreeRadio">病假</label>
                    </td>
                </tr>
                <tr>
                    <td>奖罚工资:</td>
                    <td>
                        <input type="radio" name="judgeSalaryRadio" value="1" id="fixedlySalaryRadio" checked/><label for="fixedlySalaryRadio">无加减</label>
                        <input type="radio" name="judgeSalaryRadio" value="2" id="addSalaryRadio"/><label for="addSalaryRadio"> 加钱</label>
                        <input type="radio" name="judgeSalaryRadio" value="3" id="subtractSalaryRadio"/><label for="subtractSalaryRadio">减钱</label><br/>
                        <input name="salaryInfo.si_variate" disabled="disabled" placeholder="无加减，禁止输入" />
                    </td>
                </tr>
                <tr>
                    <td><input type="button" value="关闭" onclick="closeUpdateSalaryInfo()"/><input type="button" id="doUpdateSalaryInfoBtn"  onclick="doUpdateSalaryInfo()" value="执行修改"/></td>
                </tr>
            </table>
        </form>
    </div>



</body>
</html>
<script>
    $(function () {
        loadDate();
        findMonthSalaryInfo();
    })

    //加载页面的时候，绑定当前时间
    function loadDate() {
        var date = new Date();
        var time = date.getFullYear()+"-"+date.getMonth()+1;
        $("#monthQuerys").val(time);
    }
    //=========================================================

    //查询年月员工的工资奖罚统计
    function findMonthSalaryInfo() {
        var param = $("#conditionFrm").serialize();
        $("#tab tr:not(:first)").remove();
        $.get("salaryInfoAction_findSalaryInfoList",param,function (data) {
           $.each(data.salaryInfoList,function (i,v) {
                var tr="<tr>";
                    tr+="<td>"+i+"</td>";
                    tr+="<td>"+v[0].e_name+"</td>";
                    tr+="<td>"+v[0].dept.d_name+"</td>";
                    tr+="<td>"+v[0].salary.s_salary+"</td>";
                    if(v[2]==null){
                        tr+="<td>0</td>";
                    }else{
                        tr+="<td>"+v[2]+"</td>";
                    }
                    tr+="<td>"+(v[0].salary.s_salary+(v[2]))+"</td>";
                    var eno = v[0].e_no;
                    tr+="<td><input type='button' value='查询详情' onclick='findSalaryInfoEmpByIdList("+eno+")'/> </td>";
                    tr+="</tr>";
                $("#tab").append(tr);
            })
        },"json");
    }

    function  findSalaryInfoCondition() {
        findMonthSalaryInfo();
    }

    function findSalaryInfoEmpByIdList(eno) {
            if( $("#salaryInfoEmpByIdDiv").css("display")=="none"){
                $("#salaryInfoEmpByIdTab tr:not(:first)").remove();
                $("#salaryInfoEmpByIdDiv").show();
                var param = $("#conditionFrm").serialize();
                $.get("salaryInfoAction_findSalaryInfoByIdDateList?salaryInfo.emp.e_no="+eno,param,function (data) {
                    if(data.salaryInfoByIdList!=null&&data.salaryInfoByIdList.length>0){
                        $.each(data.salaryInfoByIdList,function (i,v) {
                            var tr="<tr>";
                            tr+="<td>"+i+"</td>";
                            tr+="<td>"+v.emp.e_name+"</td>";
                            tr+="<td>"+v.si_casetype+"</td>";
                            tr+="<td>"+v.si_titel+"</td>";
                            tr+="<td>"+v.si_content+"</td>";
                            tr+="<td>"+v.si_time.substring(0,10)+"</td>";
                            tr+="<td>"+v.si_variate+"</td>";
                            tr+="<td><input type='button' value='修改' onclick='toUpdateSalaryInfoById("+v.si_no+")' </td>";
                            tr+="</tr>";
                            $("#salaryInfoEmpByIdTab").append(tr)
                        })
                    }else {
                        var tr="<tr><td colspan='8'>无数据</td></tr>";
                        $("#salaryInfoEmpByIdTab").append(tr)
                    }
                },"json")
            }else{
                $("#salaryInfoEmpByIdDiv").hide();
            }
    }


    //将一条详情记录查询出来，导到修改DIV中
    function  toUpdateSalaryInfoById(si_no) {
        $("#updateSalaryInFoById").show();
        $.get("salaryInfoAction_toUpdateSalaryInfoById?salaryInfo.si_no="+si_no,"",function (data) {
            var salaryInfo = data.salaryInfo;
            $("#updateSalaryInfoByIdFrm input[name='salaryInfo.si_no']").val(salaryInfo.si_no);
            $("#updateSalaryInfoByIdFrm input[name='salaryInfo.emp.e_no']").val( salaryInfo.emp.e_no);
            $("#updateSalaryInfoByIdFrm input[name='salaryInfo.emp.e_name']").val(salaryInfo.emp.e_name);
            $("#updateSalaryInfoByIdFrm input[name='salaryInfo.si_titel']").val(salaryInfo.si_titel);
            $("#updateSalaryInfoByIdFrm textarea[name='salaryInfo.si_content']").val(salaryInfo.si_content);
            $("#updateSalaryInfoByIdFrm input[name='salaryInfo.si_time']").val(salaryInfo.si_time.substring(0,10));

            //获取请假类型，obj成为数组
            var obj = $("#updateSalaryInfoByIdFrm input[name='salaryInfo.si_casetype']");
             for(var i=0;i<obj.length;i++){
                if(obj[i].value==salaryInfo.si_casetype){//看看后台的请假类型与数组中哪个值相等
                    obj[i].click(); //选中
                }
            }
            //获取奖罚类型单选框
            var judge = $("#updateSalaryInfoByIdFrm input[name='judgeSalaryRadio']");
            if(salaryInfo.si_variate>0){
                judge[1].click();
                $("#updateSalaryInfoByIdFrm input[name='salaryInfo.si_variate']").val(salaryInfo.si_variate);
            }else if(salaryInfo.si_variate<0){
                judge[2].click();
                $("#updateSalaryInfoByIdFrm input[name='salaryInfo.si_variate']").val(-salaryInfo.si_variate);//加上减号 --得正
            }else{
                judge[0].click();
                $("#updateSalaryInfoByIdFrm input[name='salaryInfo.si_variate']").val("").html("");
            }


        },"json")
    }

    //执行修改考勤表
    function doUpdateSalaryInfo() {
        var param = $("#updateSalaryInfoByIdFrm").serialize();
       $.post("salaryInfoAction_doUpdateSalaryInfo",param,function (data) {
            alert(data.msg);
        },"json");
    }

    //关闭修改员工考勤窗口
    function closeUpdateSalaryInfo() {
       $("#updateSalaryInFoById").hide();
    }
    //关闭查看指定员工时间段考勤窗口
    function closeSalaryInfoEmpByIdDiv() {
        $("#salaryInfoEmpByIdDiv").hide();
        $("#updateSalaryInFoById").hide();
    }


    //判断是否要加减工资，如果需要开启 输入金额框
    $("#addSalaryRadio").click(function () {
        $("#updateSalaryInfoByIdFrm input[name='salaryInfo.si_variate']").val("").attr("disabled",false).attr("placeholder","请输入要（加）的工资");
    });
    $("#subtractSalaryRadio").click(function () {
        $("#updateSalaryInfoByIdFrm input[name='salaryInfo.si_variate']").val("").attr("disabled",false).attr("placeholder","请输入要（减）的工资");
    });
    $("#fixedlySalaryRadio").click(function () {
        $("#updateSalaryInfoByIdFrm input[name='salaryInfo.si_variate']").val("").attr("disabled",true).attr("placeholder","无加减，禁止输入");
    });
</script>
