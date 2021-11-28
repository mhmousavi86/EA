

//+------------------------------------------------------------------+
//|                                                         Zone.mq4 |
//|                        Copyright 2021, MetaQuotes Software Corp. |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright "Copyright 2021, MetaQuotes Software Corp."
#property link      ""
#property version   "1.00"
#property strict

#include <MhTemplate.mqh>
#include <TrendFilters.mqh>
//+--------------------
int OnInit()
  {
  initSuportResistanceZones();
   return(INIT_SUCCEEDED);
  }

void OnTick()
  {
  // setMhTemp();
  // getHightZone(0,ZONE_RESIST,ZONE_VERIFIED);
  // getLowZone(0,ZONE_RESIST,ZONE_VERIFIED);
  
  // getTrend(0);
  
   FastFractals();
   FindZones();
   DrawZones();
   
  }
  
  