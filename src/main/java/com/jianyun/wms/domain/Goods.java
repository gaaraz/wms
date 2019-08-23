package com.jianyun.wms.domain;

/**
 * 货物信息
 * @author Ken
 *
 */
public class Goods {

	private Integer id;// 货物ID
	private String name;// 货物名
	private String size;// 货物规格
	private Double value;// 货物价值
	private Integer categoryId;
	private String category;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getSize() {
		return size;
	}

	public void setSize(String size) {
		this.size = size;
	}

	public Double getValue() {
		return value;
	}

	public void setValue(Double value) {
		this.value = value;
	}

	public Integer getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(Integer categoryId) {
		this.categoryId = categoryId;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	@Override
	public String toString() {
		return "Goods [id=" + id + ", name=" + name  + ", size=" + size + ", value=" + value +",categoryId="+categoryId+ "]";
	}

}
