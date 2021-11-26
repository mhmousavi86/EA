//+------------------------------------------------------------------+
//|                                                   MhTemplate.mqh |
//|                        Copyright 2021, MetaQuotes Software Corp. |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright "Copyright 2021, MetaQuotes Software Corp."
#property link      ""
#property strict
#include <CSupportResistance.mqh>
#include <SupportResistanceZones.mqh>
CSupportResistance* _supportResistanceW1;

CSupportResistance* _supportResistanceD1;

CSupportResistance* _supportResistanceH4;

CSupportResistance* _supportResistanceH1;





#define MAGICMA  20131111

//--- Inputs

input double Lots          =0.01;

input double MaximumRisk   =0.02;

input double DecreaseFactor=3;

input int    MovingPeriod  =8;

input int    MovingShift   =21;



input int    HeavyMovingPeriod  =144;

input int    HeavyMovingShift   =200;



double    currentProfit;

double    previousProfit;



bool  isUp = false;

bool wasUp = false;

bool cross = false;





extern int     period_RSI           = 14,

               stoploss             = 100,

               takeprofit           = 200,

               slippage             = 10,

               buy_level            = 30,

               sell_level           = 70,

               Magic                = 777;

extern double  Lot                  = 0.01;





double currrenLightAverageCrossPoint = 0.0;

double firstLightAverageCrossPoint   = 0.0;

double secondLightAverageCrossPoint  = 0.0;



double currentFirstMovingAverageValue;

double currentSecondMovingAverageValue;

double currentFirstHeavyMovingAverageValue;

double currentSecondHeavyMovingAverageValue;



int oldTime;









double firstResistance = 0;

double secondResistance = 0;

double firstSupport = 0;

double secondSupport = 0;



int totalPendingOrders = 0;




int ActiveonTime=Period();

input ENUM_LINE_STYLE FiboLineStype=STYLE_DASHDOTDOT;









extern bool        SR_1Hours       = true;

extern bool        SR_4Hours       = false;

extern bool        SR_Daily        = false;

extern bool        SR_Weekly       = false;

extern bool        ShowAgeLabels   = true;

extern bool        ShowLastTouch   = false;

extern bool        ShowAllSRLines  = false;

extern string      __colors__      = "---- S/R settings ----";

extern color       ColorAge1       = Red;

extern color       ColorAge2       = Red;

extern color       ColorAge3       = Red;

extern color       ColorAge4       = Red;

extern color       ColorText       = White;


color        Colors[]     = {Red,Red, Red,Red};


  //+------------------------------------------------------------------+


void setMhTemp() {
  // initSuportResistanceZones();
   FastFractals();
   FindZones();
   DrawZones();
   //CalculateSR(true);
long handle=ChartID();

   if(handle>0)
     {
      ChartSetInteger(handle,CHART_SHOW_GRID,false);
      ChartSetInteger(handle,CHART_SHIFT,true);
      ChartSetInteger(handle,CHART_MODE,CHART_CANDLES);
      ChartSetInteger(handle,CHART_COLOR_BACKGROUND,White);
      ChartSetInteger(handle,CHART_COLOR_CHART_DOWN,Black);
      ChartSetInteger(handle,CHART_COLOR_CHART_UP,Black);
      ChartSetInteger(handle,CHART_COLOR_CANDLE_BEAR,clrBlue);
      ChartSetInteger(handle,CHART_COLOR_CANDLE_BULL,clrRed);
      ChartSetInteger(handle,CHART_COLOR_FOREGROUND,Black);
      ChartSetInteger(handle,CHART_COLOR_BID,Black);
      ChartSetInteger(handle,CHART_COLOR_ASK,Black);
      ChartSetInteger(handle,CHART_SCALE,0,2);
     }
}

//+------------------------------------------------------------------+

void CalculateSR(bool forceRefresh = false)

{

   _supportResistanceW1 = new CSupportResistance(Symbol(), PERIOD_W1);

   _supportResistanceD1 = new CSupportResistance(Symbol(), PERIOD_D1);

   _supportResistanceH4 = new CSupportResistance(Symbol(), PERIOD_H4);

   _supportResistanceH1 = new CSupportResistance(Symbol(), PERIOD_H1);

   string txt="S/R:";

   if (SR_Weekly)

   {

      txt +="W1,";

      _supportResistanceW1.Calculate(forceRefresh);

      _supportResistanceW1.Draw("W1", ColorText, Colors, ShowAgeLabels, ShowLastTouch, ShowAllSRLines);

   }

   

   if (SR_Daily)

   {

      txt +="D1,";

      _supportResistanceD1.Calculate(forceRefresh);

      _supportResistanceD1.Draw("D1", ColorText, Colors, ShowAgeLabels, ShowLastTouch, ShowAllSRLines);

   }

   

   if (SR_4Hours)

   {

      txt +="H4,";

      _supportResistanceH4.Calculate(forceRefresh);

      _supportResistanceH4.Draw("H4", ColorText, Colors, ShowAgeLabels, ShowLastTouch, ShowAllSRLines);

   }

   

   if (SR_1Hours)

   {

      txt +="H1,";

      _supportResistanceH1.Calculate(forceRefresh);

      firstResistance   = _supportResistanceH1.getFirstResistance("H1", ColorText, Colors, ShowAgeLabels, ShowLastTouch, ShowAllSRLines);

      secondResistance  = _supportResistanceH1.getSecondResistance("H1", ColorText, Colors, ShowAgeLabels, ShowLastTouch, ShowAllSRLines);

      firstSupport      = _supportResistanceH1.getFirstSupport("H1", ColorText, Colors, ShowAgeLabels, ShowLastTouch, ShowAllSRLines);

      secondSupport     = _supportResistanceH1.getSecondSupport("H1", ColorText, Colors, ShowAgeLabels, ShowLastTouch, ShowAllSRLines);

      _supportResistanceH1.Draw("H1", ColorText, Colors, ShowAgeLabels, ShowLastTouch, ShowAllSRLines);

   }

   

   switch (SR_Detail)

   {

      case Minium:     txt += " Minimum";     break;

      case MediumLow:  txt += " Medium/Low";  break;

      case Medium:     txt += " Medium";      break;

      case MediumHigh: txt += " Medium/High"; break;

      case Maximum:    txt += " Maximum";     break;

   }

   

   ObjectCreate("@info", OBJ_LABEL, 0, 0, 0);

   ObjectSet("@info", OBJPROP_BACK, false);

   ObjectSet("@info", OBJPROP_CORNER, CORNER_LEFT_UPPER);

   ObjectSet("@info", OBJPROP_XDISTANCE, 250);

   ObjectSet("@info", OBJPROP_YDISTANCE, 0);

   ObjectSetText("@info", txt, 8, "Arial", ColorText);

   

   //Comment(firstSupport);

   

   

}
