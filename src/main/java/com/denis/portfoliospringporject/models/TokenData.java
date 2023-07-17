package com.denis.portfoliospringporject.models;

public class TokenData {
    private String symbol;
    private String tokenName;
    private double tokenPriceUSD;
    private double priceChange24h;
    private double volume24h;
    private String imageUrl;

    public TokenData(){

    }

    public TokenData(String symbol, String tokenName, double tokenPriceUSD, double priceChange24h, double volume24h, String imageUrl) {
        this.symbol = symbol;
        this.tokenName = tokenName;
        this.tokenPriceUSD = tokenPriceUSD;
        this.priceChange24h = priceChange24h;
        this.volume24h = volume24h;
        this.imageUrl = imageUrl;
    }

    public String getSymbol() {
        return symbol;
    }

    public void setSymbol(String symbol) {
        this.symbol = symbol;
    }

    public String getTokenName() {
        return tokenName;
    }

    public void setTokenName(String tokenName) {
        this.tokenName = tokenName;
    }

    public double getTokenPriceUSD() {
        if (tokenPriceUSD >= 10000) {
            return Math.round(tokenPriceUSD);
        } else if (tokenPriceUSD >= 10) {
            return Math.round(tokenPriceUSD * 10) / 10.0;
        } else {
            return Math.round(tokenPriceUSD * 1000) / 1000.0;
        }
    }

    public void setTokenPriceUSD(double tokenPriceUSD) {
        this.tokenPriceUSD = tokenPriceUSD;
    }

    public double getPriceChange24h() {
        return Math.round(priceChange24h * 100.0) / 100.0;
    }
    public void setPriceChange24h(double priceChange24h) {
        this.priceChange24h = priceChange24h;
    }

    public double getVolume24h() {
        return volume24h;
    }

    public void setVolume24h(double volume24h) {
        this.volume24h = volume24h;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }
    public String getVolume24hFormatted() {
        if (volume24h >= 1000000) {
            return String.format("%.2fM", volume24h / 1000000);
        } else if (volume24h >= 1000) {
            return String.format("%.2fK", volume24h / 1000);
        } else {
            return String.format("%.2f", volume24h);
        }
    }
}
