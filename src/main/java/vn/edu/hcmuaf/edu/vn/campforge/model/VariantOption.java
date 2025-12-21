package vn.edu.hcmuaf.edu.vn.campforge.model;

import java.io.Serializable;

public class VariantOption implements Serializable {
    private int variantId;
    private int attrId;
    private String attrCode;
    private String attrName;
    private String value;

    public VariantOption() {}

    public VariantOption(int variantId, int attrId, String attrCode, String attrName, String value) {
        this.variantId = variantId;
        this.attrId = attrId;
        this.attrCode = attrCode;
        this.attrName = attrName;
        this.value = value;
    }

    public int getVariantId() { return variantId; }
    public void setVariantId(int variantId) { this.variantId = variantId; }

    public int getAttrId() { return attrId; }
    public void setAttrId(int attrId) { this.attrId = attrId; }

    public String getAttrCode() { return attrCode; }
    public void setAttrCode(String attrCode) { this.attrCode = attrCode; }

    public String getAttrName() { return attrName; }
    public void setAttrName(String attrName) { this.attrName = attrName; }

    public String getValue() { return value; }
    public void setValue(String value) { this.value = value; }
}
