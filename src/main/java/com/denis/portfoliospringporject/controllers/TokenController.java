package com.denis.portfoliospringporject.controllers;

import com.denis.portfoliospringporject.components.TransactionDTOConverter;
import com.denis.portfoliospringporject.components.UserDTOConverter;
import com.denis.portfoliospringporject.dto.TransactionDTO;
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

import java.security.Principal;
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

    @Autowired
    TransactionDTOConverter transactionDTOConverter;

    @Autowired
    UserDTOConverter userDTOConverter;

    @RequestMapping(value = {"/","/index"})
    public String indexGet() {
        return "index";
    }

    @GetMapping("/trade")
    public String tradeGet(Principal principal, Model model, HttpSession session) {

        if(principal==null) {
            return "redirect:/login";
        }

        String email = principal.getName();
        User user = userService.findByEmail(email);
        model.addAttribute("user", user);

        Transaction transactionMarket = new Transaction();
        Transaction transactionLimit = new Transaction();
        List<Transaction> openTransactions = transactionService.allUserTransactionsByType((user.getId()), "open");
        List<Transaction> cloedTransactions = transactionService.allUserTransactionsByType((user.getId()), "closed");
        List<Transaction> pendingTransactions = transactionService.allUserTransactionsByType((user.getId()), "pending");


        model.addAttribute("transactionMarket", transactionMarket);
        model.addAttribute("transactionLimit", transactionLimit);
        model.addAttribute("openOrders", transactionDTOConverter.entityToDtoList(openTransactions));
        model.addAttribute("closedOrders", transactionDTOConverter.entityToDtoList(cloedTransactions));
        model.addAttribute("pendingOrders", transactionDTOConverter.entityToDtoList(pendingTransactions));

        OkHttpClient client = new OkHttpClient().newBuilder().build();
        String symbol = session.getAttribute("symbol") != null ? (String) session.getAttribute("symbol") : "BTC";

        double bitcoinPrice = 0.0;
        double ethereumPrice = 0.0;
        double uniswapPrice = 0.0;
        double ripplePrice = 0.0;
        double chainlinkPrice = 0.0;

        try {
            Request orderBookRequest = new Request.Builder()
                    .url("https://data-api.binance.vision/api/v3/depth?symbol=" + symbol + "USDT")
                    .build();

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
                System.out.println("Failed to fetch data from external API.");
                model.addAttribute("errorMessage", "Oops! Something went wrong while fetching data. Please try again later.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("An error occurred while processing the request: " + e.getMessage());
            model.addAttribute("errorMessage", "Oops! Something went wrong. Please try again later.");
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
    public String tradePost(@RequestParam String symbol, HttpSession session) {

        session.setAttribute("symbol", symbol);
        return "redirect:/trade";
    }

    @PostMapping("/marketorder")
    public String marketorder(@Valid @ModelAttribute("transactionMarket") Transaction transactionMarket,
                              BindingResult result, Principal principal){

        if(principal==null) {
            return "redirect:/login";
        }

        String email = principal.getName();
        User user = userService.findByEmail(email);

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
        transactionMarket.setClosedAt(LocalDateTime.now());
        transactionMarket.setUser(user);
        userService.updateUser(user);
        transactionService.saveTransaction(transactionMarket);

        return "redirect:/trade";
    }

    @GetMapping("/closemarket/{transactionId}")
    public String closeOrder(@PathVariable("transactionId") Long transactionId,
                             @RequestParam("traLastPrice") double traLastPrice,
                             Principal principal){

        if(principal==null) {
            return "redirect:/login";
        }

        Transaction transaction = transactionService.findTransaction(transactionId);
        Type type = typeService.findByName("closed");

        transaction.setType(type);
        if(transaction.getDirection().equals("long")){
            transaction.setLastPrice(traLastPrice);
            transaction.setEarnings(transaction.getTokenSize()*(transaction.getLastPrice()-transaction.getPrice()));
        } else if(transaction.getDirection().equals("short")){
            transaction.setLastPrice(traLastPrice);
            transaction.setEarnings(transaction.getTokenSize()*(transaction.getPrice()-transaction.getLastPrice()));
        }

        String email = principal.getName();
        User user = userService.findByEmail(email);

        user.setUsd(user.getUsd() + transaction.getAmount() + transaction.getEarnings());
        userService.updateUser(user);
        transactionService.saveTransaction(transaction);

        return "redirect:/trade";
    }

    @GetMapping("/liquidation/{transactionId}")
    public String liquidation(@PathVariable("transactionId") Long transactionId,
                              Principal principal){

        if(principal==null) {
            return "redirect:/login";
        }

        Transaction transaction = transactionService.findTransaction(transactionId);
        Type type = typeService.findByName("closed");


        transaction.setType(type);
        if(transaction.getDirection().equals("long")){
            transaction.setLastPrice(transaction.getLiqPrice());
            transaction.setEarnings(transaction.getTokenSize()*(transaction.getLastPrice()-transaction.getPrice()));
        } else if(transaction.getDirection().equals("short")){
            transaction.setLastPrice(transaction.getLiqPrice());
            transaction.setEarnings(transaction.getTokenSize()*(transaction.getPrice()-transaction.getLastPrice()));
        }

        String email = principal.getName();
        User user = userService.findByEmail(email);

        user.setUsd(user.getUsd()+transaction.getEarnings());
        userService.updateUser(user);
        transactionService.saveTransaction(transaction);

        return "redirect:/trade";
    }

    @GetMapping("/leaderboard")
    public String leaderboardGet(Model model, Principal principal){

        if(principal==null) {
            return "redirect:/login";
        }

        String email = principal.getName();
        User user = userService.findByEmail(email);

        model.addAttribute("user", userDTOConverter.entityToDto(user));
        model.addAttribute("userList",userDTOConverter.entityToDtoList(userService.allUserByMostUsd()));

        return "leaderboard";
    }

    @GetMapping("/leaderboard/{userId}")
    public String userTransactionsGet(@PathVariable Long userId, Model model, Principal principal){
        if(principal==null) {
            return "redirect:/login";
        }

        String email = principal.getName();
        User currentUser = userService.findByEmail(email);
        User user = userService.findById(userId);

        model.addAttribute("currentUser",userDTOConverter.entityToDto(currentUser));
        model.addAttribute("user",userDTOConverter.entityToDto(user));
        model.addAttribute("transactionList", transactionDTOConverter.entityToDtoList(transactionService.allUserTransactions(userId)));

        return "userTransactions";
    }

    @GetMapping("/history/{userId}")
    public String historyGet(@PathVariable Long userId,Model model, Principal principal){
        if(principal==null) {
            return "redirect:/login";
        }

        String email = principal.getName();
        User user = userService.findByEmail(email);

        model.addAttribute("user",userDTOConverter.entityToDto(user));
        model.addAttribute("transactionList", transactionDTOConverter.entityToDtoList(transactionService.allUserTransactions(userId)));

        return "history";
    }

}