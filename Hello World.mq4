//+------------------------------------------------------------------+
//|                                                  Hello World.mq4 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- create timer
   EventSetTimer(1);
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//--- destroy timer
   EventKillTimer();
   
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---


  }
//+------------------------------------------------------------------+
//| Timer function                                                   |
//+------------------------------------------------------------------+
void OnTimer()
  {
//---
     Print("-------------------------------------------------!"); 
     Print("AccountNumber："+AccountNumber());
     Print("AccountBalance："+AccountBalance());
     Print("AccountCompany："+AccountCompany());
     Print("AccountProfit："+AccountProfit());
     Print("Bars："+Bars);
     Print("Open[0]+High[0]+Low[0]+Close[0]："+Open[0]+","+High[0]+","+Low[0]+","+Close[0]);
     Print("MarketInfo[ASK,BID]："+MarketInfo("XAUUSD",MODE_ASK)+","+MarketInfo("XAUUSD",MODE_BID));
     
  }
//+------------------------------------------------------------------+
//| Tester function                                                  |
//+------------------------------------------------------------------+
double OnTester()
  {
//---
   double ret=0.0;
//---

//---
   return(ret);
  }
//+------------------------------------------------------------------+
