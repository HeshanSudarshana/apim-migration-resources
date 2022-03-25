package org.wso2.carbon.apimgt.migration.dto;

public class APIInfoDTO {
    private int apiId;
    private String apiName;
    private String apiProvider;
    private String apiContext;
    private String apiVersion;
    private String getApiContextTemplate;
    private String uuid;
    private String status;
    private String type;
    private String organization;

    public String getUuid() { return uuid; }

    public void setUuid(String uuid) { this.uuid = uuid; }

    public int getApiId() {
        return apiId;
    }

    public void setApiId(int apiId) {
        this.apiId = apiId;
    }

    public String getApiName() {
        return apiName;
    }

    public void setApiName(String apiName) {
        this.apiName = apiName;
    }

    public String getApiProvider() {
        return apiProvider;
    }

    public void setApiProvider(String apiProvider) {
        this.apiProvider = apiProvider;
    }

    public String getApiContext() {
        return apiContext;
    }

    public void setApiContext(String apiContext) {
        this.apiContext = apiContext;
    }

    public String getApiVersion() {
        return apiVersion;
    }

    public void setApiVersion(String apiVersion) {
        this.apiVersion = apiVersion;
    }

    public String getGetApiContextTemplate() {
        return getApiContextTemplate;
    }

    public void setGetApiContextTemplate(String getApiContextTemplate) {
        this.getApiContextTemplate = getApiContextTemplate;
    }

    public String getStatus() {

        return status;
    }

    public void setStatus(String status) {

        this.status = status;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getOrganization() {

        return organization;
    }

    public void setOrganization(String organization) {

        this.organization = organization;
    }
}
