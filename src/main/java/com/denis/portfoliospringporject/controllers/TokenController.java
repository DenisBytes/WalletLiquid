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
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.atomic.AtomicBoolean;

@Controller
public class TokenController {

    @Autowired
    UserService userService;
    @Autowired
    TransactionService transactionService;

    @Autowired
    TypeService typeService;

    @GetMapping("/index")
    public String index(Model model) {
        OkHttpClient client = new OkHttpClient().newBuilder().build();

        List<String> desiredSymbols = Arrays.asList("BTC", "ETH", "HBAR", "XDC", "LDO", "CSPR", "MKR", "CRV",
                "RPL", "ALGO", "QNT", "UNI", "LINK", "XRP", "SNX", "COMP");
        List<TokenData> tokens = new ArrayList<>();

        try {
            // Retrieve data from the CoinCap API
            Request coinCapRequest = new Request.Builder()
                    .url("https://api.coincap.io/v2/assets")
                    .build();

            try (Response coinCapResponse = client.newCall(coinCapRequest).execute()) {
                if (coinCapResponse.isSuccessful()) {
                    String coinCapResponseBody = coinCapResponse.body().string();
                    ObjectMapper coinCapObjectMapper = new ObjectMapper();
                    JsonNode coinCapRoot = coinCapObjectMapper.readTree(coinCapResponseBody);
                    JsonNode coinCapDataNode = coinCapRoot.path("data");

                    // Iterate over the tokens from CoinCap API
                    for (JsonNode tokenNode : coinCapDataNode) {
                        String symbol = tokenNode.path("symbol").asText();

                        // Check if the token symbol is in the specified list
                        if (desiredSymbols.contains(symbol)) {
                            String tokenName = tokenNode.path("name").asText();
                            double tokenPriceUSD = tokenNode.path("priceUsd").asDouble();
                            double priceChange24h = tokenNode.path("changePercent24Hr").asDouble();
                            double volume24h = tokenNode.path("volumeUsd24Hr").asDouble();

                            // Retrieve logo from the other API
                            String logoUrl = getLogoUrl(client, symbol);
                            TokenData token = new TokenData(symbol, tokenName, tokenPriceUSD, priceChange24h, volume24h, logoUrl);
                            tokens.add(token);
                        }
                    }
                } else {
                    // Handle unsuccessful response
                }
            }

            model.addAttribute("tokens", tokens);
        } catch (Exception e) {
            e.printStackTrace();
        }

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

        if(session.getAttribute("loggedInUserID") == null){
            return "redirect:/login";
        }
        User user = userService.findById((Long) session.getAttribute("loggedInUserID"));
        model.addAttribute("user",user);

        Transaction transactionMarket = new Transaction();
        Transaction transactionLimit = new Transaction();

        model.addAttribute("transactionMarket", transactionMarket);
        model.addAttribute("transactionLimit", transactionLimit);
        model.addAttribute("openOrders", transactionService.allUserTransactionsByType((Long) session.getAttribute("loggedInUserID"),"open"));
        model.addAttribute("closedOrders", transactionService.allUserTransactionsByType((Long) session.getAttribute("loggedInUserID"),"close"));
        model.addAttribute("pendingOrders", transactionService.allUserTransactionsByType((Long) session.getAttribute("loggedInUserID"),"pending"));

        OkHttpClient client = new OkHttpClient().newBuilder().build();
        String symbol = new String();

        if(session.getAttribute("symbol") == null){
            symbol = "BTC";
        }else{
            symbol = (String) session.getAttribute("symbol"); // Get the symbol from the session
        }

        try {
            // Retrieve data from the CEX.IO API for order book
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

            try (Response orderBookResponse = client.newCall(orderBookRequest).execute();
                 Response tradeHistoryResponse = client.newCall(tradeHistoryRequest).execute();
                 Response bitcoinResponse = client.newCall(bitcoinRequest).execute();
                 Response ethereumResponse = client.newCall(ethereumRequest).execute();
                 Response uniswapResponse = client.newCall(uniswapRequest).execute();
                 Response rippleResponse = client.newCall(rippleRequest).execute();
                 Response chainlinkResponse = client.newCall(chainlinkRequest).execute()) {

                if (orderBookResponse.isSuccessful() && tradeHistoryResponse.isSuccessful()) {
                    String orderBookResponseBody = orderBookResponse.body().string();
                    String tradeHistoryResponseBody = tradeHistoryResponse.body().string();
                    String bitcoinResponseBody = bitcoinResponse.body().string();
                    String ethereumResponseBody = ethereumResponse.body().string();
                    String uniswapResponseBody = uniswapResponse.body().string();
                    String rippleResponseBody = rippleResponse.body().string();
                    String chainlinkResponseBody = chainlinkResponse.body().string();


                    ObjectMapper orderBookObjectMapper = new ObjectMapper();
                    JsonNode orderBookRoot = orderBookObjectMapper.readTree(orderBookResponseBody);

                    ObjectMapper tradeHistoryObjectMapper = new ObjectMapper();
                    JsonNode tradeHistoryRoot = tradeHistoryObjectMapper.readTree(tradeHistoryResponseBody);

                    ObjectMapper bitcoinObjectMapper = new ObjectMapper();
                    JsonNode bitcoinRoot = bitcoinObjectMapper.readTree(bitcoinResponseBody);

                    ObjectMapper ethereumObjectMapper = new ObjectMapper();
                    JsonNode ethereumRoot = ethereumObjectMapper.readTree(ethereumResponseBody);

                    ObjectMapper uniswapObjectMapper = new ObjectMapper();
                    JsonNode uniswapRoot = uniswapObjectMapper.readTree(uniswapResponseBody);

                    ObjectMapper rippleObjectMapper = new ObjectMapper();
                    JsonNode rippleRoot = rippleObjectMapper.readTree(rippleResponseBody);

                    ObjectMapper chainlinkObjectMapper = new ObjectMapper();
                    JsonNode chainlinkRoot = chainlinkObjectMapper.readTree(chainlinkResponseBody);

                    // Extract the necessary data from the order book response
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

                    String bitcoinPrice = noDecimalFormat.format(bitcoinPricePre);
                    String ethereumPrice = oneDecimalFormat.format(ethereumPricePre);
                    String uniswapPrice = threeDecimalFormat.format(uniswapPricePre);
                    String ripplePrice = threeDecimalFormat.format(ripplePricePre);
                    String chainlinkPrice = threeDecimalFormat.format(chainlinkPricePre);


                    // Extract the necessary data from the trade history response
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

                    // Pass the data to the view
                    model.addAttribute("symbol",symbol);
                    model.addAttribute("bids", bidsNode);
                    model.addAttribute("asks", asksNode);
                    model.addAttribute("tradeHistory", tradeHistoryList);
                    model.addAttribute("bitcoinPrice", Double.parseDouble(bitcoinPrice));
                    model.addAttribute("ethereumPrice", Double.parseDouble(ethereumPrice));
                    model.addAttribute("uniswapPrice", Double.parseDouble(uniswapPrice));
                    model.addAttribute("ripplePrice", Double.parseDouble(ripplePrice));
                    model.addAttribute("chainlinkPrice", Double.parseDouble(chainlinkPrice));
                } else {
                    // Handle unsuccessful response
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
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
                             BindingResult result, Model model, HttpSession session){

        if(session.getAttribute("loggedInUserID") == null){
            return "redirect:/login";
        }
        if(result.hasErrors()){
            return "trade";
        }

        User user = userService.findById((Long) session.getAttribute("loggedInUserID"));

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
                             Model model, HttpSession session){
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

        user.setUsd(transaction.getAmount()+transaction.getEarnings());
        userService.upgradeUser(user);
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