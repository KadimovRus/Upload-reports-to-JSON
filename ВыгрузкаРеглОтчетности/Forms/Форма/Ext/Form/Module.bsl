﻿&НаСервере   
// Структура для записи всех видов надбавок
Перем ПереченьНадбавок;

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ЗаполнитьСписокОтчетов();
	ЗаполнитьОтборВидовОтчетов();
КонецПроцедуры               

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	УстановитьОтборы();
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовФормы

&НаКлиенте
Процедура ИспользоватьОтборПоПериодуПриИзменении(Элемент)
	УстановитьОтборы();
КонецПроцедуры

&НаКлиенте
Процедура РабочийПериодПриИзменении(Элемент)
	ИспользоватьОтборПоПериоду = (РабочийПериод <> Дата("00010101000000"));
	УстановитьОтборы();
КонецПроцедуры

&НаКлиенте
Процедура ИспользоватьОтборПоОрганизацииПриИзменении(Элемент)
	УстановитьОтборы();
КонецПроцедуры

&НаКлиенте
Процедура ОтборПоОрганизацииПриИзменении(Элемент)
	ИспользоватьОтборПоОрганизации = ОтборПоОрганизации.Количество() > 0;
	УстановитьОтборы();
КонецПроцедуры

&НаКлиенте
Процедура ИспользоватьОтборПоОтчетамПриИзменении(Элемент) 
	Если Не ИспользоватьОтборПоОтчетам Тогда
		ЗаполнитьОтборВидовОтчетов();
	Иначе
		ОбновитьОтборВидОтчетов();
	КонецЕсли;
	УстановитьОтборы();
КонецПроцедуры

&НаКлиенте
Процедура ДеревоВидовОтчетовПриИзменении(Элемент)
	УстановитьОтборы();
КонецПроцедуры

&НаКлиенте
Процедура ИспользоватьОтборПоВидуРасходаПриИзменении(Элемент)
	УстановитьОтборы();
КонецПроцедуры

&НаКлиенте
Процедура ОтборПоВидуРасходовПриИзменении(Элемент)
	ИспользоватьОтборПоВидуРасхода = ОтборПоВидуРасходов.Количество() > 0;
	УстановитьОтборы();
КонецПроцедуры

&НаКлиенте
Процедура ИспользоватьОтборПоРазделуПриИзменении(Элемент)
	УстановитьОтборы();
КонецПроцедуры

&НаКлиенте
Процедура ОтборПоРазделуПриИзменении(Элемент)
	ИспользоватьОтборПоРазделу = ОтборПоРазделу.Количество() > 0;
	УстановитьОтборы();
КонецПроцедуры

&НаКлиенте
Процедура ДеревоВидовОтчетовИспользоватьПриИзменении(Элемент)
	Если ИспользоватьОтборПоОтчетам Тогда
		ОбновитьОтборВидОтчетов();
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура Выгрузить(Команда)
	
	ПодготовитьТаблицуОтчетов(); 
		
	Сообщение = Новый СообщениеПользователю;
	Сообщение.Текст = "Начало обработки данных " + ТекущаяДата();
	Сообщение.Сообщить();
	
	ВыгрузитьНаСервере();
	
	Сообщение.Текст = "Обработка завершена " + ТекущаяДата();
	Сообщение.Сообщить();  
	
	Сообщение.Текст = "Начата запись файлов " + ТекущаяДата();
	Сообщение.Сообщить();
	
	Для Каждого стр Из ТаблицаОтчетов Цикл		
		ПараметрыОтчета = Новый Структура;
		ПараметрыОтчета.Вставить("ВидОтчета", КодСправочника(стр.ВидОтчета));
		ПараметрыОтчета.Вставить("Период", стр.ФинансовыйПериод);
		ПараметрыОтчета.Вставить("КодОрганизации",  КодСправочника(стр.Организация));
		ПараметрыОтчета.Вставить("Отчет", стр.РегламентированныйОтчет);
		ДвоничныеДанные = стр.ДанныеФайла; 
		ИмяФайла = ИмяФайла(ПараметрыОтчета); 
		ИмяФайла = КаталогВыгрузки + "\" + ИмяФайла + ".zip";
		ДвоничныеДанные.Записать(ИмяФайла); 
	КонецЦикла;	         
   	
	Сообщение.Текст = "Запись файлов завершена" + ТекущаяДата(); 
	Сообщение.Сообщить(); 	
	
	ТаблицаОтчетов.Очистить();
	
КонецПроцедуры 

&НаКлиенте
Процедура КаталогВыгрузкиНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	ДиалогВыбораФайла = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.ВыборКаталога);
	
	ДиалогВыбораФайла.Каталог = ""; 
    ДиалогВыбораФайла.МножественныйВыбор = Ложь; 
    ДиалогВыбораФайла.Заголовок = "Выберите каталог"; 
	
	Если ДиалогВыбораФайла.Выбрать() Тогда
		КаталогВыгрузки = ДиалогВыбораФайла.Каталог;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура СписокОтчетовВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	ТекДанные = Элементы.СписокОтчетов.ТекущиеДанные;
	Если Элементы.СписокОтчетов.ТекущиеДанные <> Неопределено Тогда
		ПоказатьЗначение(, ТекДанные.РегламентированныйОтчет);
	КонецЕсли;
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
// Преобразование динамического списка в таблицу значений
// Тип возвращаемого значения ТаблицаЗначений
Функция СписокВТСервере()

    Схема = Элементы.СписокОтчетов.ПолучитьИсполняемуюСхемуКомпоновкиДанных();
    Настройки = Элементы.СписокОтчетов.ПолучитьИсполняемыеНастройкиКомпоновкиДанных();
    КомпоновщикМакета = Новый КомпоновщикМакетаКомпоновкиДанных();
    МакетКомпоновки = КомпоновщикМакета.Выполнить(Схема, Настройки, , , Тип("ГенераторМакетаКомпоновкиДанныхДляКоллекцииЗначений"));
    
    ПроцессорКомпоновки = Новый ПроцессорКомпоновкиДанных;
    ПроцессорКомпоновки.Инициализировать(МакетКомпоновки);
    
    ПроцессорВывода = Новый ПроцессорВыводаРезультатаКомпоновкиДанныхВКоллекциюЗначений;
    ТаблицаРезультат = ПроцессорВывода.Вывести(ПроцессорКомпоновки);
	
	Возврат ТаблицаРезультат;

КонецФункции    

&НаСервере
Функция ИмяФайла(ПараметрыОтчета)  
	
	ИмяФайла = "";
	Если ПараметрыОтчета.ВидОтчета = "001001" Тогда
		ИмяФайла = "RPDDV";	
	ИначеЕсли ПараметрыОтчета.ВидОтчета = "001002" Тогда
        ИмяФайла = "RPDDS";	
	ИначеЕсли  ПараметрыОтчета.ВидОтчета = "001003" Тогда
        ИмяФайла = "RPZP";
	Иначе
		ВызватьИсключение "Не определен тип отчета";
	КонецЕсли;

	УИД_Отчета = СтрЗаменить(ПараметрыОтчета.Отчет.УникальныйИдентификатор(), "-", "");
	
	ИмяФайла = ИмяФайла + "_" + ПараметрыОтчета.Период + "_" + ПараметрыОтчета.КодОрганизации + "_" + УИД_Отчета;
	
	Возврат ИмяФайла;
	
КонецФункции

&НаСервере
Процедура УстановитьОтборы()

	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбора(СписокОтчетов.КомпоновщикНастроек.Настройки.Отбор, "ДатаНачала", РабочийПериод.ДатаНачала, ВидСравненияКомпоновкиДанных.БольшеИлиРавно, , ИспользоватьОтборПоПериоду);
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбора(СписокОтчетов.КомпоновщикНастроек.Настройки.Отбор, "ДатаОкончания", РабочийПериод.ДатаОкончания, ВидСравненияКомпоновкиДанных.МеньшеИлиРавно, , ИспользоватьОтборПоПериоду);
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбора(СписокОтчетов.КомпоновщикНастроек.Настройки.Отбор, "Организация", ОтборПоОрганизации, ВидСравненияКомпоновкиДанных.ВСпискеПоИерархии, , ИспользоватьОтборПоОрганизации);
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбора(СписокОтчетов.КомпоновщикНастроек.Настройки.Отбор, "ВидОтчета", ОтборВидовОтчетов, ВидСравненияКомпоновкиДанных.ВСписке, , Истина);
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбора(СписокОтчетов.КомпоновщикНастроек.Настройки.Отбор, "ВидРасходов", ОтборПоВидуРасходов, ВидСравненияКомпоновкиДанных.ВСписке, , ИспользоватьОтборПоВидуРасхода);
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбора(СписокОтчетов.КомпоновщикНастроек.Настройки.Отбор, "Раздел", ОтборПоРазделу, ВидСравненияКомпоновкиДанных.ВСписке, , ИспользоватьОтборПоРазделу);
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьСписокОтчетов()
	
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ РАЗРЕШЕННЫЕ
	               |	0 КАК Использовать,
	               |	РегламентированныеОтчеты.Ссылка КАК ВидОтчета
	               |ИЗ
	               |	Справочник.РегламентированныеОтчеты КАК РегламентированныеОтчеты
	               |ГДЕ
	               |	РегламентированныеОтчеты.ПометкаУдаления = ЛОЖЬ
	               |	И РегламентированныеОтчеты.Ссылка В(&СписокОтчетов)
	               |
	               |УПОРЯДОЧИТЬ ПО
	               |	РегламентированныеОтчеты.Ссылка ИЕРАРХИЯ
	               |АВТОУПОРЯДОЧИВАНИЕ";
	
	СписокЗначений = Новый СписокЗначений;
	СписокЗначений.Добавить(Справочники.РегламентированныеОтчеты.НайтиПоКоду("001001"));
	СписокЗначений.Добавить(Справочники.РегламентированныеОтчеты.НайтиПоКоду("001002"));
	СписокЗначений.Добавить(Справочники.РегламентированныеОтчеты.НайтиПоКоду("001003"));
	Запрос.УстановитьПараметр("СписокОтчетов", СписокЗначений);
	РезультатЗапроса = Запрос.Выполнить();
	мДеревоВидовОтчетов = РезультатЗапроса.Выгрузить(ОбходРезультатаЗапроса.ПоГруппировкамСИерархией);
	ЗначениеВРеквизитФормы(мДеревоВидовОтчетов, "ДеревоВидовОтчетов");
	
КонецПроцедуры 

&НаКлиенте
Процедура ОбновитьОтборВидОтчетов()
	
	ОтборВидовОтчетов.Очистить();	
	ПолучитьСписокВыбранныхЭлементовРекурсивно(ДеревоВидовОтчетов.ПолучитьЭлементы());
	
КонецПроцедуры	

&НаКлиенте
Процедура ПолучитьСписокВыбранныхЭлементовРекурсивно(КоллекцияЭлементов)

	Для Каждого ЭлементДерева Из КоллекцияЭлементов Цикл
		
		Если ЭлементДерева.Использовать = 1 Тогда
			ОтборВидовОтчетов.Добавить(ЭлементДерева.ВидОтчета);			
		КонецЕсли;
		
	КонецЦикла;

КонецПроцедуры // ПолучитьСписокВыбранныхЭлементов() 

&НаСервере
Процедура ЗаполнитьОтборВидовОтчетов()
	
	ОтборВидовОтчетов.Очистить();
	ОтборВидовОтчетов.Добавить(Справочники.РегламентированныеОтчеты.НайтиПоКоду("001001"));
	ОтборВидовОтчетов.Добавить(Справочники.РегламентированныеОтчеты.НайтиПоКоду("001002"));
	ОтборВидовОтчетов.Добавить(Справочники.РегламентированныеОтчеты.НайтиПоКоду("001003"));
	
КонецПроцедуры

&НаСервере
Процедура ВыгрузитьНаСервере() 	
	
	ЗаполнитьТаблицыНадбавок();
	
	ОтчетОбъект = РеквизитФормыВЗначение("Обработка");	
	
    Индикатор = 0;
	КоличествоОтчетов = ТаблицаОтчетов.Количество();
		
	Для инд = 0 По КоличествоОтчетов - 1 Цикл
	
		стр = ТаблицаОтчетов[инд];
		
		СписокСохранения = стр.РегламентированныйОтчет.ДанныеОтчета.Получить(); 
		
		Показатели = СписокСохранения.ПоказателиОтчета;
		ДанныеПоРазделам = СписокСохранения.ДанныеМногострочныхРазделов; 
		
		ОтчетСсылка = стр.РегламентированныйОтчет;
		ДанныеОтчета = Новый Структура;
		ДанныеОтчета.Вставить("Организация", стр.Организация);
		ДанныеОтчета.Вставить("Период", стр.ФинансовыйПериод);
		ДанныеОтчета.Вставить("ВидОтчета", стр.ВидОтчета.Код);
		ДанныеОтчета.Вставить("Раздел", ОтчетСсылка.РазделПодраздел); 
		ДанныеОтчета.Вставить("КодРаздела", ОтчетСсылка.РазделПодраздел.Код);
		ДанныеОтчета.Вставить("ВидРасходов", ОтчетСсылка.ВидРасходов); 
		ДанныеОтчета.Вставить("КодВидаРасходов", ОтчетСсылка.ВидРасходов.Код);
		ДанныеОтчета.Вставить("Документ", ОтчетСсылка);
		ДанныеОтчета.Вставить("ПеречниНадбавок", ПереченьНадбавок);
		
		ДанныеОтчета.Вставить("ДанныеПоРазделам", ДанныеПоРазделам); 
		ДанныеОтчета.Вставить("Показатели", Показатели);
		
		Адрес = ОтчетОбъект.РезультатПреобразования(ДанныеОтчета);
		стр.ДанныеФайла = ПолучитьИзВременногоХранилища(Адрес);
		
		Индикатор = (Инд + 1) / КоличествоОтчетов * 100;
		
	КонецЦикла;		
		
КонецПроцедуры

&НаСервере
Функция КодСправочника(ЭлементСправочника)
	
	Возврат ЭлементСправочника.Код;
	
КонецФункции

&НаСервере
Процедура ПодготовитьТаблицуОтчетов()
	
	ТаблицаОтчетов.Загрузить(СписокВТСервере());

КонецПроцедуры

&НаСервере
Процедура ЗаполнитьТаблицыНадбавок()
	
	ПереченьНадбавок = Новый Структура();

	ЗаполнитьТаблицыНадбавокОбщие();
	ЗаполнитьТаблицыНадбавокВоен(); 
	ЗаполнитьТаблицыНадбавокСотр();
	ЗаполнитьТаблицыНадбавокГражданские();
			
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьТаблицыНадбавокОбщие()
	
	ТекДата = ТекущаяДатаСеанса();

	// Особые условия		
	Запрос = Новый Запрос;
	Запрос.Текст = ТекстЗапросаНадбавкаОсобыеУсловия();	
	Запрос.УстановитьПараметр("Дата", ТекДата);	
	ПереченьНадбавок.Вставить("ПереченьНадбавокОсобыеУсловия", Запрос.Выполнить().Выгрузить());
	
    // Поощрительные		
	Запрос.Текст = ТекстЗапросаНадбавкаПоощрительные();
	ПереченьНадбавок.Вставить("ПереченьНадбавокПоощрения", Запрос.Выполнить().Выгрузить());
	
	// Районный коэффициент	
	Запрос.Текст =  ТекстЗапросаРайонныйКоэффициент();	
	ПереченьНадбавок.Вставить("ПереченьНадбавокРайКоэффициент", Запрос.Выполнить().Выгрузить());
	
	// Северная надбавка	
	Запрос.Текст = ТекстЗапросаНадбавкаСеверная();	
	ПереченьНадбавок.Вставить("ПереченьНадбавокСеверная", Запрос.Выполнить().Выгрузить());
	
	// Юридическая надбавка	
	Запрос.Текст = ТекстЗапросаНадбавкаЮридическая();
	ПереченьНадбавок.Вставить("ПереченьНадбавокЮридическая", Запрос.Выполнить().Выгрузить());	
	
	// Доплата за риск	
	Запрос.Текст = ТекстЗапросаНадбавкаЗаРиск();	
	ПереченьНадбавок.Вставить("ПереченьНадбавокДоплатаЗаРиск", Запрос.Выполнить().Выгрузить());

	// Служба в СКР	
	Запрос.Текст = ТекстЗапросаНадбавкаСКР();	
	ПереченьНадбавок.Вставить("ПереченьНадбавокСлужбаСКР", Запрос.Выполнить().Выгрузить());

КонецПроцедуры

&НаСервере
Процедура ЗаполнитьТаблицыНадбавокВоен()
	
	ТекДата = ТекущаяДатаСеанса();	
	КатегорияВоен = Перечисления.гндлф_КатегорииСотрудниковДля3ОБ.ВСЛ;
	
	// Увел окладов 
	Запрос = Новый Запрос;
	Запрос.Текст = ТекстЗапросаУвеличОкладов();	
	Запрос.УстановитьПараметр("Дата", ТекДата);
	Запрос.УстановитьПараметр("КатегорияСотрудников", КатегорияВоен);
	
	ПереченьНадбавок.Вставить("ПереченьНадбавокУвеличениеОкладовВоен", Запрос.Выполнить().Выгрузить());	
	
	// Выслуга лет
	Запрос.Текст = ТекстЗапросаНадбавкаВыслугаЛет();	
	ПереченьНадбавок.Вставить("ПереченьНадбавокВыслугаЛетВоен", Запрос.Выполнить().Выгрузить());
	
	// Классность
	Запрос.Текст = ТекстЗапросаНадбавкаКлассность();	
	ПереченьНадбавок.Вставить("ПереченьНадбавокКлассностьВоен", Запрос.Выполнить().Выгрузить());
	
	// Гостайна	
	Запрос.Текст = ТекстЗапросаНадбавкаГостайна();
	ПереченьНадбавок.Вставить("ПереченьНадбавокГостайнаВоен", Запрос.Выполнить().Выгрузить());
	
	// Стаж гостайны
	Запрос.Текст = ТекстЗапросаНадбавкаСтажГосТайны();	
	ПереченьНадбавок.Вставить("ПереченьНадбавокСтажГостайнаВоен", Запрос.Выполнить().Выгрузить());
	
	// Стаж шифр
	Запрос.Текст = ТекстЗапросаНадбавкаСтажШифровальщики();
	ПереченьНадбавок.Вставить("ПереченьНадбавокСтажШифрВоен", Запрос.Выполнить().Выгрузить()); 

КонецПроцедуры

&НаСервере
Процедура ЗаполнитьТаблицыНадбавокСотр()
	
	ТекДата = ТекущаяДатаСеанса();	
	КатегорияСотрудники = Перечисления.гндлф_КатегорииСотрудниковДля3ОБ.СОТР;
	
	// Увеличение окладов МО 
	Запрос = Новый Запрос;
	Запрос.Текст = ТекстЗапросаУвеличОкладовМО();                          
	Запрос.УстановитьПараметр("Дата", ТекДата);
	Запрос.УстановитьПараметр("КатегорияСотрудников", КатегорияСотрудники);	
	ПереченьНадбавок.Вставить("ПереченьНадбавокУвеличОкладовМОСотр", Запрос.Выполнить().Выгрузить());	
	
	// Увел окладов 
	Запрос.Текст = ТекстЗапросаУвеличОкладов();	
	ПереченьНадбавок.Вставить("ПереченьНадбавокУвеличениеОкладовСотр", Запрос.Выполнить().Выгрузить());	
	
	// Выслуга лет
	Запрос.Текст = ТекстЗапросаНадбавкаВыслугаЛет();	
	ПереченьНадбавок.Вставить("ПереченьНадбавокВыслугаЛетСотр", Запрос.Выполнить().Выгрузить());
	
	// Классность
	Запрос.Текст = ТекстЗапросаНадбавкаКлассность();	
	ПереченьНадбавок.Вставить("ПереченьНадбавокКлассностьСотр", Запрос.Выполнить().Выгрузить());
	
	// Гостайна	
	Запрос.Текст = ТекстЗапросаНадбавкаГостайна();
	ПереченьНадбавок.Вставить("ПереченьНадбавокГостайнаСотр", Запрос.Выполнить().Выгрузить());	
			
	// Стаж гостайны
	Запрос.Текст = ТекстЗапросаНадбавкаСтажГосТайны();	
	ПереченьНадбавок.Вставить("ПереченьНадбавокСтажГостайнаСотр", Запрос.Выполнить().Выгрузить());
	
	// Стаж шифр
	Запрос.Текст = ТекстЗапросаНадбавкаСтажШифровальщики();	
	ПереченьНадбавок.Вставить("ПереченьНадбавокСтажШифрСотр", Запрос.Выполнить().Выгрузить()); 

КонецПроцедуры

&НаСервере
Процедура ЗаполнитьТаблицыНадбавокГражданские()
	
	ТекДата = ТекущаяДатаСеанса();
	КатегорияГраждане = Перечисления.гндлф_КатегорииСотрудниковДля3ОБ.ГП;
	
	// Надбавка за знание языков
	Запрос = Новый Запрос;
	Запрос.Текст = ТекстЗапросаНадбавкаЗаЗнаниеИностранныхЯзыков();
	
	Запрос.УстановитьПараметр("Дата", ТекДата);
	Запрос.УстановитьПараметр("КатегорияСотрудников", КатегорияГраждане); 
	ПереченьНадбавок.Вставить("ПереченьНадбавокЗаЗнаниеИностранногоГражд", Запрос.Выполнить().Выгрузить());
	
	// Водителям за категорию	
	Запрос.Текст = ТекстЗапросаНадбавкаВодителямЗаКатегорию();	
	ПереченьНадбавок.Вставить("ПереченьНадбавокВодителямЗаКатегориюГражд", Запрос.Выполнить().Выгрузить()); 
	
	// Почетное звание/степень	
	Запрос.Текст = ТекстЗапросаНадбавкаЗаПочетноеЗвание();	
	ПереченьНадбавок.Вставить("ПереченьНадбавокЗаПочетноеЗваниеГражд", Запрос.Выполнить().Выгрузить()); 
	
	// Мед и фарм работникам 
	Запрос.Текст = ТекстЗапросаНадбавкаМедИФармРаботникам();	
	ПереченьНадбавок.Вставить("ПереченьНадбавокМедИФармРаботникамГражд", Запрос.Выполнить().Выгрузить()); 
	
	// Выслуга лет
	Запрос.Текст = ТекстЗапросаНадбавкаВыслугаЛет();	
	ПереченьНадбавок.Вставить("ПереченьНадбавокВыслугаЛетГражд", Запрос.Выполнить().Выгрузить()); 
	
	// Мед. стаж
	Запрос.Текст = ТекстЗапросаНадбавкаРаботникамМедОрганизацийЗаСтаж();	
	ПереченьНадбавок.Вставить("ПереченьНадбавокМедСтажГражд", Запрос.Выполнить().Выгрузить()); 
	
	// Работа во вредных условиях                           
	Запрос.Текст = ТекстЗапросаДоплатаГПЗаВредныеИОпасныеУсловия();	
	ПереченьНадбавок.Вставить("ПереченьНадбавокЗаРаботуВоВредныхИОпасныхУсловияхГражд", Запрос.Выполнить().Выгрузить()); 
	
	//  Руководство бригадой                                  
	Запрос.Текст = ТекстЗапросаНадбавкаРуководствоБригадой();	
	ПереченьНадбавок.Вставить("ПереченьНадбавокРуководствоБригадойГражд", Запрос.Выполнить().Выгрузить()); 
	
	// Водителям                                                                      
	Запрос.Текст = ТекстЗапросаНадбавкаВодителям();
	ПереченьНадбавок.Вставить("ПереченьНадбавокВодителямГражд", Запрос.Выполнить().Выгрузить());	
	
	// Гостайна  
	Запрос.Текст = ТекстЗапросаНадбавкаГостайна();
	ПереченьНадбавок.Вставить("ПереченьНадбавокГостайнаГражд", Запрос.Выполнить().Выгрузить());	
	
	// Стаж гостайна
	Запрос.Текст = ТекстЗапросаНадбавкаСтажГосТайны();                                          
	ПереченьНадбавок.Вставить("ПереченьНадбавокСтажГостайнаГражд", Запрос.Выполнить().Выгрузить());	
	
	// Шифр
	Запрос.Текст = ТекстЗапросаНадбавкаШифрГражд();
	ПереченьНадбавок.Вставить("ПереченьНадбавокШифрГражд", Запрос.Выполнить().Выгрузить());	
	
КонецПроцедуры 

#Область ТекстыЗапросовНадбавок

&НаСервереБезКонтекста
Функция ТекстЗапросаНадбавкаОсобыеУсловия()
	
	Текст = 
		"ВЫБРАТЬ
		|	Справочникгндлф_ПроцентНадбавкиЗаОсобыеУсловия.Код КАК Код,
		|	Справочникгндлф_ПроцентНадбавкиЗаОсобыеУсловия.Наименование КАК Наименование,
		|	Справочникгндлф_ПроцентНадбавкиЗаОсобыеУсловия.ИмяПредопределенныхДанных КАК Имя,
		|	ЕСТЬNULL(гндлф_НадбавкаЗаОсобыеУсловияСрезПоследних.Размер, 0) КАК Размер
		|ИЗ
		|	Справочник.гндлф_ПроцентНадбавкиЗаОсобыеУсловия КАК Справочникгндлф_ПроцентНадбавкиЗаОсобыеУсловия
		|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.гндлф_НадбавкаЗаОсобыеУсловия.СрезПоследних(&Дата, ) КАК гндлф_НадбавкаЗаОсобыеУсловияСрезПоследних
		|		ПО (гндлф_НадбавкаЗаОсобыеУсловияСрезПоследних.ПроцентНадбавки = Справочникгндлф_ПроцентНадбавкиЗаОсобыеУсловия.Ссылка)
		|ГДЕ
		|	ЕСТЬNULL(гндлф_НадбавкаЗаОсобыеУсловияСрезПоследних.Размер, 0) > 0";

	Возврат Текст;
	
КонецФункции 

&НаСервереБезКонтекста
Функция ТекстЗапросаНадбавкаПоощрительные()
	
	Текст = 
		"ВЫБРАТЬ
		|	Справочникгндлф_ПроцентВыплатыЗаОсобыеДостижения.Код КАК Код,
		|	Справочникгндлф_ПроцентВыплатыЗаОсобыеДостижения.Наименование КАК Наименование,
		|	Справочникгндлф_ПроцентВыплатыЗаОсобыеДостижения.ИмяПредопределенныхДанных КАК Имя,
		|	ЕСТЬNULL(гндлф_ВыплатаЗаОсобыеДостиженияСрезПоследних.Размер, 0) КАК Размер
		|ИЗ
		|	Справочник.гндлф_ПроцентВыплатыЗаОсобыеДостижения КАК Справочникгндлф_ПроцентВыплатыЗаОсобыеДостижения
		|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.гндлф_ВыплатаЗаОсобыеДостижения.СрезПоследних(&Дата, ) КАК гндлф_ВыплатаЗаОсобыеДостиженияСрезПоследних
		|		ПО Справочникгндлф_ПроцентВыплатыЗаОсобыеДостижения.Ссылка = гндлф_ВыплатаЗаОсобыеДостиженияСрезПоследних.ПроцентВыплаты
		|ГДЕ
		|	ЕСТЬNULL(гндлф_ВыплатаЗаОсобыеДостиженияСрезПоследних.Размер, 0) > 0";

	Возврат Текст;
	
КонецФункции 

&НаСервереБезКонтекста
Функция ТекстЗапросаРайонныйКоэффициент()
	
	Текст = 
		"ВЫБРАТЬ
		|	Справочникгндлф_ПроцентРайонногоКоэффициента.Код КАК Код,
		|	Справочникгндлф_ПроцентРайонногоКоэффициента.Наименование КАК Наименование,
		|	Справочникгндлф_ПроцентРайонногоКоэффициента.ИмяПредопределенныхДанных КАК Имя,
		|	ЕСТЬNULL(гндлф_РайонныйКоэффициентСрезПоследних.Размер, 0) КАК Размер
		|ИЗ
		|	Справочник.гндлф_ПроцентРайонногоКоэффициента КАК Справочникгндлф_ПроцентРайонногоКоэффициента
		|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.гндлф_РайонныйКоэффициент.СрезПоследних(&Дата, ) КАК гндлф_РайонныйКоэффициентСрезПоследних
		|		ПО (гндлф_РайонныйКоэффициентСрезПоследних.ПроцентРайонногоКоэффициента = Справочникгндлф_ПроцентРайонногоКоэффициента.Ссылка)
		|ГДЕ
		|	ЕСТЬNULL(гндлф_РайонныйКоэффициентСрезПоследних.Размер, 0) > 0";

	Возврат Текст;
	
КонецФункции 

&НаСервереБезКонтекста
Функция ТекстЗапросаНадбавкаСеверная()
	
	Текст = 
		"ВЫБРАТЬ
		|	Справочникгндлф_ПроцентСевернойНадбавки.Код КАК Код,
		|	Справочникгндлф_ПроцентСевернойНадбавки.Наименование КАК Наименование,
		|	Справочникгндлф_ПроцентСевернойНадбавки.ИмяПредопределенныхДанных КАК Имя,
		|	ЕСТЬNULL(гндлф_НадбавкаЗаСлужбуНаСевереСрезПоследних.Размер, 0) КАК Размер
		|ИЗ
		|	Справочник.гндлф_ПроцентСевернойНадбавки КАК Справочникгндлф_ПроцентСевернойНадбавки
		|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.гндлф_НадбавкаЗаСлужбуНаСевере.СрезПоследних(&Дата, ) КАК гндлф_НадбавкаЗаСлужбуНаСевереСрезПоследних
		|		ПО (гндлф_НадбавкаЗаСлужбуНаСевереСрезПоследних.ПроцентНадбавки = Справочникгндлф_ПроцентСевернойНадбавки.Ссылка)
		|ГДЕ
		|	ЕСТЬNULL(гндлф_НадбавкаЗаСлужбуНаСевереСрезПоследних.Размер, 0) > 0";

	Возврат Текст;
	
КонецФункции 

&НаСервереБезКонтекста
Функция ТекстЗапросаНадбавкаЮридическая()
	
	Текст = 
		"ВЫБРАТЬ
		|	Справочникгндлф_ПроцентЮридическойНадбавки.Код КАК Код,
		|	Справочникгндлф_ПроцентЮридическойНадбавки.Наименование КАК Наименование,
		|	Справочникгндлф_ПроцентЮридическойНадбавки.ИмяПредопределенныхДанных КАК Имя,
		|	ЕСТЬNULL(гндлф_НадбавкаЮридическихПодразделенийСрезПоследних.Размер, 0) КАК Размер
		|ИЗ
		|	Справочник.гндлф_ПроцентЮридическойНадбавки КАК Справочникгндлф_ПроцентЮридическойНадбавки
		|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.гндлф_НадбавкаЮридическихПодразделений.СрезПоследних(&Дата, ) КАК гндлф_НадбавкаЮридическихПодразделенийСрезПоследних
		|		ПО (гндлф_НадбавкаЮридическихПодразделенийСрезПоследних.ПроцентНадбавки = Справочникгндлф_ПроцентЮридическойНадбавки.Ссылка)
		|ГДЕ
		|	ЕСТЬNULL(гндлф_НадбавкаЮридическихПодразделенийСрезПоследних.Размер, 0) > 0";

	Возврат Текст;
	
КонецФункции 

&НаСервереБезКонтекста
Функция ТекстЗапросаНадбавкаЗаРиск()
	
	Текст = 
		"ВЫБРАТЬ
		|	Справочникгндлф_ПроцентНадбавкиЗаРиск.Код КАК Код,
		|	Справочникгндлф_ПроцентНадбавкиЗаРиск.Наименование КАК Наименование,
		|	Справочникгндлф_ПроцентНадбавкиЗаРиск.ИмяПредопределенныхДанных КАК ИмяПредопределенныхДанных,
		|	ЕСТЬNULL(гндлф_НадбавкаЗаРискСрезПоследних.Размер, 0) КАК Размер
		|ИЗ
		|	Справочник.гндлф_ПроцентНадбавкиЗаРиск КАК Справочникгндлф_ПроцентНадбавкиЗаРиск
		|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.гндлф_НадбавкаЗаРиск.СрезПоследних(&Дата, ) КАК гндлф_НадбавкаЗаРискСрезПоследних
		|		ПО (гндлф_НадбавкаЗаРискСрезПоследних.ПроцентНадбавки = Справочникгндлф_ПроцентНадбавкиЗаРиск.Ссылка)
		|ГДЕ
		|	ЕСТЬNULL(гндлф_НадбавкаЗаРискСрезПоследних.Размер, 0) > 0";

	Возврат Текст;
	
КонецФункции 

&НаСервереБезКонтекста
Функция ТекстЗапросаНадбавкаСКР()
	
	Текст = 
		"ВЫБРАТЬ
		|	Справочникгндлф_ОснованиеНадбавкиСКР.Код КАК Код,
		|	Справочникгндлф_ОснованиеНадбавкиСКР.Наименование КАК Наименование,
		|	Справочникгндлф_ОснованиеНадбавкиСКР.ИмяПредопределенныхДанных КАК Имя,
		|	ЕСТЬNULL(гндлф_НадбавкаСКРСрезПоследних.Размер, 0) КАК Размер
		|ИЗ
		|	Справочник.гндлф_ОснованиеНадбавкиСКР КАК Справочникгндлф_ОснованиеНадбавкиСКР
		|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.гндлф_НадбавкаСКР.СрезПоследних(&Дата, ) КАК гндлф_НадбавкаСКРСрезПоследних
		|		ПО (гндлф_НадбавкаСКРСрезПоследних.Основание = Справочникгндлф_ОснованиеНадбавкиСКР.Ссылка)
		|ГДЕ
		|	ЕСТЬNULL(гндлф_НадбавкаСКРСрезПоследних.Размер, 0) > 0";

	Возврат Текст;
	
КонецФункции 

&НаСервереБезКонтекста
Функция ТекстЗапросаУвеличОкладовМО()
	
	Текст = 
		"ВЫБРАТЬ
		|	Справочникгндлф_КвалРазрядВМОиЛО.Код КАК Код,
		|	Справочникгндлф_КвалРазрядВМОиЛО.Наименование КАК Наименование,
		|	Справочникгндлф_КвалРазрядВМОиЛО.ИмяПредопределенныхДанных КАК Имя,
		|	ЕСТЬNULL(гндлф_УвеличениеДОвМОиЛОСрезПоследних.Размер, 0) КАК Размер
		|ИЗ
		|	Справочник.гндлф_КвалРазрядВМОиЛО КАК Справочникгндлф_КвалРазрядВМОиЛО
		|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.гндлф_УвеличениеДОвМОиЛО.СрезПоследних(&Дата, Категория = &КатегорияСотрудников) КАК гндлф_УвеличениеДОвМОиЛОСрезПоследних
		|		ПО (гндлф_УвеличениеДОвМОиЛОСрезПоследних.КвалификационныйРазряд = Справочникгндлф_КвалРазрядВМОиЛО.Ссылка)
		|ГДЕ
		|	гндлф_УвеличениеДОвМОиЛОСрезПоследних.Размер > 0";

	Возврат Текст;
	
КонецФункции 

&НаСервереБезКонтекста
Функция ТекстЗапросаУвеличОкладов()
	
	Текст = 
		"ВЫБРАТЬ
		|	Справочникгндлф_КвалРазрядЛетчиков.Код КАК Код,
		|	Справочникгндлф_КвалРазрядЛетчиков.ИмяПредопределенныхДанных КАК Имя,
		|	ЕСТЬNULL(гндлф_УвеличениеДОЛетчиковСрезПоследних.Размер, 0) КАК Размер,
		|	Справочникгндлф_КвалРазрядЛетчиков.Наименование КАК Наименование
		|ИЗ
		|	Справочник.гндлф_КвалРазрядЛетчиков КАК Справочникгндлф_КвалРазрядЛетчиков
		|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.гндлф_УвеличениеДОЛетчиков.СрезПоследних(&Дата, Категория = &КатегорияСотрудников) КАК гндлф_УвеличениеДОЛетчиковСрезПоследних
		|		ПО (гндлф_УвеличениеДОЛетчиковСрезПоследних.КвалификационныйРазряд = Справочникгндлф_КвалРазрядЛетчиков.Ссылка)
		|ГДЕ
		|	ЕСТЬNULL(гндлф_УвеличениеДОЛетчиковСрезПоследних.Размер, 0) > 0";

	Возврат Текст;
	
КонецФункции 

&НаСервереБезКонтекста
Функция ТекстЗапросаНадбавкаКлассность()
	
	Текст = 
		"ВЫБРАТЬ
		|	Справочникгндлф_КвалЗвание.Код КАК Код,
		|	Справочникгндлф_КвалЗвание.Наименование КАК Наименование,
		|	Справочникгндлф_КвалЗвание.ИмяПредопределенныхДанных КАК Имя,
		|	ЕСТЬNULL(гндлф_НадбавкаЗаКвалификационноеЗваниеСрезПоследних.Размер, 0) КАК Размер
		|ИЗ
		|	Справочник.гндлф_КвалЗвание КАК Справочникгндлф_КвалЗвание
		|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.гндлф_НадбавкаЗаКвалификационноеЗвание.СрезПоследних(&Дата, Категория = &КатегорияСотрудников) КАК гндлф_НадбавкаЗаКвалификационноеЗваниеСрезПоследних
		|		ПО (гндлф_НадбавкаЗаКвалификационноеЗваниеСрезПоследних.КвалификационноеЗвание = Справочникгндлф_КвалЗвание.Ссылка)
		|ГДЕ
		|	ЕСТЬNULL(гндлф_НадбавкаЗаКвалификационноеЗваниеСрезПоследних.Размер, 0) > 0";

	Возврат Текст;
	
КонецФункции 

&НаСервереБезКонтекста
Функция ТекстЗапросаНадбавкаСтажГосТайны()
	
	Текст = 
		"ВЫБРАТЬ
		|	Справочникгндлф_СтажГосТайны.Код КАК Код,
		|	Справочникгндлф_СтажГосТайны.Наименование КАК Наименование,
		|	Справочникгндлф_СтажГосТайны.ИмяПредопределенныхДанных КАК Имя,
		|	ЕСТЬNULL(гндлф_НадбавкаЗаСтажЗащитыГосТайныСрезПоследних.Размер, 0) КАК Размер
		|ИЗ
		|	Справочник.гндлф_СтажГосТайны КАК Справочникгндлф_СтажГосТайны
		|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.гндлф_НадбавкаЗаСтажЗащитыГосТайны.СрезПоследних(&Дата, Категория = &КатегорияСотрудников) КАК гндлф_НадбавкаЗаСтажЗащитыГосТайныСрезПоследних
		|		ПО (гндлф_НадбавкаЗаСтажЗащитыГосТайныСрезПоследних.ПроцентНадбавки = Справочникгндлф_СтажГосТайны.Ссылка)
		|ГДЕ
		|	ЕСТЬNULL(гндлф_НадбавкаЗаСтажЗащитыГосТайныСрезПоследних.Размер, 0) > 0";

	Возврат Текст;
	
КонецФункции 

&НаСервереБезКонтекста
Функция ТекстЗапросаНадбавкаСтажШифровальщики()
	
	Текст = 
		"ВЫБРАТЬ
		|	Справочникгндлф_СтажШифровальщики.Код КАК Код,
		|	Справочникгндлф_СтажШифровальщики.Наименование КАК Наименование,
		|	Справочникгндлф_СтажШифровальщики.ИмяПредопределенныхДанных КАК Имя,
		|	ЕСТЬNULL(гндлф_НадбавкаЗаСтажШифровальщикиСрезПоследних.Размер, 0) КАК Размер
		|ИЗ
		|	Справочник.гндлф_СтажШифровальщики КАК Справочникгндлф_СтажШифровальщики
		|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.гндлф_НадбавкаЗаСтажШифровальщики.СрезПоследних(&Дата, Категория = &КатегорияСотрудников) КАК гндлф_НадбавкаЗаСтажШифровальщикиСрезПоследних
		|		ПО (гндлф_НадбавкаЗаСтажШифровальщикиСрезПоследних.Стаж = Справочникгндлф_СтажШифровальщики.Ссылка)
		|ГДЕ
		|	ЕСТЬNULL(гндлф_НадбавкаЗаСтажШифровальщикиСрезПоследних.Размер, 0) > 0";

	Возврат Текст;
	
КонецФункции 

&НаСервереБезКонтекста
Функция ТекстЗапросаНадбавкаЗаЗнаниеИностранныхЯзыков()
	
	Текст = 
		"ВЫБРАТЬ
		|	Справочникгндлф_НадбавкаЗаЗнаниеИностранныхЯзыков.Код КАК Код,
		|	Справочникгндлф_НадбавкаЗаЗнаниеИностранныхЯзыков.Наименование КАК Наименование,
		|	Справочникгндлф_НадбавкаЗаЗнаниеИностранныхЯзыков.ИмяПредопределенныхДанных КАК ИмяПредопределенныхДанных,
		|	ЕСТЬNULL(гндлф_НадбавкаЗаЗнаниеИностранныхЯзыковСрезПоследних.Размер, 0) КАК Размер
		|ИЗ
		|	Справочник.гндлф_НадбавкаЗаЗнаниеИностранныхЯзыков КАК Справочникгндлф_НадбавкаЗаЗнаниеИностранныхЯзыков
		|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.гндлф_НадбавкаЗаЗнаниеИностранныхЯзыков.СрезПоследних(&Дата, Категория = &КатегорияСотрудников) КАК гндлф_НадбавкаЗаЗнаниеИностранныхЯзыковСрезПоследних
		|		ПО (гндлф_НадбавкаЗаЗнаниеИностранныхЯзыковСрезПоследних.Надбавка = Справочникгндлф_НадбавкаЗаЗнаниеИностранныхЯзыков.Ссылка)
		|ГДЕ
		|	ЕСТЬNULL(гндлф_НадбавкаЗаЗнаниеИностранныхЯзыковСрезПоследних.Размер, 0) > 0";

	Возврат Текст;
	
КонецФункции 

&НаСервереБезКонтекста
Функция ТекстЗапросаНадбавкаВодителямЗаКатегорию()
	
	Текст = 
		"ВЫБРАТЬ
		|	Справочникгндлф_НадбавкаВодителямЗаКатегорию.Код КАК Код,
		|	Справочникгндлф_НадбавкаВодителямЗаКатегорию.Наименование КАК Наименование,
		|	Справочникгндлф_НадбавкаВодителямЗаКатегорию.Предопределенный КАК Предопределенный,
		|	ЕСТЬNULL(гндлф_НадбавкаВодителямЗаКатегориюСрезПоследних.Размер, 0) КАК Размер
		|ИЗ
		|	Справочник.гндлф_НадбавкаВодителямЗаКатегорию КАК Справочникгндлф_НадбавкаВодителямЗаКатегорию
		|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.гндлф_НадбавкаВодителямЗаКатегорию.СрезПоследних(&Дата, Категория = &КатегорияСотрудников) КАК гндлф_НадбавкаВодителямЗаКатегориюСрезПоследних
		|		ПО (гндлф_НадбавкаВодителямЗаКатегориюСрезПоследних.Надбавка = Справочникгндлф_НадбавкаВодителямЗаКатегорию.Ссылка)
		|ГДЕ
		|	ЕСТЬNULL(гндлф_НадбавкаВодителямЗаКатегориюСрезПоследних.Размер, 0) > 0";

	Возврат Текст;
	
КонецФункции 

&НаСервереБезКонтекста
Функция ТекстЗапросаНадбавкаЗаПочетноеЗвание()
	
	Текст = 
		"ВЫБРАТЬ
		|	Справочникгндлф_НадбавкаЗаПочетноеЗвание.Код КАК Код,
		|	Справочникгндлф_НадбавкаЗаПочетноеЗвание.Наименование КАК Наименование,
		|	Справочникгндлф_НадбавкаЗаПочетноеЗвание.ИмяПредопределенныхДанных КАК ИмяПредопределенныхДанных,
		|	ЕСТЬNULL(гндлф_НадбавкаЗаПочетноеЗваниеСрезПоследних.Размер, 0) КАК Размер
		|ИЗ
		|	Справочник.гндлф_НадбавкаЗаПочетноеЗвание КАК Справочникгндлф_НадбавкаЗаПочетноеЗвание
		|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.гндлф_НадбавкаЗаПочетноеЗвание.СрезПоследних(&Дата, Категория = &КатегорияСотрудников) КАК гндлф_НадбавкаЗаПочетноеЗваниеСрезПоследних
		|		ПО (гндлф_НадбавкаЗаПочетноеЗваниеСрезПоследних.Надбавка = Справочникгндлф_НадбавкаЗаПочетноеЗвание.Ссылка)
		|ГДЕ
		|	НЕ Справочникгндлф_НадбавкаЗаПочетноеЗвание.Архив
		|	И ЕСТЬNULL(гндлф_НадбавкаЗаПочетноеЗваниеСрезПоследних.Размер, 0) > 0";

	Возврат Текст;
	
КонецФункции 

&НаСервереБезКонтекста
Функция ТекстЗапросаНадбавкаМедИФармРаботникам()
	
	Текст = 
		"ВЫБРАТЬ
		|	Справочникгндлф_НадбавкаМедИФармРаботникам.Код КАК Код,
		|	Справочникгндлф_НадбавкаМедИФармРаботникам.Наименование КАК Наименование,
		|	Справочникгндлф_НадбавкаМедИФармРаботникам.ИмяПредопределенныхДанных КАК ИмяПредопределенныхДанных,
		|	ЕСТЬNULL(гндлф_НадбавкаМедИФармРаботникамСрезПоследних.Размер, 0) КАК Размер
		|ИЗ
		|	Справочник.гндлф_НадбавкаМедИФармРаботникам КАК Справочникгндлф_НадбавкаМедИФармРаботникам
		|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.гндлф_НадбавкаМедИФармРаботникам.СрезПоследних(&Дата, Категория = &КатегорияСотрудников) КАК гндлф_НадбавкаМедИФармРаботникамСрезПоследних
		|		ПО (гндлф_НадбавкаМедИФармРаботникамСрезПоследних.Надбавка = Справочникгндлф_НадбавкаМедИФармРаботникам.Ссылка)
		|ГДЕ
		|	ЕСТЬNULL(гндлф_НадбавкаМедИФармРаботникамСрезПоследних.Размер, 0) > 0";

	Возврат Текст;
	
КонецФункции 

&НаСервереБезКонтекста
Функция ТекстЗапросаНадбавкаВыслугаЛет()
	
	Текст = 
		"ВЫБРАТЬ
		|	Справочникгндлф_СтажВыслугаЛет.Код КАК Код,
		|	Справочникгндлф_СтажВыслугаЛет.Наименование КАК Наименование,
		|	Справочникгндлф_СтажВыслугаЛет.ИмяПредопределенныхДанных КАК Имя,
		|	ЕСТЬNULL(гндлф_НадбавкаЗаВыслугуЛетСрезПоследних.Размер, 0) КАК Размер
		|ИЗ
		|	Справочник.гндлф_СтажВыслугаЛет КАК Справочникгндлф_СтажВыслугаЛет
		|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.гндлф_НадбавкаЗаВыслугуЛет.СрезПоследних(&Дата, Категория = &КатегорияСотрудников) КАК гндлф_НадбавкаЗаВыслугуЛетСрезПоследних
		|		ПО (гндлф_НадбавкаЗаВыслугуЛетСрезПоследних.Стаж = Справочникгндлф_СтажВыслугаЛет.Ссылка)
		|ГДЕ
		|	ЕСТЬNULL(гндлф_НадбавкаЗаВыслугуЛетСрезПоследних.Размер, 0) > 0"; 
	
	Возврат Текст;
	
КонецФункции 

&НаСервереБезКонтекста
Функция ТекстЗапросаНадбавкаРаботникамМедОрганизацийЗаСтаж()
	
	Текст = 
		"ВЫБРАТЬ
		|	Справочникгндлф_НадбавкаРаботникамМедОрганизацийЗаСтаж.Код КАК Код,
		|	Справочникгндлф_НадбавкаРаботникамМедОрганизацийЗаСтаж.Наименование КАК Наименование,
		|	Справочникгндлф_НадбавкаРаботникамМедОрганизацийЗаСтаж.ИмяПредопределенныхДанных КАК ИмяПредопределенныхДанных,
		|	ЕСТЬNULL(гндлф_НадбавкаРаботникамМедОрганизацийЗаСтажСрезПоследних.Размер, 0) КАК Размер
		|ИЗ
		|	Справочник.гндлф_НадбавкаРаботникамМедОрганизацийЗаСтаж КАК Справочникгндлф_НадбавкаРаботникамМедОрганизацийЗаСтаж
		|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.гндлф_НадбавкаРаботникамМедОрганизацийЗаСтаж.СрезПоследних(&Дата, Категория = &КатегорияСотрудников) КАК гндлф_НадбавкаРаботникамМедОрганизацийЗаСтажСрезПоследних
		|		ПО (гндлф_НадбавкаРаботникамМедОрганизацийЗаСтажСрезПоследних.Надбавка = Справочникгндлф_НадбавкаРаботникамМедОрганизацийЗаСтаж.Ссылка)
		|ГДЕ
		|	ЕСТЬNULL(гндлф_НадбавкаРаботникамМедОрганизацийЗаСтажСрезПоследних.Размер, 0) > 0"; 
	
	Возврат Текст;
	
КонецФункции 

&НаСервереБезКонтекста
Функция ТекстЗапросаДоплатаГПЗаВредныеИОпасныеУсловия()
	
	Текст = 
		"ВЫБРАТЬ
		|	Справочникгндлф_ДоплатаГПЗаРаботуВоВредныхИОпасныхУсловиях.Код КАК Код,
		|	Справочникгндлф_ДоплатаГПЗаРаботуВоВредныхИОпасныхУсловиях.Наименование КАК Наименование,
		|	Справочникгндлф_ДоплатаГПЗаРаботуВоВредныхИОпасныхУсловиях.ИмяПредопределенныхДанных КАК ИмяПредопределенныхДанных,
		|	ЕСТЬNULL(гндлф_ДоплатаГПЗаРаботуВоВредныхИОпасныхУсловияхСрезПоследних.Размер, 0) КАК Размер
		|ИЗ
		|	Справочник.гндлф_ДоплатаГПЗаРаботуВоВредныхИОпасныхУсловиях КАК Справочникгндлф_ДоплатаГПЗаРаботуВоВредныхИОпасныхУсловиях
		|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.гндлф_ДоплатаГПЗаРаботуВоВредныхИОпасныхУсловиях.СрезПоследних(&Дата, Категория = &КатегорияСотрудников) КАК гндлф_ДоплатаГПЗаРаботуВоВредныхИОпасныхУсловияхСрезПоследних
		|		ПО (гндлф_ДоплатаГПЗаРаботуВоВредныхИОпасныхУсловияхСрезПоследних.Надбавка = Справочникгндлф_ДоплатаГПЗаРаботуВоВредныхИОпасныхУсловиях.Ссылка)
		|ГДЕ
		|	НЕ Справочникгндлф_ДоплатаГПЗаРаботуВоВредныхИОпасныхУсловиях.Архив
		|	И ЕСТЬNULL(гндлф_ДоплатаГПЗаРаботуВоВредныхИОпасныхУсловияхСрезПоследних.Размер, 0) > 0"; 
	
	Возврат Текст;
	
КонецФункции 

&НаСервереБезКонтекста
Функция ТекстЗапросаНадбавкаРуководствоБригадой()
	
	Текст = 
		"ВЫБРАТЬ
		|	Справочникгндлф_НадбавкаЗаРуководствоБригадой.Код КАК Код,
		|	Справочникгндлф_НадбавкаЗаРуководствоБригадой.Наименование КАК Наименование,
		|	Справочникгндлф_НадбавкаЗаРуководствоБригадой.ИмяПредопределенныхДанных КАК ИмяПредопределенныхДанных,
		|	ЕСТЬNULL(гндлф_НадбавкаЗаРуководствоБригадойСрезПоследних.Размер, 0) КАК Размер
		|ИЗ
		|	Справочник.гндлф_НадбавкаЗаРуководствоБригадой КАК Справочникгндлф_НадбавкаЗаРуководствоБригадой
		|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.гндлф_НадбавкаЗаРуководствоБригадой.СрезПоследних(&Дата, Категория = &КатегорияСотрудников) КАК гндлф_НадбавкаЗаРуководствоБригадойСрезПоследних
		|		ПО (гндлф_НадбавкаЗаРуководствоБригадойСрезПоследних.Надбавка = Справочникгндлф_НадбавкаЗаРуководствоБригадой.Ссылка)
		|ГДЕ
		|	НЕ Справочникгндлф_НадбавкаЗаРуководствоБригадой.ПометкаУдаления
		|	И ЕСТЬNULL(гндлф_НадбавкаЗаРуководствоБригадойСрезПоследних.Размер, 0) > 0"; 
	
	Возврат Текст;
	
КонецФункции 

&НаСервереБезКонтекста
Функция ТекстЗапросаНадбавкаВодителям()
	
	Текст = 
		"ВЫБРАТЬ
		|	Справочникгндлф_НадбавкаВодителям.Код КАК Код,
		|	Справочникгндлф_НадбавкаВодителям.Наименование КАК Наименование,
		|	Справочникгндлф_НадбавкаВодителям.ИмяПредопределенныхДанных КАК ИмяПредопределенныхДанных,
		|	ЕСТЬNULL(гндлф_НадбавкаВодителямСрезПоследних.Размер, 0) КАК Размер
		|ИЗ
		|	Справочник.гндлф_НадбавкаВодителям КАК Справочникгндлф_НадбавкаВодителям
		|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.гндлф_НадбавкаВодителям.СрезПоследних(&Дата, Категория = &КатегорияСотрудников) КАК гндлф_НадбавкаВодителямСрезПоследних
		|		ПО (гндлф_НадбавкаВодителямСрезПоследних.Надбавка = Справочникгндлф_НадбавкаВодителям.Ссылка)
		|ГДЕ
		|	ЕСТЬNULL(гндлф_НадбавкаВодителямСрезПоследних.Размер, 0) > 0"; 
	
	Возврат Текст;
	
КонецФункции 

&НаСервереБезКонтекста
Функция ТекстЗапросаНадбавкаГостайна()
	
	Текст = 
		"ВЫБРАТЬ
		|	Справочникгндлф_СтепеньСекретности.Код КАК Код,
		|	Справочникгндлф_СтепеньСекретности.Наименование КАК Наименование,
		|	Справочникгндлф_СтепеньСекретности.ИмяПредопределенныхДанных КАК Имя,
		|	ЕСТЬNULL(гндлф_НадбавкаЗаГосТайнуСрезПоследних.Размер, 0) КАК Размер
		|ИЗ
		|	Справочник.гндлф_СтепеньСекретности КАК Справочникгндлф_СтепеньСекретности
		|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.гндлф_НадбавкаЗаГосТайну.СрезПоследних(&Дата, Категория = &КатегорияСотрудников) КАК гндлф_НадбавкаЗаГосТайнуСрезПоследних
		|		ПО (гндлф_НадбавкаЗаГосТайнуСрезПоследних.СтепеньСекретности = Справочникгндлф_СтепеньСекретности.Ссылка)
		|ГДЕ
		|	ЕСТЬNULL(гндлф_НадбавкаЗаГосТайнуСрезПоследних.Размер, 0) > 0"; 
	
	Возврат Текст;
	
КонецФункции 

&НаСервереБезКонтекста
Функция ТекстЗапросаНадбавкаШифрГражд()
	
	Текст = 
		"ВЫБРАТЬ
		|	гндлф_НадбавкаЗаШифрыГП.Код КАК Код,
		|	гндлф_НадбавкаЗаШифрыГП.Наименование КАК Наименование,
		|	гндлф_НадбавкаЗаШифрыГП.Предопределенный КАК Предопределенный,
		|	ЕСТЬNULL(гндлф_НадбавкаЗаШифрыГПСрезПоследних.Размер, 0) КАК Размер
		|ИЗ
		|	Справочник.гндлф_НадбавкаЗаШифрыГП КАК гндлф_НадбавкаЗаШифрыГП
		|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.гндлф_НадбавкаЗаШифрыГП.СрезПоследних(&Дата, Категория = &КатегорияСотрудников) КАК гндлф_НадбавкаЗаШифрыГПСрезПоследних
		|		ПО (гндлф_НадбавкаЗаШифрыГПСрезПоследних.Надбавка = гндлф_НадбавкаЗаШифрыГП.Ссылка)
		|ГДЕ
		|	ЕСТЬNULL(гндлф_НадбавкаЗаШифрыГПСрезПоследних.Размер, 0) > 0"; 
	
	Возврат Текст;
	
КонецФункции 


#КонецОбласти

#КонецОбласти