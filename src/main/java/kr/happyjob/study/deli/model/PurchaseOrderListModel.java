package kr.happyjob.study.deli.model;

public class PurchaseOrderListModel {
	private int purchase_code;
	private String company_class_name;
	private int purchase_total_price;
	private String purchase_end_date;
	private int product_code;
	private String product_name;
	private String product_model_number;
	private String product_model_name;
	private int product_model_price;
	private String produce_company_name;
	private String owner_approve_yn;
	private String deposit_check_yn;
	
	
	
	public String getOwner_approve_yn() {
		return owner_approve_yn;
	}
	public void setOwner_approve_yn(String owner_approve_yn) {
		this.owner_approve_yn = owner_approve_yn;
	}
	public String getDeposit_check_yn() {
		return deposit_check_yn;
	}
	public void setDeposit_check_yn(String deposit_check_yn) {
		this.deposit_check_yn = deposit_check_yn;
	}
	public int getPurchase_code() {
		return purchase_code;
	}
	public void setPurchase_code(int purchase_code) {
		this.purchase_code = purchase_code;
	}
	public String getCompany_class_name() {
		return company_class_name;
	}
	public void setCompany_class_name(String company_class_name) {
		this.company_class_name = company_class_name;
	}
	public int getPurchase_total_price() {
		return purchase_total_price;
	}
	public void setPurchase_total_price(int purchase_total_price) {
		this.purchase_total_price = purchase_total_price;
	}
	public String getPurchase_end_date() {
		return purchase_end_date;
	}
	public void setPurchase_end_date(String purchase_end_date) {
		this.purchase_end_date = purchase_end_date;
	}
	public int getProduct_code() {
		return product_code;
	}
	public void setProduct_code(int product_code) {
		this.product_code = product_code;
	}
	public String getproduct_name() {
		return product_name;
	}
	public void setproduct_name(String product_name) {
		this.product_name = product_name;
	}
	public String getProduct_model_number() {
		return product_model_number;
	}
	public void setProduct_model_number(String product_model_number) {
		this.product_model_number = product_model_number;
	}
	public String getProduct_model_name() {
		return product_model_name;
	}
	public void setProduct_model_name(String product_model_name) {
		this.product_model_name = product_model_name;
	}
	public int getProduct_model_price() {
		return product_model_price;
	}
	public void setProduct_model_price(int product_model_price) {
		this.product_model_price = product_model_price;
	}
	public String getProduce_company_name() {
		return produce_company_name;
	}
	public void setProduce_company_name(String produce_company_name) {
		this.produce_company_name = produce_company_name;
	}
	
	
	
}
