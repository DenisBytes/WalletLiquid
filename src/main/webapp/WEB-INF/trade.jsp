<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
  <link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
  <style>

    nav{
      background-color: black;
      width: 100%;
    }

    #nav-logo-img{
      padding: 0% 2%;
      width: 75px;
      height: 75px;
    }
    .nav-logo{
      color: white;
    }

    .nav-btn{
      background-color: blue;
      color: white;
      border-radius: 5%;
      border: 1px solid blue;

    }

    #tradingview_6184e{
      height: 550px;
    }
    body {
      background-color: white;
      color: white;
    }

    h2 {
      color: white;
    }

    div{background-color: black;

    }
    table {
      color: white;
      font-size: 12px;
    }

    td.green {
      color: green;
    }

    td.red {
      color: red;
    }

    .table-container > div {
      flex-grow: 1;
    }
    .side {
      width: 100%;
      height: 33%;
    }
    select{
      color: black;
    }

  </style>
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
</head>
<body>
<nav class="d-flex justify-content-between align-items-center p-2">
  <div class="d-flex justify-content-between align-items-center nav-logo" style="width: 40%">
    <div class="d-flex align-items-center">
      <img id="nav-logo-img" src="${pageContext.request.contextPath}/images/hyperliquid1.gif">
      <h3 style="margin-left: 5px;font-family: 'Libre Baskerville';">Wallet<h3 style="font-style: italic;font-family: 'Libre Baskerville'">liquid</h3></h3>
    </div>
    <a href="/leaderboard" class="text-muted text-decoration-none" ><h5>Leaderboard</h5></a>
    <a href="/history/${user.id}" class="text-muted text-decoration-none" ><h5>Trade History</h5></a>
  </div>
  <div class="d-flex w-25 justify-content-around">
    <h3>Welcome ${user.firstName}</h3>
    <img src="${pageContext.request.contextPath}${user.image}" alt="Not found" width="50px" height="50px" style="background-color: white; border: white 2px solid"/>
    <a href="/logout"><button class="p-2 nav-btn">Log out</button></a>
  </div>
</nav>
<div style="margin: 2%;padding: 1%">
  <div class="d-flex">
    <div class="col-6">
      <div class="d-flex justify-content-between align-items-center w-100" style="border: white 1px solid; border-radius: 0.5rem;padding: 2%;">
        <div>
          <form method="post" action="/elaborate">
            <select name="symbol" id="symbolSelect">
              <option value="BTC" ${symbol == 'BTC' ? 'selected' : ''}>BTC / USD</option>
              <option value="ETH" ${symbol == 'ETH' ? 'selected' : ''}>ETH / USD</option>
              <option value="LINK" ${symbol == 'LINK' ? 'selected' : ''}>LINK / USD</option>
              <option value="XRP" ${symbol == 'XRP' ? 'selected' : ''}>XRP / USD</option>
              <option value="UNI" ${symbol == 'UNI' ? 'selected' : ''}>UNI / USD</option>
            </select>
            <button type="submit">Go</button>
          </form>
        </div>
        <div class="tokens" >
          <div class="tokens-slide">
            <span>BTC-USD</span>
            <span class="text-muted">${bitcoinPrice}</span>
            <span>ETH-USD</span>
            <span class="text-muted">${ethereumPrice}</span>
            <span>UNI-USD</span>
            <span class="text-muted">${uniswapPrice}</span>
            <span>XRP-USD</span>
            <span class="text-muted">${ripplePrice}</span>
            <span>LINK-USD</span>
            <span class="text-muted" style="margin-right: 7px">${chainlinkPrice}</span>
          </div>
          <div class="tokens-slide">
            <span>BTC-USD</span>
            <span class="text-muted">${bitcoinPrice}</span>
            <span>ETH-USD</span>
            <span class="text-muted">${ethereumPrice}</span>
            <span>UNI-USD</span>
            <span class="text-muted">${uniswapPrice}</span>
            <span>XRP-USD</span>
            <span class="text-muted">${ripplePrice}</span>
            <span>LINK-USD</span>
            <span class="text-muted" style="margin-right: 7px">${chainlinkPrice}</span>
          </div>
        </div>
      </div>
      <style>
        @keyframes slide {
          from{
            transform: translateX(0%);
          }
          to{
            transform: translateX(-100%);
          }
        }

        .tokens{
          display: flex;
          overflow: hidden;
          padding: 1%;
          background-color: black;
          color: white;
          white-space: nowrap;
        }

        .tokens:hover .tokens-slide{
          animation-play-state:paused;
        }

        .tokens-slide{
          animation: 10s slide infinite linear;
          white-space: nowrap; /* Prevent text wrapping */
        }

        .tokens-slide span {
          display: inline-block;
          padding: 0% 0.125%;
          text-overflow: fade; /* Add ellipsis (...) to indicate hidden text */
        }
      </style>
      <div class="tradingview-widget-container row w-100">
        <div id="tradingview_6184e"></div>
        <div class="tradingview-widget-copyright"><a href="https://www.tradingview.com/" rel="noopener nofollow" target="_blank"><span class="blue-text">Track all markets on TradingView</span></a></div>

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
              "toolbar_bg": "#f1f3f6",
              "enable_publishing": false,
              "save_image": false,
              "container_id": "tradingview_6184e"
            });
          }
          updateSymbol();
        </script>
      </div>

    </div>

    <div class="col-3" style="height: 550px;border: 1px solid white; border-radius: 0.5rem; padding: 1%;height: min-content;">
      <p>Order Book</p>
      <div>
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
      <div>
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

      <div>
        <p>Trade History</p>
        <section class="side">
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

    <div class="col-3" style="border: 1px solid white; border-radius: 0.5rem; padding: 2%;height: min-content">

      <ul class="nav nav-pills" id="myTab">
        <li class="nav-item"><a class="nav-link active" href="#market" data-bs-toggle="pill">Market</a></li>
        <li class="nav-item"><a class="nav-link" href="#limit" data-bs-toggle="pill">Limit</a></li>
      </ul>
      <div class="tab-content">
        <div class="tab-pane fade show active" id="market">
          <form:form action="/marketorder" method="post" modelAttribute="transactionMarket">
            <div class="row" style="padding: 2%;margin-top: 2%; border-radius: 0.5rem; border: white 1px solid">
              <form:select path="direction" cssClass="toggle-dropdown">
                <form:option value="long" label="Long" />
                <form:option value="short" label="Short" />
              </form:select>
            </div>
            <div class="row" style="padding: 2%">
              <p><form:label path="amount">Amount: </form:label></p>
              <form:errors path="amount"/>
              <form:input type="number" path="amount"></form:input>
            </div>
            <div class="row">
              <div class="d-flex">
                <p style="margin-right: 5%"><form:label path="leverage">Leverage: </form:label></p>
                <div id="sliderValue"></div>
              </div>
              <form:errors path="leverage"></form:errors>
              <form:input path="leverage" type="range" id="leverageSlider" name="leverage" min="1" max="100" step="1" onchange="updateValue(this.value)" />
            </div>
            <div class="row" style="padding: 2%">
              <p><b>Current Price: </b><span id="currentPrice"></span></p>
              <p><b>Liquidation Price: </b><span id="liquidationPrice"></span></p>
              <p><b>Portfolio: </b>${user.usd} USD</p>
            </div>
            <form:hidden path="price" id="currentPriceInput" name="currentPrice" />
            <form:hidden path="symbol" value="${symbol}" />

            <input type="submit" class="btn btn-primary w-100" style="margin-top: 5%" value="Place Order"/>
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
          <div class="card" style="width: 100%; margin-top: 8%">
            <div class="card-body bg-warning">
              <h5 class="card-title">ATTENTION</h5>
              <h6 class="card-subtitle mb-2 text-muted">Please Read</h6>
              <p class="card-text">Before placing or closing any order, reload the page, in order to get the updated data. Thanks for understanding</p>
            </div>
          </div>

          </div>
        </div>
        <div class="tab-pane fade" id="limit" >
          <h1>Coming Soon...</h1>
        </div>
      </div>

    </div>
  </div>

  <div class="m-4 p-4" >
    <ul class="nav nav-pills" id="myTab1">
      <li class="nav-item"><a class="nav-link active" href="#positions" data-bs-toggle="pill">Positions</a></li>
      <li class="nav-item"><a class="nav-link" href="#orders" data-bs-toggle="pill">Orders</a></li>
      <li class="nav-item"><a class="nav-link" href="#trades" data-bs-toggle="pill">Trades</a></li>
    </ul>
    <div class="tab-content">
      <div class="tab-pane fade show active" id="positions" >
        <div>
          <section class="side">
            <table class="w-100">
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
                    <td class="text-success">${transaction.symbol}-USD</td>
                  </c:if>
                  <c:if test="${transaction.direction == 'short'}">
                    <td class="text-danger">${transaction.symbol}-USD</td>
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
                        <c:set var="percentage" value="${(difference / bitcoinPrice) * 100}" />
                        <td class="text-success">+${transaction.tokenSize * difference}
                          (+<fmt:formatNumber value="${percentage}" type="percent" pattern="##.##" />)</td>
                      </c:if>
                      <c:if test="${transaction.price < bitcoinPrice}">
                        <c:set var="difference" value="${transaction.price - bitcoinPrice}" />
                        <c:set var="percentage" value="${(difference / bitcoinPrice) * 100}" />
                        <td class="text-danger">${transaction.tokenSize * difference}
                          (<fmt:formatNumber value="${percentage}" type="percent" pattern="##.##" />)</td>
                      </c:if>
                    </c:if>
                    <c:if test="${transaction.direction == 'long'}">
                      <c:if test="${transaction.price <= bitcoinPrice}">
                        <c:set var="difference" value="${bitcoinPrice - transaction.price}" />
                        <c:set var="percentage" value="${(difference / bitcoinPrice) * 100}" />
                        <td class="text-success">+${transaction.tokenSize * difference}
                          (+<fmt:formatNumber value="${percentage}" type="percent" pattern="##.##" />)</td>
                      </c:if>
                      <c:if test="${transaction.price > bitcoinPrice}">
                        <c:set var="difference" value="${bitcoinPrice - transaction.price}" />
                        <c:set var="percentage" value="${(difference / bitcoinPrice) * 100}" />
                        <td class="text-danger">${transaction.tokenSize * difference}
                          (<fmt:formatNumber value="${percentage}" type="percent" pattern="##.##" />)</td>
                      </c:if>
                    </c:if>
                  </c:if>
                  <c:if test="${transaction.symbol == 'ETH'}">
                    <c:if test="${transaction.direction == 'short'}">
                      <c:if test="${transaction.price >= ethereumPrice}">
                        <c:set var="difference" value="${transaction.price - ethereumPrice}" />
                        <c:set var="percentage" value="${(difference / ethereumPrice) * 100}" />
                        <td class="text-success">+${transaction.tokenSize * difference}
                          (+<fmt:formatNumber value="${percentage}" type="percent" pattern="##.##" />)</td>
                      </c:if>
                      <c:if test="${transaction.price < ethereumPrice}">
                        <c:set var="difference" value="${transaction.price - ethereumPrice}" />
                        <c:set var="percentage" value="${(difference / ethereumPrice) * 100}" />
                        <td class="text-danger">${transaction.tokenSize * difference}
                          (<fmt:formatNumber value="${percentage}" type="percent" pattern="##.##" />)</td>
                      </c:if>
                    </c:if>
                    <c:if test="${transaction.direction == 'long'}">
                      <c:if test="${transaction.price <= ethereumPrice}">
                        <c:set var="difference" value="${ethereumPrice - transaction.price}" />
                        <c:set var="percentage" value="${(difference / ethereumPrice) * 100}" />
                        <td class="text-success">+${transaction.tokenSize * difference}
                          (+<fmt:formatNumber value="${percentage}" type="percent" pattern="##.##" />)</td>
                      </c:if>
                      <c:if test="${transaction.price > ethereumPrice}">
                        <c:set var="difference" value="${ethereumPrice - transaction.price}" />
                        <c:set var="percentage" value="${(difference / ethereumPrice) * 100}" />
                        <td class="text-danger">${transaction.tokenSize * difference}
                          (<fmt:formatNumber value="${percentage}" type="percent" pattern="##.##" />)</td>
                      </c:if>
                    </c:if>
                  </c:if>
                  <c:if test="${transaction.symbol == 'UNI'}">
                    <c:if test="${transaction.direction == 'short'}">
                      <c:if test="${transaction.price >= uniswapPrice}">
                        <c:set var="difference" value="${transaction.price - uniswapPrice}" />
                        <c:set var="percentage" value="${(difference / uniswapPrice) * 100}" />
                        <td class="text-success">+${transaction.tokenSize * difference}
                          (+<fmt:formatNumber value="${percentage}" type="percent" pattern="##.##" />)</td>
                      </c:if>
                      <c:if test="${transaction.price < uniswapPrice}">
                        <c:set var="difference" value="${transaction.price - uniswapPrice}" />
                        <c:set var="percentage" value="${(difference / uniswapPrice) * 100}" />
                        <td class="text-danger">${transaction.tokenSize * difference}
                          (<fmt:formatNumber value="${percentage}" type="percent" pattern="##.##" />)</td>
                      </c:if>
                    </c:if>
                    <c:if test="${transaction.direction == 'long'}">
                      <c:if test="${transaction.price <= uniswapPrice}">
                        <c:set var="difference" value="${uniswapPrice - transaction.price}" />
                        <c:set var="percentage" value="${(difference / uniswapPrice) * 100}" />
                        <td class="text-success">+${transaction.tokenSize * difference}
                          (+<fmt:formatNumber value="${percentage}" type="percent" pattern="##.##" />)</td>
                      </c:if>
                      <c:if test="${transaction.price > uniswapPrice}">
                        <c:set var="difference" value="${uniswapPrice - transaction.price}" />
                        <c:set var="percentage" value="${(difference / uniswapPrice) * 100}" />
                        <td class="text-danger">${transaction.tokenSize * difference}
                          (<fmt:formatNumber value="${percentage}" type="percent" pattern="##.##" />)</td>
                      </c:if>
                    </c:if>
                  </c:if>
                  <c:if test="${transaction.symbol == 'XRP'}">
                    <c:if test="${transaction.direction == 'short'}">
                      <c:if test="${transaction.price >= ripplePrice}">
                        <c:set var="difference" value="${transaction.price - ripplePrice}" />
                        <c:set var="percentage" value="${(difference / ripplePrice) * 100}" />
                        <td class="text-success">+${transaction.tokenSize * difference}
                          (+<fmt:formatNumber value="${percentage}" type="percent" pattern="##.##" />)</td>
                      </c:if>
                      <c:if test="${transaction.price < ripplePrice}">
                        <c:set var="difference" value="${transaction.price - ripplePrice}" />
                        <c:set var="percentage" value="${(difference / ripplePrice) * 100}" />
                        <td class="text-danger">${transaction.tokenSize * difference}
                          (<fmt:formatNumber value="${percentage}" type="percent" pattern="##.##" />)</td>
                      </c:if>
                    </c:if>
                    <c:if test="${transaction.direction == 'long'}">
                      <c:if test="${transaction.price <= ripplePrice}">
                        <c:set var="difference" value="${ripplePrice - transaction.price}" />
                        <c:set var="percentage" value="${(difference / ripplePrice) * 100}" />
                        <td class="text-success">+${transaction.tokenSize * difference}
                          (+<fmt:formatNumber value="${percentage}" type="percent" pattern="##.##" />)</td>
                      </c:if>
                      <c:if test="${transaction.price > ripplePrice}">
                        <c:set var="difference" value="${ripplePrice - transaction.price}" />
                        <c:set var="percentage" value="${(difference / ripplePrice) * 100}" />
                        <td class="text-danger">${transaction.tokenSize * difference}
                          (<fmt:formatNumber value="${percentage}" type="percent" pattern="##.##" />)</td>
                      </c:if>
                    </c:if>
                  </c:if>
                  <c:if test="${transaction.symbol == 'LINK'}">
                    <c:if test="${transaction.direction == 'short'}">
                      <c:if test="${transaction.price >= chainlinkPrice}">
                        <c:set var="difference" value="${transaction.price - chainlinkPrice}" />
                        <c:set var="percentage" value="${(difference / chainlinkPrice) * 100}" />
                        <td class="text-success">+${transaction.tokenSize * difference}
                          (+<fmt:formatNumber value="${percentage}" type="percent" pattern="##.##" />)</td>
                      </c:if>
                      <c:if test="${transaction.price < chainlinkPrice}">
                        <c:set var="difference" value="${transaction.price - chainlinkPrice}" />
                        <c:set var="percentage" value="${(difference / chainlinkPrice) * 100}" />
                        <td class="text-danger">${transaction.tokenSize * difference}
                          (<fmt:formatNumber value="${percentage}" type="percent" pattern="##.##" />)</td>
                      </c:if>
                    </c:if>
                    <c:if test="${transaction.direction == 'long'}">
                      <c:if test="${transaction.price <= chainlinkPrice}">
                        <c:set var="difference" value="${chainlinkPrice - transaction.price}" />
                        <c:set var="percentage" value="${(difference / chainlinkPrice) * 100}" />
                        <td class="text-success">+${transaction.tokenSize * difference}
                          (+<fmt:formatNumber value="${percentage}" type="percent" pattern="##.##" />)</td>
                      </c:if>
                      <c:if test="${transaction.price > chainlinkPrice}">
                        <c:set var="difference" value="${chainlinkPrice - transaction.price}" />
                        <c:set var="percentage" value="${(difference / chainlinkPrice) * 100}" />
                        <td class="text-danger">${transaction.tokenSize * difference}
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

                    <a href="/closemarket/${transaction.id}?traLastPrice=${lastPrice}"><button class="btn btn-primary">Market Close</button></a>
                    <button class="btn btn-primary" disabled>Limit Close</button>
                  </td>
                </tr>
              </c:forEach>
              </tbody>
            </table>
          </section>
        </div>
      </div>
      <div class="tab-pane fade" id="orders">

      </div>
      <div class="tab-pane fade" id="trades">
        <section class="side">
          <table class="w-100">
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
                  <td class="text-success">${transaction.symbol}-USD</td>
                </c:if>
                <c:if test="${transaction.direction == 'short'}">
                  <td class="text-danger">${transaction.symbol}-USD</td>
                </c:if>
                <td>${transaction.tokenSize} ${transaction.symbol}</td>
                <td>${transaction.amount}</td>
                <td>${transaction.leverage}</td>
                <td>${transaction.price}</td>
                <td>${transaction.lastPrice}</td>
                <td class="${transaction.earnings >= 0 ? 'text-success' : 'text-danger'}">${transaction.earnings}</td>
              </tr>
            </c:forEach>
            </tbody>
          </table>
        </section>
      </div>
    </div>
  </div>
</div>
</body>
</html>
