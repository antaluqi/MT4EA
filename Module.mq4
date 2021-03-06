//+------------------------------------------------------------------+
//|                                                       Module.mq4 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

int MAGIC=0;
string 货币对=Symbol();
double 下单量;
int 滑点;
bool 启动报警=true;

double 止损点数;
double 止损价格;
double 止盈点数;
double 止盈价格;

double BUYSTOP点数距离;
double BUYSTOP线条;
double BUYLIMIT点数距离;
double BUYLIMIT线条;
double SELLSTOP点数距离;
double SELLSTOP线条;
double SELLLIMIT点数距离;
double SELLLIMIT线条;


double 启动点数;
double 移动止损点数;


double 历史总下单量;  // 已经平仓的所有订单下单量之和
double 历史总盈亏;    // 已经平仓的所有订单总的盈亏
double 历史下单量;    // 指定货币对已平仓订单的下单量之和
double 历史盈亏;      // 指定货币对已平仓订单的盈亏之和
double mbbo;          // 指定货币对已平仓买单的数量
double mbbprofito;    // 指定货币对已平仓买单的盈亏之和
double msso;          // 指定货币对已平仓卖单的数量
double mssprofito;    // 指定货币对已平仓卖单的盈亏之和

double bb;            // 指定MAGIC数值已开仓的买单数量之和（不区分货币对）
double bbprofit;      // 指定MAGIC数值已开仓的买单盈亏之和（不区分货币对）
double ss;            // 指定MAGIC数值已开仓的卖单数量之和（不区分货币对）
double ssprofit;      // 指定MAGIC数值已开仓的卖单盈亏之和（不区分货币对）
double bbl;           // 已开仓的买单数量之和（不区分货币对）
double bbprofitl;     // 已开仓的买单盈亏之和（不区分货币对）
double ssl;           // 已开仓的卖单数量之和（不区分货币对）
double ssprofitl;     // 已开仓的卖单盈亏之和（不区分货币对）
double ossa;          // 所有未删除的SELLSTOP挂单的数量（不区分货币对）
double osla;          // 所有未删除的SELLLIMT挂单的数量（不区分货币对）
double obsa;          // 所有未删除的BUYSTOP挂单的数量（不区分货币对）
double obla;          // 所有未删除的BUYLIMIT挂单的数量（不区分货币对）
double Twbs;          // 所有未平单子中盈利单子的数量之和（不区分货币对）
double Twin;          // 所有未平单子中盈利单子的盈利之和（不区分货币对）
double Tlbs;          // 所有未平单子中亏损单子的数量之和（不区分货币对）
double Tloss;         // 所有未平单子中亏损单子的亏损之和（不区分货币对）
double TOTALLOTS;     // 所有未平的订单下单量之和

double BLOTS;         // 指定货币对所有未平的买单下单量之和
double mbb;           // 指定货币对所有未平的买单数量之和
double mbbprofit;     // 指定货币对所有未平的买单盈亏之和
double SLOTS;         // 指定货币对所有未平的卖单下单量之和
double mss;           // 指定货币对所有未平的卖单数量之和
double mssprofit;     // 指定货币对所有未平的卖单盈亏之和
double moss;          // 指定货币对SELLSTOP挂单数量之和
double mosl;          // 指定货币对SELLLIMIT挂单数量之和
double mobs=0;        // 指定货币对BUYSTOP挂单数量之和
double mobl;          // 指定货币对BUYLIMIT挂单数量之和
double profitmm;      // 指定货币对总的盈亏

double TLOTSS;        // 指定货币对指定MAGIC数值未平仓的卖单下单量之和
double s;             // 指定货币对指定MAGIC数值未平仓的卖单数量之和
double sprofit;       // 指定货币对指定MAGIC数值未平仓的卖单盈亏之和
double LastPricesell; // 指定货币对指定MAGIC数值未平仓的最近卖单的开盘价格
double TLOTSB;        // 指定货币对指定MAGIC数值未平仓的买单下单量之和
double b;             // 指定货币对指定MAGIC数值未平仓的买单数量之和
double bprofit;       // 指定货币对指定MAGIC数值未平仓的买单盈亏之和
double LastPricebuy;  // 指定货币对指定MAGIC数值未平仓的最近买单的开盘价格
double TLOTS;         // 指定货币对指定MAGIC数值未平仓的订单的下单量之和

double oss;           // 指定货币对指定MAGIC数值未删除的SELLSTOP挂单数量之和
double osl;           // 指定货币对指定MAGIC数值未删除的SELLLIMIT挂单数量之和
double obs;           // 指定货币对指定MAGIC数值未删除的BUYSTOP挂单数量之和
double obl;           // 指定货币对指定MAGIC数值未删除的BUYLIMIT挂单数量之和
double SLASTLOTS;     // 指定货币对指定MAGIC数值未平仓的最近卖单的下单量
double BLASTLOTS;     // 指定货币对指定MAGIC数值未平仓的最近买单的下单量


//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- create timer
   EventSetTimer(1);

//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//--- destroy timer
   EventKillTimer();
   删除全部物件();

  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
   test();
  }
//+------------------------------------------------------------------+
//| Timer function                                                   |
//+------------------------------------------------------------------+
void OnTimer()
  {
//---



  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void test()
  {
   if(OrdersTotal()==0)
     {
      int l=20;
      int d=2;
      double up=iBands(NULL,0,l,d,0,PRICE_CLOSE,MODE_UPPER,0);
      double down=iBands(NULL,0,l,d,0,PRICE_CLOSE,MODE_LOWER,0);
      if(MarketInfo(货币对,MODE_ASK)>up+150*MarketInfo(货币对,MODE_POINT))
        {
         Print("1111111111111111111111111111111");
         下单量=0.1;
         滑点=5;
         止损点数=500;
         止盈点数=300;
         卖下();
         //启动点数=150;
         //移动止损点数=
         //移动止损();
        }
      if(MarketInfo(货币对,MODE_BID)<down-150*MarketInfo(货币对,MODE_POINT))
        {
         Print("2222222222222222222222222222222");
         下单量=0.1;
         滑点=5;
         止损点数=500;
         止盈点数=300;
         买上();
         //启动点数=150;
         //移动止损点数=
         //移动止损();
        }

     }
  }
//+------------------------------------------------------------------+
//| 买单模块                                                 |
//+------------------------------------------------------------------+
void 买上()
  {
// 将下单量转换成指定的精度
   下单量=NormalizeDouble(下单量,2);
// 限制下单量的数值必须大于系统默认的最小下单量
   if(下单量<MarketInfo(货币对,MODE_MINLOT))
     {
      下单量=MarketInfo(货币对,MODE_MINLOT);
     }

// 限制最大下单量
// if (下单量>最大下单量){下单量=最大下单量}

// 限制下单量的数值必须小于系统默认的最大下单量
   if(下单量>MarketInfo(货币对,MODE_MAXLOT))
     {
      下单量=MarketInfo(货币对,MODE_MAXLOT);
     }
// 计算订单的止盈价格
   if(止盈点数==0)
     {
      止盈价格=0;
     }
   if(止盈点数>0)
     {
      止盈价格=(MarketInfo(货币对,MODE_ASK)+(止盈点数*MarketInfo(货币对,MODE_POINT)));
     }
// 计算订单的止损价格
   if(止损点数==0)
     {
      止损价格=0;
     }
   if(止损点数>0)
     {
      止损价格=(MarketInfo(货币对,MODE_ASK)-(止盈点数*MarketInfo(货币对,MODE_POINT)));
     }
// 完成下买单的动作
   int ticket=OrderSend(货币对,OP_BUY,下单量,MarketInfo(货币对,MODE_ASK),滑点,止损价格,止盈价格,"下买单",MAGIC,0,Violet);
   if(ticket<0)
     {
      if(启动报警)
        {Alert("下买单没有成功！",GetLastError());}
      else
         if(启动报警)
           {Alert("下买单成功");}
     }
  }


//+------------------------------------------------------------------+
//| 卖单模块                                                 |
//+------------------------------------------------------------------+
void 卖下()
  {
// 将下单量转换成指定的精度
   下单量=NormalizeDouble(下单量,2);
// 限制下单量的数值必须大于系统默认的最小下单量
   if(下单量<MarketInfo(货币对,MODE_MINLOT))
     {
      下单量=MarketInfo(货币对,MODE_MINLOT);
     }

// 限制最大下单量
// if (下单量>最大下单量){下单量=最大下单量}

// 限制下单量的数值必须小于系统默认的最大下单量
   if(下单量>MarketInfo(货币对,MODE_MAXLOT))
     {
      下单量=MarketInfo(货币对,MODE_MAXLOT);
     }
// 计算订单的止盈价格
   if(止盈点数==0)
     {
      止盈价格=0;
     }
   if(止盈点数>0)
     {
      止盈价格=(MarketInfo(货币对,MODE_BID)-(止盈点数*MarketInfo(货币对,MODE_POINT)));
     }
// 计算订单的止损价格
   if(止损点数==0)
     {
      止损价格=0;
     }
   if(止损点数>0)
     {
      止损价格=(MarketInfo(货币对,MODE_BID)+(止盈点数*MarketInfo(货币对,MODE_POINT)));
     }
// 完成下买单的动作
   int ticket=OrderSend(货币对,OP_SELL,下单量,MarketInfo(货币对,MODE_BID),滑点,止损价格,止盈价格,"下卖单",MAGIC,0,GreenYellow);
   if(ticket<0)
     {
      if(启动报警)
        {Alert("下卖单没有成功！",GetLastError());}
      else
         if(启动报警)
           {Alert("下卖单成功");}
     }
  }

//+------------------------------------------------------------------+
//| 关闭买单模块                                                 |
//+------------------------------------------------------------------+
void 关闭买上()
  {
   double 卖价;
   double 手数;
   int 订单类型;
   bool result = false;
   int 订单号;
// 遍历所有订单
   for(int i=OrdersTotal()-1; i>=0; i--)
     {
      if(OrderSelect(i,SELECT_BY_POS))
        {
         //选择符合要求的订单
         if(OrdersTotal()>0 && OrderSymbol()==货币对 && OrderMagicNumber()==MAGIC)
           {
            // 获取要用到的变量数值
            卖价=MarketInfo(货币对,MODE_BID);
            订单号=OrderTicket();
            手数=OrderLots();
            订单类型=OrderType();
            switch(订单类型)
              {
               // 如果是买单则将其关闭
               case OP_BUY:
                  result=OrderClose(订单号,手数,卖价,滑点,Yellow);
                  break;

              }
           }
        }
     }
  }

//+------------------------------------------------------------------+
//| 关闭卖单模块                                                 |
//+------------------------------------------------------------------+
void 关闭卖下()
  {
   double 买价;
   double 手数;
   int 订单类型;
   bool result = false;
   int 订单号;
// 遍历所有订单
   for(int i=OrdersTotal()-1; i>=0; i--)
     {
      if(OrderSelect(i,SELECT_BY_POS))
        {
         //选择符合要求的订单
         if(OrdersTotal()>0 && OrderSymbol()==货币对 && OrderMagicNumber()==MAGIC)
           {
            // 获取要用到的变量数值
            买价=MarketInfo(货币对,MODE_ASK);
            订单号=OrderTicket();
            手数=OrderLots();
            订单类型=OrderType();
            switch(订单类型)
              {
               // 如果是买单则将其关闭
               case OP_SELL:
                  result=OrderClose(订单号,手数,买价,滑点,Red);
                  break;

              }
           }
        }
     }
  }


//+------------------------------------------------------------------+
//| 平盈利单模块                                                 |
//+------------------------------------------------------------------+
void 关闭盈利单()
  {
   double 买价;
   double 卖价;
   int 订单号;
   double 手数;
   int 订单类型;
   bool result = false;

// 遍历所有订单
   for(int i=OrdersTotal()-1; i>=0; i--)
     {
      if(OrderSelect(i,SELECT_BY_POS))
        {
         // 选择盈利且符合要求的订单
         if(OrderSymbol()==货币对 && OrderProfit()+OrderSwap()+OrderCommission()>0 && OrderMagicNumber()==MAGIC)
           {
            //获取要用到的变量
            买价=MarketInfo(OrderSymbol(),MODE_ASK);
            卖价=MarketInfo(OrderSymbol(),MODE_BID);
            订单号=OrderTicket();
            手数=OrderLots();
            订单类型=OrderType();
            switch(订单类型)
              {
               // 如果订单类型满足则删除
               case OP_BUY:
                  result=OrderClose(订单号,手数,卖价,滑点,Yellow);
                  if(启动报警)
                    {
                     Alert(货币对+"买单盈利单子关闭！");
                    }
                  break;
               case OP_SELL:
                  result=OrderClose(订单号,手数,买价,滑点,Red);
                  if(启动报警)
                    {
                     Alert(货币对+"卖单盈利单子关闭！");
                    }
                  break;
              }
            if(result== false)
              {
               if(启动报警)
                 {
                  Alert("EA关闭盈利单子失败");
                 }
              }
           }


        }
     }
  }

//+------------------------------------------------------------------+
//| 平亏损单模块                                                |
//+------------------------------------------------------------------+
void 关闭亏损单()
  {
   double 买价;
   double 卖价;
   int 订单号;
   double 手数;
   int 订单类型;
   bool result = false;

// 遍历所有订单
   for(int i=OrdersTotal()-1; i>=0; i--)
     {
      if(OrderSelect(i,SELECT_BY_POS))
        {
         // 选择盈利且符合要求的订单
         if(OrderSymbol()==货币对 && OrderProfit()+OrderSwap()+OrderCommission()<0 && OrderMagicNumber()==MAGIC)
           {
            //获取要用到的变量
            买价=MarketInfo(OrderSymbol(),MODE_ASK);
            卖价=MarketInfo(OrderSymbol(),MODE_BID);
            订单号=OrderTicket();
            手数=OrderLots();
            订单类型=OrderType();
            switch(订单类型)
              {
               // 如果订单类型满足则删除
               case OP_BUY:
                  result=OrderClose(订单号,手数,卖价,滑点,Yellow);
                  if(启动报警)
                    {
                     Alert(货币对+"买单亏损单子关闭！");
                    }
                  break;
               case OP_SELL:
                  result=OrderClose(订单号,手数,买价,滑点,Red);
                  if(启动报警)
                    {
                     Alert(货币对+"卖单亏损单子关闭！");
                    }
                  break;
              }
            if(result== false)
              {
               if(启动报警)
                 {
                  Alert("EA关闭亏损单子失败");
                 }
              }
           }


        }
     }
  }


//+------------------------------------------------------------------+
//| BUYSTOP挂单模块                                                 |
//+------------------------------------------------------------------+
void BUYSTOP买上()
  {
   double 止损价格1;
   double 止盈价格1;
// 将下单量转换成指定的精度
   下单量=NormalizeDouble(下单量,2);
// 限制下单量的数值必须大于系统默认的最小下单量
   if(下单量<MarketInfo(货币对,MODE_MINLOT))
     {
      下单量=MarketInfo(货币对,MODE_MINLOT);
     }

// 限制最大下单量
// if (下单量>最大下单量){下单量=最大下单量}

// 限制下单量的数值必须小于系统默认的最大下单量
   if(下单量>MarketInfo(货币对,MODE_MAXLOT))
     {
      下单量=MarketInfo(货币对,MODE_MAXLOT);
     }

// 限制挂单之间的距离点数和关单的数量
   if(BUYSTOP点数距离>2 && BUYSTOP线条>0)
     {
      for(int K=1; K<BUYSTOP线条; K++)
        {
         // 计算挂单的止盈价格
         if(止盈点数==0)
           {
            止盈价格1=0;
            止盈价格=0;
           }
         if(止盈点数>0)
           {
            止盈价格1=(MarketInfo(货币对,MODE_ASK)+(止盈点数*MarketInfo(货币对,MODE_POINT)));
            止盈价格=止盈价格1+(K*(BUYSTOP点数距离*MarketInfo(货币对,MODE_POINT)));
           }
         // 计算挂单的止损价格
         if(止损点数==0)
           {
            止损价格1=0;
            止损价格=0;
           }
         if(止损点数>0)
           {
            止损价格1=(MarketInfo(货币对,MODE_ASK)-(止损点数*MarketInfo(货币对,MODE_POINT)));
            止损价格=止损价格1+(K*(BUYSTOP点数距离*MarketInfo(货币对,MODE_POINT)));
           }

         // 完成下挂单的动作
         int ticket= OrderSend(货币对,OP_BUYSTOP,下单量,MarketInfo(货币对,MODE_ASK)+(K*BUYSTOP点数距离*MarketInfo(货币对,MODE_POINT)),滑点,止损价格,止盈价格,"BUYSTOP挂单",MAGIC,0,Green);
         if(ticket<0)
           {
            if(启动报警)
              {
               Alert("BUYSTOP买上失败！");
              }
           }
         else
           {
            if(启动报警)
              {
               Alert("BUYSTOP买上成功！");
              }
           }
        }

     }
   else
      return;
  }



//+------------------------------------------------------------------+
//| BUYLIMIT挂单模块                                                 |
//+------------------------------------------------------------------+
void BUYLIMIT买上()
  {
   double 止损价格1;
   double 止盈价格1;
// 将下单量转换成指定的精度
   下单量=NormalizeDouble(下单量,2);
// 限制下单量的数值必须大于系统默认的最小下单量
   if(下单量<MarketInfo(货币对,MODE_MINLOT))
     {
      下单量=MarketInfo(货币对,MODE_MINLOT);
     }

// 限制最大下单量
// if (下单量>最大下单量){下单量=最大下单量}

// 限制下单量的数值必须小于系统默认的最大下单量
   if(下单量>MarketInfo(货币对,MODE_MAXLOT))
     {
      下单量=MarketInfo(货币对,MODE_MAXLOT);
     }

// 限制挂单之间的距离点数和关单的数量
   if(BUYLIMIT点数距离>2 && BUYLIMIT线条>0)
     {
      for(int K=1; K<BUYLIMIT线条; K++)
        {
         // 计算挂单的止盈价格
         if(止盈点数==0)
           {
            止盈价格1=0;
            止盈价格=0;
           }
         if(止盈点数>0)
           {
            止盈价格1=(MarketInfo(货币对,MODE_ASK)+(止盈点数*MarketInfo(货币对,MODE_POINT)));
            止盈价格=止盈价格1-(K*(BUYLIMIT点数距离*MarketInfo(货币对,MODE_POINT)));
           }
         // 计算挂单的止损价格
         if(止损点数==0)
           {
            止损价格1=0;
            止损价格=0;
           }
         if(止损点数>0)
           {
            止损价格1=(MarketInfo(货币对,MODE_ASK)-(止损点数*MarketInfo(货币对,MODE_POINT)));
            止损价格=止损价格1-(K*(BUYLIMIT点数距离*MarketInfo(货币对,MODE_POINT)));
           }

         // 完成下挂单的动作
         int ticket= OrderSend(货币对,OP_BUYLIMIT,下单量,MarketInfo(货币对,MODE_ASK)-(K*BUYLIMIT点数距离*MarketInfo(货币对,MODE_POINT)),滑点,止损价格,止盈价格,"BUYLIMIT挂单",MAGIC,0,Green);
         if(ticket<0)
           {
            if(启动报警)
              {
               Alert("BUYLIMIT买上失败！");
              }
           }
         else
           {
            if(启动报警)
              {
               Alert("BUYLIMIT买上成功！");
              }
           }
        }

     }
   else
      return;
  }




//+------------------------------------------------------------------+
//| SELLSTOP挂单模块                                                 |
//+------------------------------------------------------------------+
void SELLSTOP卖下()
  {
   double 止损价格1;
   double 止盈价格1;
// 将下单量转换成指定的精度
   下单量=NormalizeDouble(下单量,2);
// 限制下单量的数值必须大于系统默认的最小下单量
   if(下单量<MarketInfo(货币对,MODE_MINLOT))
     {
      下单量=MarketInfo(货币对,MODE_MINLOT);
     }

// 限制最大下单量
// if (下单量>最大下单量){下单量=最大下单量}

// 限制下单量的数值必须小于系统默认的最大下单量
   if(下单量>MarketInfo(货币对,MODE_MAXLOT))
     {
      下单量=MarketInfo(货币对,MODE_MAXLOT);
     }

// 限制挂单之间的距离点数和关单的数量
   if(SELLSTOP点数距离>2 && SELLSTOP线条>0)
     {
      for(int K=1; K<SELLSTOP线条; K++)
        {
         // 计算挂单的止盈价格
         if(止盈点数==0)
           {
            止盈价格1=0;
            止盈价格=0;
           }
         if(止盈点数>0)
           {
            止盈价格1=(MarketInfo(货币对,MODE_BID)-(止盈点数*MarketInfo(货币对,MODE_POINT)));
            止盈价格=止盈价格1-(K*(SELLSTOP点数距离*MarketInfo(货币对,MODE_POINT)));
           }
         // 计算挂单的止损价格
         if(止损点数==0)
           {
            止损价格1=0;
            止损价格=0;
           }
         if(止损点数>0)
           {
            止损价格1=(MarketInfo(货币对,MODE_BID)+(止损点数*MarketInfo(货币对,MODE_POINT)));
            止损价格=止损价格1-(K*(SELLSTOP点数距离*MarketInfo(货币对,MODE_POINT)));
           }

         // 完成下挂单的动作
         int ticket= OrderSend(货币对,OP_SELLSTOP,下单量,MarketInfo(货币对,MODE_BID)-(K*SELLSTOP点数距离*MarketInfo(货币对,MODE_POINT)),滑点,止损价格,止盈价格,"SELLSTOP挂单",MAGIC,0,Green);
         if(ticket<0)
           {
            if(启动报警)
              {
               Alert("SELLSTOP卖下失败！");
              }
           }
         else
           {
            if(启动报警)
              {
               Alert("SELLSTOP卖下成功！");
              }
           }
        }

     }
   else
      return;
  }



//+------------------------------------------------------------------+
//| SELLLIMIT挂单模块                                                 |
//+------------------------------------------------------------------+
void SELLLIMIT卖下()
  {
   double 止损价格1;
   double 止盈价格1;
// 将下单量转换成指定的精度
   下单量=NormalizeDouble(下单量,2);
// 限制下单量的数值必须大于系统默认的最小下单量
   if(下单量<MarketInfo(货币对,MODE_MINLOT))
     {
      下单量=MarketInfo(货币对,MODE_MINLOT);
     }

// 限制最大下单量
// if (下单量>最大下单量){下单量=最大下单量}

// 限制下单量的数值必须小于系统默认的最大下单量
   if(下单量>MarketInfo(货币对,MODE_MAXLOT))
     {
      下单量=MarketInfo(货币对,MODE_MAXLOT);
     }

// 限制挂单之间的距离点数和关单的数量
   if(SELLLIMIT点数距离>2 && SELLLIMIT线条>0)
     {
      for(int K=1; K<SELLLIMIT线条; K++)
        {
         // 计算挂单的止盈价格
         if(止盈点数==0)
           {
            止盈价格1=0;
            止盈价格=0;
           }
         if(止盈点数>0)
           {
            止盈价格1=(MarketInfo(货币对,MODE_BID)-(止盈点数*MarketInfo(货币对,MODE_POINT)));
            止盈价格=止盈价格1+(K*(SELLLIMIT点数距离*MarketInfo(货币对,MODE_POINT)));
           }
         // 计算挂单的止损价格
         if(止损点数==0)
           {
            止损价格1=0;
            止损价格=0;
           }
         if(止损点数>0)
           {
            止损价格1=(MarketInfo(货币对,MODE_BID)+(止损点数*MarketInfo(货币对,MODE_POINT)));
            止损价格=止损价格1+(K*(SELLLIMIT点数距离*MarketInfo(货币对,MODE_POINT)));
           }

         // 完成下挂单的动作
         int ticket= OrderSend(货币对,OP_SELLLIMIT,下单量,MarketInfo(货币对,MODE_BID)+(K*SELLLIMIT点数距离*MarketInfo(货币对,MODE_POINT)),滑点,止损价格,止盈价格,"SELLLIMIT挂单",MAGIC,0,Green);
         if(ticket<0)
           {
            if(启动报警)
              {
               Alert("SELLLIMIT卖下失败！");
              }
           }
         else
           {
            if(启动报警)
              {
               Alert("SELLLIMIT卖下成功！");
              }
           }
        }

     }
   else
      return;
  }


//+------------------------------------------------------------------+
//| 删除BUYSTOP挂单模块                                              |
//+------------------------------------------------------------------+
void 关闭BUYSTOP挂单()
  {
   int 订单号;
   int 订单类型;
   bool result=false;
   for(int i=OrdersTotal()-1; i>=0; i--)
     {
      if(OrderSelect(i,SELECT_BY_POS))
        {
         if(OrderSymbol()==货币对 && OrderMagicNumber()==MAGIC)
           {
            订单号=OrderTicket();
            订单类型=OrderType();
            switch(订单类型)
              {
               case OP_BUYSTOP:
                  result=OrderDelete(订单号);
              }
            if(result==false)
              {
               if(启动报警)
                 {
                  Alert("删除BUYSTOP挂单未成功");
                 }
              }
            else
              {
               if(启动报警)
                 {
                  Alert("成功删除BUYSTOP挂单");
                 }
              }
           }
        }
     }
  }

//+------------------------------------------------------------------+
//| 删除BUYLIMIT挂单模块                                             |
//+------------------------------------------------------------------+
void 关闭BUYLIMIT挂单()
  {
   int 订单号;
   int 订单类型;
   bool result=false;
   for(int i=OrdersTotal()-1; i>=0; i--)
     {
      if(OrderSelect(i,SELECT_BY_POS))
        {
         if(OrderSymbol()==货币对 && OrderMagicNumber()==MAGIC)
           {
            订单号=OrderTicket();
            订单类型=OrderType();
            switch(订单类型)
              {
               case OP_BUYLIMIT:
                  result=OrderDelete(订单号);
              }
            if(result==false)
              {
               if(启动报警)
                 {
                  Alert("删除BUYLIMIT挂单未成功");
                 }
              }
            else
              {
               if(启动报警)
                 {
                  Alert("成功删除BUYLIMIT挂单");
                 }
              }
           }
        }
     }
  }


//+------------------------------------------------------------------+
//| 删除SELLSTOP挂单模块                                              |
//+------------------------------------------------------------------+
void 关闭SELLSTOP挂单()
  {
   int 订单号;
   int 订单类型;
   bool result=false;
   for(int i=OrdersTotal()-1; i>=0; i--)
     {
      if(OrderSelect(i,SELECT_BY_POS))
        {
         if(OrderSymbol()==货币对 && OrderMagicNumber()==MAGIC)
           {
            订单号=OrderTicket();
            订单类型=OrderType();
            switch(订单类型)
              {
               case OP_SELLSTOP:
                  result=OrderDelete(订单号);
              }
            if(result==false)
              {
               if(启动报警)
                 {
                  Alert("删除SELLSTOP挂单未成功");
                 }
              }
            else
              {
               if(启动报警)
                 {
                  Alert("成功删除SELLSTOP挂单");
                 }
              }
           }
        }
     }
  }

//+------------------------------------------------------------------+
//| 删除SELLLIMIT挂单模块                                             |
//+------------------------------------------------------------------+
void 关闭SELLLIMIT挂单()
  {
   int 订单号;
   int 订单类型;
   bool result=false;
   for(int i=OrdersTotal()-1; i>=0; i--)
     {
      if(OrderSelect(i,SELECT_BY_POS))
        {
         if(OrderSymbol()==货币对 && OrderMagicNumber()==MAGIC)
           {
            订单号=OrderTicket();
            订单类型=OrderType();
            switch(订单类型)
              {
               case OP_SELLLIMIT:
                  result=OrderDelete(订单号);
              }
            if(result==false)
              {
               if(启动报警)
                 {
                  Alert("删除SELLLIMIT挂单未成功");
                 }
              }
            else
              {
               if(启动报警)
                 {
                  Alert("成功删除SELLLIMIT挂单");
                 }
              }
           }
        }
     }
  }

//+------------------------------------------------------------------+
//| 删除所有挂单模块                                                 |
//+------------------------------------------------------------------+
void 关闭全部挂单()
  {
   int 订单号;
   int 订单类型;
   bool result=false;
   for(int i=OrdersTotal()-1; i>=0; i--)
     {
      if(OrderSelect(i,SELECT_BY_POS))
        {
         if(OrderSymbol()==货币对 && OrderMagicNumber()==MAGIC)
           {
            订单号=OrderTicket();
            订单类型=OrderType();
            if(订单类型==OP_BUYSTOP || 订单类型==OP_BUYLIMIT|| 订单类型==OP_SELLSTOP|| 订单类型==OP_SELLLIMIT)
              {

               result=OrderDelete(订单号);
               if(result==false)
                 {
                  if(启动报警)
                    {
                     Alert("删除挂单未成功");
                    }
                 }
               else
                 {
                  if(启动报警)
                    {
                     Alert("成功删除挂单");
                    }
                 }

              }

           }
        }
     }
  }


//+------------------------------------------------------------------+
//| 户口检查模块                                                 |
//+------------------------------------------------------------------+
void 户口检查模块()
  {
// ----------------------------------------------------------------变量定义
   历史总下单量=0;  // 已经平仓的所有订单下单量之和
   历史总盈亏=0;     // 已经平仓的所有订单总的盈亏
   历史下单量=0;    // 指定货币对已平仓订单的下单量之和
   历史盈亏=0;      // 指定货币对已平仓订单的盈亏之和
   mbbo=0;          // 指定货币对已平仓买单的数量
   mbbprofito=0;    // 指定货币对已平仓买单的盈亏之和
   msso=0;          // 指定货币对已平仓卖单的数量
   mssprofito=0;    // 指定货币对已平仓卖单的盈亏之和

   bb=0;            // 指定MAGIC数值已开仓的买单数量之和（不区分货币对）
   bbprofit=0;      // 指定MAGIC数值已开仓的买单盈亏之和（不区分货币对）
   ss=0;            // 指定MAGIC数值已开仓的卖单数量之和（不区分货币对）
   ssprofit=0;      // 指定MAGIC数值已开仓的卖单盈亏之和（不区分货币对）
   bbl=0;           // 已开仓的买单数量之和（不区分货币对）
   bbprofitl=0;     // 已开仓的买单盈亏之和（不区分货币对）
   ssl=0;           // 已开仓的卖单数量之和（不区分货币对）
   ssprofitl=0;     // 已开仓的卖单盈亏之和（不区分货币对）
   ossa=0;          // 所有未删除的SELLSTOP挂单的数量（不区分货币对）
   osla=0;          // 所有未删除的SELLLIMT挂单的数量（不区分货币对）
   obsa=0;          // 所有未删除的BUYSTOP挂单的数量（不区分货币对）
   obla=0;          // 所有未删除的BUYLIMIT挂单的数量（不区分货币对）
   Twbs=0;          // 所有未平单子中盈利单子的数量之和（不区分货币对）
   Twin=0;          // 所有未平单子中盈利单子的盈利之和（不区分货币对）
   Tlbs=0;          // 所有未平单子中亏损单子的数量之和（不区分货币对）
   Tloss=0;         // 所有未平单子中亏损单子的亏损之和（不区分货币对）
   TOTALLOTS=0;     // 所有未平的订单下单量之和

   BLOTS=0;         // 指定货币对所有未平的买单下单量之和
   mbb=0;           // 指定货币对所有未平的买单数量之和
   mbbprofit=0;     // 指定货币对所有未平的买单盈亏之和
   SLOTS=0;         // 指定货币对所有未平的卖单下单量之和
   mss=0;           // 指定货币对所有未平的卖单数量之和
   mssprofit=0;     // 指定货币对所有未平的卖单盈亏之和
   moss=0;          // 指定货币对SELLSTOP挂单数量之和
   mosl=0;          // 指定货币对SELLLIMIT挂单数量之和
   mobs=0;          // 指定货币对BUYSTOP挂单数量之和
   mobl=0;          // 指定货币对BUYLIMIT挂单数量之和
   profitmm=0;      // 指定货币对总的盈亏

   TLOTSS=0;        // 指定货币对指定MAGIC数值未平仓的卖单下单量之和
   s=0;             // 指定货币对指定MAGIC数值未平仓的卖单数量之和
   sprofit=0;       // 指定货币对指定MAGIC数值未平仓的卖单盈亏之和
   LastPricesell=0; // 指定货币对指定MAGIC数值未平仓的最近卖单的开盘价格
   TLOTSB=0;        // 指定货币对指定MAGIC数值未平仓的买单下单量之和
   b=0;             // 指定货币对指定MAGIC数值未平仓的买单数量之和
   bprofit=0;       // 指定货币对指定MAGIC数值未平仓的买单盈亏之和
   LastPricebuy=0;  // 指定货币对指定MAGIC数值未平仓的最近买单的开盘价格
   TLOTS=0;         // 指定货币对指定MAGIC数值未平仓的订单的下单量之和

   oss=0;           // 指定货币对指定MAGIC数值未删除的SELLSTOP挂单数量之和
   osl=0;           // 指定货币对指定MAGIC数值未删除的SELLLIMIT挂单数量之和
   obs=0;           // 指定货币对指定MAGIC数值未删除的BUYSTOP挂单数量之和
   obl=0;           // 指定货币对指定MAGIC数值未删除的BUYLIMIT挂单数量之和
   SLASTLOTS=0;     // 指定货币对指定MAGIC数值未平仓的最近卖单的下单量
   BLASTLOTS=0;     // 指定货币对指定MAGIC数值未平仓的最近买单的下单量

// ----------------------------------------------------------------


   for(int r=0; r<OrdersHistoryTotal(); r++)
     {
      if(OrderSelect(r,SELECT_BY_POS,MODE_HISTORY))
        {
         if(OrderType()== OP_BUY || OrderType()== OP_SELL)
           {
            历史总下单量+=OrderLots();//OrderLots：订单手数
            历史总盈亏+=OrderProfit()+OrderCommission()+OrderSwap();
            // OrderProfit：订单净利； OrderSwap：仓息 OrderCommission：订单佣金
           }
         if(OrderSymbol()==货币对)
           {
            历史下单量+=OrderLots();
            历史盈亏+=OrderProfit()+OrderCommission()+OrderSwap();

            if(OrderType()==OP_BUY)
              {
               mbbo++;// 指定货币对已平仓买单的数量
               mbbprofito+=OrderProfit()+OrderSwap()+OrderCommission();// 指定货币对已平仓买单的盈亏之和
              }
            if(OrderType()==OP_SELL)
              {
               msso++;// 指定货币对已平仓卖单的数量
               mssprofito+=OrderProfit()+OrderSwap()+OrderCommission();// 指定货币对已平仓卖单的盈亏之和

              }
           }
        }
     }

   for(int cnt=0; cnt<OrdersTotal(); cnt++)
     {
      if(OrderSelect(cnt,SELECT_BY_POS,MODE_TRADES))
        {
         if(OrderType()==OP_BUY && OrderMagicNumber()==MAGIC)  // OrderType: 订单类型； OrderMagicNumber：订单指定编号
           {
            bb++;  // 指定MAGIC数值已开仓的买单数量之和（不区分货币对）
            bbprofit+=OrderProfit()+OrderSwap()+OrderCommission();// 指定MAGIC数值已开仓的买单盈亏之和（不区分货币对）
           }
         if(OrderType()==OP_SELL && OrderMagicNumber()==MAGIC)
           {
            ss++;// 指定MAGIC数值已开仓的卖单数量之和（不区分货币对）
            ssprofit+=OrderProfit()+OrderSwap()+OrderCommission();// 指定MAGIC数值已开仓的卖单盈亏之和（不区分货币对）
           }
         if(OrderType()==OP_BUY)
           {
            bbl++;// 已开仓的买单数量之和（不区分货币对）
            bbprofitl+=OrderProfit()+OrderSwap()+OrderCommission();// 已开仓的买单盈亏之和（不区分货币对）
           }
         if(OrderType()==OP_SELL)
           {
            ssl++;// 已开仓的卖单数量之和（不区分货币对）
            ssprofitl+=OrderProfit()+OrderSwap()+OrderCommission();// 已开仓的卖单盈亏之和（不区分货币对）
           }
         if(OrderType()==OP_SELLSTOP)
           {
            ossa++;// 所有未删除的SELLSTOP挂单的数量（不区分货币对）
           }
         if(OrderType()==OP_SELLLIMIT)
           {
            osla++;// 所有未删除的SELLLIMIT挂单的数量（不区分货币对）
           }
         if(OrderType()==OP_BUYSTOP)
           {
            obsa++;// 所有未删除的BUYSTOP挂单的数量（不区分货币对）
           }
         if(OrderType()==OP_BUYLIMIT)
           {
            obla++;// 所有未删除的BUYLIMIT挂单的数量（不区分货币对）
           }
         if((OrderType()==OP_BUY ||OrderType()==OP_SELL) && (OrderProfit()+OrderSwap()+OrderCommission()>0))
           {
            Twbs++;// 所有未平单子中盈利单子的数量之和（不区分货币对）
            Twin+=OrderProfit()+OrderSwap()+OrderCommission();// 所有未平单子中盈利单子的盈利之和（不区分货币对）
           }
         if((OrderType()==OP_BUY ||OrderType()==OP_SELL) && (OrderProfit()+OrderSwap()+OrderCommission()<0))
           {
            Tlbs++;// 所有未平单子中亏损单子的数量之和（不区分货币对）
            Tloss+=OrderProfit()+OrderSwap()+OrderCommission();// 所有未平单子中盈利单子的亏损之和（不区分货币对）
           }
         if(OrderType()==OP_BUY ||OrderType()==OP_SELL)
           {
            TOTALLOTS+=OrderLots();// 所有未平的订单下单量之和
           }
         if(OrderSymbol()== 货币对)
           {
            if(OrderType()==OP_BUY)
              {
               BLOTS+=OrderLots();// 指定货币对所有未平的买单下单量之和
               mbb++;             // 指定货币对所有未平的买单数量之和
               mbbprofit+=OrderProfit()+OrderSwap()+OrderCommission();// 指定货币对所有未平的买单盈利之和
              }
            if(OrderType()==OP_SELL)
              {
               SLOTS+=OrderLots();// 指定货币对所有未平的卖单下单量之和
               mss++;             // 指定货币对所有未平的卖单数量之和
               mssprofit+=OrderProfit()+OrderSwap()+OrderCommission();// 指定货币对所有未平的卖单盈利之和
              }
            if(OrderType()==OP_SELLSTOP)
              {
               moss++;// 指定货币对SELLSTOP挂单数量之和
              }
            if(OrderType()==OP_SELLLIMIT)
              {
               mosl++;// 指定货币对SELLLIMIT挂单数量之和
              }
            if(OrderType()==OP_BUYSTOP)
              {
               mobs++;// 指定货币对BUYSTOP挂单数量之和
              }
            if(OrderType()==OP_BUYLIMIT)
              {
               mobl++;// 指定货币对BUYLIMIT挂单数量之和
              }
            profitmm+=OrderProfit()+OrderSwap()+OrderCommission();// 指定货币对总的盈亏
           }

         if(OrderSymbol()==货币对 && OrderMagicNumber()==MAGIC)
           {
            if(OrderType()==OP_SELL)
              {
               TLOTSS+=OrderLots();
               s++;
               SLASTLOTS=OrderLots();
               sprofit+=OrderProfit()+OrderSwap()+OrderCommission();
               LastPricesell=OrderOpenPrice();
              }
            if(OrderType()==OP_BUY)
              {
               TLOTSB+=OrderLots();
               b++;
               BLASTLOTS=OrderLots();
               bprofit+=OrderProfit()+OrderSwap()+OrderCommission();
               LastPricebuy=OrderOpenPrice();
              }
            if(OrderType()==OP_SELL || OrderType()==OP_BUY)
              {
               TLOTS+=OrderLots();
              }
            if(OrderType()==OP_SELLSTOP)
              {
               oss++;// 指定货币对指定MAGIC数值未删除的SELLSTOP挂单数量之和
              }
            if(OrderType()==OP_SELLLIMIT)
              {
               osl++;// 指定货币对指定MAGIC数值未删除的SELLLIMIT挂单数量之和
              }
            if(OrderType()==OP_BUYSTOP)
              {
               obs++;// 指定货币对指定MAGIC数值未删除的BUYSTOP挂单数量之和
              }
            if(OrderType()==OP_BUYLIMIT)
              {
               obl++;// 指定货币对指定MAGIC数值未删除的BUYLIMIT挂单数量之和
              }
           }
        }

     }
  }

//+------------------------------------------------------------------+
//| 删除全部物件模块                                                 |
//+------------------------------------------------------------------+
void 删除全部物件()
  {
   int totle=ObjectsTotal();
   for(int i=totle-1; i>0; i--)
     {
      string name=ObjectName(i);
      ObjectDelete(name);
     }
  }


//+------------------------------------------------------------------+
//| 移动止损模块                                                |
//+------------------------------------------------------------------+
void 移动止损()
  {
   int total=OrdersTotal();
//遍历所有订单
   for(int i=0; i<total; i++)
     {
      //选择订单
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
        {
         //指定货币对
         if(OrderSymbol()==货币对)
           {
            //选择订单类型
            if(OrderType()==OP_BUY)
              {
               //如果现价比开盘价高“启动点数”，就启动移动止损功能
               if(MarketInfo(货币对,MODE_BID)-OrderOpenPrice()>启动点数*MarketInfo(货币对,MODE_POINT))
                 {
                  //设置止损价格条件
                  if(OrderStopLoss()<MarketInfo(货币对,MODE_BID)-移动止损点数*MarketInfo(货币对,MODE_POINT))
                    {
                     //修改移动止损价格
                     bool resl=OrderModify(OrderTicket(),OrderOpenPrice(),MarketInfo(货币对,MODE_BID)-移动止损点数*MarketInfo(货币对,MODE_POINT),OrderTakeProfit(),OrderExpiration(),CLR_NONE);

                    }
                 }
               else
                  if(OrderType()==OP_SELL)
                    {
                     //如果现价比开盘价低“启动点数”，就启动移动止损功能
                     if(OrderOpenPrice()-MarketInfo(货币对,MODE_ASK)>启动点数*MarketInfo(货币对,MODE_POINT))
                       {
                        //设置止损价格条件
                        if(OrderStopLoss()>MarketInfo(货币对,MODE_ASK)+移动止损点数*MarketInfo(货币对,MODE_POINT))
                          {
                           bool resl=OrderModify(OrderTicket(),OrderOpenPrice(),MarketInfo(货币对,MODE_ASK)+移动止损点数*MarketInfo(货币对,MODE_POINT),OrderTakeProfit(),OrderExpiration(),CLR_NONE);

                          }
                       }

                    }
              }

           }
        }

     }

  }

//+------------------------------------------------------------------+
//| 报错模块                                                 |
//+------------------------------------------------------------------+
void 报错信息(string a)
  {
//自动更新数据
   RefreshRates();
//判断EA是否在优化模式中运行
   if(IsOptimization())
      return;
   int 错误代码=GetLastError();
   string 报错内容;
   if(错误代码!=0)
     {
      switch(错误代码)
        {
         case 3:
            报错内容="错误代码："+DoubleToStr(错误代码)+" 无效交易参量";
            break;
         case 4:
            报错内容="错误代码："+DoubleToStr(错误代码)+" 交易服务器繁忙";
            break;
         case 5:
            报错内容="错误代码："+DoubleToStr(错误代码)+" 客户端旧版本";
            break;
         case 6:
            报错内容="错误代码："+DoubleToStr(错误代码)+" 没有连接服务器";
            break;
         case 7:
            报错内容="错误代码："+DoubleToStr(错误代码)+" 没有权限";
            break;
         case 9:
            报错内容="错误代码："+DoubleToStr(错误代码)+" 交易运行故障";
            break;
         case 64:
            报错内容="错误代码："+DoubleToStr(错误代码)+" 账户禁止";
            break;
         case 65:
            报错内容="错误代码："+DoubleToStr(错误代码)+" 无效账户";
            break;
         case 129:
            报错内容="错误代码："+DoubleToStr(错误代码)+" 无效价格";
            break;
         case 130:
            报错内容="错误代码："+DoubleToStr(错误代码)+" 无效停止";
            break;
         case 131:
            报错内容="错误代码："+DoubleToStr(错误代码)+" 无效交易量";
            break;
         case 132:
            报错内容="错误代码："+DoubleToStr(错误代码)+" 市场关闭";
            break;
         case 133:
            报错内容="错误代码："+DoubleToStr(错误代码)+" 交易被禁止";
            break;
         case 134:
            报错内容="错误代码："+DoubleToStr(错误代码)+" 资金不足";
            break;
         case 135:
            报错内容="错误代码："+DoubleToStr(错误代码)+" 价格改变";
            break;
         case 137:
            报错内容="错误代码："+DoubleToStr(错误代码)+" 经纪繁忙";
            break;
         case 139:
            报错内容="错误代码："+DoubleToStr(错误代码)+" 订单被锁定";
            break;
         case 140:
            报错内容="错误代码："+DoubleToStr(错误代码)+" 只允许看涨仓位";
            break;
         case 147:
            报错内容="错误代码："+DoubleToStr(错误代码)+" 时间周期被经纪否定";
            break;
         case 148:
            报错内容="错误代码："+DoubleToStr(错误代码)+" 开单和挂单总数被经纪限定";
            break;
         case 149:
            报错内容="错误代码："+DoubleToStr(错误代码)+" 当对冲被拒绝时，打开相对于现有的以一个单置";
            break;
         case 150:
            报错内容="错误代码："+DoubleToStr(错误代码)+" 平掉违反FIFO的单子";
            break;
         case 4000:
            报错内容="错误代码："+DoubleToStr(错误代码)+" 没有错误";
            break;
         case 4001:
            报错内容="错误代码："+DoubleToStr(错误代码)+" 错误函数指示";
            break;
         case 4002:
            报错内容="错误代码："+DoubleToStr(错误代码)+" 数组索引超出范围";
            break;
         case 4003:
            报错内容="错误代码："+DoubleToStr(错误代码)+" 对于调用堆栈存储器函数没有足够的内存";
            break;
         case 4004:
            报错内容="错误代码："+DoubleToStr(错误代码)+" 循环堆栈存储器溢出";
            break;
         case 4005:
            报错内容="错误代码："+DoubleToStr(错误代码)+" 对于堆栈存储器没有内存";
            break;
         case 4006:
            报错内容="错误代码："+DoubleToStr(错误代码)+" 对于字行参量没有足够内存";
            break;
         case 4007:
            报错内容="错误代码："+DoubleToStr(错误代码)+" 对于字行没有足够没存";
            break;
         case 4009:
            报错内容="错误代码："+DoubleToStr(错误代码)+" 在数组中没有初始字符串";
            break;
         case 4010:
            报错内容="错误代码："+DoubleToStr(错误代码)+" 对于数组没有内存";
            break;
         case 4011:
            报错内容="错误代码："+DoubleToStr(错误代码)+" 字行过长";
            break;
         case 4012:
            报错内容="错误代码："+DoubleToStr(错误代码)+" 余数划分内容";
            break;
         case 4013:
            报错内容="错误代码："+DoubleToStr(错误代码)+" 零划分";
            break;
         case 4014:
            报错内容="错误代码："+DoubleToStr(错误代码)+" 不明原因";
            break;
         case 4015:
            报错内容="错误代码："+DoubleToStr(错误代码)+" 错误转换(没有常规错误)";
            break;
         case 4016:
            报错内容="错误代码："+DoubleToStr(错误代码)+" 没有初始数组";
            break;
         case 4017:
            报错内容="错误代码："+DoubleToStr(错误代码)+" 禁止调用DLL";
            break;
         case 4018:
            报错内容="错误代码："+DoubleToStr(错误代码)+" 数据库不能下载";
            break;
         case 4019:
            报错内容="错误代码："+DoubleToStr(错误代码)+" 数据库不能下载";
            break;
         case 4020:
            报错内容="错误代码："+DoubleToStr(错误代码)+" 禁止调用智能交易系统";
            break;
         case 4021:
            报错内容="错误代码："+DoubleToStr(错误代码)+" 对于来自函数的字行没有足够内存";
            break;
         case 4022:
            报错内容="错误代码："+DoubleToStr(错误代码)+" 系统繁忙(没有常规错误)";
            break;
         case 4050:
            报错内容="错误代码："+DoubleToStr(错误代码)+" 无效计数参量函数";
            break;
         case 4051:
            报错内容="错误代码："+DoubleToStr(错误代码)+" 无效参量值函数";
            break;
         case 4052:
            报错内容="错误代码："+DoubleToStr(错误代码)+" 字行函数内部错误";
            break;
         case 4053:
            报错内容="错误代码："+DoubleToStr(错误代码)+" 一些数组错误";
            break;
         case 4054:
            报错内容="错误代码："+DoubleToStr(错误代码)+" 应用不正确数组";
            break;
         case 4055:
            报错内容="错误代码："+DoubleToStr(错误代码)+" 自定义指标错误";
            break;
         case 4056:
            报错内容="错误代码："+DoubleToStr(错误代码)+" 不协调数组";
            break;
         case 4057:
            报错内容="错误代码："+DoubleToStr(错误代码)+" 整体变量过程错误";
            break;
         case 4058:
            报错内容="错误代码："+DoubleToStr(错误代码)+" 整体变量未找到";
            break;
         case 4059:
            报错内容="错误代码："+DoubleToStr(错误代码)+" 测试模式函数禁止";
            break;
         case 4060:
            报错内容="错误代码："+DoubleToStr(错误代码)+" 没有确认函数";
            break;
         case 4061:
            报错内容="错误代码："+DoubleToStr(错误代码)+" 发送邮件错误";
            break;
         case 4062:
            报错内容="错误代码："+DoubleToStr(错误代码)+" 字行预计参量";
            break;
         case 4063:
            报错内容="错误代码："+DoubleToStr(错误代码)+" 整数预计参量";
            break;
         case 4064:
            报错内容="错误代码："+DoubleToStr(错误代码)+" 双预计参量";
            break;
         case 4065:
            报错内容="错误代码："+DoubleToStr(错误代码)+" 数组作为预计参量";
            break;
         case 4066:
            报错内容="错误代码："+DoubleToStr(错误代码)+" 刷新状态请求历史数据";
            break;
         case 4067:
            报错内容="错误代码："+DoubleToStr(错误代码)+" 交易函数错误";
            break;
         case 4099:
            报错内容="错误代码："+DoubleToStr(错误代码)+" 文件结束";
            break;
         case 4100:
            报错内容="错误代码："+DoubleToStr(错误代码)+" 一些文件错误";
            break;
         case 4101:
            报错内容="错误代码："+DoubleToStr(错误代码)+" 错误文件名称";
            break;
         case 4102:
            报错内容="错误代码："+DoubleToStr(错误代码)+" 打开文件过多";
            break;
         case 4103:
            报错内容="错误代码："+DoubleToStr(错误代码)+" 不能打开文件";
            break;
         case 4104:
            报错内容="错误代码："+DoubleToStr(错误代码)+" 不协调文件";
            break;
         case 4105:
            报错内容="错误代码："+DoubleToStr(错误代码)+" 没有选择订单";
            break;
         case 4106:
            报错内容="错误代码："+DoubleToStr(错误代码)+" 不明货币对";
            break;
         case 4107:
            报错内容="错误代码："+DoubleToStr(错误代码)+" 无效价格";
            break;
         case 4108:
            报错内容="错误代码："+DoubleToStr(错误代码)+" 无效订单编码";
            break;
         case 4109:
            报错内容="错误代码："+DoubleToStr(错误代码)+" 不允许交易";
            break;
         case 4110:
            报错内容="错误代码："+DoubleToStr(错误代码)+" 不允许长期";
            break;
         case 4111:
            报错内容="错误代码："+DoubleToStr(错误代码)+" 不允许短期";
            break;
         case 4200:
            报错内容="错误代码："+DoubleToStr(错误代码)+" 订单已存在";
            break;
         case 4201:
            报错内容="错误代码："+DoubleToStr(错误代码)+" 不明订单属性";
            break;
         case 4203:
            报错内容="错误代码："+DoubleToStr(错误代码)+" 不明订单类型";
            break;
         case 4204:
            报错内容="错误代码："+DoubleToStr(错误代码)+" 没有订单名称";
            break;
         case 4205:
            报错内容="错误代码："+DoubleToStr(错误代码)+" 订单坐标错误";
            break;
         case 4206:
            报错内容="错误代码："+DoubleToStr(错误代码)+" 没有指定子窗口";
            break;
         case 4207:
            报错内容="错误代码："+DoubleToStr(错误代码)+" 订单一些函数错误";
            break;
         case 4250:
            报错内容="错误代码："+DoubleToStr(错误代码)+" 错误设定发送通知到队列中";
            break;
         case 4253:
            报错内容="错误代码："+DoubleToStr(错误代码)+" 通知发送过于频繁";
            break;
        }


     }

   if(错误代码!=0)
     {
      //如果交易繁忙
      while(IsTradeContextBusy())
         //暂停执行300毫秒
         Sleep(300);
      Print(a+报错内容);
     }

  }



//+------------------------------------------------------------------+
//| 按键模块                                                 |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void 按键(string name, string txt1,string txt2,int X,int Y,int L,int W,int corner,color color1,color color2,int fontsize)
  {
// 如果没有按键，则创建一个
   if(ObjectFind(0,name)==-1)
     {
      //创建一个OBJ_BUTTON
      ObjectCreate(0,name,OBJ_BUTTON,0,0,0);
      // 设置X坐标
      ObjectSetInteger(0,name,OBJPROP_XDISTANCE,X);
      // 设置Y坐标
      ObjectSetInteger(0,name,OBJPROP_YDISTANCE,Y);
      // 设置长度
      ObjectSetInteger(0,name,OBJPROP_XSIZE,L);
      // 设置宽度
      ObjectSetInteger(0,name,OBJPROP_YSIZE,W);
      // 设置字体
      ObjectSetString(0,name,OBJPROP_FONT,"微软雅黑");
      // 设置文字大小
      ObjectSetInteger(0,name,OBJPROP_FONTSIZE,fontsize);
      // 设置角落位置
      ObjectSetInteger(0,name,OBJPROP_CORNER,corner);
      //设置在图标中有限接受鼠标点击事件
      ObjectSetInteger(0,name,OBJPROP_ZORDER,0);
      // 如果按键按下则设置按键上的文字颜色
     }

  }


//+------------------------------------------------------------------+
//|   OnChartEvent 事件处理函数                                              |
//+------------------------------------------------------------------+
void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
  {
   if(id==CHARTEVENT_OBJECT_CLICK)
     {

      string name="按键1";
      if(sparam==name)
        {
         Print(name+" 被按下！");
         if(ObjectGetInteger(0,name,OBJPROP_STATE)==1)
           {
            // 改变按键的颜色
            ObjectSetInteger(0,name,OBJPROP_COLOR,Red);
            // 改变按钮名字
            ObjectSetString(0,name,OBJPROP_TEXT,"按下");

           }
         else // 如果按键没有被按下
           {
            // 改变按键的颜色
            ObjectSetInteger(0,name,OBJPROP_COLOR,Blue);
            // 改变按钮名字
            ObjectSetString(0,name,OBJPROP_TEXT,"弹起");
           }

        }
     }


  }
//+------------------------------------------------------------------+
