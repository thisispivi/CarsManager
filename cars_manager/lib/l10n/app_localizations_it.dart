// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appTitle => 'Cars Manager';

  @override
  String get carData_name => 'Nome Auto';

  @override
  String get carData_model => 'Modello';

  @override
  String get carData_manufacture => 'Costruttore';

  @override
  String get carData_yearOfManufacture => 'Anno di Produzione';

  @override
  String get carData_licensePlate => 'Targa';

  @override
  String get carData_photo => 'Foto';

  @override
  String get carData_fuelType => 'Tipo carburante';

  @override
  String get cars_car_shortTitle => 'Auto';

  @override
  String get fuel_entry_shortTitle => 'Rifornimento';

  @override
  String get cars_emptyState =>
      'Nessuna auto ancora. Tocca + per aggiungerne una.';

  @override
  String get cars_removeConfirmTitle => 'Rimuovere l\'auto?';

  @override
  String cars_removeConfirmBody(String name) {
    return 'Rimuovere \"$name\" dalla tua collezione?';
  }

  @override
  String get cars_noCarsLeftTitle => 'Nessuna auto rimasta';

  @override
  String get cars_noCarsLeftBody => 'Aggiungi una nuova auto per continuare.';

  @override
  String get cars_activeRemoved =>
      'Auto attiva rimossa. Selezionane un\'altra.';

  @override
  String get payments_selectCarHint =>
      'Seleziona un\'auto per vedere i pagamenti.';

  @override
  String get fuel_selectCarHint =>
      'Seleziona un\'auto per vedere i dati carburante.';

  @override
  String get stats_selectCarHint =>
      'Seleziona un\'auto per vedere le statistiche.';

  @override
  String get fuelType_petrol => 'Benzina';

  @override
  String get fuelType_diesel => 'Diesel';

  @override
  String get fuelType_electric => 'Elettrica';

  @override
  String get fuelType_hybrid => 'Ibrida';

  @override
  String get fuelType_lpg => 'GPL';

  @override
  String unit_km(String length) {
    return '$length km';
  }

  @override
  String unit_currency(String amount, String currency, String space) {
    return '$amount$space$currency';
  }

  @override
  String get settings_title => 'Impostazioni';

  @override
  String get common_close => 'Chiudi';

  @override
  String get language_name_en => 'Inglese';

  @override
  String get language_name_it => 'Italiano';

  @override
  String get language_selector_title => 'Lingua';

  @override
  String get payments_inspectionsData_title => 'Dati Revisioni';

  @override
  String get payments_inspectionsData_empty =>
      'Nessuna revisione. Tocca Aggiungi per crearne una.';

  @override
  String get payments_inspectionsData_nextDue => 'Prossima Revisione';

  @override
  String get days => 'giorni';

  @override
  String get date => 'Data';

  @override
  String get payments_inspectionsData_status => 'Stato';

  @override
  String get payments_inspectionsData_status_passed => 'Superata';

  @override
  String get payments_inspectionsData_status_failed => 'Non Superata';

  @override
  String get payments_inspectionsData_mileage => 'Chilometri';

  @override
  String get payments_insuranceData_title => 'Dati Assicurazione';

  @override
  String get payments_insuranceData_empty =>
      'Nessuna assicurazione. Tocca Aggiungi per crearne una.';

  @override
  String get payments_insuranceData_nextDue => 'Scadenza Assicurazione';

  @override
  String get payments_insuranceData_policyNumber => 'Numero';

  @override
  String get payments_insuranceData_provider => 'Fornitore';

  @override
  String get payments_taxesData_title => 'Dati Bollo';

  @override
  String get payments_taxesData_empty =>
      'Nessun bollo. Tocca Aggiungi per crearne uno.';

  @override
  String get payments_taxesData_nextDue => 'Prossimo Bollo';

  @override
  String get payments_expenseDistribution_title => 'Distribuzione Spese';

  @override
  String get payments_expensesByYear_title => 'Spese per Anno';

  @override
  String get payments_inspectionData_shortTitle => 'Revisione';

  @override
  String get payments_insuranceData_shortTitle => 'Assicurazione';

  @override
  String get payments_taxData_shortTitle => 'Bollo';

  @override
  String get payments_repairsData_title => 'Dati Riparazioni';

  @override
  String get payments_repairsData_empty =>
      'Nessuna riparazione. Tocca Aggiungi per crearne una.';

  @override
  String get payments_repairsData_shortTitle => 'Riparazioni';

  @override
  String get amount => 'Importo';

  @override
  String get themeSelector_title => 'Tema';

  @override
  String get fineType_speeding => 'Eccesso di Velocità';

  @override
  String get fineType_parking => 'Parcheggio';

  @override
  String get fineType_redLight => 'Semaforo Rosso';

  @override
  String get fineType_other => 'Other';

  @override
  String get payments_finesData_type => 'Tipo';

  @override
  String get payments_finesData_title => 'Dati Multe';

  @override
  String get payments_finesData_empty =>
      'Nessuna multa. Tocca Aggiungi per crearne una.';

  @override
  String get payments_fines_chart_countByYear_title => 'Multe per anno';

  @override
  String get payments_fines_chart_amountByYear_title =>
      'Totale importo multe per anno';

  @override
  String get payments_fines_chart_byType_title => 'Multe per tipo';

  @override
  String get payments_fineData_shortTitle => 'Multa';

  @override
  String get total => 'Totale';

  @override
  String get common_add => 'Aggiungi';

  @override
  String get common_edit => 'Modifica';

  @override
  String get common_save => 'Salva';

  @override
  String get common_ok => 'OK';

  @override
  String get common_pick => 'Scegli';

  @override
  String get common_delete => 'Elimina';

  @override
  String get common_cancel => 'Annulla';

  @override
  String get common_optional => 'opzionale';

  @override
  String get common_start => 'Inizio';

  @override
  String get common_end => 'Fine';

  @override
  String get common_description => 'Descrizione';

  @override
  String get common_notes => 'Note';

  @override
  String common_addEntity(String entity) {
    return 'Aggiungi $entity';
  }

  @override
  String common_editEntity(String entity) {
    return 'Modifica $entity';
  }

  @override
  String get common_actions => 'Azioni';

  @override
  String get common_deleted => 'Eliminato';

  @override
  String get common_deleteConfirmTitle => 'Eliminare elemento?';

  @override
  String get common_deleteConfirmBody =>
      'Questa azione non può essere annullata.';

  @override
  String get common_back => 'Indietro';

  @override
  String get common_overdue => 'Scaduto';

  @override
  String get common_noData => 'Nessun dato';

  @override
  String common_showAll(int count) {
    return 'Mostra tutti i $count elementi';
  }

  @override
  String get common_showLess => 'Mostra meno';

  @override
  String get fuel_entries_title => 'Rifornimenti';

  @override
  String get fuel_entries_empty =>
      'Nessun rifornimento. Tocca Aggiungi per crearne uno.';

  @override
  String get fuel_addEntry_title => 'Aggiungi rifornimento';

  @override
  String get fuel_fuelType_label => 'Tipo di carburante';

  @override
  String get fuel_amount_liters_label => 'Litri';

  @override
  String get fuel_amount_kwh_label => 'kWh';

  @override
  String get fuel_price_per_l_label => 'Prezzo / L';

  @override
  String get fuel_price_per_kwh_label => 'Prezzo / kWh';

  @override
  String get fuel_total_cost_label => 'Costo totale';

  @override
  String get fuel_expensesByYear_title => 'Spese carburante per anno';

  @override
  String get fuel_avgPriceByYear_title => 'Prezzo medio per unità per anno';

  @override
  String get fuel_amountByYear_title => 'Quantità totale per anno';

  @override
  String validation_required(String field) {
    return '$field è obbligatorio';
  }

  @override
  String validation_minLength(String field, int min) {
    return '$field deve contenere almeno $min caratteri';
  }

  @override
  String validation_maxLength(String field, int max) {
    return '$field deve contenere al massimo $max caratteri';
  }

  @override
  String get validation_invalidYear => 'Inserisci un anno valido';

  @override
  String validation_yearBetween(int min, int max) {
    return 'L\'anno deve essere tra $min e $max';
  }

  @override
  String get validation_licensePlateInvalid => 'La targa non sembra valida';

  @override
  String validation_number_gt_zero(String field) {
    return '$field deve essere un numero > 0';
  }

  @override
  String validation_number_gte_zero(String field) {
    return '$field deve essere un numero ≥ 0';
  }

  @override
  String get nav_garage => 'Garage';

  @override
  String get nav_analytics => 'Analisi';

  @override
  String get nav_reminders => 'Promemoria';

  @override
  String get nav_reminders_title => 'Promemoria';

  @override
  String get nav_switchCar => 'Cambia auto';

  @override
  String get analytics_title => 'Analisi';

  @override
  String get analytics_subtitle => 'Le tue spese in sintesi';

  @override
  String get analytics_totalTracked => 'TOTALE TRACCIATO';

  @override
  String analytics_vehicleCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count veicoli',
      one: '$count veicolo',
    );
    return '$_temp0';
  }

  @override
  String get analytics_last12Months => 'ultimi 12 mesi';

  @override
  String get analytics_emptyTitle => 'Nessuna analisi disponibile';

  @override
  String get analytics_emptySubtitle =>
      'Aggiungi un\'auto e registra carburante o spese per sbloccare gli insight.';

  @override
  String get analytics_costOverview => 'Panoramica costi totali';

  @override
  String get analytics_categoryBreakdown => 'Ripartizione per categoria';

  @override
  String get analytics_costPerCar => 'Costo per auto';

  @override
  String get analytics_monthlyTrend => 'Andamento mensile';

  @override
  String get analytics_tableMonth => 'Mese';

  @override
  String get analytics_tableFuel => 'Carburante';

  @override
  String get analytics_tableMaint => 'Manut.';

  @override
  String get analytics_tableFixed => 'Fissi';

  @override
  String get analytics_tableTotal => 'Totale';

  @override
  String get analytics_insightAcrossVehicles => 'Su ogni veicolo e categoria';

  @override
  String get analytics_insightVsLastMonth => 'Rispetto al mese scorso';

  @override
  String get analytics_insightLargestCategory =>
      'Categoria di spesa principale';

  @override
  String get analytics_insightDeadlines => 'In scadenza nei prossimi 30 giorni';

  @override
  String get analytics_insightThisMonth => 'Questo mese è attivo';

  @override
  String get analytics_noUrgentDeadlines => 'Nessuna scadenza urgente';

  @override
  String analytics_deadlinesSoon(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'scadenze',
      one: 'scadenza',
    );
    return '$count $_temp0 a breve';
  }

  @override
  String get analytics_filterAll => 'Tutte le auto';

  @override
  String get analytics_noCarSelected =>
      'Seleziona almeno un\'auto per vedere le analisi.';

  @override
  String get analytics_noCategoryData =>
      'Nessuna categoria di costo ha ancora dati.';

  @override
  String get analytics_noSpendYet => 'Nessuna spesa ancora';

  @override
  String get analytics_startLoggingPatterns =>
      'Inizia a registrare dati per vedere gli andamenti';

  @override
  String analytics_trackedAmount(String amount) {
    return '$amount tracciati';
  }

  @override
  String analytics_deltaPercent(String percent, String direction) {
    return '$percent% $direction';
  }

  @override
  String get analytics_deltaUp => 'in più';

  @override
  String get analytics_deltaDown => 'in meno';

  @override
  String get analytics_exportCsv => 'Esporta CSV';

  @override
  String analytics_exportFailed(String error) {
    return 'Esportazione non riuscita: $error';
  }

  @override
  String get settings_preferences => 'Preferenze';

  @override
  String get settings_dataManagement => 'Gestione dati';

  @override
  String get settings_exportBackup => 'Esporta dati / Backup';

  @override
  String get settings_resetData => 'Reimposta tutti i dati';

  @override
  String get settings_resetDataConfirm =>
      'Questo eliminerà tutte le auto e le voci. L\'azione non può essere annullata.';

  @override
  String get settings_resetDataTitle => 'Reimpostare tutti i dati?';

  @override
  String get reminders_noReminders => 'Nessuna scadenza ancora';

  @override
  String get reminders_insurance => 'Assicurazione';

  @override
  String get reminders_inspection => 'Revisione';

  @override
  String get reminders_tax => 'Bollo';

  @override
  String get settings_testNotification => 'Notifica di test';

  @override
  String get home_welcomeBack => 'Bentornato';

  @override
  String get home_addFirstCar => 'Aggiungi la tua prima auto';

  @override
  String get home_addFirstCarSubtitle =>
      'Tieni traccia di carburante, spese, manutenzione e scadenze da un\'unica dashboard.';

  @override
  String get home_addCar => 'Aggiungi auto';

  @override
  String get home_activeCar => 'Attiva';

  @override
  String get home_switchCar => 'Cambia';

  @override
  String get home_quickActions => 'Azioni rapide';

  @override
  String get home_quickFuel => 'Carburante';

  @override
  String get home_quickExpense => 'Spesa';

  @override
  String get home_quickSearch => 'Cerca';

  @override
  String get home_upcoming => 'In scadenza';

  @override
  String get home_upcomingEmpty => 'Nessuna scadenza imminente.';

  @override
  String get home_recentActivity => 'Attività recente';

  @override
  String get home_recentActivityEmpty =>
      'I nuovi rifornimenti e le spese appariranno qui.';

  @override
  String get home_recentActivitySeeAll => 'Vedi tutto';

  @override
  String get home_monthlySummary => 'Riepilogo mensile';

  @override
  String get home_monthlySummarySubtitle =>
      'Speso questo mese tra carburante e spese';

  @override
  String get home_activityFuelEntry => 'Rifornimento';

  @override
  String get home_activityRepair => 'Riparazione';

  @override
  String get home_activityFine => 'Multa';

  @override
  String get home_activityVehicleTax => 'Bollo';

  @override
  String get home_activityInspection => 'Revisione';

  @override
  String get home_activityInsurance => 'Assicurazione';

  @override
  String get garage_title => 'Il mio garage';

  @override
  String garage_subtitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count veicoli tracciati',
      one: '$count veicolo tracciato',
    );
    return '$_temp0 con storico salute, carburante e costi.';
  }

  @override
  String get garage_empty => 'Il tuo garage è vuoto';

  @override
  String get garage_activeVehicle => 'Veicolo attivo';

  @override
  String get garage_otherVehicles => 'Altri veicoli';

  @override
  String get garage_dueSoon => 'In scadenza';

  @override
  String get garage_fuelEntries => 'Rifornimenti';

  @override
  String get garage_expenseEvents => 'Spese';

  @override
  String get vehicleDetail_notFound => 'Veicolo non trovato';

  @override
  String get vehicleDetail_notFoundSubtitle =>
      'Questa auto potrebbe essere stata rimossa dal garage.';

  @override
  String get vehicleDetail_backToGarage => 'Torna al garage';

  @override
  String get vehicleDetail_tabOverview => 'Panoramica';

  @override
  String get vehicleDetail_tabFuel => 'Carburante';

  @override
  String get vehicleDetail_tabExpenses => 'Spese';

  @override
  String get vehicleDetail_tabTimeline => 'Cronologia';

  @override
  String get vehicleDetail_totalTracked => 'Totale tracciato';

  @override
  String get vehicleDetail_fuelEntries => 'Rifornimenti';

  @override
  String get vehicleDetail_serviceEvents => 'Interventi';

  @override
  String get vehicleDetail_costBreakdown => 'Ripartizione costi';

  @override
  String vehicleDetail_fuelHistory(String period) {
    return 'Storico carburante ($period)';
  }

  @override
  String get vehicleDetail_addFuel => 'Aggiungi rifornimento';

  @override
  String get vehicleDetail_expenseCategories => 'Categorie spese';

  @override
  String get vehicleDetail_latestExpenses => 'Ultime spese';

  @override
  String vehicleDetail_latestExpensesFiltered(String category) {
    return 'Ultime spese: $category';
  }

  @override
  String get vehicleDetail_addExpense => 'Aggiungi spesa';

  @override
  String get vehicleDetail_vehicleTimeline => 'Cronologia veicolo';

  @override
  String get vehicleDetail_noFuelEntries => 'Nessun rifornimento.';

  @override
  String get vehicleDetail_noExpenses => 'Nessuna spesa.';

  @override
  String vehicleDetail_noExpensesFiltered(String category) {
    return 'Nessuna spesa di tipo $category.';
  }

  @override
  String get vehicleDetail_noData => 'Nessun dato sui costi.';

  @override
  String get vehicleDetail_timelineEmpty =>
      'Carburante, manutenzione e pagamenti appariranno qui.';

  @override
  String vehicleDetail_showAllEntries(int count) {
    return 'Mostra tutti i $count rifornimenti';
  }

  @override
  String vehicleDetail_showAllExpenses(int count) {
    return 'Mostra tutte le $count spese';
  }

  @override
  String vehicleDetail_showAllEvents(int count) {
    return 'Mostra tutti i $count eventi';
  }

  @override
  String get vehicleDetail_addExpenseTitle => 'Aggiungi spesa';

  @override
  String get vehicleDetail_insurance => 'Assicurazione';

  @override
  String get vehicleDetail_inspection => 'Revisione';

  @override
  String get vehicleDetail_tax => 'Bollo';

  @override
  String get vehicleDetail_repair => 'Riparazione';

  @override
  String get vehicleDetail_fine => 'Multa';

  @override
  String get vehicleDetail_fuel => 'Carburante';

  @override
  String get vehicleDetail_noPlate => 'Nessuna targa';

  @override
  String get vehicleDetail_fuelNotSet => 'Carburante non impostato';

  @override
  String get onboarding_slide1Title => 'Le tue auto, organizzate';

  @override
  String get onboarding_slide1Subtitle =>
      'Tieni ogni veicolo, scadenza e dettaglio chiave in un\'unica vista.';

  @override
  String get onboarding_slide2Title => 'Traccia ogni costo';

  @override
  String get onboarding_slide2Subtitle =>
      'Registra carburante, assicurazione, bollo, riparazioni e multe senza cercare nei menu.';

  @override
  String get onboarding_slide3Title => 'Non perdere mai una scadenza';

  @override
  String get onboarding_slide3Subtitle =>
      'Vedi rinnovi e date di manutenzione imminenti prima che diventino urgenti.';

  @override
  String get onboarding_skip => 'Salta';

  @override
  String get onboarding_getStarted => 'Inizia';

  @override
  String get onboarding_continue => 'Continua';

  @override
  String get analytics_yearlyCost => 'Costi annuali per categoria';

  @override
  String get analytics_yearlyNoData => 'Nessun dato per i veicoli selezionati.';

  @override
  String get common_next => 'Avanti';

  @override
  String get common_all => 'Tutti';

  @override
  String get carForm_step_basics => 'Base';

  @override
  String get carForm_step_details => 'Dettagli';

  @override
  String get carForm_step_photo => 'Foto';

  @override
  String get carForm_step_basicsDesc =>
      'Assegna un nome all\'auto e aggiungi le informazioni sul modello per riconoscerla rapidamente.';

  @override
  String get carForm_step_detailsDesc =>
      'Aggiungi la targa e il tipo di carburante per impostazioni predefinite più precise.';

  @override
  String get carForm_step_photoDesc =>
      'Aggiungi una foto chiara per il garage e il cruscotto. Puoi saltare questo passaggio per ora.';

  @override
  String carForm_imagePickerError(String error) {
    return 'Impossibile aprire il selettore immagini: $error';
  }

  @override
  String get vehicleDetail_totalLiters => 'Litri totali';

  @override
  String get vehicleDetail_avgPricePerLiter => 'Prezzo medio/L';

  @override
  String vehicleDetail_categorySummary(String category) {
    return 'Riepilogo $category';
  }

  @override
  String get common_due => 'Scade:';

  @override
  String get common_left => 'rimasti';

  @override
  String get common_addToCalendar => 'Aggiungi al calendario';

  @override
  String get calendar_addSuccess =>
      'Calendario aperto con i dettagli dell\'evento.';

  @override
  String get calendar_addBrowserFallback =>
      'Google Calendar aperto con i dettagli dell\'evento.';

  @override
  String calendar_addFailed(String error) {
    return 'Calendario non riuscito: $error';
  }

  @override
  String get settings_subtitle =>
      'Preferenze, promemoria, dati e informazioni sull\'app.';

  @override
  String get settings_theme_subtitle => 'Scegli come appare Cars Manager.';

  @override
  String get settings_theme_system => 'Sistema';

  @override
  String get settings_theme_light => 'Chiaro';

  @override
  String get settings_theme_dark => 'Scuro';

  @override
  String get settings_units => 'Unità';

  @override
  String get settings_units_subtitle => 'Distanza e volume predefiniti.';

  @override
  String get settings_units_metric => 'Metrico';

  @override
  String get settings_units_imperial => 'Imperiale';

  @override
  String get settings_currency => 'Valuta';

  @override
  String get settings_currency_subtitle =>
      'Usata per totali, grafici ed esportazioni.';

  @override
  String get settings_notifications => 'Notifiche';

  @override
  String get settings_notifications_enableReminders => 'Attiva promemoria';

  @override
  String get settings_notifications_subtitle =>
      'Mostra assicurazione, revisione e bollo in scadenza.';

  @override
  String get settings_notifications_test => 'Invia notifica di test';

  @override
  String get settings_notifications_testSubtitle =>
      'Anteprima dei promemoria Android.';

  @override
  String get settings_notifications_scheduleTest =>
      'Programma promemoria di test';

  @override
  String get settings_notifications_scheduleTestSubtitle =>
      'Invia un vero promemoria tra 2 minuti.';

  @override
  String get settings_notifications_testScheduled =>
      'Promemoria di test programmato tra 2 minuti.';

  @override
  String get settings_notifications_permissionDenied =>
      'Il permesso per le notifiche e disattivato.';

  @override
  String get settings_reminder_90days => '90 giorni';

  @override
  String get settings_reminder_30days => '30 giorni';

  @override
  String get settings_reminder_7days => '7 giorni';

  @override
  String get settings_reminder_1day => '1 giorno';

  @override
  String get settings_exportSubtitle =>
      'Scarica uno snapshot CSV del tuo garage.';

  @override
  String get settings_importBackup => 'Importa dati / Backup';

  @override
  String get settings_importSubtitle =>
      'Ripristina un backup CSV creato da Cars Manager.';

  @override
  String get settings_importConfirmTitle => 'Importare il backup?';

  @override
  String settings_importConfirmBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count veicoli',
      one: '$count veicolo',
    );
    return 'Questo sostituirà il garage attuale con $_temp0 dal backup.';
  }

  @override
  String settings_importSuccess(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count veicoli',
      one: '$count veicolo',
    );
    return 'Importati $_temp0.';
  }

  @override
  String settings_importFailed(String error) {
    return 'Importazione non riuscita: $error';
  }

  @override
  String get settings_resetDataSubtitle =>
      'Elimina tutte le auto e le voci da questo dispositivo.';

  @override
  String get settings_about => 'Informazioni';

  @override
  String get settings_version => 'Versione';

  @override
  String get settings_language_subtitle =>
      'Gestisce etichette, date e testi localizzati.';
}
