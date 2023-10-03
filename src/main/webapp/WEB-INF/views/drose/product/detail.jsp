<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="imui" uri="http://www.intra-mart.co.jp/taglib/imui"%>
<%@ taglib prefix="imart"
	uri="http://www.intra-mart.co.jp/taglib/core/standard"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="f" uri="http://terasoluna.org/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>





<imui:head>
	<title>Untitled</title>
	<script src="ui/libs/jquery-validation-1.9.0/jquery.validate.js"></script>
	<script type="text/javascript">

		var rules = {
			product_name : {
				required : true
			},
			category_name : {
				required : true
			},
			price : {
				required : true
			},
			quantity : {
				required : true
			}

		};
		var messages = {
			product_name : {
				required : "Plese input product name"
			},
			category_name : {
				required : "Plese input category name"
			},
			price : {
				required : "Plese input price"
			},
			quantity : {
				required : "Plese input quantity"
			}
		};
		$(function() {
			
			$('#updatebutton').click(function() {
					imuiConfirm('Do you want to proceed update this data?', 'Confirmation', function(){
						$("#updateForm").attr("action", "product/search/detail/update");
	                    imuiAjaxSend("#updateForm", "POST", "json", $.noop,
	                            $.noop, true, 10000, false, function(returnObject) {
	                    				
	                    				console.log("returnObject")
	                    				console.log(returnObject);
	                                if (!returnObject.parameters.init) {
	                                    // clear the inpu
	                                }else{
	                                	console.log("ke sini karena error")
	                                }
	                            });
	                    return false;
	                });       
	            });
			

			$('#clearbutton').click(function() {
				console.log('sini')
				$('#quantity').val("")
				$('#price').val("")
			});
			
			
			$("#deleteIcon").click(()=>{
				imuiConfirm('Do you want to proceed delete this data?', 'Confirmation', function(){
					console.log("id")
					console.log($("#id").val())
					var id = $("#id").val()
					
			        var url = "product/search/detail/delete";
			        var form = document.createElement("form");
			        form.setAttribute("action", url);
			        form.setAttribute("method", "post");
			        document.body.appendChild(form);
			        var input = document.createElement('input');
			        input.setAttribute('type', 'text');
			        input.setAttribute('name', "id");
			        input.setAttribute('value',id);
			        form.appendChild(input);
			        
			        form.submit()
			        
			        
			        
					
				})
			})
			
			
		});
		
		
	</script>
</imui:head>
<!-- 画面タイトル -->
<div class="imui-title">
	<h1 id="h1">Insert New Product 11</h1>
</div>
<!-- ツールバー -->
<div class="imui-toolbar-wrap">
	<div class="imui-toolbar-inner">
		<ul class="imui-list-toolbar">
			<!-- 戻るボタン -->
			<li><a href="#" class="imui-toolbar-icon" title="Back"><span
					class="im-ui-icon-common-16-back"></span></a></li>
			<li><a class="imui-toolbar-icon" title="Delete" id="deleteIcon"><span
					class="im-ui-icon-common-16-trashbox"></span></a></li>
		</ul>
	</div>
</div>
<!-- コンテンツエリア -->
<div class="imui-form-container-narrow">
	<!-- h2 -->
	<div class="imui-chapter-title">
		<h2>Insert New Product</h2>
	</div>
	<form:form id="updateForm" name="updateForm" method="POST"
		class="target_form mt-10" modelAttribute="insertProductForm">
		<table class="imui-form">
			<tr hidden>
				<th><label>Product Id</label></th>
				<td><imui:textbox id="id" name="id" readonly value="${product.id}"
						style="width: 200px; background-color: #f0f0f0;" /></td>
			</tr>
			<tr>
				<th><label>Product Name</label></th>
				<td><imui:textbox id="name" name="name" readonly value="${product.name}"
						style="width: 200px; background-color: #f0f0f0;" /></td>
			</tr>
			<tr>
				<th><label>Product Category</label></th>
				<td><imui:textbox id="category" name="category" readonly value="${product.category}"
						style="width: 200px; background-color: #f0f0f0;" /></td>
			</tr>
			<tr>
				<th><label for="price">Price</label></th>
				<td><input type="number" id="price" name="price" value="${product.price}"
					style="width: 200px;"></td>
			</tr>
			<tr>
				<th><label for="quantity">Quantity</label></th>
				<td><input type="number" id="stockquantity" name="stockquantity" value="${product.stockquantity}"
					style="width: 200px;"></td>
			</tr>
			<tr>
				<th><label for="myfile">Upload FIle</label></th>
				<td><input type="file" id="myfile" name="myfile"></td>
			</tr>
		</table>
		<div class="imui-operation-parts">
			<imui:button value="Update" id="updatebutton"
				class="imui-large-button" />
			<imui:button value="Clear" id="clearbutton" class="imui-large-button" />
			
			
		</div>

	</form:form>
</div>