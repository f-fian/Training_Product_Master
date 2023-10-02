package drose.product.service;

import java.util.*;

import drose.product.model.ProductData;
import drose.product.model.ProductFileData;
import drose.product.model.ProductForm;
import drose.product.repository.ProductRepository;

import java.text.SimpleDateFormat;

public class ProductService {

	private ProductRepository productRepository = new ProductRepository();

	public final String getCurrentDate() {
		Date currentDate = new Date();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd");
		return dateFormat.format(currentDate);
	}

	private List<ProductFileData> getEntity_ProductFile(final ActionProcessParameter parameter,
			final Map<String, Object> userParameter, String system_matter_id) {
		List<ProductFileData> result = new ArrayList<ProductFileData>();

		try {
			List<String> varId = (List<String>) userParameter.get("f_contract_upload_file_id");
			List<String> varFileName = (List<String>) userParameter.get("f_contract_upload_file_name");
			List<String> varFileRealName = (List<String>) userParameter.get("f_contract_upload_file_real_name");

			for (int i = 0; i < varId.size(); i++) {
				ProductFileData entity = new ProductFileData();

				entity.setId(Integer.parseInt(varId.get(i)));

				entity.setFile_name(getEntity_TryCatch_String(varFileName, i));
				entity.setFile_real_name(getEntity_TryCatch_String(varFileRealName, i));

				entity.setFile_path("training_products/" + entity.getFile_real_name());

				if (!entity.getFile_name().equals("") && !entity.getFile_real_name().equals("")) {
					if (!entity.getFile_name().equals("-") && !entity.getFile_real_name().equals("-")) {
						result.add(entity);
					}
				}
			}
		} catch (Exception e) {
			ProductFileData entity = new ProductFileData();
			try {
				entity.setId(Integer.parseInt(userParameter.get("f_contract_upload_file_id").toString()));
				entity.setFile_path("training_product/" + entity.getFile_real_name());

				if (!entity.getFile_name().equals("") && !entity.getFile_real_name().equals("")) {
					if (!entity.getFile_name().equals("-") && !entity.getFile_real_name().equals("-")) {
						result.add(entity);
					}
				}

			} catch (Exception e2) {
				System.out.println("no file entity");
			}
		}

		return result;
	}

	private String getEntity_TryCatch_String(List<String> input_form, int i) {

		try {
			return input_form.get(i);
		} catch (Exception e) {
			return "";
		}
	}

	public final List<Map<String, Object>> getSearchResult(ProductForm productForm) throws Exception {
		List<ProductData> listData = productRepository.selectSearchResult(productForm);
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
		try {
			for (int i = 0; i < listData.size(); i++) {
				ProductData dataRow = new ProductData();
				dataRow = listData.get(i);
				result.add(this.createValueMap("id", dataRow.getId(), "name", dataRow.getName(), "category",
						dataRow.getCategory(), "stockquantity", dataRow.getStockquantity(), "price", dataRow.getPrice()));
			}
			return result;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			throw new Exception("Error in getSearchResult()", e);
		}
	}

	public Map<String, Object> createValueMap(Object... objArray) {
		Map<String, Object> map = new HashMap<String, Object>();
		int size = objArray.length;
		for (int i = 0; i < size; i++) {
			if ((i + 1) % 2 == 1) {
				map.put(objArray[i].toString(), objArray[i + 1]);
			}
		}
		return map;
	}

}
