<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
  <link rel="stylesheet" href="/css/trade.css">
  <link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body class="special-darkgreen">
<nav class="d-flex justify-content-between align-items-center p-2">
    <div class="d-flex justify-content-between align-items-center nav-logo nav-brand">
        <div class="d-flex align-items-center">
            <img id="nav-logo-img" src="${pageContext.request.contextPath}/images/hyperliquid1.gif">
            <h3>Wallet<h3 style="font-style: italic;">liquid</h3></h3>
        </div>
        <a href="/leaderboard" class="text-muted text-decoration-none" ><h5>Leaderboard</h5></a>
        <a href="/history/${user.id}" class="text-muted text-decoration-none" ><h5>Trade History</h5></a>
    </div>
    <div class="d-flex nav-brand justify-content-around">
      <h3>Welcome ${user.firstName}</h3>
      <img src="${pageContext.request.contextPath}${user.image}" alt="Not found" width="50px" height="50px" style="background-color: transparent"/>
      <a href="/logout"><button class="p-2 nav-btn">Log out</button></a>
    </div>
</nav>

<c:if test="${errorMessage != null}">
  <span class="w-100 d-flex justify-content-center">
    <h1>${errorMessage}</h1>
  </span>
</c:if>

<div class="trading-container special-green">
  <div class="d-flex special-green">
    <div class="col-6 special-green">
      <div class="d-flex justify-content-between align-items-center w-100 mini-nav special-green">
        <div class="special-green">
          <form method="post" class="special-green" action="/elaborate">
            <select name="symbol" id="symbolSelect" class="special-darkgreen" style="color:white;">
              <option value="BTC" ${symbol == 'BTC' ? 'selected' : ''}>BTC / USD</option>
              <option value="ETH" ${symbol == 'ETH' ? 'selected' : ''}>ETH / USD</option>
              <option value="LINK" ${symbol == 'LINK' ? 'selected' : ''}>LINK / USD</option>
              <option value="XRP" ${symbol == 'XRP' ? 'selected' : ''}>XRP / USD</option>
              <option value="UNI" ${symbol == 'UNI' ? 'selected' : ''}>UNI / USD</option>
            </select>
            <button class="nav-btn" type="submit">Go</button>
          </form>
        </div>
        <!-- TradingView Widget BEGIN -->
        <div class="tradingview-widget-container w-75">
          <div class="tradingview-widget-container__widget"></div>
          <script type="text/javascript" src="https://s3.tradingview.com/external-embedding/embed-widget-ticker-tape.js" async>
            {
              "symbols": [
              {
                "description": "BTC - USD",
                "proName": "BINANCE:BTCUSD"
              },
              {
                "description": "ETH - USD",
                "proName": "BINANCE:ETHUSD"
              },
              {
                "description": "UNI - USD",
                "proName": "BINANCE:UNIUSD"
              },
              {
                "description": "XRP - USD",
                "proName": "BINANCE:XRPUSD"
              },
              {
                "description": "LINK - USD",
                "proName": "BINANCE:LINKUSD"
              }
            ],
                    "showSymbolLogo": true,
                    "colorTheme": "dark",
                    "isTransparent": true,
                    "displayMode": "adaptive",
                    "locale": "en"
            }
          </script>
        </div>
        <!-- TradingView Widget END -->
      </div>
      <div class="tradingview-widget-container row w-100" style="margin-top: 2%">
        <div id="tradingview_6184e" class="special-green"></div>
        <script type="text/javascript" src="https://s3.tradingview.com/tv.js"></script>
        <script type="text/javascript">
          function updateSymbol() {
            var widget = new TradingView.widget({
              "autosize": true,
              "symbol": "KUCOIN:" + "${symbol}" + "USDT",
              "interval": "D",
              "timezone": "Etc/UTC",
              "theme": "dark",
              "style": "1",
              "locale": "en",
              "hide_volume": true,
              "toolbar_bg": "#f1f3f6",
              "enable_publishing": false,
              "backgroundColor": "#02221f",
              "gridColor": "#0f2e29",
              "save_image": false,
              "hide_side_toolbar": false,
              "container_id": "tradingview_6184e"
            });
          }
          updateSymbol();
        </script>
      </div>
      <div>
        <!-- TradingView Widget BEGIN -->
        <div class="tradingview-widget-container">
          <div class="tradingview-widget-container__widget"></div>
          <script type="text/javascript" src="https://s3.tradingview.com/external-embedding/embed-widget-tickers.js" async>
            {
              "symbols": [
              {
                "description": "BItcoin",
                "proName": "BINANCE:BTCUSDT"
              },
              {
                "description": "Ethereum",
                "proName": "BINANCE:ETHUSDT"
              },
              {
                "description": "Uniswap",
                "proName": "BINANCE:UNIUSDT"
              },
              {
                "description": "Ripple",
                "proName": "BINANCE:XRPUSDT"
              },
              {
                "description": "Chainlink",
                "proName": "BINANCE:LINKUSDT"
              }
            ],
                    "colorTheme": "dark",
                    "isTransparent": true,
                    "showSymbolLogo": true,
                    "locale": "en"
            }
          </script>
        </div>
        <!-- TradingView Widget END -->
      </div>
    </div>

    <div class="col-3 special-green" style="border: 1px solid #97fce4; border-radius: 0.5rem;" >
      <p style="color: white">Order Book</p>
      <div class="orderbook special-darkgreen">
        <section class="side">
          <table class="w-100">
            <thead>
            <tr>
              <th scope="col" class="col-4">Price</th>
              <th scope="col" class="col-4">Size</th>
              <th scope="col" class="col-4">Amount (USD)</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="ask" items="${fn:split(fn:substringAfter(asks, '['), '] [')}" varStatus="status" end="10">
              <tr>
                <c:set var="askArr" value="${fn:split(ask, ',')}" />
                <c:set var="askPrice" value="${askArr[0].replace('\"','')}" />
                <c:set var="askSize" value="${askArr[1].replace('\"','')}" />
                <td class="red"><fmt:formatNumber value="${askPrice}" pattern="0.000" /></td>
                <td>${askSize}</td>
                <c:if test="${status.count % 2 != 0}">
                  <td><fmt:formatNumber value="${askPrice * askSize}" pattern="0.00" /></td>
                </c:if>
              </tr>
            </c:forEach>
            </tbody>
          </table>
        </section>
      </div>
      <div class="orderbook special-darkgreen">
        <section class="side">
          <table class="w-100">
            <thead>
            <tr>
              <th scope="col" class="col-4">&nbsp;</th>
              <th scope="col" class="col-4">&nbsp;</th>
              <th scope="col" class="col-4">&nbsp;</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="bid" items="${fn:split(fn:substringAfter(bids, '['), '] [')}" varStatus="status" end="10">
              <tr>
                <c:set var="bidArr" value="${fn:split(bid, ',')}" />
                <c:set var="bidPrice" value="${bidArr[0].replace('\"','')}" />
                <c:set var="bidSize" value="${bidArr[1].replace('\"','')}" />
                <td class="green"><fmt:formatNumber value="${bidPrice}" pattern="0.000" /></td>
                <td>${bidSize}</td>
                <c:if test="${status.count % 2 != 0}">
                  <td><fmt:formatNumber value="${bidPrice * bidSize}" pattern="0.00" /></td>
                </c:if>
              </tr>
            </c:forEach>
            </tbody>
          </table>
        </section>
      </div>

      <div class="special-green">
        <p style="color: white; margin-top: 2%">Trade History</p>
        <section class="side tradehistory special-darkgreen">
          <table class="w-100">
            <thead>
            <tr>
              <th scope="col" class="col-4">Price</th>
              <th scope="col" class="col-4">Size</th>
              <th scope="col" class="col-4">Time</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="trade" items="${tradeHistory}" varStatus="status" end="6">
              <c:set var="type" value="${trade['type']}" />
              <c:set var="price" value="${trade['price']}" />
              <c:set var="amount" value="${trade['amount']}" />
              <c:set var="date" value="${trade['date']}" />

              <tr>
                <td class="${type eq 'buy' ? 'green' : 'red'}">${price}</td>
                <td>${amount}</td>
                <td>${date}</td>
              </tr>
            </c:forEach>
            </tbody>
          </table>
        </section>
      </div>
    </div>

    <div class="col-3 special-darkgreen" style="border: #97fce4 1px solid; border-radius: 0.5rem">

      <script>
        document.addEventListener("DOMContentLoaded", function(){
          var tabList = [].slice.call(document.querySelectorAll("#myTab a #myTab1"));
          tabList.forEach(function(tab){
            var tabTrigger = new bootstrap.Tab(tab);

            tab.addEventListener("click", function(event){
              event.preventDefault();
              tabTrigger.show();
            });
          });
        });
      </script>

      <ul class="nav nav-pills" id="myTab">
        <li class="nav-item"><a class="nav-link active" href="#market" data-bs-toggle="pill">Market</a></li>
        <li class="nav-item"><a class="nav-link" href="#limit" data-bs-toggle="pill">Limit</a></li>
      </ul>
      <div class="tab-content special-darkgreen">
        <div class="tab-pane fade show active special-darkgreen" id="market">
          <form:form action="/marketorder" method="post" modelAttribute="transactionMarket">
            <div class="row special-darkgreen" style="padding: 2%;margin-top: 5%;">
              <form:select path="direction" cssClass="toggle-dropdown special-green" cssStyle="color: white; padding: 1%;border: 1px solid #97fce4;border-radius: 0.5rem;">
                <form:option value="long" label="Long" />
                <form:option value="short" label="Short" />
              </form:select>
            </div>
            <div class="row special-darkgreen" style="padding: 2%">
              <p><form:label path="amount">Amount: </form:label></p>
              <form:errors path="amount" cssStyle="color: white"/>
              <form:input type="number" cssClass="special-green" cssStyle="color: white; border: 1px solid #97fce4;border-radius: 0.5rem; padding: 1%" path="amount"></form:input>
            </div>
            <div class="row special-darkgreen">
              <div class="d-flex special-darkgreen">
                <p style="margin-right: 5%"><form:label path="leverage">Leverage: </form:label></p>
                <div id="sliderValue" class="special-darkgreen"></div>
              </div>
              <form:errors path="leverage"></form:errors>
              <form:input path="leverage" type="range" id="leverageSlider" name="leverage" min="1" max="100" step="1" onchange="updateValue(this.value)" />
            </div>
            <div class="row special-darkgreen" style="padding: 2%">
              <p><b>Current Price: </b><span id="currentPrice"></span></p>
              <p><b>Liquidation Price: </b><span id="liquidationPrice"></span></p>
              <p><b>Portfolio: </b>${user.usd} USD</p>
            </div>
            <form:hidden path="price" id="currentPriceInput" name="currentPrice" />
            <form:hidden path="symbol" value="${symbol}" />

            <input type="submit" class="nav-btn p-2 w-100" style="margin-top: 5%" value="Place Order"/>
          </form:form>
          <script>
            function updateValue(value) {
              document.getElementById("sliderValue").textContent = value;
            }

            function updateLiquidationPrice() {
              const direction = document.getElementById("direction").value;
              const entryPrice = parseFloat(getEntryPrice());
              const maintenanceMargin = 0.906;
              const leverage = parseInt(document.getElementById("leverageSlider").value);
              let liquidationPrice;

              if (direction == "long") {
                liquidationPrice = entryPrice * (1 - maintenanceMargin / leverage);
              } else if (direction == "short") {
                liquidationPrice = entryPrice * (1 + maintenanceMargin / leverage);
              } else {
                liquidationPrice = 0;
              }

              document.getElementById("liquidationPrice").textContent = liquidationPrice.toFixed(2);
            }

            function getEntryPrice() {
              const symbol = "${symbol}";
              let entryPrice;

              switch (symbol) {
                case "BTC":
                  entryPrice = parseFloat("${bitcoinPrice}");
                  break;
                case "ETH":
                  entryPrice = parseFloat("${ethereumPrice}");
                  break;
                case "UNI":
                  entryPrice = parseFloat("${uniswapPrice}");
                  break;
                case "XRP":
                  entryPrice = parseFloat("${ripplePrice}");
                  break;
                case "LINK":
                  entryPrice = parseFloat("${chainlinkPrice}");
                  break;
                default:
                  entryPrice = 0;
                  break;
              }
              document.getElementById("currentPrice").textContent = entryPrice;
              document.getElementById("currentPriceInput").value = entryPrice; // Set hidden input value
              return entryPrice;
            }

            setInterval(getEntryPrice, 5000);

            // Update liquidation price on input change
            document.getElementById("leverageSlider").addEventListener("input", updateLiquidationPrice);
            document.getElementById("direction").addEventListener("change", updateLiquidationPrice);
            document.addEventListener("DOMContentLoaded", updateLiquidationPrice);
            document.addEventListener("DOMContentLoaded", getEntryPrice);
          </script>
          <div class="card" style="width: 100%; margin-top: 8%; border: 1px yellow solid;border-radius: 0.5rem;">
            <div class="card-body special-green" style="border-radius: 0.5rem">
              <h5 class="card-title"><img src="${pageContext.request.contextPath}/images/warning.png" width="50px" height="50px"> ATTENTION</h5>
              <h6 class="card-subtitle mb-2 text-muted">Please Read</h6>
              <p class="card-text">Before placing or closing any order, reload the page, in order to get the updated data. Thanks for understanding</p>
            </div>
          </div>
        </div>
        <div class="tab-pane fade" id="limit">
          <h1 style="color: white; margin-top: 2% ">Coming Soon...</h1>
        </div>
      </div>
    </div>
  </div>
</div>

<div class="trading-container special-green">
    <ul class="nav nav-pills" id="myTab1" style="margin-bottom: 1%">
      <li class="nav-item"><a class="nav-link active" href="#positions" data-bs-toggle="pill">Positions</a></li>
      <li class="nav-item"><a class="nav-link" href="#orders" data-bs-toggle="pill">Orders</a></li>
      <li class="nav-item"><a class="nav-link" href="#trades" data-bs-toggle="pill">Trades</a></li>
    </ul>
    <div class="tab-content special-darkgreen">
      <div class="tab-pane fade show active" id="positions" >
        <div>
          <section class="side">
            <table class="table" style="color: white">
              <thead>
              <tr>
                <th scope="col">Pair</th>
                <th scope="col">Size</th>
                <th scope="col">Value</th>
                <th scope="col">Entry Price</th>
                <th scope="col">Current Price</th>
                <th scope="col">Liquidation Price</th>
                <th scope="col">Earnings</th>
                <th scope="col">Margin</th>
                <th scope="col">Close</th>
              </tr>
              </thead>
              <tbody>
              <c:forEach var="transaction" items="${openOrders}">
                <tr>
                  <c:if test="${transaction.direction == 'long'}">
                    <td class="green">${transaction.symbol}-USD</td>
                  </c:if>
                  <c:if test="${transaction.direction == 'short'}">
                    <td class="red">${transaction.symbol}-USD</td>
                  </c:if>
                  <td>${transaction.tokenSize} ${transaction.symbol}</td>
                  <td>${transaction.amount*transaction.leverage}$</td>
                  <td>${transaction.price}</td>
                  <c:if test="${transaction.symbol == 'BTC'}">
                    <td>${bitcoinPrice}</td>
                  </c:if>
                  <c:if test="${transaction.symbol == 'ETH'}">
                    <td>${ethereumPrice}</td>
                  </c:if>
                  <c:if test="${transaction.symbol == 'UNI'}">
                    <td>${uniswapPrice}</td>
                  </c:if>
                  <c:if test="${transaction.symbol == 'XRP'}">
                    <td>${ripplePrice}</td>
                  </c:if>
                  <c:if test="${transaction.symbol == 'LINK'}">
                    <td>${chainlinkPrice}</td>
                  </c:if>
                  <td>${transaction.liqPrice}</td>
                  <c:if test="${transaction.symbol == 'BTC'}">
                    <c:if test="${transaction.direction == 'short'}">
                      <c:if test="${transaction.price >= bitcoinPrice}">
                        <c:set var="difference" value="${transaction.price - bitcoinPrice}" />
                        <c:set var="percentage" value="${(transaction.tokenSize * difference) * 100/transaction.amount}" />
                        <td class="green">+${transaction.tokenSize * difference}
                          (+<fmt:formatNumber value="${percentage}" type="percent" pattern="##.##" />)</td>
                      </c:if>
                      <c:if test="${transaction.price < bitcoinPrice}">
                        <c:set var="difference" value="${transaction.price - bitcoinPrice}" />
                        <c:set var="percentage" value="${(transaction.tokenSize * difference) * 100/transaction.amount}" />
                        <td class="red">${transaction.tokenSize * difference}
                          (<fmt:formatNumber value="${percentage}" type="percent" pattern="##.##" />)</td>
                      </c:if>
                    </c:if>
                    <c:if test="${transaction.direction == 'long'}">
                      <c:if test="${transaction.price <= bitcoinPrice}">
                        <c:set var="difference" value="${bitcoinPrice - transaction.price}" />
                        <c:set var="percentage" value="${(transaction.tokenSize * difference) * 100/transaction.amount}" />
                        <td class="green">+${transaction.tokenSize * difference}
                          (+<fmt:formatNumber value="${percentage}" type="percent" pattern="##.##" />)</td>
                      </c:if>
                      <c:if test="${transaction.price > bitcoinPrice}">
                        <c:set var="difference" value="${bitcoinPrice - transaction.price}" />
                        <c:set var="percentage" value="${(transaction.tokenSize * difference) * 100/transaction.amount}" />
                        <td class="red">${transaction.tokenSize * difference}
                          (<fmt:formatNumber value="${percentage}" type="percent" pattern="##.##" />)</td>
                      </c:if>
                    </c:if>
                  </c:if>
                  <c:if test="${transaction.symbol == 'ETH'}">
                    <c:if test="${transaction.direction == 'short'}">
                      <c:if test="${transaction.price >= ethereumPrice}">
                        <c:set var="difference" value="${transaction.price - ethereumPrice}" />
                        <c:set var="percentage" value="${(transaction.tokenSize * difference) * 100/transaction.amount}" />
                        <td class="green">+${transaction.tokenSize * difference}
                          (+<fmt:formatNumber value="${percentage}" type="percent" pattern="##.##" />)</td>
                      </c:if>
                      <c:if test="${transaction.price < ethereumPrice}">
                        <c:set var="difference" value="${transaction.price - ethereumPrice}" />
                        <c:set var="percentage" value="${(transaction.tokenSize * difference) * 100/transaction.amount}" />
                        <td class="red">${transaction.tokenSize * difference}
                          (<fmt:formatNumber value="${percentage}" type="percent" pattern="##.##" />)</td>
                      </c:if>
                    </c:if>
                    <c:if test="${transaction.direction == 'long'}">
                      <c:if test="${transaction.price <= ethereumPrice}">
                        <c:set var="difference" value="${ethereumPrice - transaction.price}" />
                        <c:set var="percentage" value="${(transaction.tokenSize * difference) * 100/transaction.amount}" />
                        <td class="green">+${transaction.tokenSize * difference}
                          (+<fmt:formatNumber value="${percentage}" type="percent" pattern="##.##" />)</td>
                      </c:if>
                      <c:if test="${transaction.price > ethereumPrice}">
                        <c:set var="difference" value="${ethereumPrice - transaction.price}" />
                        <c:set var="percentage" value="${(transaction.tokenSize * difference) * 100/transaction.amount}" />
                        <td class="red">${transaction.tokenSize * difference}
                          (<fmt:formatNumber value="${percentage}" type="percent" pattern="##.##" />)</td>
                      </c:if>
                    </c:if>
                  </c:if>
                  <c:if test="${transaction.symbol == 'UNI'}">
                    <c:if test="${transaction.direction == 'short'}">
                      <c:if test="${transaction.price >= uniswapPrice}">
                        <c:set var="difference" value="${transaction.price - uniswapPrice}" />
                        <c:set var="percentage" value="${(transaction.tokenSize * difference) * 100/transaction.amount}" />
                        <td class="green">+${transaction.tokenSize * difference}
                          (+<fmt:formatNumber value="${percentage}" type="percent" pattern="##.##" />)</td>
                      </c:if>
                      <c:if test="${transaction.price < uniswapPrice}">
                        <c:set var="difference" value="${transaction.price - uniswapPrice}" />
                        <c:set var="percentage" value="${(transaction.tokenSize * difference) * 100/transaction.amount}" />
                        <td class="red">${transaction.tokenSize * difference}
                          (<fmt:formatNumber value="${percentage}" type="percent" pattern="##.##" />)</td>
                      </c:if>
                    </c:if>
                    <c:if test="${transaction.direction == 'long'}">
                      <c:if test="${transaction.price <= uniswapPrice}">
                        <c:set var="difference" value="${uniswapPrice - transaction.price}" />
                        <c:set var="percentage" value="${(transaction.tokenSize * difference) * 100/transaction.amount}" />
                        <td class="green">+${transaction.tokenSize * difference}
                          (+<fmt:formatNumber value="${percentage}" type="percent" pattern="##.##" />)</td>
                      </c:if>
                      <c:if test="${transaction.price > uniswapPrice}">
                        <c:set var="difference" value="${uniswapPrice - transaction.price}" />
                        <c:set var="percentage" value="${(transaction.tokenSize * difference) * 100/transaction.amount}" />
                        <td class="red">${transaction.tokenSize * difference}
                          (<fmt:formatNumber value="${percentage}" type="percent" pattern="##.##" />)</td>
                      </c:if>
                    </c:if>
                  </c:if>
                  <c:if test="${transaction.symbol == 'XRP'}">
                    <c:if test="${transaction.direction == 'short'}">
                      <c:if test="${transaction.price >= ripplePrice}">
                        <c:set var="difference" value="${transaction.price - ripplePrice}" />
                        <c:set var="percentage" value="${(transaction.tokenSize * difference) * 100/transaction.amount}" />
                        <td class="green">+${transaction.tokenSize * difference}
                          (+<fmt:formatNumber value="${percentage}" type="percent" pattern="##.##" />)</td>
                      </c:if>
                      <c:if test="${transaction.price < ripplePrice}">
                        <c:set var="difference" value="${transaction.price - ripplePrice}" />
                        <c:set var="percentage" value="${(transaction.tokenSize * difference) * 100/transaction.amount}" />
                        <td class="red">${transaction.tokenSize * difference}
                          (<fmt:formatNumber value="${percentage}" type="percent" pattern="##.##" />)</td>
                      </c:if>
                    </c:if>
                    <c:if test="${transaction.direction == 'long'}">
                      <c:if test="${transaction.price <= ripplePrice}">
                        <c:set var="difference" value="${ripplePrice - transaction.price}" />
                        <c:set var="percentage" value="${(transaction.tokenSize * difference) * 100/transaction.amount}" />
                        <td class="green">+${transaction.tokenSize * difference}
                          (+<fmt:formatNumber value="${percentage}" type="percent" pattern="##.##" />)</td>
                      </c:if>
                      <c:if test="${transaction.price > ripplePrice}">
                        <c:set var="difference" value="${ripplePrice - transaction.price}" />
                        <c:set var="percentage" value="${(transaction.tokenSize * difference) * 100/transaction.amount}" />
                        <td class="red">${transaction.tokenSize * difference}
                          (<fmt:formatNumber value="${percentage}" type="percent" pattern="##.##" />)</td>
                      </c:if>
                    </c:if>
                  </c:if>
                  <c:if test="${transaction.symbol == 'LINK'}">
                    <c:if test="${transaction.direction == 'short'}">
                      <c:if test="${transaction.price >= chainlinkPrice}">
                        <c:set var="difference" value="${transaction.price - chainlinkPrice}" />
                        <c:set var="percentage" value="${(transaction.tokenSize * difference) * 100/transaction.amount}" />
                        <td class="green">+${transaction.tokenSize * difference}
                          (+<fmt:formatNumber value="${percentage}" type="percent" pattern="##.##" />)</td>
                      </c:if>
                      <c:if test="${transaction.price < chainlinkPrice}">
                        <c:set var="difference" value="${transaction.price - chainlinkPrice}" />
                        <c:set var="percentage" value="${(transaction.tokenSize * difference) * 100/transaction.amount}" />
                        <td class="red">${transaction.tokenSize * difference}
                          (<fmt:formatNumber value="${percentage}" type="percent" pattern="##.##" />)</td>
                      </c:if>
                    </c:if>
                    <c:if test="${transaction.direction == 'long'}">
                      <c:if test="${transaction.price <= chainlinkPrice}">
                        <c:set var="difference" value="${chainlinkPrice - transaction.price}" />
                        <c:set var="percentage" value="${(transaction.tokenSize * difference) * 100/transaction.amount}" />
                        <td class="green">+${transaction.tokenSize * difference}
                          (+<fmt:formatNumber value="${percentage}" type="percent" pattern="##.##" />)</td>
                      </c:if>
                      <c:if test="${transaction.price > chainlinkPrice}">
                        <c:set var="difference" value="${chainlinkPrice - transaction.price}" />
                        <c:set var="percentage" value="${(transaction.tokenSize * difference) * 100/transaction.amount}" />
                        <td class="red">${transaction.tokenSize * difference}
                          (<fmt:formatNumber value="${percentage}" type="percent" pattern="##.##" />)</td>
                      </c:if>
                    </c:if>
                  </c:if>

                  <td>${transaction.amount} (${transaction.leverage}x)</td>
                  <td>
                    <c:set var="lastPrice" value="" />

                    <c:choose>
                      <c:when test="${transaction.symbol == 'BTC'}">
                        <c:set var="lastPrice" value="${bitcoinPrice}" />
                      </c:when>
                      <c:when test="${transaction.symbol == 'ETH'}">
                        <c:set var="lastPrice" value="${ethereumPrice}" />
                      </c:when>
                      <c:when test="${transaction.symbol == 'UNI'}">
                        <c:set var="lastPrice" value="${uniswapPrice}" />
                      </c:when>
                      <c:when test="${transaction.symbol == 'XRP'}">
                        <c:set var="lastPrice" value="${ripplePrice}" />
                      </c:when>
                      <c:when test="${transaction.symbol == 'LINK'}">
                        <c:set var="lastPrice" value="${chainlinkPrice}" />
                      </c:when>
                    </c:choose>

                    <a href="/closemarket/${transaction.id}?traLastPrice=${lastPrice}"><button class="nav-btn p-2">Market Close</button></a>
                  </td>
                </tr>
              </c:forEach>
              </tbody>
            </table>
          </section>
        </div>
      </div>
      <div class="tab-pane fade d-flex justify-content-center" id="orders">
        <h1 style="color: white; margin: 1%">Coming Soon...</h1>
      </div>
      <div class="tab-pane fade" id="trades">
        <section class="side">
          <table class="table" style="color: white;">
            <thead>
            <tr>
              <th scope="col">Pair</th>
              <th scope="col">Size</th>
              <th scope="col">Amount</th>
              <th scope="col">Leverage</th>
              <th scope="col">Entry Price</th>
              <th scope="col">Close Price</th>
              <th scope="col">Earnings</th>
            </tr>
            </thead>
            <tbody>
              <c:forEach var="transaction" items="${closedOrders}">
                <tr>
                  <c:if test="${transaction.direction == 'long'}">
                    <td class="text-success" style="padding: 1%">${transaction.symbol}-USD</td>
                  </c:if>
                  <c:if test="${transaction.direction == 'short'}">
                    <td class="text-danger" style="padding: 1%">${transaction.symbol}-USD</td>
                  </c:if>
                  <td style="padding: 1%">${transaction.tokenSize} ${transaction.symbol}</td>
                  <td style="padding: 1%">${transaction.amount}</td>
                  <td style="padding: 1%">${transaction.leverage}</td>
                  <td style="padding: 1%">${transaction.price}</td>
                  <td style="padding: 1%">${transaction.lastPrice}</td>
                  <td style="padding: 1%" class="${transaction.earnings >= 0 ? 'text-success' : 'text-danger'}">${transaction.earnings}</td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
        </section>
      </div>
    </div>
</div>
</body>
</html>
