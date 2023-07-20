package com.denis.portfoliospringporject.controllers;

import com.denis.portfoliospringporject.models.TokenData;
import com.denis.portfoliospringporject.models.Transaction;
import com.denis.portfoliospringporject.models.Type;
import com.denis.portfoliospringporject.models.User;
import com.denis.portfoliospringporject.services.TransactionService;
import com.denis.portfoliospringporject.services.TypeService;
import com.denis.portfoliospringporject.services.UserService;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import java.text.DecimalFormat;
import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.*;


@Controller
public class TokenController {

    @Autowired
    UserService userService;
    @Autowired
    TransactionService transactionService;

    @Autowired
    TypeService typeService;

    @RequestMapping(value = {"/","/index"})
    public String index(Model model, HttpSession session) {

        session.setAttribute("loggedInUserID", null);

        return "index";
    }
    private String getLogoUrl(OkHttpClient client, String symbol) throws Exception {
        String apiKey = "ddd124324e14748fe778172f90a2def1ce56617ba3723f75f1d25dd3e8f8ca6b";
        String url = "https://data-api.cryptocompare.com/asset/v1/data/by/symbol?asset_symbol=" + symbol + "&api_key=" + apiKey;

        Request logoRequest = new Request.Builder()
                .url(url)
                .build();

        try (Response logoResponse = client.newCall(logoRequest).execute()) {
            if (logoResponse.isSuccessful()) {
                ObjectMapper logoObjectMapper = new ObjectMapper();
                JsonNode logoRoot = logoObjectMapper.readTree(logoResponse.body().byteStream());
                JsonNode logoDataNode = logoRoot.path("Data");

                if (logoDataNode.isObject()) {
                    String urlja = logoDataNode.path("LOGO_URL").asText();
                    return  urlja;
                }
            }
        }

        return null;
    }

    @GetMapping("/trade")
    public String showOrderBook(Model model, HttpSession session) {

        if (session.getAttribute("loggedInUserID") == null){
            System.out.println("HELLO NOT WORKING");
            return "redirect:/login";
        }

        User user = userService.findById((Long) session.getAttribute("loggedInUserID"));
        model.addAttribute("user", user);

        System.out.println(user.getImage());

        Transaction transactionMarket = new Transaction();
        Transaction transactionLimit = new Transaction();
        model.addAttribute("transactionMarket", transactionMarket);
        model.addAttribute("transactionLimit", transactionLimit);
        model.addAttribute("openOrders", transactionService.allUserTransactionsByType((Long) session.getAttribute("loggedInUserID"), "open"));
        model.addAttribute("closedOrders", transactionService.allUserTransactionsByType((Long) session.getAttribute("loggedInUserID"), "close"));
        model.addAttribute("pendingOrders", transactionService.allUserTransactionsByType((Long) session.getAttribute("loggedInUserID"), "pending"));

        OkHttpClient client = new OkHttpClient().newBuilder().build();
        String symbol = session.getAttribute("symbol") != null ? (String) session.getAttribute("symbol") : "BTC";

        double bitcoinPrice = 0.0;
        double ethereumPrice = 0.0;
        double uniswapPrice = 0.0;
        double ripplePrice = 0.0;
        double chainlinkPrice = 0.0;

        try {
            // Retrieve data from the Binance API for order book
            Request orderBookRequest = new Request.Builder()
                    .url("https://data-api.binance.vision/api/v3/depth?symbol=" + symbol + "USDT")
                    .build();

            // Retrieve data from the CEX.IO API for trade history
            Request tradeHistoryRequest = new Request.Builder()
                    .url("https://cex.io/api/trade_history/" + symbol + "/USDT")
                    .build();

            Request bitcoinRequest = new Request.Builder()
                    .url("https://data-api.binance.vision/api/v3/avgPrice?symbol=BTCUSDT")
                    .build();

            Request ethereumRequest = new Request.Builder()
                    .url("https://data-api.binance.vision/api/v3/avgPrice?symbol=ETHUSDT")
                    .build();

            Request uniswapRequest = new Request.Builder()
                    .url("https://data-api.binance.vision/api/v3/avgPrice?symbol=UNIUSDT")
                    .build();

            Request rippleRequest = new Request.Builder()
                    .url("https://data-api.binance.vision/api/v3/avgPrice?symbol=XRPUSDT")
                    .build();

            Request chainlinkRequest = new Request.Builder()
                    .url("https://data-api.binance.vision/api/v3/avgPrice?symbol=LINKUSDT")
                    .build();

            Response orderBookResponse = client.newCall(orderBookRequest).execute();
            Response tradeHistoryResponse = client.newCall(tradeHistoryRequest).execute();
            Response bitcoinResponse = client.newCall(bitcoinRequest).execute();
            Response ethereumResponse = client.newCall(ethereumRequest).execute();
            Response uniswapResponse = client.newCall(uniswapRequest).execute();
            Response rippleResponse = client.newCall(rippleRequest).execute();
            Response chainlinkResponse = client.newCall(chainlinkRequest).execute();

            if (orderBookResponse.isSuccessful() && tradeHistoryResponse.isSuccessful()) {
                String orderBookResponseBody = orderBookResponse.body().string();
                String tradeHistoryResponseBody = tradeHistoryResponse.body().string();
                String bitcoinResponseBody = bitcoinResponse.body().string();
                String ethereumResponseBody = ethereumResponse.body().string();
                String uniswapResponseBody = uniswapResponse.body().string();
                String rippleResponseBody = rippleResponse.body().string();
                String chainlinkResponseBody = chainlinkResponse.body().string();

                ObjectMapper objectMapper = new ObjectMapper();
                JsonNode orderBookRoot = objectMapper.readTree(orderBookResponseBody);
                JsonNode tradeHistoryRoot = objectMapper.readTree(tradeHistoryResponseBody);
                JsonNode bitcoinRoot = objectMapper.readTree(bitcoinResponseBody);
                JsonNode ethereumRoot = objectMapper.readTree(ethereumResponseBody);
                JsonNode uniswapRoot = objectMapper.readTree(uniswapResponseBody);
                JsonNode rippleRoot = objectMapper.readTree(rippleResponseBody);
                JsonNode chainlinkRoot = objectMapper.readTree(chainlinkResponseBody);

                JsonNode bidsNode = orderBookRoot.path("bids");
                JsonNode asksNode = orderBookRoot.path("asks");
                double bitcoinPricePre = bitcoinRoot.path("price").asDouble();
                double ethereumPricePre = ethereumRoot.path("price").asDouble();
                double uniswapPricePre = uniswapRoot.path("price").asDouble();
                double ripplePricePre = rippleRoot.path("price").asDouble();
                double chainlinkPricePre = chainlinkRoot.path("price").asDouble();

                DecimalFormat noDecimalFormat = new DecimalFormat("#");
                DecimalFormat oneDecimalFormat = new DecimalFormat("#.#");
                DecimalFormat threeDecimalFormat = new DecimalFormat("#.###");

                bitcoinPrice = Double.parseDouble(noDecimalFormat.format(bitcoinPricePre));
                ethereumPrice = Double.parseDouble(oneDecimalFormat.format(ethereumPricePre));
                uniswapPrice = Double.parseDouble(threeDecimalFormat.format(uniswapPricePre));
                ripplePrice = Double.parseDouble(threeDecimalFormat.format(ripplePricePre));
                chainlinkPrice = Double.parseDouble(threeDecimalFormat.format(chainlinkPricePre));

                List<Map<String, String>> tradeHistoryList = new ArrayList<>();

                for (JsonNode tradeNode : tradeHistoryRoot) {
                    Map<String, String> tradeData = new HashMap<>();
                    tradeData.put("type", tradeNode.get("type").asText());
                    tradeData.put("price", tradeNode.get("price").asText());
                    tradeData.put("amount", tradeNode.get("amount").asText());

                    String timestamp = tradeNode.get("date").asText();
                    long timestampMillis = Long.parseLong(timestamp) * 1000L;
                    Instant instant = Instant.ofEpochMilli(timestampMillis);
                    LocalDateTime dateTime = LocalDateTime.ofInstant(instant, ZoneId.systemDefault());
                    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm:ss");
                    String formattedTime = dateTime.format(formatter);

                    tradeData.put("date", formattedTime);
                    tradeHistoryList.add(tradeData);
                }

                model.addAttribute("symbol", symbol);
                model.addAttribute("bids", bidsNode);
                model.addAttribute("asks", asksNode);
                model.addAttribute("tradeHistory", tradeHistoryList);
                model.addAttribute("bitcoinPrice", bitcoinPrice);
                model.addAttribute("ethereumPrice", ethereumPrice);
                model.addAttribute("uniswapPrice", uniswapPrice);
                model.addAttribute("ripplePrice", ripplePrice);
                model.addAttribute("chainlinkPrice", chainlinkPrice);
            } else {
                // Handle unsuccessful response
            }
        } catch (Exception e) {
            e.printStackTrace();
            // Handle exception as needed
        }

        List<Transaction> transactionList = transactionService.allTransactionsByType("open");

        for (Transaction transaction : transactionList) {
            double tokenPrice = 0.0;

            if (transaction.getSymbol().equals("BTC")) {
                tokenPrice = bitcoinPrice;
            } else if (transaction.getSymbol().equals("ETH")) {
                tokenPrice = ethereumPrice;
            } else if (transaction.getSymbol().equals("UNI")) {
                tokenPrice = uniswapPrice;
            } else if (transaction.getSymbol().equals("XRP")) {
                tokenPrice = ripplePrice;
            } else if (transaction.getSymbol().equals("LINK")) {
                tokenPrice = chainlinkPrice;
            }

            if (transaction.getDirection().equals("short") && tokenPrice > transaction.getLiqPrice()) {
                return "redirect:/liquidation/" + transaction.getId();
            } else if (transaction.getDirection().equals("long") && tokenPrice < transaction.getLiqPrice()) {
                return "redirect:/liquidation/" + transaction.getId();
            }
        }

        return "trade";
    }


    @PostMapping("/elaborate")
    public String trade(@RequestParam String symbol, HttpSession session) {

        session.setAttribute("symbol", symbol);
        return "redirect:/trade";
    }

    @PostMapping("/marketorder")
    public String marketorder(@Valid @ModelAttribute("transactionMarket") Transaction transactionMarket,
                              BindingResult result, HttpSession session){

        if(session.getAttribute("loggedInUserID") == null){
            return "redirect:/login";
        }

        User user = userService.findById((Long) session.getAttribute("loggedInUserID"));

        if(result.hasErrors() || transactionMarket.getAmount() > user.getUsd()){
            return "redirect:/trade";
        }

        Type t = typeService.findByName("open");

        transactionMarket.setOrder("market");
        transactionMarket.setType(t);
        transactionMarket.setTokenSize((transactionMarket.getAmount()*transactionMarket.getLeverage())/transactionMarket.getPrice());
        user.setUsd(user.getUsd()-transactionMarket.getAmount());
        if (transactionMarket.getDirection().equals("long")) {
            transactionMarket.setLiqPrice(transactionMarket.getPrice() * (1 - 0.906 / transactionMarket.getLeverage()));
        } else if (transactionMarket.getDirection().equals("short")) {
            transactionMarket.setLiqPrice(transactionMarket.getPrice() * (1 + 0.906 / transactionMarket.getLeverage()));
        }
        transactionMarket.setUser(user);
        userService.updateUser(user);
        transactionService.saveTransaction(transactionMarket);

        return "redirect:/trade";
    }

    @GetMapping("/closemarket/{transactionId}")
    public String closeOrder(@PathVariable("transactionId") Long transactionId,
                             @RequestParam("traLastPrice") double traLastPrice,
                             HttpSession session){
        Transaction transaction = transactionService.findTransaction(transactionId);
        Type type = typeService.findByName("close");


        transaction.setType(type);
        if(transaction.getDirection().equals("long")){
            transaction.setLastPrice(traLastPrice);
            transaction.setEarnings(transaction.getTokenSize()*(transaction.getLastPrice()-transaction.getPrice()));
        } else if(transaction.getDirection().equals("short")){
            transaction.setLastPrice(traLastPrice);
            transaction.setEarnings(transaction.getTokenSize()*(transaction.getPrice()-transaction.getLastPrice()));
        }

        User user = userService.findById((Long) session.getAttribute("loggedInUserID"));


        System.out.println("user usd: "+user.getUsd());
        System.out.println("tran amount: "+transaction.getAmount());
        System.out.println("tran earnings: "+transaction.getEarnings());

        user.setUsd(user.getUsd() +transaction.getEarnings());
        userService.updateUser(user);
        transactionService.saveTransaction(transaction);

        return "redirect:/trade";
    }

    @GetMapping("/liquidation/{transactionId}")
    public String liquidation(@PathVariable("transactionId") Long transactionId,
                             HttpSession session){
        Transaction transaction = transactionService.findTransaction(transactionId);
        Type type = typeService.findByName("close");


        transaction.setType(type);
        if(transaction.getDirection().equals("long")){
            transaction.setLastPrice(transaction.getLiqPrice());
            transaction.setEarnings(transaction.getTokenSize()*(transaction.getLastPrice()-transaction.getPrice()));
        } else if(transaction.getDirection().equals("short")){
            transaction.setLastPrice(transaction.getLiqPrice());
            transaction.setEarnings(transaction.getTokenSize()*(transaction.getPrice()-transaction.getLastPrice()));
        }

        User user = userService.findById((Long) session.getAttribute("loggedInUserID"));

        user.setUsd(user.getUsd()+transaction.getEarnings());
        userService.updateUser(user);
        transactionService.saveTransaction(transaction);

        return "redirect:/trade";
    }

    @GetMapping("/leaderboard")
    public String leaderboard(Model model, HttpSession session){

        if(session.getAttribute("loggedInUserID") == null){
            return "redirect:/login";
        }

        model.addAttribute("user", userService.findById((Long) session.getAttribute("loggedInUserID")));
        model.addAttribute("userList",userService.allUserByMostUsd());

        return "leaderboard";
    }

    @GetMapping("/leaderboard/{userId}")
    public String userTransactions(@PathVariable Long userId, Model model, HttpSession session){
        if(session.getAttribute("loggedInUserID") == null){
            return "redirect:/login";
        }

        User currentUser = userService.findById((Long) session.getAttribute("loggedInUserID"));

        User user = userService.findById(userId);

        model.addAttribute("currentUser",currentUser);
        model.addAttribute("user",user);
        model.addAttribute("transactionList", transactionService.allUserTransactions(userId));

        return "userTransactions";
    }

    @GetMapping("/history/{userId}")
    public String history(@PathVariable Long userId,Model model, HttpSession session){
        if(session.getAttribute("loggedInUserID") == null){
            return "redirect:/login";
        }

        User user = userService.findById(userId);

        model.addAttribute("user",user);
        model.addAttribute("transactionList", transactionService.allUserTransactions(userId));

        return "history";
    }
}