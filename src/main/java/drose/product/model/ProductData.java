package drose.product.model;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

public class ProductData {
	
	private String id;
	private String name;
	private String category;
	private String price;
	private String stockquantity;
	private String insert_date;
	private String updated_date;
	private String uploadfile;
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getPrice() {
		return price;
	}
	public void setPrice(String price) {
		this.price = price;
	}
	public String getStockquantity() {
		return stockquantity;
	}
	public void setStockquantity(String stockquantity) {
		this.stockquantity = stockquantity;
	}
	public String getCreateddate() {
		return insert_date;
	}
	public void setCreateddate(String createddate) {
		this.insert_date = createddate;
	}
	public String getUpdated_date() {
		return updated_date;
	}
	public void setupdated_date(String updated_date) {
		this.updated_date = updated_date;
	}
	public String getUploadfile() {
		return uploadfile;
	}
	public void setUploadfile(String uploadfile) {
		this.uploadfile = uploadfile;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	
	public ProductForm setFormData(ProductForm productForm) {
		productForm.setId(this.id);
		productForm.setName(this.name);
		productForm.setCategory(this.category);
		productForm.setPrice(this.price);
		productForm.setStockquantity(this.stockquantity);
	return productForm;
	}
	@Override
	public String toString() {
		return "ProductData [id=" + id + ", name=" + name + ", category=" + category + ", price=" + price
				+ ", stockquantity=" + stockquantity + ", insert_date=" + insert_date + ", updated_date=" + updated_date
				+ ", uploadfile=" + uploadfile + "]";
	}
	
	
	
}
