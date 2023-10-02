package drose.product.repository;

import java.lang.reflect.InvocationTargetException;
import java.sql.SQLException;
import java.util.*;

import javax.naming.NamingException;
import drose.product.model.ProductData;
import drose.product.model.ProductForm;
import jp.co.intra_mart.foundation.database.*;

public class ProductRepository {
	
	public void insertData(ProductData productModel) throws Exception {
		try {
			SQLManager sqlManager = new SQLManager();
			ColumnValues columnValues = new ColumnValues();
			columnValues.add("name", productModel.getName());
			columnValues.add("category", productModel.getCategory());
			columnValues.add("price", Double.parseDouble(productModel.getPrice()));
			columnValues.add("stockquantity", Integer.parseInt(productModel.getStockquantity()));
			sqlManager.insert("t_products", columnValues);
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception("DB error in insertData()", e);
		}

	}

	public List<ProductData> selectSearchResult (ProductForm productForm) throws Exception {
        List<ProductData> sqlResults = new ArrayList<ProductData>();
        try {
            SQLManager sqlManager = new SQLManager();
            Collection<Object> parameters = new ArrayList<Object>();
            String sql = "SELECT * FROM t_products";
            if(!(productForm.getCategory().equals(""))) {
                sql = sql + " WHERE category LIKE ? "; 
                parameters.add("%" + productForm.getCategory() + "%");
            }
            sqlResults = (List<ProductData>) sqlManager.select(ProductData.class, sql, parameters);
            return sqlResults;
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("DB error in selectSearchResult()", e);
        }
    }
	
	public ProductData selectProductData(String products_id) throws Exception {
		try {
			SQLManager slqManager = new SQLManager("dms", false);
			String sql;
			sql = "SELECT "
					+ "id::text, "	
					+ "special_incentive_id, "
					+ "special_incentive_name, "
					+ "REPLACE(CAST(start_date as text), '-','/')start_date, "
					+ "REPLACE(CAST(end_date as text), '-','/')end_date, "
					+ "businessunit "
					+ "FROM "
					+ "wf_i_dipo_special_incentive_periode "
					+ "WHERE "
					+ "id::text = ? ";
			Collection<Object> parameters = new ArrayList<Object>();
			parameters.add(products_id);
			List<ProductData> sqlResults = new ArrayList<ProductData>();
			sqlResults = (List<ProductData>) slqManager.select(ProductData.class, sql, parameters);
			ProductData result = new ProductData();
			result = sqlResults.get(0);
			return result;
		}
		catch(Exception e){
			e.printStackTrace();
			throw new Exception("DB error in selectSearchData()", e);
		}
	}
	
	public static final Collection<ProductData> selectCategory() throws Exception {
		try {
			SQLManager slqManager = new SQLManager("dms", false);
			String sql;
			sql = "SELECT category " + 
					"FROM t_products ";
			Collection<Object> parameters = new ArrayList<Object>();
			return (List<ProductData>) slqManager.select(ProductData.class, sql, parameters);
		}
		catch(Exception e){
			e.printStackTrace();
			throw new Exception("DB error in selectBusinessunit", e);
		}
	}
	
	private String sqlSelectProductModel = "SELECT * FROM t_products WHERE id = ?" ;
	public Collection<ProductData> selectSearchDetailData (String select_value, String select_where) throws Exception {
		try {
			SQLManager sqlManager = new SQLManager("dms", false);
			Collection<Object> parameters = new ArrayList<Object>();
			String sqlType = null;
			
			if (select_where.equals("products_id")) {
				sqlType = sqlSelectProductModel;
			}
			parameters.add(select_value);
			Collection<ProductData> result = sqlManager.select(ProductData.class, sqlType, parameters);
			return result;
		}catch (SQLException e) {
			e.printStackTrace();
			throw new Exception ("DB error in selectDetailData ", e);
		}
		
	}
	
	public ProductData getProductById (String id) throws Exception {
        List<ProductData> sqlResult;
        try {
            SQLManager sqlManager = new SQLManager();
            String sql = "SELECT * FROM t_products";
            sql = sql + " WHERE id = "+id; 
            Collection<Object> parameters = new ArrayList<Object>();
            sqlResult = (List<ProductData>) sqlManager.select(ProductData.class, sql,parameters);
            return sqlResult.get(0);
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("DB error in selectSearchResult()", e);
        }
    }

}
