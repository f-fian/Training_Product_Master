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
			
			$('#insertbutton').click(function() {
				console.log("masuk form");
				if (!imuiValidate('#insertForm', rules, messages))
					return;
				$('#insertForm').submit();
			});

			$('#clearbutton').click(function() {
				console.log('sini')
				$('#product_name').val("")
				$('#quantity').val("")
				$('#price').val("")
			});
			
			
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
		</ul>
	</div>
</div>
<!-- コンテンツエリア -->
<div class="imui-form-container-narrow">
	<!-- h2 -->
	<div class="imui-chapter-title">
		<h2>Insert New Product</h2>
	</div>
	<form:form id="insertForm" name="insertForm" method="POST"
		class="target_form mt-10" action="product/insert/data"
		modelAttribute="insertProductForm">
		<table class="imui-form">
			<tr>
				<th><label>Product Name</label></th>
				<td><imui:textbox id="product_name" name="product_name" readonly value="${product.name}"
						style="width: 200px; background-color: #f0f0f0;" /></td>
			</tr>
			<tr>
				<th><label>Product Category</label></th>
				<td><imui:textbox id="product_categoty" name="product_categoty" readonly value="${product.category}"
						style="width: 200px; background-color: #f0f0f0;" /></td>
			</tr>
			<tr>
				<th><label for="price">Price</label></th>
				<td><input type="number" id="price" name="price" value="${product.price}"
					style="width: 200px;"></td>
			</tr>
			<tr>
				<th><label for="quantity">Quantity</label></th>
				<td><input type="number" id="quantity" name="quantity" value="${product.stockquantity}"
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