package vn.edu.hcmuaf.edu.vn.campforge.model;

import java.io.Serializable;

public class Banner implements Serializable {
    private int id;
    private String placement;
    private String title;
    private String imageUrl;
    private String linkUrl;
    private String btnText;
    private int sortOrder;
    private int isActive;

    public Banner(int id, String placement, String title, String imageUrl, String linkUrl, String btnText, int sortOrder, int isActive) {
        this.id = id;
        this.placement = placement;
        this.title = title;
        this.imageUrl = imageUrl;
        this.linkUrl = linkUrl;
        this.btnText = btnText;
        this.sortOrder = sortOrder;
        this.isActive = isActive;
    }

    public Banner() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getPlacement() {
        return placement;
    }

    public void setPlacement(String placement) {
        this.placement = placement;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public String getLinkUrl() {
        return linkUrl;
    }

    public void setLinkUrl(String linkUrl) {
        this.linkUrl = linkUrl;
    }

    public String getBtnText() {
        return btnText;
    }

    public void setBtnText(String btnText) {
        this.btnText = btnText;
    }

    public int getSortOrder() {
        return sortOrder;
    }

    public void setSortOrder(int sortOrder) {
        this.sortOrder = sortOrder;
    }

    public int getIsActive() {
        return isActive;
    }

    public void setIsActive(int isActive) {
        this.isActive = isActive;
    }
}
