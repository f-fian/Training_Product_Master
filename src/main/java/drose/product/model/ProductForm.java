package drose.product.model;

public class ProductForm {
	
	private String id;
	private String name;
	private String category;
	private String price;
	private String stockquantity;
	
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
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}

}
