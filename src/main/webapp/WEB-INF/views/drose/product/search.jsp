<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="im" uri="http://www.intra-mart.co.jp/taglib/im-tenant" %>
<%@ taglib prefix="imui"   uri="http://www.intra-mart.co.jp/taglib/imui"%>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="imart" uri="http://www.intra-mart.co.jp/taglib/core/standard" %>
<%@ taglib prefix="f" uri="http://terasoluna.org/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>

<imui:head>
    <meta charset="UTF-8">
    <title>Search product</title>
    <script type="text/javascript">
    $(function(){
        function getData(){
        	
        	console.log("masuk ngak ke sini")
            $('#baseIncentiveSearchForm').attr('action', 'product/search/result'); 
            imuiAjaxSend("#baseIncentiveSearchForm", "POST", "json",
                $.noop, $.noop, true, 10000, false,
                function (returnObject) {
                    if(!returnObject.parameters.init){
                        $("#listTable").setGridParam({
                            rowNum: returnObject.parameters.gridData.length,
                            data: returnObject.parameters.gridData
                        }).trigger("reloadGrid");
                    }else{
                        $("#listTable").clearGridData();
                    }
            });
        }
        $("#category").keypress(function(e){
            console.log(e)
            if (e.which === 13){
                return false;
            }
        })
        
        $("#clearBtn").click(function(){
            $("#category").val("");
            $("#listTable").clearGridData();
        });
        
        $("#searchBtn").click(function(){
        	console.log("searchBtn")
            getData();
        });
    });
    
function onDblClickRow(rowid, e) {
		var rowData = $(this).jqGrid("getRowData", rowid);
		var id = rowData.id;
        var url = "product/search/detail";
        var form = document.createElement("form");
        form.setAttribute("action", url);
        form.setAttribute("method", "post");
        form.style.display = "none";
        document.body.appendChild(form);
        var input = document.createElement('input');
        input.setAttribute('type', 'text');
        input.setAttribute('name', "id");
        input.setAttribute('value',id);
        form.appendChild(input);
        
        form.submit();
 }
 
    
 </script>
</imui:head>
    
<imart type="head">
    <title>List screen</title>
</imart>    

<div class="imui-title">
    <h1>Search product</h1>
</div>   
     
<!-- Below toolbar -->
<div class="imui-toolbar-wrap">
    <div class="imui-toolbar-inner">
        <ul class="imui-list-toolbar">
            <li>
                <a class="imui-toolbar-icon" href="home" id="back"><span class="im-ui-icon-common-16-back"></span><span class="ml-5">Back</span></a>
            </li>
            <li class="icon-split"></li>
            <li>
                <a class="imui-toolbar-icon imui-unaccented" href="/imart/product/insert"><span class="im-ui-icon-common-16-new mr-5"></span>Add new incentive</a>
            </li>
        </ul>
    </div>
</div>

</imart>
    
    <!-- Search filter box -->
<div class="imui-form-container-wide">
    <div class="imui-chapter-title"><h2>Search filter option</h2></div>
    
    <form:form id="baseIncentiveSearchForm" action="" modelAttribute="BasicSalesListForm">
        <table class="imui-form-search-condition">
            <tbody>
                <tr>
                    <th><label for="category">Product Category</label></th>
                    <td>
                        <input id="category" name="category" type="text" size="50" placeholder="Product Category"/>
                    </td>
                </tr>
            </tbody>
        </table>
        
        <imui:button name="search" value="Search" class="imui-medium-button" id="searchBtn"/>
        <imui:button name="clear" value="Clear" class="imui-medium-button" id="clearBtn"/>
    </form:form>
</div>


<!-- Content Area -->
<div class="imui-form-container-wide">
    <div class="imui-title">
        <h1>Base Incentive Records</h1>
    </div>
    <div class="imui-form-container-full">
        <imui:listTable data="${searchResults}" id="listTable" viewRecords="true" width="100%" height="550"  onDblClickRow="onDblClickRow">
                <pager rowNum="10" rowList="10,50,100,500" />
                <cols>
                    <col name="id" caption="Id" wrap="true" hidden="true"/>
                    <col name="name" caption="Product Name" warp="true"/>
                    <col name="category" caption="Product Category" warp="true"/> 
                    <col name="price" caption="Product Price" warp="true"/>                 
                    <col name="stockquantity" caption="Stock Quantity Product" warp="true"/>
                </cols>
            </imui:listTable>   
    </div>
</html>