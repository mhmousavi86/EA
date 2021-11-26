//+------------------------------------------------------------------+
//|                                                 TrendFilters.mqh |
//|                        Copyright 2021, MetaQuotes Software Corp. |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright "Copyright 2021, MetaQuotes Software Corp."
#property link      ""
#property strict

 enum STATE

  {
   BULL,
   BEAR,
   SWING
  };
  
  
  STATE getTrend(int index) 

  {

   STATE state=SWING;



   double MA8=iMA(Symbol(),0,8,0,MODE_EMA,PRICE_CLOSE,index);

   double MA21=iMA(Symbol(),0,21,0,MODE_EMA,PRICE_CLOSE,index);



   double kijunsen=iIchimoku(Symbol(),0,7,22,44,MODE_KIJUNSEN,index);

   double tenkansen=iIchimoku(Symbol(),0,7,22,44,MODE_TENKANSEN,index);



   double close=iClose(Symbol(),0,index);

string lbl = "";


   if(close>=kijunsen && tenkansen>=kijunsen)

     {

      if(close >= MA8 && close >= MA21)

        {
         lbl = "BULL";
         state=BULL;

        } else {
          lbl = "SWING";
         state=SWING;

        }

     } else if(close<kijunsen && tenkansen<kijunsen) {

      if(close<MA8 && close<MA21)
        {
        lbl = "BEAR";
         state=BEAR;
        } else {
        lbl = "SWING";
         state=SWING;
        }
       } else {
       lbl = "SWING";
         state=SWING;
     }


//   ObjectCreate(lbl,OBJ_LABEL,0,0,0.0,0,0.0,0,0.0); 
//
//  ObjectSet(lbl,OBJPROP_CORNER,1.0); 
//
//  ObjectSet(lbl,OBJPROP_XDISTANCE,5.0); 
//
//  ObjectSet(lbl,OBJPROP_YDISTANCE,18.0); 
//
//  ObjectSet(lbl,OBJPROP_BACK,1.0); 
//
//  ObjectSetText(lbl,lbl,12,"Calibri",Black); 

Comment(lbl);
   return state;

  }
  