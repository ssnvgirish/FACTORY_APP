class AppConstants {
  AppConstants._();

  // Machine names
  static const String frameMachine1 = 'Frame Machine 1';
  static const String frameMachine2 = 'Frame Machine 2';
  static const String sheetMachine3 = 'Sheet Machine 3';
  static const String sheetMachine4 = 'Sheet Machine 4';
  static const String sheetMachine5 = 'Sheet Machine 5';

  static const List<String> frameMachines = [frameMachine1, frameMachine2];
  static const List<String> sheetMachines = [
    sheetMachine3,
    sheetMachine4,
    sheetMachine5,
  ];
  static const List<String> allMachines = [...frameMachines, ...sheetMachines];

  // Shifts
  static const String dayShift = 'Day Shift';
  static const String nightShift = 'Night Shift';
  static const List<String> shifts = [dayShift, nightShift];

  // Roles
  static const String roleMachineOperator = 'machine_operator';
  static const String roleQualityPacking = 'quality_packing_supervisor';
  static const String roleFramesSenior = 'frames_senior_operator';
  static const String roleSheetSenior = 'sheet_senior_operator';
  static const String rolePlantManager = 'plant_manager';
  static const String roleAdmin = 'admin';

  static const List<String> allRoles = [
    roleMachineOperator,
    roleQualityPacking,
    roleFramesSenior,
    roleSheetSenior,
    rolePlantManager,
    roleAdmin,
  ];

  static const Map<String, String> roleDisplayNames = {
    roleMachineOperator: 'Machine Operator',
    roleQualityPacking: 'Quality & Packing Supervisor',
    roleFramesSenior: 'Frames Senior Operator',
    roleSheetSenior: 'Sheet Senior Operator',
    rolePlantManager: 'Plant Manager',
    roleAdmin: 'Admin',
  };

  // Frame sections
  static const List<String> defaultFrameSections = [
    '3x2',
    '4x2',
    '4x2.5',
    '5x2.5',
    '3x2 (HR)',
    '4x2.5(HR)',
    'Window Shutter',
  ];

  // Frame densities
  static const List<String> defaultFrameDensities = [
    '0.75',
    '0.80',
    '0.90',
    'Others',
  ];

  // Frame colors
  static const List<String> defaultFrameColors = [
    'Brown',
    'Ivory',
    'NFC Color',
  ];

  // Sheet thicknesses
  static const List<String> defaultSheetThicknesses = [
    '6mm',
    '7mm',
    '8mm',
    '9mm',
    '12mm',
    '13mm',
    '16mm',
    '17mm',
    '18mm',
    '19mm',
    '22mm',
    '25mm sheet',
    '25mm Door',
    '26mm',
    '27mm',
    '28mm',
    '30mm',
    '31mm',
    '33mm',
    '35mm',
    '36mm',
  ];

  // Sheet densities
  static const List<String> defaultSheetDensities = [
    '0.45',
    '0.50',
    '0.55',
    '0.60',
    '0.65',
    '0.70',
    '0.80',
    'Others',
  ];

  // Sheet colors
  static const List<String> defaultSheetColors = [
    'Brown',
    'Ivory',
    'NFC Sanding',
    'NFC No Sanding',
    'White',
  ];

  // Maintenance items
  static const List<String> defaultMaintenanceItems = [
    'Die Cleaning',
    'Die Change',
    'Generator Maintenance',
    'Air Compressor Maintenance',
    'Chiller Maintenance',
    'Mixer Maintenance',
    'Main Machine Maintenance',
    'UPS Maintenance',
    'Others',
  ];

  // Approval statuses
  static const String statusPending = 'pending';
  static const String statusApproved = 'approved';
  static const String statusRejected = 'rejected';

  // Frame weight lookup table (weight per foot in kg)
  static const Map<String, Map<String, double>> defaultFrameWeights = {
    '3x2': {'0.75': 0.486, '0.80': 0.519, '0.90': 0.584},
    '4x2': {'0.75': 0.647, '0.80': 0.690, '0.90': 0.777},
    '4x2.5': {'0.75': 0.810, '0.80': 0.864, '0.90': 0.972},
    '5x2.5': {'0.75': 1.012, '0.80': 1.080, '0.90': 1.215},
    '3x2 (HR)': {'0.75': 0.486, '0.80': 0.519, '0.90': 0.584},
    '4x2.5(HR)': {'0.75': 0.810, '0.80': 0.864, '0.90': 0.972},
    'Window Shutter': {'0.75': 0.648, '0.80': 0.691, '0.90': 0.778},
  };

  // Frame weight flat map (section|density → weight per foot)
  // Used as the stored format in ReferenceTable backend
  static const Map<String, double> defaultFrameWeightsFlat = {
    '3x2|0.75': 0.486,
    '3x2|0.80': 0.519,
    '3x2|0.90': 0.584,
    '4x2|0.75': 0.647,
    '4x2|0.80': 0.690,
    '4x2|0.90': 0.777,
    '4x2.5|0.75': 0.810,
    '4x2.5|0.80': 0.864,
    '4x2.5|0.90': 0.972,
    '5x2.5|0.75': 1.012,
    '5x2.5|0.80': 1.080,
    '5x2.5|0.90': 1.215,
    '3x2 (HR)|0.75': 0.486,
    '3x2 (HR)|0.80': 0.519,
    '3x2 (HR)|0.90': 0.584,
    '4x2.5(HR)|0.75': 0.810,
    '4x2.5(HR)|0.80': 0.864,
    '4x2.5(HR)|0.90': 0.972,
    'Window Shutter|0.75': 0.648,
    'Window Shutter|0.80': 0.691,
    'Window Shutter|0.90': 0.778,
  };

  // Sheet weight flat map (thickness|density → weight per sqft)
  static const Map<String, double> defaultSheetWeightsFlat = {
    '6mm|0.45': 0.199,
    '6mm|0.50': 0.221,
    '6mm|0.55': 0.243,
    '6mm|0.60': 0.265,
    '6mm|0.65': 0.287,
    '6mm|0.70': 0.309,
    '6mm|0.80': 0.354,
    '7mm|0.45': 0.232,
    '7mm|0.50': 0.258,
    '7mm|0.55': 0.284,
    '7mm|0.60': 0.309,
    '7mm|0.65': 0.335,
    '7mm|0.70': 0.361,
    '7mm|0.80': 0.413,
    '8mm|0.45': 0.265,
    '8mm|0.50': 0.295,
    '8mm|0.55': 0.324,
    '8mm|0.60': 0.354,
    '8mm|0.65': 0.383,
    '8mm|0.70': 0.413,
    '8mm|0.80': 0.472,
    '9mm|0.45': 0.298,
    '9mm|0.50': 0.332,
    '9mm|0.55': 0.365,
    '9mm|0.60': 0.398,
    '9mm|0.65': 0.431,
    '9mm|0.70': 0.464,
    '9mm|0.80': 0.531,
    '12mm|0.45': 0.398,
    '12mm|0.50': 0.442,
    '12mm|0.55': 0.487,
    '12mm|0.60': 0.531,
    '12mm|0.65': 0.575,
    '12mm|0.70': 0.619,
    '12mm|0.80': 0.708,
    '13mm|0.45': 0.431,
    '13mm|0.50': 0.479,
    '13mm|0.55': 0.527,
    '13mm|0.60': 0.575,
    '13mm|0.65': 0.623,
    '13mm|0.70': 0.671,
    '13mm|0.80': 0.767,
    '16mm|0.45': 0.531,
    '16mm|0.50': 0.590,
    '16mm|0.55': 0.649,
    '16mm|0.60': 0.708,
    '16mm|0.65': 0.767,
    '16mm|0.70': 0.826,
    '16mm|0.80': 0.944,
    '17mm|0.45': 0.564,
    '17mm|0.50': 0.627,
    '17mm|0.55': 0.689,
    '17mm|0.60': 0.752,
    '17mm|0.65': 0.815,
    '17mm|0.70': 0.877,
    '17mm|0.80': 1.003,
    '18mm|0.45': 0.597,
    '18mm|0.50': 0.663,
    '18mm|0.55': 0.730,
    '18mm|0.60': 0.796,
    '18mm|0.65': 0.862,
    '18mm|0.70': 0.929,
    '18mm|0.80': 1.062,
    '19mm|0.45': 0.630,
    '19mm|0.50': 0.700,
    '19mm|0.55': 0.770,
    '19mm|0.60': 0.840,
    '19mm|0.65': 0.910,
    '19mm|0.70': 0.980,
    '19mm|0.80': 1.121,
    '22mm|0.45': 0.730,
    '22mm|0.50': 0.811,
    '22mm|0.55': 0.892,
    '22mm|0.60': 0.973,
    '22mm|0.65': 1.054,
    '22mm|0.70': 1.135,
    '22mm|0.80': 1.297,
    '25mm sheet|0.45': 0.829,
    '25mm sheet|0.50': 0.921,
    '25mm sheet|0.55': 1.013,
    '25mm sheet|0.60': 1.106,
    '25mm sheet|0.65': 1.198,
    '25mm sheet|0.70': 1.290,
    '25mm sheet|0.80': 1.475,
    '25mm Door|0.45': 0.829,
    '25mm Door|0.50': 0.921,
    '25mm Door|0.55': 1.013,
    '25mm Door|0.60': 1.106,
    '25mm Door|0.65': 1.198,
    '25mm Door|0.70': 1.290,
    '25mm Door|0.80': 1.475,
    '26mm|0.45': 0.862,
    '26mm|0.50': 0.958,
    '26mm|0.55': 1.054,
    '26mm|0.60': 1.150,
    '26mm|0.65': 1.246,
    '26mm|0.70': 1.341,
    '26mm|0.80': 1.534,
    '27mm|0.45': 0.895,
    '27mm|0.50': 0.995,
    '27mm|0.55': 1.094,
    '27mm|0.60': 1.194,
    '27mm|0.65': 1.293,
    '27mm|0.70': 1.393,
    '27mm|0.80': 1.593,
    '28mm|0.45': 0.929,
    '28mm|0.50': 1.032,
    '28mm|0.55': 1.135,
    '28mm|0.60': 1.238,
    '28mm|0.65': 1.341,
    '28mm|0.70': 1.444,
    '28mm|0.80': 1.652,
    '30mm|0.45': 0.995,
    '30mm|0.50': 1.106,
    '30mm|0.55': 1.216,
    '30mm|0.60': 1.327,
    '30mm|0.65': 1.437,
    '30mm|0.70': 1.548,
    '30mm|0.80': 1.770,
    '31mm|0.45': 1.028,
    '31mm|0.50': 1.143,
    '31mm|0.55': 1.257,
    '31mm|0.60': 1.371,
    '31mm|0.65': 1.485,
    '31mm|0.70': 1.600,
    '31mm|0.80': 1.829,
    '33mm|0.45': 1.094,
    '33mm|0.50': 1.216,
    '33mm|0.55': 1.338,
    '33mm|0.60': 1.460,
    '33mm|0.65': 1.581,
    '33mm|0.70': 1.703,
    '33mm|0.80': 1.947,
    '35mm|0.45': 1.161,
    '35mm|0.50': 1.290,
    '35mm|0.55': 1.419,
    '35mm|0.60': 1.548,
    '35mm|0.65': 1.677,
    '35mm|0.70': 1.806,
    '35mm|0.80': 2.065,
    '36mm|0.45': 1.194,
    '36mm|0.50': 1.327,
    '36mm|0.55': 1.460,
    '36mm|0.60': 1.593,
    '36mm|0.65': 1.725,
    '36mm|0.70': 1.858,
    '36mm|0.80': 2.124,
  };

  // Frame production targets (section → target weight kg per hour)
  static const Map<String, double> defaultFrameTargets = {
    '3x2': 80.0,
    '4x2': 100.0,
    '4x2.5': 120.0,
    '5x2.5': 140.0,
    '3x2 (HR)': 80.0,
    '4x2.5(HR)': 120.0,
    'Window Shutter': 90.0,
  };

  // Sheet production targets (thickness → target running feet per hour)
  static const Map<String, double> defaultSheetTargets = {
    '6mm': 250.0,
    '7mm': 230.0,
    '8mm': 210.0,
    '9mm': 200.0,
    '12mm': 170.0,
    '13mm': 160.0,
    '16mm': 140.0,
    '17mm': 130.0,
    '18mm': 125.0,
    '19mm': 120.0,
    '22mm': 100.0,
    '25mm sheet': 85.0,
    '25mm Door': 85.0,
    '26mm': 80.0,
    '27mm': 78.0,
    '28mm': 75.0,
    '30mm': 70.0,
    '31mm': 68.0,
    '33mm': 60.0,
    '35mm': 55.0,
    '36mm': 52.0,
  };

  // Salary variable weightages (must sum to 100)
  static const Map<String, double> defaultSalaryWeightages = {
    'wA': 15.0, // Machine Cleaning
    'wB': 10.0, // Tools Count
    'wC': 25.0, // Machine Health
    'wD': 20.0, // Production Efficiency
    'wE': 20.0, // Report Writing Efficiency
    'wF': 10.0, // Quality / Packing
  };

  // Max permissible durations for frame maintenance (in hours)
  static const Map<String, double> frameMaintenanceMaxDurations = {
    'Die Change': 2.0,
    'Die Cleaning': 1.0,
  };

  // Max permissible durations for sheet maintenance (in hours)
  static const Map<String, double> sheetMaintenanceMaxDurations = {
    'Die Change': 4.0,
    'Die Cleaning': 2.0,
  };

  // ═══════════════════════════════════════
  // SCRAP REGRIND SECTION
  // ═══════════════════════════════════════

  // Scrap Regrind Machines
  static const String crusherMachine1 = 'Crusher Machine 1';
  static const String crusherMachine2 = 'Crusher Machine 2';
  static const String crusherMachine3 = 'Crusher Machine 3';
  static const String pulverizerMachine1 = 'Pulverizer Machine 1';
  static const String pulverizerMachine2 = 'Pulverizer Machine 2';
  static const String pulverizerMachine3 = 'Pulverizer Machine 3';
  static const String shredder = 'Shredder';

  static const List<String> scrapAllMachines = [
    crusherMachine1,
    crusherMachine2,
    crusherMachine3,
    pulverizerMachine1,
    pulverizerMachine2,
    pulverizerMachine3,
    shredder,
  ];

  static const List<String> scrapPulverizerMachines = [
    pulverizerMachine1,
    pulverizerMachine2,
    pulverizerMachine3,
  ];

  static const List<String> scrapQualityMachines = [
    frameMachine1,
    frameMachine2,
    sheetMachine3,
    sheetMachine4,
    sheetMachine5,
  ];

  // Scrap Products
  static const String framesBrownScrap = 'Frames Brown Color Scrap';
  static const String sheetsBrownScrap = 'Sheets Brown Color Scrap';
  static const String sheetsIvoryScrap = 'Sheets Ivory Color Scrap';
  static const String sheetsNfcScrap = 'Sheets NFC Color Scrap';
  static const String sheetsOrangeScrap = 'Sheets Orange Color Scrap';
  static const String mixScrap = 'Mix scrap';

  static const List<String> scrapProducts = [
    framesBrownScrap,
    sheetsBrownScrap,
    sheetsIvoryScrap,
    sheetsNfcScrap,
    sheetsOrangeScrap,
    mixScrap,
  ];

  // Scrap Maintenance Items
  static const List<String> scrapMaintenanceItems = [
    'Blade gap adjustment',
    'Blade replacement',
    'Generator maintenance',
    'Motors maintenance',
    'Panel Board maintenance',
    'Machine electrical parts maintenance',
    'Machine mechanical parts maintenance',
    'Others',
  ];

  // Scrap target production weight per hour (kg) - per product/section
  // (Admin-configurable; defaults below)
  static const Map<String, double> scrapTargetWeightPerHour = {
    framesBrownScrap: 100.0,
    sheetsBrownScrap: 100.0,
    sheetsIvoryScrap: 100.0,
    sheetsNfcScrap: 100.0,
    sheetsOrangeScrap: 100.0,
    mixScrap: 100.0,
  };

  // Scrap salary variable names
  static const String scrapVarA = 'Machine Cleaning %';
  static const String scrapVarB = 'Tools Count %';
  static const String scrapVarE = 'Production Efficiency %';
  static const String scrapVarF = 'Report Writing Efficiency %';
  static const String scrapVarG = 'Scrap Quality Rating %';

  // Firestore collections
  static const String usersCollection = 'users';
  static const String frameReportsCollection = 'frameReports';
  static const String sheetReportsCollection = 'sheetReports';
  static const String scrapRegrindReportsCollection = 'scrapRegrindReports';
  static const String salaryCalculationsCollection = 'salaryCalculations';
  static const String referenceTablesCollection = 'referenceTables';

  // Report sub-collections
  static const String machineCleaningReports = 'machineCleaningReports';
  static const String toolsCountReports = 'toolsCountReports';
  static const String machineHealthReports = 'machineHealthReports';
  static const String productionDetailsReports = 'productionDetailsReports';
  static const String productionCalcReports = 'productionCalcReports';
  static const String shiftPackingReports = 'shiftPackingReports';
  static const String reportWritingEfficiency = 'reportWritingEfficiency';
  static const String customerRejectionReports = 'customerRejectionReports';
  static const String scrapQualityReports = 'scrapQualityReports';

  // Reference table document IDs
  static const String frameWeightsDoc = 'frameWeights';
  static const String sheetWeightsDoc = 'sheetWeights';
  static const String frameTargetsDoc = 'frameTargets';
  static const String sheetTargetsDoc = 'sheetTargets';
  static const String scrapTargetsDoc = 'scrapTargets';
  static const String salaryWeightagesDoc = 'salaryWeightages';
  static const String scrapSalaryWeightagesDoc = 'scrapSalaryWeightages';
  static const String dropdownMenusDoc = 'dropdownMenus';
}
