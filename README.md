# 🌐 Website Delivery with Azure Front Door and Azure CDN

A cloud computing project that demonstrates how to deliver a secure, scalable, and high-performance website using **Azure Front Door** and **Azure CDN**. The project focuses on **global traffic routing, HTTPS, CDN/edge caching, compression, and high-performance website delivery** using Terraform.

---

## Architecture
![Architecture](Architecture.png)




## 📁 Project Structure

```text
azure-frontdoor-cdn/
│
├── main.tf
├── variables.tf
├── outputs.tf
├── provider.tf
│
├── website/
│   ├── index.html
│   └── style.css
│
├── scripts/
│   ├── deploy.sh
│   └── destroy.sh
│
└── README.md
```

---

## 🔄 How the Project Works

### 1. User requests the website

A user opens the Azure Front Door URL:

```text
https://<frontdoor-endpoint>.azurefd.net
```

### 2. Request reaches Azure Front Door

Azure Front Door receives the request at Microsoft's edge network.

### 3. Front Door checks its cache

If the requested content is available at the edge, Front Door can serve the cached content without contacting the origin.

### 4. Request is forwarded to Azure Storage

If the content isn't available from cache, Front Door forwards the request to the configured Storage static website origin.

### 5. Azure Storage returns the website

Azure Storage returns:

```text
index.html
style.css
```

### 6. Front Door delivers the response

The content is returned to the user through Front Door.

---

# 🚀 Prerequisites

Before deploying this project, install:

### Azure CLI

Verify:

```bash
az --version
```

### Terraform

Verify:

```bash
terraform version
```

### Azure subscription

You need an active Azure subscription.

---

# 🔐 Azure Login

Login to Azure:

```bash
az login
```

Check the current subscription:

```bash
az account show
```

If you have multiple subscriptions:

```bash
az account list --output table
```

Select your subscription:

```bash
az account set --subscription "YOUR_SUBSCRIPTION_NAME"
```

---


# 📦 Terraform Deployment

Navigate to the project directory:

```bash
cd azure-frontdoor-cdn
```

Initialize Terraform:

```bash
terraform init
```

Validate the configuration:

```bash
terraform validate
```

Format the Terraform files:

```bash
terraform fmt
```

Create a deployment plan:

```bash
terraform plan
```

Apply the infrastructure:

```bash
terraform apply
```

Type:

```text
yes
```

when Terraform asks for confirmation.

---

# 🚀 Using the Deployment Script

You can also use the included deployment script:

```bash
chmod +x scripts/*.sh
```

Then:

```bash
./scripts/deploy.sh
```

The script performs:

```text
Terraform Init
      ↓
Terraform Validate
      ↓
Terraform Format
      ↓
Terraform Plan
      ↓
Terraform Apply
```

---

# 🌐 Get the Website URL

After deployment, run:

```bash
terraform output
```

You should see outputs similar to:

```text
frontdoor_url = "https://fd-cdn-endpoint-xxxxx.z01.azurefd.net"
storage_website_url = "https://frontdoorcdnwebsite01.z13.web.core.windows.net/"
```

The recommended URL for users is:

```bash
terraform output frontdoor_url
```

Open the resulting URL in your browser.

---

# 🧪 Testing

## Test 1 — Test the Storage Website

Get the Storage website URL:

```bash
terraform output storage_website_url
```

Open it in a browser.

The website should display the project page.

---

## Test 2 — Test Azure Front Door

Get the Front Door URL:

```bash
terraform output frontdoor_url
```

Open it in your browser.

The request should flow through:

```text
User
 ↓
Azure Front Door
 ↓
Storage Origin
 ↓
Static Website
```

---

## Test 3 — Test HTTPS

Try accessing the Front Door endpoint using HTTP:

```text
http://<frontdoor-hostname>
```

The configuration is designed to redirect HTTP traffic to:

```text
https://<frontdoor-hostname>
```

---

## Test 4 — Check HTTP Headers

Use:

```bash
curl -I https://<frontdoor-hostname>
```

This allows you to inspect response headers and demonstrate that the request is being served through the Front Door endpoint.


# 🔒 Security Features

This project includes several basic security and performance features.

### HTTPS

Front Door supports HTTPS for the website endpoint.

### HTTP Redirect

HTTP traffic is redirected to HTTPS.

### TLS

The Storage Account is configured to require:


### Edge Delivery

Front Door provides an edge entry point for users instead of exposing the Storage website URL as the primary application URL.

---

# ⚡ Performance Features

The project demonstrates:

### CDN / Edge Caching

Static content can be cached closer to users.

### Compression

Compression is enabled for common web content such as:

```text
HTML
CSS
JavaScript
JSON
SVG
```

### Global Delivery

Azure Front Door uses Microsoft's global edge network to serve users from locations closer to them.

---

# 📊 Monitoring and Troubleshooting

Check Terraform resources:

```bash
terraform state list
```

Check Front Door profile:

```bash
az afd profile list --output table
```

Check Front Door endpoints:

```bash
az afd endpoint list \
  --resource-group rg-frontdoor-cdn \
  --profile-name fd-cdn \
  --output table
```

Check Front Door routes:

```bash
az afd route list \
  --resource-group rg-frontdoor-cdn \
  --profile-name fd-cdn-demo \
  --endpoint-name fd-cdn-endpoint \
  --output table
```

Check Storage blobs:

```bash
az storage blob list \
  --account-name YOUR_STORAGE_ACCOUNT \
  --container-name '$web' \
  --auth-mode login \
  --output table
```

---

# ⚠️ Troubleshooting

## Front Door shows "Page not found"

If you receive:

```text
Page not found

Oops! We weren't able to find your Azure Front Door Service configuration.
```

First check the Front Door endpoint:

```bash
az afd endpoint list \
  --resource-group rg-frontdoor-cdn-demo \
  --profile-name fd-cdn-demo \
  --output table
```

Then check the route:

```bash
az afd route list \
  --resource-group rg-frontdoor-cdn-demo \
  --profile-name fd-cdn-demo \
  --endpoint-name fd-cdn-endpoint \
  --output table
```

Also verify that the Storage static website works directly:

```bash
terraform output storage_website_url
```

Azure Front Door configuration can take some time to propagate after deployment.

---

# 🧹 Destroy the Infrastructure

To remove all resources created by Terraform:

```bash
terraform destroy
```

Or use:

```bash
./scripts/destroy.sh
```

⚠️ **Warning:** This deletes the Azure resources created by this Terraform project.

---

# 💰 Cost Consideration

Azure Front Door and Azure Storage can incur charges depending on usage.

This project is intended as a **learning/demo environment**, so destroy the resources when you are finished:

```bash
terraform destroy
```

Always check current Azure pricing before deploying production workloads.


# 🎤 Interview Explanation

**Question: What did you build?**

> I built a static website delivery solution using Azure Storage and Azure Front Door. The website is hosted in Azure Storage, while Azure Front Door acts as the global entry point and edge delivery layer. I configured an origin group pointing to the Storage static website, HTTPS redirection, caching, compression, and health probes. The entire infrastructure is deployed using Terraform.

**Question: Why use Azure Front Door?**

> Azure Front Door provides global Layer 7 traffic routing and edge delivery. It can improve application performance by serving content from edge locations closer to users and also provides features such as HTTPS, caching, health probes, and routing.

**Question: Why use Azure Storage?**

> Because this project contains a static website, Azure Storage Static Website Hosting provides a simple and cost-effective way to host HTML, CSS, JavaScript, and other static content.

**Question: Why Terraform?**

> Terraform allows me to define the Azure infrastructure as code. This makes the environment repeatable, version-controlled, and easier to deploy or destroy.

---

# ⭐ Future Improvements

This project can be extended with:

* [ ] Custom domain
* [ ] Managed TLS certificate
* [ ] Azure WAF
* [ ] Web Application Firewall policies
* [ ] Azure Monitor
* [ ] Log Analytics
* [ ] Front Door access logs
* [ ] CI/CD with GitHub Actions
* [ ] Multiple Storage origins
* [ ] Multi-region architecture
* [ ] Private Origin
* [ ] Infrastructure modules
* [ ] Automated testing

---

## 📄 License

This project is created for **educational and portfolio purposes**.
