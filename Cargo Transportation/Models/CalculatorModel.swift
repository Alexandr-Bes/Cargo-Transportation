//
//  CalculatorModel.swift
//  Cargo Transportation
//
//  Created by Alex Bezkopylnyi on 07.12.2020.
//

import Foundation

struct CalculatorModel: Codable {
    var culture: String
    var areasSendId: String
    var areasResiveId: String
    var warehouseSendId: String
    var warehouseResiveId: String
    var InsuranceValue: Double
    var CashOnDeliveryValue: Double
    var dateSend: String
    var deliveryScheme: Int
    var category: [CategoryModel]
    var dopUslugaClassificator: [DopUslugaClassificationModel]
}

struct CategoryModel: Codable {
    var categoryId: String          //Id категории груза
    var countPlace: Int             //Количество мест
    var helf: Double                //Вес
    var size: Double                //Объем
}

struct DopUslugaClassificationModel: Codable {
    var dopUsluga: [DopUslugaModel]
}

struct DopUslugaModel: Codable {
    var uslugaId: String
    var count: Int
}

// MARK: - FOR TESTS
/*
struct CalculatorModelTest: Codable {
    var culture: String         //Культура
    var areasSendId: String       //Id города отправления
    var areasResiveId: String      //Id города получения
    var warehouseSendId: String              //Id склада отправления
    var warehouseResiveId: String           // Id склада получения
    var areasSendIdName: String            //Наименование города отправления
    var areasResiveIdName:String          //Наименование города получения
    var warehouseSendIdName: String      //Наименование склада отправления
    var warehouseResiveIdName: String   //Наименование склада получения
    var CashOnDeliveryValue: Double    //Сумма наложенного платежа
    var CashOnDeliveryValuta: Int       //Валюта наложенного платежа
    var InsuranceValue: Double          //Страховая стоимость груза
    // TODO: - >??? decimal<
    var InsuranceCost: Double           //decimal InsuranceCost; //Стоимость страховки
    var dateSend: String                // DateTime? dateSend; "06.06.2014", //Дата отправления
    var dateResive: String              //Дата получения
    var climbingToFloor: Int            //Доставка на этаж
    var descentFromFloor: Int           //Спуск с этажа
    var deliveryScheme: Int             //Схема доставки ???
    var category: [CategoryModelTest]         //Перечисления категорий груза
    var dopUslugaClassificator: [DopUslugaClassificationModelTest]  //Перечисление доп. услуг
    var categorySumma: Double?              //decimal
    var allSumma: Double?               //decimal //Общая стоимость перевозки
    var status: Bool                //Статус расчета
    var denyIssue: Bool             //Запрет выдачи
    var EconomDelivery: Bool        //Экономная доставка, флаг
    var EconomPickUp: Bool          //Экономный забор, флаг
    var IsGidrobort: Bool           //Гидроборт, флаг
    var IsOverSize: Bool            //Негабарит, флаг
    var isPostomat: Bool            //Запрет выдачи, флаг
    var comment: String             //Описание расчета
    var SummaryTransportCost: Double    //decimal //Стоимость перевозки склад склад
    var SummaryDuCost: Double           //decimal //Стоимость доп. услуг
    var SummaryOformlenieCost: Double   //decimal //Стоимость оформления
    var currency: Int       //Валюта
    var viewType: Int       //
}

struct CategoryModelTest: Codable {
    var categoryId: String          //Id категории груза
    var categoryIdName: String      //Наименование категории груза
    var classification: Int
    var countPlace: Int             //Количество мест
    var helf: Double                //Вес
    var size: Double                //Объем
    var height: Double?
    var lenght: Double?
    var width: Double?
    var helfTarif: Double       //Тариф за кг
    var egTarif: Double         //Тариф за единицу груза
    var oformlenie: Double      //Стоимость оформления за место
    var oformlenieCost: Double  //Общая стоимость оформления
    var deliveryCost: Double    //Стоимость перевозки
    var documentCost: Double
    var comment: String         //Ход расчета
    
}

struct DopUslugaClassificationModelTest: Codable {
    var classification: Int     //Код категории
    var name: String            //Наименование категории
    var dopUsluga: [DopUslugaModelTest]
}

struct DopUslugaModelTest:Codable {
    var uslugaId: String        //Id доп. услуги
    var name: String            //Наименование доп. услуги
    var cost: Double            //decimal? cost; //Стоимость доп. услуги
    var count: Int              //Количество услуг
    var classification: Int
    var minWidth: Double        //decimal
    var maxWidth:Double         //decimal
    var summa: Double           //decimal  Общая стоимость доп. услуги
    var comment: String
    var currency: Int       //Валюта
}
*/
