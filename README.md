# 🌐 Website Delivery with Azure Front Door and Azure CDN

A cloud computing project that demonstrates how to deliver a secure, scalable, and high-performance website using **Azure Front Door** and **Azure CDN**. This project showcases global traffic routing, content caching, HTTPS, and improved website performance by leveraging Microsoft Azure services.

---

## 📖 Overview

Modern web applications require fast, reliable, and secure content delivery for users across the globe. This project uses **Azure Front Door** as the global entry point for routing and load balancing, while **Azure CDN** caches static assets closer to users to reduce latency and improve performance.

---

## 🚀 Features

- Global traffic routing with Azure Front Door
- Static content acceleration using Azure CDN
- Website hosting on Azure App Service
- Static asset storage using Azure Blob Storage
- HTTPS support
- High availability and scalability
- Optional Azure WAF integration for security
- Monitoring with Azure Monitor and Application Insights

---

## 🏗️ Architecture

```text
                    Users
                      │
                      ▼
            Azure Front Door
      (Global Load Balancer + WAF)
                      │
          ┌───────────┴───────────┐
          │                       │
          ▼                       ▼
 Azure App Service        Azure App Service
   (Primary)                (Secondary)
          │
          ▼
 Azure Storage Account
 (Blob Storage - Static Files)
          │
          ▼
        Azure CDN
```

---

## 🛠️ Azure Services Used

- Azure Resource Group
- Azure App Service
- Azure Storage Account
- Azure Blob Storage
- Azure Front Door
- Azure CDN
- Azure Monitor
- Application Insights
- Azure WAF (Optional)
- Azure DNS (Optional)

---

## 📂 Project Structure

```text
Website-Delivery-with-Azure-Front-Door-and-Azure-CDN/
│
├── README.md
├── deployment-guide.md
├── architecture.png
├── website/
│   ├── index.html
│   ├── style.css
│   ├── script.js
│   └── images/
│
├── terraform/
│   ├── provider.tf
│   ├── main.tf
│   ├── variables.tf
│   └── outputs.tf
│
└── screenshots/
    ├── resource-group.png
    ├── storage-account.png
    ├── app-service.png
    ├── front-door.png
    ├── cdn-profile.png
    └── final-output.png
```

---

## ⚙️ Deployment Steps

### 1. Create a Resource Group

```bash
RG-WebsiteDelivery
```

---

### 2. Create a Storage Account

- Enable **Static Website Hosting**
- Upload:
  - index.html
  - style.css
  - script.js
  - images/

---

### 3. Create an Azure App Service

Deploy the website to Azure App Service.

---

### 4. Create an Azure CDN Profile

- Create a CDN Profile
- Create a CDN Endpoint
- Connect the endpoint to the Storage Account

---

### 5. Create Azure Front Door

Configure:

- Backend Pool
- Routing Rules
- Health Probes
- HTTPS

---

### 6. Configure Custom Domain (Optional)

Example:

```
www.example.com
```

Enable HTTPS using managed certificates.

---

### 7. Enable Azure WAF (Optional)

Protect the application against:

- SQL Injection
- Cross-Site Scripting (XSS)
- Malicious Bots
- Common Web Attacks

---

### 8. Enable Monitoring

Configure:

- Azure Monitor
- Application Insights
- Log Analytics

---

## 📊 Workflow

```text
User
 │
 ▼
Azure Front Door
 │
 ▼
Azure App Service
 │
 ├──────────────► Dynamic Content
 │
 ▼
Azure Storage
 │
 ▼
Azure CDN
 │
 ▼
Cached Static Content
```

---

## 💡 Benefits

- Faster website loading
- Reduced latency
- Improved user experience
- Secure HTTPS communication
- Global content delivery
- Automatic scalability
- High availability
- Better application performance

---

## 📷 Screenshots

Include screenshots such as:

- Azure Resource Group
- Storage Account
- Blob Storage
- Azure App Service
- Azure Front Door
- Azure CDN
- Website Running Successfully

---

## 📚 Learning Outcomes

This project demonstrates:

- Azure Front Door configuration
- Azure CDN deployment
- Website hosting on Azure
- Blob Storage integration
- Traffic routing
- Static content caching
- HTTPS configuration
- Performance optimization
- Monitoring cloud applications

---

## 🔮 Future Improvements

- CI/CD using GitHub Actions
- Infrastructure as Code using Terraform or Bicep
- Multi-region deployment
- Custom domain integration
- Azure Key Vault integration
- Automated scaling
- Monitoring dashboards and alerts

---

## 👨‍💻 Technologies Used

- HTML5
- CSS3
- JavaScript
- Microsoft Azure
- Azure Front Door
- Azure CDN
- Azure App Service
- Azure Storage
- Terraform (Optional)

---

## 📄 License

This project is licensed under the MIT License.

---

## 🙌 Acknowledgements

- Microsoft Azure Documentation
- Azure Front Door
- Azure CDN
- Azure App Service
- Azure Storage

---

⭐ If you found this project helpful, consider giving it a star on GitHub!
