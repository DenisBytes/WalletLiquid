# WalletLiquid - Crypto Futures Paper Trading Platform
Platform where you can paper trade ("fake" money) crypto futures.

## Getting Started
   To run WalletLiquid locally, follow these simple steps:

1. **Clone the repository to your local machine:**

   ```bash
   git clone https://github.com/DenisBytes/WalletLiquid.git

2. **Navigate to the project directory:**

   ```bash
   cd WalletLiquid

3. **Build the project using Maven:**

   ```bash
   mvn clean install
   
4. Run the application:

   ```bash
   mvn spring-boot:run

Open your web browser and visit localhost:8080 to access the WalletLiquid platform.

## Requirements

Before running the application, ensure you have the following prerequisites installed on your system:

- JDK (Java Development Kit): WalletLiquid requires Java to run. You can download the latest JDK from Oracle or use an OpenJDK distribution.
- MySQL Workbench: WalletLiquid uses MySQL as its database. Make sure you have MySQL Workbench installed, and you may need to configure the database connection settings in the application (if not already configured).

Mysql username and password are both set tp **root**. Change if needed (in **application.properties** file)
