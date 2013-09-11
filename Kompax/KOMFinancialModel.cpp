//
//  KOMFinancialModel.cpp
//  Kompax
//
//  Created by Bryan on 13-8-18.
//  Copyright (c) 2013年 Bryan. All rights reserved.
//

#include "KOMFinancialModel.h"
#include <iostream>
#include <math.h>
using namespace std;

/* buyTime为购房时间， accYear为公积金开始年份，accMonth为公积金开始月份
 * mortTime为贷款年限 area为购房面积,,part为首付成数，price为房价，accMoney为公积金月缴金额，asset为现有资产,
 * income为月收入
 * priceIncre为房价增长率，incomeIncre为工资增长率，riskIntere为风险偏好利率
 */
double KOMFinancialModel::getHouseConsume(int buyTime,int accYear,int accMonth,int mortTime,
                       double area,double part,double price,double accMoney,
                       double asset,double income,double priceIncre,double incomeIncre,double riskIntere)
{
    
    double totalCost,AV_TC,accpart;     //TotalCost房屋总价AV_TC购房时房屋价格,accpart公积金占收入比例
    
    totalCost = price*area;               //欲购买房屋现值
    AV_TC = totalCost * pow((1 + priceIncre),buyTime);        //购买房屋时房屋价格
    accpart = accMoney / income;                            //accpart为公积金占收入比例
    
    if (isLegal(AV_TC,part,income,incomeIncre,buyTime,mortTime,accpart))
    {
        cout<<"您所输入的首付比例太低或者贷款年限过短，导致月后还款额可能违反国家规定，请进行相应修改"<<endl;
        return 0;
    }
    
    int countMonth;                                     //为公积金距离首付时间
    countMonth=12*(2013-accYear+buyTime)+accMonth-8;
    
    double accIntere;                                   //公积金累积利率
    accIntere=0.05/12;
    double accacc;                                      //为购房时公积金累积额度
    accacc=(pow((1+2*accIntere),countMonth)-1)/accIntere*accMoney;
    
    double downPayment,incomepart;                  //首付中需要节省下来的钱、为了首付月收入需要储蓄比例
    downPayment=AV_TC*part-accacc-asset*pow((1+riskIntere),buyTime);
    incomepart = downPayment * (riskIntere-incomeIncre)/(12 * income) / (pow(1+riskIntere,buyTime)-pow(1+incomeIncre,buyTime));
    
    double consume;                                     //可以消费额
    if (incomepart>=0.65)
    {
        cout<<"您所输入的首付比例过高，若实施可能影响您的生活质量，建议对其进行修改"<<endl;
        return -1;
    }
    else if (incomepart<=0)
    {
        cout<<"您所输入的首付比例较低，无需改变生活质量即可获得首付所需款项"<<endl;
        return -1;
    }
    else
    {
        consume=income*(1-incomepart);
        return consume;
    }
}

double KOMFinancialModel::getCarConsume(int buyTime,int mortTime,double carprice,double part,double asset,double income,double priceIncre,double incomeIncre,double riskIntere)
{
    double downPayment;                                 //首付中需要节省下来的钱
    downPayment=carprice*part-asset*pow((1+riskIntere),buyTime);
    
    double savepart;                                    //为了首付月收入需要储蓄比例
    savepart=downPayment*(riskIntere-incomeIncre)/(12*income)/(pow(1+riskIntere,buyTime)-pow(1+incomeIncre,buyTime));
    
    double consume;                                     //可以消费额
    if (savepart>=0.65)
    {
        cout<<"您所输入的首付比例过高，若实施可能影响您的生活质量，建议对其进行修改"<<endl;
        return -1;
    }
    else if (savepart<=0)
    {
        cout<<"您所输入的首付比例较低，无需改变生活质量即可获得首付所需款项"<<endl;
        return -1;
    }
    else
    {
        consume = income * (1 - savepart);
        return consume;
    }
}

/*
 * currentAge为现阶段年龄，retireAge为退休年龄，Consume为当前每月消费额，其余相同，现阶段以及退休年龄由用户输入，
 * 当前每月消费额由系统读取其账户情况。最后是返回为达致退休目标所需每月消费额。
 */
double KOMFinancialModel::retireConsume(int currentAge, int retireAge, double income, double consume,double riskIntere)
{
    //以退休前后支出比法作为近似预计计算,替代率为70% ，通货膨胀率4%，活到80岁
    double retireCost,currentSave;      //退休时总体养老金现值 ,currentSave为每月储蓄量 
    int C_Ryear,R_Dyear;                //C_Ryear为距退休年数，R_Dyear为退休到挂了的年份
    
    C_Ryear=retireAge-currentAge;
    R_Dyear=80-retireAge;
    
    retireCost=consume * 0.7 * pow(1.04,C_Ryear) / 0.01 * (1 - pow(1.04 / 1.05,R_Dyear));
    currentSave=retireCost*(riskIntere - 0.04) / pow((1 + riskIntere),C_Ryear) / (1 - pow(1.04 / (1 + riskIntere),C_Ryear));
    
    return (income - currentSave);
}

//判断过后月还贷额是否合法
bool KOMFinancialModel::isLegal(double AV_TC,double part, double income, double incomeIncre, int buyTime, int mortTime,double accpart)
{
    double mortAV_TC;//此为月贷需要返还总额
    mortAV_TC=AV_TC*(1-part);
    
    double AV_income;//此为买房时工资水平
    AV_income=income*pow((1 + incomeIncre),buyTime);
    
    cout<< mortAV_TC<<endl;
    cout<< AV_income<<endl;
    double PV_income;//为法律允许月贷款50%于购房时现值
    PV_income= (0.5 + accpart) * AV_income * 12 * (1 - pow(((1 + incomeIncre) / ( 1 + 0.06)),mortTime))/(0.06 - incomeIncre);
    
    cout<<PV_income<<endl;
    
    if  (mortAV_TC >= PV_income)  return true;
    else                        return false;
}
