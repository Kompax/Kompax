//
//  KOMFinancialModel.h
//  Kompax
//
//  Created by Bryan on 13-8-18.
//  Copyright (c) 2013年 Bryan. All rights reserved.
//

#ifndef Kompax_KOMFinancialModel_h
#define Kompax_KOMFinancialModel_h

#endif


class KOMFinancialModel {
    
public:
    
    //获取房贷情况下所需每月消费的量的函数
    double getHouseConsume(int BuyTime,int accYear,int accMonth,int mortTime,
                           double area,double part,double price,double accMoney,
                           double asset,double income,double priceIncre,double incomeIncre,double riskIntere);
    
    //获取车贷情况下所需每月消费的量的函数
    double getCarConsume(int buyTime,int mortTime,double carPrice,double part,double asset,double income,double priceIncre,double incomeIncre,double riskIntere);
    
    //获取退休计划的消费额函数
    double retireConsume(int currentAge, int retireAge, double income, double consume,double riskIntere);
    
    //判断过后月还贷额是否合法
    bool isLegal(double AV_TC,double part, double income, double incomeIncre, int buyTime, int mortTime,double accPart);
    
};