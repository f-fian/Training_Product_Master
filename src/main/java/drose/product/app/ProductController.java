package drose.product.app;

import java.util.*;


import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import drose.product.model.ProductData;
import drose.product.model.ProductForm;
import drose.product.repository.ProductRepository;
import drose.product.service.ProductService;

@Controller

@RequestMapping("product")

public class ProductController {

	private ProductRepository productRepository = new ProductRepository();
	private ProductService productService = new ProductService();

	@RequestMapping(value = "search")
	public final String search(final Model model) throws Exception {
		List<Map<String, Object>> initListData = new ArrayList<Map<String, Object>>();
		model.addAttribute("searchResults", initListData);
		return "drose/product/search.jsp";
	}

	@RequestMapping(value = "insert")
	public String insert() {
		return "drose/product/insert.jsp";
	}

	
	 @RequestMapping(value = "search/detail") public final String detail(
			 final Model model,
			 @RequestParam("id") String id) throws Exception { 
		 System.out.println(id);
		 ProductData productData = productRepository.getProductById(id);
		 model.addAttribute("product", productData);
		 return "drose/product/detail.jsp"; 
	 }
	 
	 @ResponseBody
	 @RequestMapping(value = "search/detail/update") 
	 public Map<String, Object> updateProduct(
			 final Model model,@ModelAttribute("ProductData") ProductData productData) throws Exception { 
		 	System.out.println("Update FOrm");
		 	System.out.println(productData);
		 	
		 	Map<String, Object> result = new HashMap<String, Object>();
			Map<String, Object> parameters = new HashMap<String, Object>();
			productRepository.updateProductById(productData.getId(), productData.getPrice(), productData.getStockquantity());
			parameters.put("init", false);
			// Data found
			result.put("error", Boolean.FALSE);
			result.put("successMessage", "Success Update Data");
			result.put("parameters", parameters);
			return result;
	 }
	 

	 @RequestMapping(value = "search/detail/delete") 
	 public final String deleteProduct(@RequestParam("id") String id) throws Exception { 
		 	System.out.println("delete product");
		 	System.out.println(id);
		 	productRepository.deleteProductById(id);
		 	return "redirect:/product/search";
	 }
	 
	@ResponseBody
	@RequestMapping(value = "insert/data", method = RequestMethod.POST)
	public Map<String, Object> insertData(@ModelAttribute("ProductData") ProductData productData) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		productRepository.insertData(productData);
		parameters.put("init", false);
		// Data found
		result.put("error", Boolean.FALSE);
		result.put("successMessage", "Success Insert Data");
		result.put("parameters", parameters);
		return result;
	}

	@ResponseBody
	@RequestMapping(value = "search/result")
	public Map<String, Object> searchResult(ProductForm productForm) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		List<Map<String, Object>> gridData = new ArrayList<Map<String, Object>>(
				productService.getSearchResult(productForm));

		if (gridData.size() == 0) {
			parameters.put("init", true);
			parameters.put("gridData", gridData);
			// No Data Found
			result.put("error", Boolean.TRUE);
			result.put("errorMessage", "No Data Result");
			result.put("parameters", parameters);
		} else {
			parameters.put("init", false);
			parameters.put("gridData", gridData);
			// Data found
			result.put("error", Boolean.FALSE);
			result.put("successMessage", "Data Retrieved");
			result.put("parameters", parameters);
		}
		return result;
	}

}
