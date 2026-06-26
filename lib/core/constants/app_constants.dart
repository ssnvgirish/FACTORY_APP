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

  // Frame weight lookup table: section × density → weight per foot (kg)
  static const Map<String, Map<String, double>> defaultFrameWeights = {
    '3x2': {'0.75': 0.486, '0.80': 0.519, '0.90': 0.584},
    '4x2': {'0.75': 0.647, '0.80': 0.690, '0.90': 0.777},
    '4x2.5': {'0.75': 0.810, '0.80': 0.864, '0.90': 0.972},
    '5x2.5': {'0.75': 1.012, '0.80': 1.080, '0.90': 1.215},
    '3x2 (HR)': {'0.75': 0.486, '0.80': 0.519, '0.90': 0.584},
    '4x2.5(HR)': {'0.75': 0.810, '0.80': 0.864, '0.90': 0.972},
    'Window Shutter': {'0.75': 0.648, '0.80': 0.691, '0.90': 0.778},
  };

  // Sheet weight lookup table: thickness × density → weight per sqft (kg)
  static const Map<String, Map<String, double>> defaultSheetWeights = {
    '6mm': {
      '0.45': 0.199,
      '0.50': 0.221,
      '0.55': 0.243,
      '0.60': 0.265,
      '0.65': 0.287,
      '0.70': 0.309,
      '0.80': 0.354,
    },
    '7mm': {
      '0.45': 0.232,
      '0.50': 0.258,
      '0.55': 0.284,
      '0.60': 0.309,
      '0.65': 0.335,
      '0.70': 0.361,
      '0.80': 0.413,
    },
    '8mm': {
      '0.45': 0.265,
      '0.50': 0.295,
      '0.55': 0.324,
      '0.60': 0.354,
      '0.65': 0.383,
      '0.70': 0.413,
      '0.80': 0.472,
    },
    '9mm': {
      '0.45': 0.298,
      '0.50': 0.332,
      '0.55': 0.365,
      '0.60': 0.398,
      '0.65': 0.431,
      '0.70': 0.464,
      '0.80': 0.531,
    },
    '12mm': {
      '0.45': 0.398,
      '0.50': 0.442,
      '0.55': 0.487,
      '0.60': 0.531,
      '0.65': 0.575,
      '0.70': 0.619,
      '0.80': 0.708,
    },
    '13mm': {
      '0.45': 0.431,
      '0.50': 0.479,
      '0.55': 0.527,
      '0.60': 0.575,
      '0.65': 0.623,
      '0.70': 0.671,
      '0.80': 0.767,
    },
    '16mm': {
      '0.45': 0.531,
      '0.50': 0.590,
      '0.55': 0.649,
      '0.60': 0.708,
      '0.65': 0.767,
      '0.70': 0.826,
      '0.80': 0.944,
    },
    '17mm': {
      '0.45': 0.564,
      '0.50': 0.627,
      '0.55': 0.689,
      '0.60': 0.752,
      '0.65': 0.815,
      '0.70': 0.877,
      '0.80': 1.003,
    },
    '18mm': {
      '0.45': 0.597,
      '0.50': 0.663,
      '0.55': 0.730,
      '0.60': 0.796,
      '0.65': 0.862,
      '0.70': 0.929,
      '0.80': 1.062,
    },
    '19mm': {
      '0.45': 0.630,
      '0.50': 0.700,
      '0.55': 0.770,
      '0.60': 0.840,
      '0.65': 0.910,
      '0.70': 0.980,
      '0.80': 1.121,
    },
    '22mm': {
      '0.45': 0.730,
      '0.50': 0.811,
      '0.55': 0.892,
      '0.60': 0.973,
      '0.65': 1.054,
      '0.70': 1.135,
      '0.80': 1.297,
    },
    '25mm sheet': {
      '0.45': 0.829,
      '0.50': 0.921,
      '0.55': 1.013,
      '0.60': 1.106,
      '0.65': 1.198,
      '0.70': 1.290,
      '0.80': 1.475,
    },
    '25mm Door': {
      '0.45': 0.829,
      '0.50': 0.921,
      '0.55': 1.013,
      '0.60': 1.106,
      '0.65': 1.198,
      '0.70': 1.290,
      '0.80': 1.475,
    },
    '26mm': {
      '0.45': 0.862,
      '0.50': 0.958,
      '0.55': 1.054,
      '0.60': 1.150,
      '0.65': 1.246,
      '0.70': 1.341,
      '0.80': 1.534,
    },
    '27mm': {
      '0.45': 0.895,
      '0.50': 0.995,
      '0.55': 1.094,
      '0.60': 1.194,
      '0.65': 1.293,
      '0.70': 1.393,
      '0.80': 1.593,
    },
    '28mm': {
      '0.45': 0.929,
      '0.50': 1.032,
      '0.55': 1.135,
      '0.60': 1.238,
      '0.65': 1.341,
      '0.70': 1.444,
      '0.80': 1.652,
    },
    '30mm': {
      '0.45': 0.995,
      '0.50': 1.106,
      '0.55': 1.216,
      '0.60': 1.327,
      '0.65': 1.437,
      '0.70': 1.548,
      '0.80': 1.770,
    },
    '31mm': {
      '0.45': 1.028,
      '0.50': 1.143,
      '0.55': 1.257,
      '0.60': 1.371,
      '0.65': 1.485,
      '0.70': 1.600,
      '0.80': 1.829,
    },
    '33mm': {
      '0.45': 1.094,
      '0.50': 1.216,
      '0.55': 1.338,
      '0.60': 1.460,
      '0.65': 1.581,
      '0.70': 1.703,
      '0.80': 1.947,
    },
    '35mm': {
      '0.45': 1.161,
      '0.50': 1.290,
      '0.55': 1.419,
      '0.60': 1.548,
      '0.65': 1.677,
      '0.70': 1.806,
      '0.80': 2.065,
    },
    '36mm': {
      '0.45': 1.194,
      '0.50': 1.327,
      '0.55': 1.460,
      '0.60': 1.593,
      '0.65': 1.725,
      '0.70': 1.858,
      '0.80': 2.124,
    },
  };

  // Frame production targets: section × density → target kg per hour
  // Density dimension allows admin to configure density-specific targets.
  static const Map<String, Map<String, double>> defaultFrameTargets = {
    '3x2':            {'0.75': 80.0,  '0.80': 80.0,  '0.90': 80.0},
    '4x2':            {'0.75': 100.0, '0.80': 100.0, '0.90': 100.0},
    '4x2.5':          {'0.75': 120.0, '0.80': 120.0, '0.90': 120.0},
    '5x2.5':          {'0.75': 140.0, '0.80': 140.0, '0.90': 140.0},
    '3x2 (HR)':       {'0.75': 80.0,  '0.80': 80.0,  '0.90': 80.0},
    '4x2.5(HR)':      {'0.75': 120.0, '0.80': 120.0, '0.90': 120.0},
    'Window Shutter': {'0.75': 90.0,  '0.80': 90.0,  '0.90': 90.0},
  };

  // Sheet production targets: thickness × density → target running feet per hour
  static const Map<String, Map<String, double>> defaultSheetTargets = {
    '6mm':        {'0.45': 250.0, '0.50': 250.0, '0.55': 250.0, '0.60': 250.0, '0.65': 250.0, '0.70': 250.0, '0.80': 250.0},
    '7mm':        {'0.45': 230.0, '0.50': 230.0, '0.55': 230.0, '0.60': 230.0, '0.65': 230.0, '0.70': 230.0, '0.80': 230.0},
    '8mm':        {'0.45': 210.0, '0.50': 210.0, '0.55': 210.0, '0.60': 210.0, '0.65': 210.0, '0.70': 210.0, '0.80': 210.0},
    '9mm':        {'0.45': 200.0, '0.50': 200.0, '0.55': 200.0, '0.60': 200.0, '0.65': 200.0, '0.70': 200.0, '0.80': 200.0},
    '12mm':       {'0.45': 170.0, '0.50': 170.0, '0.55': 170.0, '0.60': 170.0, '0.65': 170.0, '0.70': 170.0, '0.80': 170.0},
    '13mm':       {'0.45': 160.0, '0.50': 160.0, '0.55': 160.0, '0.60': 160.0, '0.65': 160.0, '0.70': 160.0, '0.80': 160.0},
    '16mm':       {'0.45': 140.0, '0.50': 140.0, '0.55': 140.0, '0.60': 140.0, '0.65': 140.0, '0.70': 140.0, '0.80': 140.0},
    '17mm':       {'0.45': 130.0, '0.50': 130.0, '0.55': 130.0, '0.60': 130.0, '0.65': 130.0, '0.70': 130.0, '0.80': 130.0},
    '18mm':       {'0.45': 125.0, '0.50': 125.0, '0.55': 125.0, '0.60': 125.0, '0.65': 125.0, '0.70': 125.0, '0.80': 125.0},
    '19mm':       {'0.45': 120.0, '0.50': 120.0, '0.55': 120.0, '0.60': 120.0, '0.65': 120.0, '0.70': 120.0, '0.80': 120.0},
    '22mm':       {'0.45': 100.0, '0.50': 100.0, '0.55': 100.0, '0.60': 100.0, '0.65': 100.0, '0.70': 100.0, '0.80': 100.0},
    '25mm sheet': {'0.45':  85.0, '0.50':  85.0, '0.55':  85.0, '0.60':  85.0, '0.65':  85.0, '0.70':  85.0, '0.80':  85.0},
    '25mm Door':  {'0.45':  85.0, '0.50':  85.0, '0.55':  85.0, '0.60':  85.0, '0.65':  85.0, '0.70':  85.0, '0.80':  85.0},
    '26mm':       {'0.45':  80.0, '0.50':  80.0, '0.55':  80.0, '0.60':  80.0, '0.65':  80.0, '0.70':  80.0, '0.80':  80.0},
    '27mm':       {'0.45':  78.0, '0.50':  78.0, '0.55':  78.0, '0.60':  78.0, '0.65':  78.0, '0.70':  78.0, '0.80':  78.0},
    '28mm':       {'0.45':  75.0, '0.50':  75.0, '0.55':  75.0, '0.60':  75.0, '0.65':  75.0, '0.70':  75.0, '0.80':  75.0},
    '30mm':       {'0.45':  70.0, '0.50':  70.0, '0.55':  70.0, '0.60':  70.0, '0.65':  70.0, '0.70':  70.0, '0.80':  70.0},
    '31mm':       {'0.45':  68.0, '0.50':  68.0, '0.55':  68.0, '0.60':  68.0, '0.65':  68.0, '0.70':  68.0, '0.80':  68.0},
    '33mm':       {'0.45':  60.0, '0.50':  60.0, '0.55':  60.0, '0.60':  60.0, '0.65':  60.0, '0.70':  60.0, '0.80':  60.0},
    '35mm':       {'0.45':  55.0, '0.50':  55.0, '0.55':  55.0, '0.60':  55.0, '0.65':  55.0, '0.70':  55.0, '0.80':  55.0},
    '36mm':       {'0.45':  52.0, '0.50':  52.0, '0.55':  52.0, '0.60':  52.0, '0.65':  52.0, '0.70':  52.0, '0.80':  52.0},
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

  // Firestore collections (for report data — NOT for reference/lookup tables,
  // which are stored in Cloud SQL via Firebase DataConnect)
  static const String usersCollection = 'users';
  static const String frameReportsCollection = 'frameReports';
  static const String sheetReportsCollection = 'sheetReports';
  static const String scrapRegrindReportsCollection = 'scrapRegrindReports';
  static const String salaryCalculationsCollection = 'salaryCalculations';
}
