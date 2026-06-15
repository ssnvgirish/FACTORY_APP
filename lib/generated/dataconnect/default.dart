library factory_app;
import 'package:firebase_data_connect/firebase_data_connect.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';

part 'list_master_machines.dart';

part 'insert_master_machine.dart';

part 'update_master_machine.dart';

part 'delete_master_machine.dart';

part 'list_master_shifts.dart';

part 'insert_master_shift.dart';

part 'update_master_shift.dart';

part 'delete_master_shift.dart';

part 'list_master_roles.dart';

part 'insert_master_role.dart';

part 'update_master_role.dart';

part 'delete_master_role.dart';

part 'list_master_frame_sections.dart';

part 'insert_master_frame_section.dart';

part 'update_master_frame_section.dart';

part 'delete_master_frame_section.dart';

part 'list_master_frame_densities.dart';

part 'insert_master_frame_density.dart';

part 'update_master_frame_density.dart';

part 'delete_master_frame_density.dart';

part 'list_master_frame_colors.dart';

part 'insert_master_frame_color.dart';

part 'update_master_frame_color.dart';

part 'delete_master_frame_color.dart';

part 'list_master_sheet_thicknesses.dart';

part 'insert_master_sheet_thickness.dart';

part 'update_master_sheet_thickness.dart';

part 'delete_master_sheet_thickness.dart';

part 'list_master_sheet_densities.dart';

part 'insert_master_sheet_density.dart';

part 'update_master_sheet_density.dart';

part 'delete_master_sheet_density.dart';

part 'list_master_sheet_colors.dart';

part 'insert_master_sheet_color.dart';

part 'update_master_sheet_color.dart';

part 'delete_master_sheet_color.dart';

part 'list_master_maintenance_items.dart';

part 'insert_master_maintenance_item.dart';

part 'update_master_maintenance_item.dart';

part 'delete_master_maintenance_item.dart';

part 'list_master_scrap_products.dart';

part 'insert_master_scrap_product.dart';

part 'update_master_scrap_product.dart';

part 'delete_master_scrap_product.dart';

part 'list_master_frame_weights.dart';

part 'insert_master_frame_weight.dart';

part 'update_master_frame_weight.dart';

part 'delete_master_frame_weight.dart';

part 'list_master_sheet_weights.dart';

part 'insert_master_sheet_weight.dart';

part 'update_master_sheet_weight.dart';

part 'delete_master_sheet_weight.dart';

part 'list_master_frame_targets.dart';

part 'insert_master_frame_target.dart';

part 'update_master_frame_target.dart';

part 'delete_master_frame_target.dart';

part 'list_master_sheet_targets.dart';

part 'insert_master_sheet_target.dart';

part 'update_master_sheet_target.dart';

part 'delete_master_sheet_target.dart';

part 'list_master_salary_weightages.dart';

part 'insert_master_salary_weightage.dart';

part 'update_master_salary_weightage.dart';

part 'delete_master_salary_weightage.dart';

part 'list_master_scrap_targets.dart';

part 'insert_master_scrap_target.dart';

part 'update_master_scrap_target.dart';

part 'delete_master_scrap_target.dart';

part 'create_user.dart';

part 'update_user.dart';

part 'toggle_user_active.dart';

part 'get_user_by_phone.dart';

part 'get_user_by_id.dart';

part 'list_all_users.dart';

part 'create_salary_calculation.dart';

part 'update_salary_calculation.dart';

part 'get_salary_calculation.dart';

part 'list_salary_calculations.dart';

part 'list_all_salary_calculations_for_month.dart';

part 'create_scrap_cleaning_report.dart';

part 'list_scrap_cleaning_reports.dart';

part 'create_scrap_tools_count_report.dart';

part 'list_scrap_tools_count_reports.dart';

part 'create_scrap_machine_health_report.dart';

part 'create_scrap_maintenance_entry.dart';

part 'list_scrap_machine_health_reports.dart';

part 'create_scrap_production_details_report.dart';

part 'create_scrap_production_line_item.dart';

part 'list_scrap_production_details_reports.dart';

part 'get_scrap_production_details_report.dart';

part 'create_scrap_production_weight_report.dart';

part 'list_scrap_production_weight_reports.dart';

part 'create_scrap_writing_efficiency.dart';

part 'list_scrap_report_writing_efficiency.dart';

part 'create_scrap_quality_report.dart';

part 'list_scrap_quality_reports.dart';

part 'create_scrap_salary_calculation.dart';

part 'get_scrap_salary_calculation.dart';

part 'get_scrap_salary_weightages.dart';

part 'get_scrap_monthly_aggregates.dart';

part 'seed_admin_user.dart';

part 'seed_operator1.dart';

part 'seed_operator2.dart';

part 'seed_operator3.dart';

part 'seed_operator4.dart';

part 'seed_quality_packing.dart';

part 'seed_machine_frame1.dart';

part 'seed_machine_frame2.dart';

part 'seed_machine_sheet3.dart';

part 'seed_machine_sheet4.dart';

part 'seed_machine_sheet5.dart';

part 'seed_machine_crusher1.dart';

part 'seed_machine_crusher2.dart';

part 'seed_machine_crusher3.dart';

part 'seed_machine_pulverizer1.dart';

part 'seed_machine_pulverizer2.dart';

part 'seed_machine_pulverizer3.dart';

part 'seed_machine_shredder.dart';

part 'seed_shift_day.dart';

part 'seed_shift_night.dart';

part 'seed_role_operator.dart';

part 'seed_role_quality.dart';

part 'seed_role_frame_senior.dart';

part 'seed_role_sheet_senior.dart';

part 'seed_role_plant_manager.dart';

part 'seed_role_admin.dart';

part 'seed_frame_section1.dart';

part 'seed_frame_section2.dart';

part 'seed_frame_section3.dart';

part 'seed_frame_section4.dart';

part 'seed_frame_section5.dart';

part 'seed_frame_section6.dart';

part 'seed_frame_section7.dart';

part 'seed_frame_density1.dart';

part 'seed_frame_density2.dart';

part 'seed_frame_density3.dart';

part 'seed_frame_density4.dart';

part 'seed_frame_color1.dart';

part 'seed_frame_color2.dart';

part 'seed_frame_color3.dart';

part 'seed_sheet_thick1.dart';

part 'seed_sheet_thick2.dart';

part 'seed_sheet_thick3.dart';

part 'seed_sheet_thick4.dart';

part 'seed_sheet_thick5.dart';

part 'seed_sheet_thick6.dart';

part 'seed_sheet_thick7.dart';

part 'seed_sheet_thick8.dart';

part 'seed_sheet_thick9.dart';

part 'seed_sheet_thick10.dart';

part 'seed_sheet_thick11.dart';

part 'seed_sheet_thick12.dart';

part 'seed_sheet_thick13.dart';

part 'seed_sheet_thick14.dart';

part 'seed_sheet_thick15.dart';

part 'seed_sheet_thick16.dart';

part 'seed_sheet_thick17.dart';

part 'seed_sheet_thick18.dart';

part 'seed_sheet_thick19.dart';

part 'seed_sheet_thick20.dart';

part 'seed_sheet_thick21.dart';

part 'seed_sheet_density1.dart';

part 'seed_sheet_density2.dart';

part 'seed_sheet_density3.dart';

part 'seed_sheet_density4.dart';

part 'seed_sheet_density5.dart';

part 'seed_sheet_density6.dart';

part 'seed_sheet_density7.dart';

part 'seed_sheet_density8.dart';

part 'seed_sheet_color1.dart';

part 'seed_sheet_color2.dart';

part 'seed_sheet_color3.dart';

part 'seed_sheet_color4.dart';

part 'seed_sheet_color5.dart';

part 'seed_maint1.dart';

part 'seed_maint2.dart';

part 'seed_maint3.dart';

part 'seed_maint4.dart';

part 'seed_maint5.dart';

part 'seed_maint6.dart';

part 'seed_maint7.dart';

part 'seed_maint8.dart';

part 'seed_maint9.dart';

part 'seed_maint_scrap1.dart';

part 'seed_maint_scrap2.dart';

part 'seed_maint_scrap3.dart';

part 'seed_maint_scrap4.dart';

part 'seed_maint_scrap5.dart';

part 'seed_maint_scrap6.dart';

part 'seed_maint_scrap7.dart';

part 'seed_maint_scrap8.dart';

part 'seed_scrap_prod1.dart';

part 'seed_scrap_prod2.dart';

part 'seed_scrap_prod3.dart';

part 'seed_scrap_prod4.dart';

part 'seed_scrap_prod5.dart';

part 'seed_scrap_prod6.dart';

part 'seed_fw1.dart';

part 'seed_fw2.dart';

part 'seed_fw3.dart';

part 'seed_fw4.dart';

part 'seed_fw5.dart';

part 'seed_fw6.dart';

part 'seed_fw7.dart';

part 'seed_fw8.dart';

part 'seed_fw9.dart';

part 'seed_fw10.dart';

part 'seed_fw11.dart';

part 'seed_fw12.dart';

part 'seed_fw13.dart';

part 'seed_fw14.dart';

part 'seed_fw15.dart';

part 'seed_fw16.dart';

part 'seed_fw17.dart';

part 'seed_fw18.dart';

part 'seed_fw19.dart';

part 'seed_fw20.dart';

part 'seed_fw21.dart';

part 'seed_salary_wa.dart';

part 'seed_salary_wb.dart';

part 'seed_salary_wc.dart';

part 'seed_salary_wd.dart';

part 'seed_salary_we.dart';

part 'seed_salary_wf.dart';

part 'seed_scrap_salary_wa.dart';

part 'seed_scrap_salary_wb.dart';

part 'seed_scrap_salary_we.dart';

part 'seed_scrap_salary_wf.dart';

part 'seed_scrap_salary_wg.dart';

part 'seed_frame_cleaning1.dart';

part 'seed_frame_cleaning2.dart';

part 'seed_frame_cleaning3.dart';

part 'seed_frame_cleaning4.dart';

part 'seed_frame_cleaning5.dart';

part 'seed_frame_tools1.dart';

part 'seed_frame_tools2.dart';

part 'seed_frame_tools3.dart';

part 'seed_frame_tools4.dart';

part 'seed_frame_health1.dart';

part 'seed_frame_health2.dart';

part 'seed_frame_health3.dart';

part 'seed_frame_weight1.dart';

part 'seed_frame_weight2.dart';

part 'seed_frame_weight3.dart';

part 'seed_frame_weight4.dart';

part 'seed_sheet_cleaning1.dart';

part 'seed_sheet_cleaning2.dart';

part 'seed_sheet_cleaning3.dart';

part 'seed_sheet_cleaning4.dart';

part 'seed_sheet_cleaning5.dart';

part 'seed_sheet_running_feet1.dart';

part 'seed_sheet_running_feet2.dart';

part 'seed_sheet_running_feet3.dart';

part 'seed_salary_op1.dart';

part 'seed_salary_op2.dart';

part 'seed_salary_op3.dart';

part 'seed_salary_op4.dart';

part 'seed_frame_writing1.dart';

part 'seed_frame_writing2.dart';

part 'seed_frame_writing3.dart';

part 'seed_sheet_writing1.dart';

part 'seed_sheet_writing2.dart';

part 'seed_scrap_operator1.dart';

part 'seed_scrap_operator2.dart';

part 'seed_scrap_cleaning1.dart';

part 'seed_scrap_cleaning2.dart';

part 'seed_scrap_cleaning3.dart';

part 'seed_scrap_cleaning4.dart';

part 'seed_scrap_tools1.dart';

part 'seed_scrap_tools2.dart';

part 'seed_scrap_tools3.dart';

part 'seed_scrap_prod_weight1.dart';

part 'seed_scrap_prod_weight2.dart';

part 'seed_scrap_prod_weight3.dart';

part 'seed_scrap_writing1.dart';

part 'seed_scrap_writing2.dart';

part 'seed_scrap_writing3.dart';

part 'seed_scrap_quality1.dart';

part 'seed_scrap_quality2.dart';

part 'seed_scrap_quality3.dart';

part 'seed_scrap_quality4.dart';

part 'seed_scrap_salary1.dart';

part 'seed_scrap_salary2.dart';

part 'create_sheet_cleaning_report.dart';

part 'list_sheet_cleaning_reports.dart';

part 'create_sheet_tools_count_report.dart';

part 'list_sheet_tools_count_reports.dart';

part 'create_sheet_health_report.dart';

part 'create_sheet_health_rating_item.dart';

part 'list_sheet_health_reports.dart';

part 'create_sheet_production_details_report.dart';

part 'create_sheet_production_line_item.dart';

part 'list_sheet_production_details_reports.dart';

part 'get_sheet_production_details_report.dart';

part 'create_sheet_running_feet_report.dart';

part 'list_sheet_running_feet_reports.dart';

part 'create_sheet_shift_packing_report.dart';

part 'create_sheet_packing_line_item.dart';

part 'list_sheet_shift_packing_reports.dart';

part 'create_sheet_writing_efficiency.dart';

part 'list_sheet_writing_efficiency.dart';

part 'create_sheet_customer_rejection_report.dart';

part 'create_sheet_customer_rejection_item.dart';

part 'list_sheet_customer_rejection_reports.dart';

part 'create_frame_cleaning_report.dart';

part 'list_frame_cleaning_reports.dart';

part 'create_frame_tools_count_report.dart';

part 'list_frame_tools_count_reports.dart';

part 'create_frame_health_report.dart';

part 'create_frame_health_rating_item.dart';

part 'list_frame_health_reports.dart';

part 'create_frame_production_details_report.dart';

part 'create_frame_production_line_item.dart';

part 'list_frame_production_details_reports.dart';

part 'get_frame_production_details_report.dart';

part 'create_frame_production_weight_report.dart';

part 'list_frame_production_weight_reports.dart';

part 'create_frame_shift_packing_report.dart';

part 'create_frame_packing_line_item.dart';

part 'list_frame_shift_packing_reports.dart';

part 'create_frame_writing_efficiency.dart';

part 'list_frame_writing_efficiency.dart';

part 'create_frame_customer_rejection_report.dart';

part 'create_frame_customer_rejection_item.dart';

part 'list_frame_customer_rejection_reports.dart';







class DefaultConnector {
  
  
  ListMasterMachinesVariablesBuilder listMasterMachines () {
    return ListMasterMachinesVariablesBuilder(dataConnect, );
  }
  
  
  InsertMasterMachineVariablesBuilder insertMasterMachine ({required String name, required String type, required int sortOrder, required bool isActive, }) {
    return InsertMasterMachineVariablesBuilder(dataConnect, name: name,type: type,sortOrder: sortOrder,isActive: isActive,);
  }
  
  
  UpdateMasterMachineVariablesBuilder updateMasterMachine ({required UpdateMasterMachineVariablesId id, required String name, required String type, required int sortOrder, required bool isActive, }) {
    return UpdateMasterMachineVariablesBuilder(dataConnect, id: id,name: name,type: type,sortOrder: sortOrder,isActive: isActive,);
  }
  
  
  DeleteMasterMachineVariablesBuilder deleteMasterMachine ({required DeleteMasterMachineVariablesId id, }) {
    return DeleteMasterMachineVariablesBuilder(dataConnect, id: id,);
  }
  
  
  ListMasterShiftsVariablesBuilder listMasterShifts () {
    return ListMasterShiftsVariablesBuilder(dataConnect, );
  }
  
  
  InsertMasterShiftVariablesBuilder insertMasterShift ({required String name, required int sortOrder, required bool isActive, }) {
    return InsertMasterShiftVariablesBuilder(dataConnect, name: name,sortOrder: sortOrder,isActive: isActive,);
  }
  
  
  UpdateMasterShiftVariablesBuilder updateMasterShift ({required UpdateMasterShiftVariablesId id, required String name, required int sortOrder, required bool isActive, }) {
    return UpdateMasterShiftVariablesBuilder(dataConnect, id: id,name: name,sortOrder: sortOrder,isActive: isActive,);
  }
  
  
  DeleteMasterShiftVariablesBuilder deleteMasterShift ({required DeleteMasterShiftVariablesId id, }) {
    return DeleteMasterShiftVariablesBuilder(dataConnect, id: id,);
  }
  
  
  ListMasterRolesVariablesBuilder listMasterRoles () {
    return ListMasterRolesVariablesBuilder(dataConnect, );
  }
  
  
  InsertMasterRoleVariablesBuilder insertMasterRole ({required String code, required String displayName, required int sortOrder, required bool isActive, }) {
    return InsertMasterRoleVariablesBuilder(dataConnect, code: code,displayName: displayName,sortOrder: sortOrder,isActive: isActive,);
  }
  
  
  UpdateMasterRoleVariablesBuilder updateMasterRole ({required UpdateMasterRoleVariablesId id, required String code, required String displayName, required int sortOrder, required bool isActive, }) {
    return UpdateMasterRoleVariablesBuilder(dataConnect, id: id,code: code,displayName: displayName,sortOrder: sortOrder,isActive: isActive,);
  }
  
  
  DeleteMasterRoleVariablesBuilder deleteMasterRole ({required DeleteMasterRoleVariablesId id, }) {
    return DeleteMasterRoleVariablesBuilder(dataConnect, id: id,);
  }
  
  
  ListMasterFrameSectionsVariablesBuilder listMasterFrameSections () {
    return ListMasterFrameSectionsVariablesBuilder(dataConnect, );
  }
  
  
  InsertMasterFrameSectionVariablesBuilder insertMasterFrameSection ({required String name, required int sortOrder, required bool isActive, }) {
    return InsertMasterFrameSectionVariablesBuilder(dataConnect, name: name,sortOrder: sortOrder,isActive: isActive,);
  }
  
  
  UpdateMasterFrameSectionVariablesBuilder updateMasterFrameSection ({required UpdateMasterFrameSectionVariablesId id, required String name, required int sortOrder, required bool isActive, }) {
    return UpdateMasterFrameSectionVariablesBuilder(dataConnect, id: id,name: name,sortOrder: sortOrder,isActive: isActive,);
  }
  
  
  DeleteMasterFrameSectionVariablesBuilder deleteMasterFrameSection ({required DeleteMasterFrameSectionVariablesId id, }) {
    return DeleteMasterFrameSectionVariablesBuilder(dataConnect, id: id,);
  }
  
  
  ListMasterFrameDensitiesVariablesBuilder listMasterFrameDensities () {
    return ListMasterFrameDensitiesVariablesBuilder(dataConnect, );
  }
  
  
  InsertMasterFrameDensityVariablesBuilder insertMasterFrameDensity ({required String value, required int sortOrder, required bool isActive, }) {
    return InsertMasterFrameDensityVariablesBuilder(dataConnect, value: value,sortOrder: sortOrder,isActive: isActive,);
  }
  
  
  UpdateMasterFrameDensityVariablesBuilder updateMasterFrameDensity ({required UpdateMasterFrameDensityVariablesId id, required String value, required int sortOrder, required bool isActive, }) {
    return UpdateMasterFrameDensityVariablesBuilder(dataConnect, id: id,value: value,sortOrder: sortOrder,isActive: isActive,);
  }
  
  
  DeleteMasterFrameDensityVariablesBuilder deleteMasterFrameDensity ({required DeleteMasterFrameDensityVariablesId id, }) {
    return DeleteMasterFrameDensityVariablesBuilder(dataConnect, id: id,);
  }
  
  
  ListMasterFrameColorsVariablesBuilder listMasterFrameColors () {
    return ListMasterFrameColorsVariablesBuilder(dataConnect, );
  }
  
  
  InsertMasterFrameColorVariablesBuilder insertMasterFrameColor ({required String name, required int sortOrder, required bool isActive, }) {
    return InsertMasterFrameColorVariablesBuilder(dataConnect, name: name,sortOrder: sortOrder,isActive: isActive,);
  }
  
  
  UpdateMasterFrameColorVariablesBuilder updateMasterFrameColor ({required UpdateMasterFrameColorVariablesId id, required String name, required int sortOrder, required bool isActive, }) {
    return UpdateMasterFrameColorVariablesBuilder(dataConnect, id: id,name: name,sortOrder: sortOrder,isActive: isActive,);
  }
  
  
  DeleteMasterFrameColorVariablesBuilder deleteMasterFrameColor ({required DeleteMasterFrameColorVariablesId id, }) {
    return DeleteMasterFrameColorVariablesBuilder(dataConnect, id: id,);
  }
  
  
  ListMasterSheetThicknessesVariablesBuilder listMasterSheetThicknesses () {
    return ListMasterSheetThicknessesVariablesBuilder(dataConnect, );
  }
  
  
  InsertMasterSheetThicknessVariablesBuilder insertMasterSheetThickness ({required String value, required int sortOrder, required bool isActive, }) {
    return InsertMasterSheetThicknessVariablesBuilder(dataConnect, value: value,sortOrder: sortOrder,isActive: isActive,);
  }
  
  
  UpdateMasterSheetThicknessVariablesBuilder updateMasterSheetThickness ({required UpdateMasterSheetThicknessVariablesId id, required String value, required int sortOrder, required bool isActive, }) {
    return UpdateMasterSheetThicknessVariablesBuilder(dataConnect, id: id,value: value,sortOrder: sortOrder,isActive: isActive,);
  }
  
  
  DeleteMasterSheetThicknessVariablesBuilder deleteMasterSheetThickness ({required DeleteMasterSheetThicknessVariablesId id, }) {
    return DeleteMasterSheetThicknessVariablesBuilder(dataConnect, id: id,);
  }
  
  
  ListMasterSheetDensitiesVariablesBuilder listMasterSheetDensities () {
    return ListMasterSheetDensitiesVariablesBuilder(dataConnect, );
  }
  
  
  InsertMasterSheetDensityVariablesBuilder insertMasterSheetDensity ({required String value, required int sortOrder, required bool isActive, }) {
    return InsertMasterSheetDensityVariablesBuilder(dataConnect, value: value,sortOrder: sortOrder,isActive: isActive,);
  }
  
  
  UpdateMasterSheetDensityVariablesBuilder updateMasterSheetDensity ({required UpdateMasterSheetDensityVariablesId id, required String value, required int sortOrder, required bool isActive, }) {
    return UpdateMasterSheetDensityVariablesBuilder(dataConnect, id: id,value: value,sortOrder: sortOrder,isActive: isActive,);
  }
  
  
  DeleteMasterSheetDensityVariablesBuilder deleteMasterSheetDensity ({required DeleteMasterSheetDensityVariablesId id, }) {
    return DeleteMasterSheetDensityVariablesBuilder(dataConnect, id: id,);
  }
  
  
  ListMasterSheetColorsVariablesBuilder listMasterSheetColors () {
    return ListMasterSheetColorsVariablesBuilder(dataConnect, );
  }
  
  
  InsertMasterSheetColorVariablesBuilder insertMasterSheetColor ({required String name, required int sortOrder, required bool isActive, }) {
    return InsertMasterSheetColorVariablesBuilder(dataConnect, name: name,sortOrder: sortOrder,isActive: isActive,);
  }
  
  
  UpdateMasterSheetColorVariablesBuilder updateMasterSheetColor ({required UpdateMasterSheetColorVariablesId id, required String name, required int sortOrder, required bool isActive, }) {
    return UpdateMasterSheetColorVariablesBuilder(dataConnect, id: id,name: name,sortOrder: sortOrder,isActive: isActive,);
  }
  
  
  DeleteMasterSheetColorVariablesBuilder deleteMasterSheetColor ({required DeleteMasterSheetColorVariablesId id, }) {
    return DeleteMasterSheetColorVariablesBuilder(dataConnect, id: id,);
  }
  
  
  ListMasterMaintenanceItemsVariablesBuilder listMasterMaintenanceItems () {
    return ListMasterMaintenanceItemsVariablesBuilder(dataConnect, );
  }
  
  
  InsertMasterMaintenanceItemVariablesBuilder insertMasterMaintenanceItem ({required String name, required String category, required int sortOrder, required bool isActive, }) {
    return InsertMasterMaintenanceItemVariablesBuilder(dataConnect, name: name,category: category,sortOrder: sortOrder,isActive: isActive,);
  }
  
  
  UpdateMasterMaintenanceItemVariablesBuilder updateMasterMaintenanceItem ({required UpdateMasterMaintenanceItemVariablesId id, required String name, required String category, required int sortOrder, required bool isActive, }) {
    return UpdateMasterMaintenanceItemVariablesBuilder(dataConnect, id: id,name: name,category: category,sortOrder: sortOrder,isActive: isActive,);
  }
  
  
  DeleteMasterMaintenanceItemVariablesBuilder deleteMasterMaintenanceItem ({required DeleteMasterMaintenanceItemVariablesId id, }) {
    return DeleteMasterMaintenanceItemVariablesBuilder(dataConnect, id: id,);
  }
  
  
  ListMasterScrapProductsVariablesBuilder listMasterScrapProducts () {
    return ListMasterScrapProductsVariablesBuilder(dataConnect, );
  }
  
  
  InsertMasterScrapProductVariablesBuilder insertMasterScrapProduct ({required String name, required int sortOrder, required bool isActive, }) {
    return InsertMasterScrapProductVariablesBuilder(dataConnect, name: name,sortOrder: sortOrder,isActive: isActive,);
  }
  
  
  UpdateMasterScrapProductVariablesBuilder updateMasterScrapProduct ({required UpdateMasterScrapProductVariablesId id, required String name, required int sortOrder, required bool isActive, }) {
    return UpdateMasterScrapProductVariablesBuilder(dataConnect, id: id,name: name,sortOrder: sortOrder,isActive: isActive,);
  }
  
  
  DeleteMasterScrapProductVariablesBuilder deleteMasterScrapProduct ({required DeleteMasterScrapProductVariablesId id, }) {
    return DeleteMasterScrapProductVariablesBuilder(dataConnect, id: id,);
  }
  
  
  ListMasterFrameWeightsVariablesBuilder listMasterFrameWeights () {
    return ListMasterFrameWeightsVariablesBuilder(dataConnect, );
  }
  
  
  InsertMasterFrameWeightVariablesBuilder insertMasterFrameWeight ({required String section, required String density, required double weightPerFoot, }) {
    return InsertMasterFrameWeightVariablesBuilder(dataConnect, section: section,density: density,weightPerFoot: weightPerFoot,);
  }
  
  
  UpdateMasterFrameWeightVariablesBuilder updateMasterFrameWeight ({required UpdateMasterFrameWeightVariablesId id, required String section, required String density, required double weightPerFoot, }) {
    return UpdateMasterFrameWeightVariablesBuilder(dataConnect, id: id,section: section,density: density,weightPerFoot: weightPerFoot,);
  }
  
  
  DeleteMasterFrameWeightVariablesBuilder deleteMasterFrameWeight ({required DeleteMasterFrameWeightVariablesId id, }) {
    return DeleteMasterFrameWeightVariablesBuilder(dataConnect, id: id,);
  }
  
  
  ListMasterSheetWeightsVariablesBuilder listMasterSheetWeights () {
    return ListMasterSheetWeightsVariablesBuilder(dataConnect, );
  }
  
  
  InsertMasterSheetWeightVariablesBuilder insertMasterSheetWeight ({required String thickness, required String density, required double weightPerSqft, }) {
    return InsertMasterSheetWeightVariablesBuilder(dataConnect, thickness: thickness,density: density,weightPerSqft: weightPerSqft,);
  }
  
  
  UpdateMasterSheetWeightVariablesBuilder updateMasterSheetWeight ({required UpdateMasterSheetWeightVariablesId id, required String thickness, required String density, required double weightPerSqft, }) {
    return UpdateMasterSheetWeightVariablesBuilder(dataConnect, id: id,thickness: thickness,density: density,weightPerSqft: weightPerSqft,);
  }
  
  
  DeleteMasterSheetWeightVariablesBuilder deleteMasterSheetWeight ({required DeleteMasterSheetWeightVariablesId id, }) {
    return DeleteMasterSheetWeightVariablesBuilder(dataConnect, id: id,);
  }
  
  
  ListMasterFrameTargetsVariablesBuilder listMasterFrameTargets () {
    return ListMasterFrameTargetsVariablesBuilder(dataConnect, );
  }
  
  
  InsertMasterFrameTargetVariablesBuilder insertMasterFrameTarget ({required String section, required double targetKgPerHour, }) {
    return InsertMasterFrameTargetVariablesBuilder(dataConnect, section: section,targetKgPerHour: targetKgPerHour,);
  }
  
  
  UpdateMasterFrameTargetVariablesBuilder updateMasterFrameTarget ({required UpdateMasterFrameTargetVariablesId id, required String section, required double targetKgPerHour, }) {
    return UpdateMasterFrameTargetVariablesBuilder(dataConnect, id: id,section: section,targetKgPerHour: targetKgPerHour,);
  }
  
  
  DeleteMasterFrameTargetVariablesBuilder deleteMasterFrameTarget ({required DeleteMasterFrameTargetVariablesId id, }) {
    return DeleteMasterFrameTargetVariablesBuilder(dataConnect, id: id,);
  }
  
  
  ListMasterSheetTargetsVariablesBuilder listMasterSheetTargets () {
    return ListMasterSheetTargetsVariablesBuilder(dataConnect, );
  }
  
  
  InsertMasterSheetTargetVariablesBuilder insertMasterSheetTarget ({required String thickness, required double targetFeetPerHour, }) {
    return InsertMasterSheetTargetVariablesBuilder(dataConnect, thickness: thickness,targetFeetPerHour: targetFeetPerHour,);
  }
  
  
  UpdateMasterSheetTargetVariablesBuilder updateMasterSheetTarget ({required UpdateMasterSheetTargetVariablesId id, required String thickness, required double targetFeetPerHour, }) {
    return UpdateMasterSheetTargetVariablesBuilder(dataConnect, id: id,thickness: thickness,targetFeetPerHour: targetFeetPerHour,);
  }
  
  
  DeleteMasterSheetTargetVariablesBuilder deleteMasterSheetTarget ({required DeleteMasterSheetTargetVariablesId id, }) {
    return DeleteMasterSheetTargetVariablesBuilder(dataConnect, id: id,);
  }
  
  
  ListMasterSalaryWeightagesVariablesBuilder listMasterSalaryWeightages () {
    return ListMasterSalaryWeightagesVariablesBuilder(dataConnect, );
  }
  
  
  InsertMasterSalaryWeightageVariablesBuilder insertMasterSalaryWeightage ({required String variable, required String label, required String category, required double percentage, }) {
    return InsertMasterSalaryWeightageVariablesBuilder(dataConnect, variable: variable,label: label,category: category,percentage: percentage,);
  }
  
  
  UpdateMasterSalaryWeightageVariablesBuilder updateMasterSalaryWeightage ({required UpdateMasterSalaryWeightageVariablesId id, required String variable, required String label, required String category, required double percentage, }) {
    return UpdateMasterSalaryWeightageVariablesBuilder(dataConnect, id: id,variable: variable,label: label,category: category,percentage: percentage,);
  }
  
  
  DeleteMasterSalaryWeightageVariablesBuilder deleteMasterSalaryWeightage ({required DeleteMasterSalaryWeightageVariablesId id, }) {
    return DeleteMasterSalaryWeightageVariablesBuilder(dataConnect, id: id,);
  }
  
  
  ListMasterScrapTargetsVariablesBuilder listMasterScrapTargets () {
    return ListMasterScrapTargetsVariablesBuilder(dataConnect, );
  }
  
  
  InsertMasterScrapTargetVariablesBuilder insertMasterScrapTarget ({required String product, required double targetKgPerHour, }) {
    return InsertMasterScrapTargetVariablesBuilder(dataConnect, product: product,targetKgPerHour: targetKgPerHour,);
  }
  
  
  UpdateMasterScrapTargetVariablesBuilder updateMasterScrapTarget ({required UpdateMasterScrapTargetVariablesId id, required String product, required double targetKgPerHour, }) {
    return UpdateMasterScrapTargetVariablesBuilder(dataConnect, id: id,product: product,targetKgPerHour: targetKgPerHour,);
  }
  
  
  DeleteMasterScrapTargetVariablesBuilder deleteMasterScrapTarget ({required DeleteMasterScrapTargetVariablesId id, }) {
    return DeleteMasterScrapTargetVariablesBuilder(dataConnect, id: id,);
  }
  
  
  CreateUserVariablesBuilder createUser ({required String uid, required String name, required String phone, required String password, required String email, required List<String> roles, required List<String> assignedMachines, required double fixedSalary, required bool isActive, }) {
    return CreateUserVariablesBuilder(dataConnect, uid: uid,name: name,phone: phone,password: password,email: email,roles: roles,assignedMachines: assignedMachines,fixedSalary: fixedSalary,isActive: isActive,);
  }
  
  
  UpdateUserVariablesBuilder updateUser ({required UpdateUserVariablesId id, required String name, required String phone, required List<String> roles, required List<String> assignedMachines, required double fixedSalary, required bool isActive, }) {
    return UpdateUserVariablesBuilder(dataConnect, id: id,name: name,phone: phone,roles: roles,assignedMachines: assignedMachines,fixedSalary: fixedSalary,isActive: isActive,);
  }
  
  
  ToggleUserActiveVariablesBuilder toggleUserActive ({required ToggleUserActiveVariablesId id, required bool isActive, }) {
    return ToggleUserActiveVariablesBuilder(dataConnect, id: id,isActive: isActive,);
  }
  
  
  GetUserByPhoneVariablesBuilder getUserByPhone ({required String phone, }) {
    return GetUserByPhoneVariablesBuilder(dataConnect, phone: phone,);
  }
  
  
  GetUserByIdVariablesBuilder getUserById ({required GetUserByIdVariablesId id, }) {
    return GetUserByIdVariablesBuilder(dataConnect, id: id,);
  }
  
  
  ListAllUsersVariablesBuilder listAllUsers () {
    return ListAllUsersVariablesBuilder(dataConnect, );
  }
  
  
  CreateSalaryCalculationVariablesBuilder createSalaryCalculation ({required String operatorId, required String operatorName, required int year, required int month, required double a, required double b, required double c, required double d, required double e, required double f, required double wA, required double wB, required double wC, required double wD, required double wE, required double wF, required double multiplier, required double fixedSalary, required double calculatedSalary, }) {
    return CreateSalaryCalculationVariablesBuilder(dataConnect, operatorId: operatorId,operatorName: operatorName,year: year,month: month,a: a,b: b,c: c,d: d,e: e,f: f,wA: wA,wB: wB,wC: wC,wD: wD,wE: wE,wF: wF,multiplier: multiplier,fixedSalary: fixedSalary,calculatedSalary: calculatedSalary,);
  }
  
  
  UpdateSalaryCalculationVariablesBuilder updateSalaryCalculation ({required UpdateSalaryCalculationVariablesId id, required String operatorId, required String operatorName, required int year, required int month, required double a, required double b, required double c, required double d, required double e, required double f, required double wA, required double wB, required double wC, required double wD, required double wE, required double wF, required double multiplier, required double fixedSalary, required double calculatedSalary, }) {
    return UpdateSalaryCalculationVariablesBuilder(dataConnect, id: id,operatorId: operatorId,operatorName: operatorName,year: year,month: month,a: a,b: b,c: c,d: d,e: e,f: f,wA: wA,wB: wB,wC: wC,wD: wD,wE: wE,wF: wF,multiplier: multiplier,fixedSalary: fixedSalary,calculatedSalary: calculatedSalary,);
  }
  
  
  GetSalaryCalculationVariablesBuilder getSalaryCalculation ({required String operatorId, required int year, required int month, }) {
    return GetSalaryCalculationVariablesBuilder(dataConnect, operatorId: operatorId,year: year,month: month,);
  }
  
  
  ListSalaryCalculationsVariablesBuilder listSalaryCalculations () {
    return ListSalaryCalculationsVariablesBuilder(dataConnect, );
  }
  
  
  ListAllSalaryCalculationsForMonthVariablesBuilder listAllSalaryCalculationsForMonth ({required int year, required int month, }) {
    return ListAllSalaryCalculationsForMonthVariablesBuilder(dataConnect, year: year,month: month,);
  }
  
  
  CreateScrapCleaningReportVariablesBuilder createScrapCleaningReport ({required DateTime date, required String machineNumber, required int machineCondition, required int groundCondition, required int totalScore, required double percentage, required String createdBy, }) {
    return CreateScrapCleaningReportVariablesBuilder(dataConnect, date: date,machineNumber: machineNumber,machineCondition: machineCondition,groundCondition: groundCondition,totalScore: totalScore,percentage: percentage,createdBy: createdBy,);
  }
  
  
  ListScrapCleaningReportsVariablesBuilder listScrapCleaningReports () {
    return ListScrapCleaningReportsVariablesBuilder(dataConnect, );
  }
  
  
  CreateScrapToolsCountReportVariablesBuilder createScrapToolsCountReport ({required DateTime date, required String machineNumber, required int totalToolsGiven, required int totalToolsAvailable, required double percentageAvailable, required String createdBy, }) {
    return CreateScrapToolsCountReportVariablesBuilder(dataConnect, date: date,machineNumber: machineNumber,totalToolsGiven: totalToolsGiven,totalToolsAvailable: totalToolsAvailable,percentageAvailable: percentageAvailable,createdBy: createdBy,);
  }
  
  
  ListScrapToolsCountReportsVariablesBuilder listScrapToolsCountReports () {
    return ListScrapToolsCountReportsVariablesBuilder(dataConnect, );
  }
  
  
  CreateScrapMachineHealthReportVariablesBuilder createScrapMachineHealthReport ({required DateTime date, required String machineNumber, required String shift, required double totalMaintenanceDurationHours, required String createdBy, }) {
    return CreateScrapMachineHealthReportVariablesBuilder(dataConnect, date: date,machineNumber: machineNumber,shift: shift,totalMaintenanceDurationHours: totalMaintenanceDurationHours,createdBy: createdBy,);
  }
  
  
  CreateScrapMaintenanceEntryVariablesBuilder createScrapMaintenanceEntry ({required CreateScrapMaintenanceEntryVariablesReportId reportId, required String maintenanceItem, required Timestamp startTime, required Timestamp endTime, required String personDoingMaintenance, required String description, required double durationHours, }) {
    return CreateScrapMaintenanceEntryVariablesBuilder(dataConnect, reportId: reportId,maintenanceItem: maintenanceItem,startTime: startTime,endTime: endTime,personDoingMaintenance: personDoingMaintenance,description: description,durationHours: durationHours,);
  }
  
  
  ListScrapMachineHealthReportsVariablesBuilder listScrapMachineHealthReports () {
    return ListScrapMachineHealthReportsVariablesBuilder(dataConnect, );
  }
  
  
  CreateScrapProductionDetailsReportVariablesBuilder createScrapProductionDetailsReport ({required DateTime date, required String machineNumber, required String shift, required double totalProductionWeight, required String createdBy, }) {
    return CreateScrapProductionDetailsReportVariablesBuilder(dataConnect, date: date,machineNumber: machineNumber,shift: shift,totalProductionWeight: totalProductionWeight,createdBy: createdBy,);
  }
  
  
  CreateScrapProductionLineItemVariablesBuilder createScrapProductionLineItem ({required CreateScrapProductionLineItemVariablesReportId reportId, required String product, required double weightPerBag, required int totalBags, required double totalWeight, }) {
    return CreateScrapProductionLineItemVariablesBuilder(dataConnect, reportId: reportId,product: product,weightPerBag: weightPerBag,totalBags: totalBags,totalWeight: totalWeight,);
  }
  
  
  ListScrapProductionDetailsReportsVariablesBuilder listScrapProductionDetailsReports () {
    return ListScrapProductionDetailsReportsVariablesBuilder(dataConnect, );
  }
  
  
  GetScrapProductionDetailsReportVariablesBuilder getScrapProductionDetailsReport ({required String machineNumber, required DateTime date, required String shift, }) {
    return GetScrapProductionDetailsReportVariablesBuilder(dataConnect, machineNumber: machineNumber,date: date,shift: shift,);
  }
  
  
  CreateScrapProductionWeightReportVariablesBuilder createScrapProductionWeightReport ({required DateTime date, required String machineNumber, required String shift, required double totalProductionWeight, required double maintenanceWeight, required double totalWeight, required double targetWeight, required double efficiencyPercentage, required String createdBy, }) {
    return CreateScrapProductionWeightReportVariablesBuilder(dataConnect, date: date,machineNumber: machineNumber,shift: shift,totalProductionWeight: totalProductionWeight,maintenanceWeight: maintenanceWeight,totalWeight: totalWeight,targetWeight: targetWeight,efficiencyPercentage: efficiencyPercentage,createdBy: createdBy,);
  }
  
  
  ListScrapProductionWeightReportsVariablesBuilder listScrapProductionWeightReports () {
    return ListScrapProductionWeightReportsVariablesBuilder(dataConnect, );
  }
  
  
  CreateScrapWritingEfficiencyVariablesBuilder createScrapWritingEfficiency ({required DateTime date, required String machineNumber, required String shift, required Timestamp shiftEndTime, required int score, required String operatorId, }) {
    return CreateScrapWritingEfficiencyVariablesBuilder(dataConnect, date: date,machineNumber: machineNumber,shift: shift,shiftEndTime: shiftEndTime,score: score,operatorId: operatorId,);
  }
  
  
  ListScrapReportWritingEfficiencyVariablesBuilder listScrapReportWritingEfficiency () {
    return ListScrapReportWritingEfficiencyVariablesBuilder(dataConnect, );
  }
  
  
  CreateScrapQualityReportVariablesBuilder createScrapQualityReport ({required DateTime date, required String machineNumber, required String shift, required String product, required int qualityRating, required String createdBy, }) {
    return CreateScrapQualityReportVariablesBuilder(dataConnect, date: date,machineNumber: machineNumber,shift: shift,product: product,qualityRating: qualityRating,createdBy: createdBy,);
  }
  
  
  ListScrapQualityReportsVariablesBuilder listScrapQualityReports () {
    return ListScrapQualityReportsVariablesBuilder(dataConnect, );
  }
  
  
  CreateScrapSalaryCalculationVariablesBuilder createScrapSalaryCalculation ({required String operatorId, required String operatorName, required int year, required int month, required double a, required double b, required double e, required double f, required double g, required double wA, required double wB, required double wE, required double wF, required double wG, required double multiplier, required double fixedSalary, required double calculatedSalary, }) {
    return CreateScrapSalaryCalculationVariablesBuilder(dataConnect, operatorId: operatorId,operatorName: operatorName,year: year,month: month,a: a,b: b,e: e,f: f,g: g,wA: wA,wB: wB,wE: wE,wF: wF,wG: wG,multiplier: multiplier,fixedSalary: fixedSalary,calculatedSalary: calculatedSalary,);
  }
  
  
  GetScrapSalaryCalculationVariablesBuilder getScrapSalaryCalculation ({required String operatorId, required int year, required int month, }) {
    return GetScrapSalaryCalculationVariablesBuilder(dataConnect, operatorId: operatorId,year: year,month: month,);
  }
  
  
  GetScrapSalaryWeightagesVariablesBuilder getScrapSalaryWeightages () {
    return GetScrapSalaryWeightagesVariablesBuilder(dataConnect, );
  }
  
  
  GetScrapMonthlyAggregatesVariablesBuilder getScrapMonthlyAggregates ({required String machineNumber, required DateTime startDate, required DateTime endDate, }) {
    return GetScrapMonthlyAggregatesVariablesBuilder(dataConnect, machineNumber: machineNumber,startDate: startDate,endDate: endDate,);
  }
  
  
  SeedAdminUserVariablesBuilder seedAdminUser () {
    return SeedAdminUserVariablesBuilder(dataConnect, );
  }
  
  
  SeedOperator1VariablesBuilder seedOperator1 () {
    return SeedOperator1VariablesBuilder(dataConnect, );
  }
  
  
  SeedOperator2VariablesBuilder seedOperator2 () {
    return SeedOperator2VariablesBuilder(dataConnect, );
  }
  
  
  SeedOperator3VariablesBuilder seedOperator3 () {
    return SeedOperator3VariablesBuilder(dataConnect, );
  }
  
  
  SeedOperator4VariablesBuilder seedOperator4 () {
    return SeedOperator4VariablesBuilder(dataConnect, );
  }
  
  
  SeedQualityPackingVariablesBuilder seedQualityPacking () {
    return SeedQualityPackingVariablesBuilder(dataConnect, );
  }
  
  
  SeedMachineFrame1VariablesBuilder seedMachineFrame1 () {
    return SeedMachineFrame1VariablesBuilder(dataConnect, );
  }
  
  
  SeedMachineFrame2VariablesBuilder seedMachineFrame2 () {
    return SeedMachineFrame2VariablesBuilder(dataConnect, );
  }
  
  
  SeedMachineSheet3VariablesBuilder seedMachineSheet3 () {
    return SeedMachineSheet3VariablesBuilder(dataConnect, );
  }
  
  
  SeedMachineSheet4VariablesBuilder seedMachineSheet4 () {
    return SeedMachineSheet4VariablesBuilder(dataConnect, );
  }
  
  
  SeedMachineSheet5VariablesBuilder seedMachineSheet5 () {
    return SeedMachineSheet5VariablesBuilder(dataConnect, );
  }
  
  
  SeedMachineCrusher1VariablesBuilder seedMachineCrusher1 () {
    return SeedMachineCrusher1VariablesBuilder(dataConnect, );
  }
  
  
  SeedMachineCrusher2VariablesBuilder seedMachineCrusher2 () {
    return SeedMachineCrusher2VariablesBuilder(dataConnect, );
  }
  
  
  SeedMachineCrusher3VariablesBuilder seedMachineCrusher3 () {
    return SeedMachineCrusher3VariablesBuilder(dataConnect, );
  }
  
  
  SeedMachinePulverizer1VariablesBuilder seedMachinePulverizer1 () {
    return SeedMachinePulverizer1VariablesBuilder(dataConnect, );
  }
  
  
  SeedMachinePulverizer2VariablesBuilder seedMachinePulverizer2 () {
    return SeedMachinePulverizer2VariablesBuilder(dataConnect, );
  }
  
  
  SeedMachinePulverizer3VariablesBuilder seedMachinePulverizer3 () {
    return SeedMachinePulverizer3VariablesBuilder(dataConnect, );
  }
  
  
  SeedMachineShredderVariablesBuilder seedMachineShredder () {
    return SeedMachineShredderVariablesBuilder(dataConnect, );
  }
  
  
  SeedShiftDayVariablesBuilder seedShiftDay () {
    return SeedShiftDayVariablesBuilder(dataConnect, );
  }
  
  
  SeedShiftNightVariablesBuilder seedShiftNight () {
    return SeedShiftNightVariablesBuilder(dataConnect, );
  }
  
  
  SeedRoleOperatorVariablesBuilder seedRoleOperator () {
    return SeedRoleOperatorVariablesBuilder(dataConnect, );
  }
  
  
  SeedRoleQualityVariablesBuilder seedRoleQuality () {
    return SeedRoleQualityVariablesBuilder(dataConnect, );
  }
  
  
  SeedRoleFrameSeniorVariablesBuilder seedRoleFrameSenior () {
    return SeedRoleFrameSeniorVariablesBuilder(dataConnect, );
  }
  
  
  SeedRoleSheetSeniorVariablesBuilder seedRoleSheetSenior () {
    return SeedRoleSheetSeniorVariablesBuilder(dataConnect, );
  }
  
  
  SeedRolePlantManagerVariablesBuilder seedRolePlantManager () {
    return SeedRolePlantManagerVariablesBuilder(dataConnect, );
  }
  
  
  SeedRoleAdminVariablesBuilder seedRoleAdmin () {
    return SeedRoleAdminVariablesBuilder(dataConnect, );
  }
  
  
  SeedFrameSection1VariablesBuilder seedFrameSection1 () {
    return SeedFrameSection1VariablesBuilder(dataConnect, );
  }
  
  
  SeedFrameSection2VariablesBuilder seedFrameSection2 () {
    return SeedFrameSection2VariablesBuilder(dataConnect, );
  }
  
  
  SeedFrameSection3VariablesBuilder seedFrameSection3 () {
    return SeedFrameSection3VariablesBuilder(dataConnect, );
  }
  
  
  SeedFrameSection4VariablesBuilder seedFrameSection4 () {
    return SeedFrameSection4VariablesBuilder(dataConnect, );
  }
  
  
  SeedFrameSection5VariablesBuilder seedFrameSection5 () {
    return SeedFrameSection5VariablesBuilder(dataConnect, );
  }
  
  
  SeedFrameSection6VariablesBuilder seedFrameSection6 () {
    return SeedFrameSection6VariablesBuilder(dataConnect, );
  }
  
  
  SeedFrameSection7VariablesBuilder seedFrameSection7 () {
    return SeedFrameSection7VariablesBuilder(dataConnect, );
  }
  
  
  SeedFrameDensity1VariablesBuilder seedFrameDensity1 () {
    return SeedFrameDensity1VariablesBuilder(dataConnect, );
  }
  
  
  SeedFrameDensity2VariablesBuilder seedFrameDensity2 () {
    return SeedFrameDensity2VariablesBuilder(dataConnect, );
  }
  
  
  SeedFrameDensity3VariablesBuilder seedFrameDensity3 () {
    return SeedFrameDensity3VariablesBuilder(dataConnect, );
  }
  
  
  SeedFrameDensity4VariablesBuilder seedFrameDensity4 () {
    return SeedFrameDensity4VariablesBuilder(dataConnect, );
  }
  
  
  SeedFrameColor1VariablesBuilder seedFrameColor1 () {
    return SeedFrameColor1VariablesBuilder(dataConnect, );
  }
  
  
  SeedFrameColor2VariablesBuilder seedFrameColor2 () {
    return SeedFrameColor2VariablesBuilder(dataConnect, );
  }
  
  
  SeedFrameColor3VariablesBuilder seedFrameColor3 () {
    return SeedFrameColor3VariablesBuilder(dataConnect, );
  }
  
  
  SeedSheetThick1VariablesBuilder seedSheetThick1 () {
    return SeedSheetThick1VariablesBuilder(dataConnect, );
  }
  
  
  SeedSheetThick2VariablesBuilder seedSheetThick2 () {
    return SeedSheetThick2VariablesBuilder(dataConnect, );
  }
  
  
  SeedSheetThick3VariablesBuilder seedSheetThick3 () {
    return SeedSheetThick3VariablesBuilder(dataConnect, );
  }
  
  
  SeedSheetThick4VariablesBuilder seedSheetThick4 () {
    return SeedSheetThick4VariablesBuilder(dataConnect, );
  }
  
  
  SeedSheetThick5VariablesBuilder seedSheetThick5 () {
    return SeedSheetThick5VariablesBuilder(dataConnect, );
  }
  
  
  SeedSheetThick6VariablesBuilder seedSheetThick6 () {
    return SeedSheetThick6VariablesBuilder(dataConnect, );
  }
  
  
  SeedSheetThick7VariablesBuilder seedSheetThick7 () {
    return SeedSheetThick7VariablesBuilder(dataConnect, );
  }
  
  
  SeedSheetThick8VariablesBuilder seedSheetThick8 () {
    return SeedSheetThick8VariablesBuilder(dataConnect, );
  }
  
  
  SeedSheetThick9VariablesBuilder seedSheetThick9 () {
    return SeedSheetThick9VariablesBuilder(dataConnect, );
  }
  
  
  SeedSheetThick10VariablesBuilder seedSheetThick10 () {
    return SeedSheetThick10VariablesBuilder(dataConnect, );
  }
  
  
  SeedSheetThick11VariablesBuilder seedSheetThick11 () {
    return SeedSheetThick11VariablesBuilder(dataConnect, );
  }
  
  
  SeedSheetThick12VariablesBuilder seedSheetThick12 () {
    return SeedSheetThick12VariablesBuilder(dataConnect, );
  }
  
  
  SeedSheetThick13VariablesBuilder seedSheetThick13 () {
    return SeedSheetThick13VariablesBuilder(dataConnect, );
  }
  
  
  SeedSheetThick14VariablesBuilder seedSheetThick14 () {
    return SeedSheetThick14VariablesBuilder(dataConnect, );
  }
  
  
  SeedSheetThick15VariablesBuilder seedSheetThick15 () {
    return SeedSheetThick15VariablesBuilder(dataConnect, );
  }
  
  
  SeedSheetThick16VariablesBuilder seedSheetThick16 () {
    return SeedSheetThick16VariablesBuilder(dataConnect, );
  }
  
  
  SeedSheetThick17VariablesBuilder seedSheetThick17 () {
    return SeedSheetThick17VariablesBuilder(dataConnect, );
  }
  
  
  SeedSheetThick18VariablesBuilder seedSheetThick18 () {
    return SeedSheetThick18VariablesBuilder(dataConnect, );
  }
  
  
  SeedSheetThick19VariablesBuilder seedSheetThick19 () {
    return SeedSheetThick19VariablesBuilder(dataConnect, );
  }
  
  
  SeedSheetThick20VariablesBuilder seedSheetThick20 () {
    return SeedSheetThick20VariablesBuilder(dataConnect, );
  }
  
  
  SeedSheetThick21VariablesBuilder seedSheetThick21 () {
    return SeedSheetThick21VariablesBuilder(dataConnect, );
  }
  
  
  SeedSheetDensity1VariablesBuilder seedSheetDensity1 () {
    return SeedSheetDensity1VariablesBuilder(dataConnect, );
  }
  
  
  SeedSheetDensity2VariablesBuilder seedSheetDensity2 () {
    return SeedSheetDensity2VariablesBuilder(dataConnect, );
  }
  
  
  SeedSheetDensity3VariablesBuilder seedSheetDensity3 () {
    return SeedSheetDensity3VariablesBuilder(dataConnect, );
  }
  
  
  SeedSheetDensity4VariablesBuilder seedSheetDensity4 () {
    return SeedSheetDensity4VariablesBuilder(dataConnect, );
  }
  
  
  SeedSheetDensity5VariablesBuilder seedSheetDensity5 () {
    return SeedSheetDensity5VariablesBuilder(dataConnect, );
  }
  
  
  SeedSheetDensity6VariablesBuilder seedSheetDensity6 () {
    return SeedSheetDensity6VariablesBuilder(dataConnect, );
  }
  
  
  SeedSheetDensity7VariablesBuilder seedSheetDensity7 () {
    return SeedSheetDensity7VariablesBuilder(dataConnect, );
  }
  
  
  SeedSheetDensity8VariablesBuilder seedSheetDensity8 () {
    return SeedSheetDensity8VariablesBuilder(dataConnect, );
  }
  
  
  SeedSheetColor1VariablesBuilder seedSheetColor1 () {
    return SeedSheetColor1VariablesBuilder(dataConnect, );
  }
  
  
  SeedSheetColor2VariablesBuilder seedSheetColor2 () {
    return SeedSheetColor2VariablesBuilder(dataConnect, );
  }
  
  
  SeedSheetColor3VariablesBuilder seedSheetColor3 () {
    return SeedSheetColor3VariablesBuilder(dataConnect, );
  }
  
  
  SeedSheetColor4VariablesBuilder seedSheetColor4 () {
    return SeedSheetColor4VariablesBuilder(dataConnect, );
  }
  
  
  SeedSheetColor5VariablesBuilder seedSheetColor5 () {
    return SeedSheetColor5VariablesBuilder(dataConnect, );
  }
  
  
  SeedMaint1VariablesBuilder seedMaint1 () {
    return SeedMaint1VariablesBuilder(dataConnect, );
  }
  
  
  SeedMaint2VariablesBuilder seedMaint2 () {
    return SeedMaint2VariablesBuilder(dataConnect, );
  }
  
  
  SeedMaint3VariablesBuilder seedMaint3 () {
    return SeedMaint3VariablesBuilder(dataConnect, );
  }
  
  
  SeedMaint4VariablesBuilder seedMaint4 () {
    return SeedMaint4VariablesBuilder(dataConnect, );
  }
  
  
  SeedMaint5VariablesBuilder seedMaint5 () {
    return SeedMaint5VariablesBuilder(dataConnect, );
  }
  
  
  SeedMaint6VariablesBuilder seedMaint6 () {
    return SeedMaint6VariablesBuilder(dataConnect, );
  }
  
  
  SeedMaint7VariablesBuilder seedMaint7 () {
    return SeedMaint7VariablesBuilder(dataConnect, );
  }
  
  
  SeedMaint8VariablesBuilder seedMaint8 () {
    return SeedMaint8VariablesBuilder(dataConnect, );
  }
  
  
  SeedMaint9VariablesBuilder seedMaint9 () {
    return SeedMaint9VariablesBuilder(dataConnect, );
  }
  
  
  SeedMaintScrap1VariablesBuilder seedMaintScrap1 () {
    return SeedMaintScrap1VariablesBuilder(dataConnect, );
  }
  
  
  SeedMaintScrap2VariablesBuilder seedMaintScrap2 () {
    return SeedMaintScrap2VariablesBuilder(dataConnect, );
  }
  
  
  SeedMaintScrap3VariablesBuilder seedMaintScrap3 () {
    return SeedMaintScrap3VariablesBuilder(dataConnect, );
  }
  
  
  SeedMaintScrap4VariablesBuilder seedMaintScrap4 () {
    return SeedMaintScrap4VariablesBuilder(dataConnect, );
  }
  
  
  SeedMaintScrap5VariablesBuilder seedMaintScrap5 () {
    return SeedMaintScrap5VariablesBuilder(dataConnect, );
  }
  
  
  SeedMaintScrap6VariablesBuilder seedMaintScrap6 () {
    return SeedMaintScrap6VariablesBuilder(dataConnect, );
  }
  
  
  SeedMaintScrap7VariablesBuilder seedMaintScrap7 () {
    return SeedMaintScrap7VariablesBuilder(dataConnect, );
  }
  
  
  SeedMaintScrap8VariablesBuilder seedMaintScrap8 () {
    return SeedMaintScrap8VariablesBuilder(dataConnect, );
  }
  
  
  SeedScrapProd1VariablesBuilder seedScrapProd1 () {
    return SeedScrapProd1VariablesBuilder(dataConnect, );
  }
  
  
  SeedScrapProd2VariablesBuilder seedScrapProd2 () {
    return SeedScrapProd2VariablesBuilder(dataConnect, );
  }
  
  
  SeedScrapProd3VariablesBuilder seedScrapProd3 () {
    return SeedScrapProd3VariablesBuilder(dataConnect, );
  }
  
  
  SeedScrapProd4VariablesBuilder seedScrapProd4 () {
    return SeedScrapProd4VariablesBuilder(dataConnect, );
  }
  
  
  SeedScrapProd5VariablesBuilder seedScrapProd5 () {
    return SeedScrapProd5VariablesBuilder(dataConnect, );
  }
  
  
  SeedScrapProd6VariablesBuilder seedScrapProd6 () {
    return SeedScrapProd6VariablesBuilder(dataConnect, );
  }
  
  
  SeedFw1VariablesBuilder seedFw1 () {
    return SeedFw1VariablesBuilder(dataConnect, );
  }
  
  
  SeedFw2VariablesBuilder seedFw2 () {
    return SeedFw2VariablesBuilder(dataConnect, );
  }
  
  
  SeedFw3VariablesBuilder seedFw3 () {
    return SeedFw3VariablesBuilder(dataConnect, );
  }
  
  
  SeedFw4VariablesBuilder seedFw4 () {
    return SeedFw4VariablesBuilder(dataConnect, );
  }
  
  
  SeedFw5VariablesBuilder seedFw5 () {
    return SeedFw5VariablesBuilder(dataConnect, );
  }
  
  
  SeedFw6VariablesBuilder seedFw6 () {
    return SeedFw6VariablesBuilder(dataConnect, );
  }
  
  
  SeedFw7VariablesBuilder seedFw7 () {
    return SeedFw7VariablesBuilder(dataConnect, );
  }
  
  
  SeedFw8VariablesBuilder seedFw8 () {
    return SeedFw8VariablesBuilder(dataConnect, );
  }
  
  
  SeedFw9VariablesBuilder seedFw9 () {
    return SeedFw9VariablesBuilder(dataConnect, );
  }
  
  
  SeedFw10VariablesBuilder seedFw10 () {
    return SeedFw10VariablesBuilder(dataConnect, );
  }
  
  
  SeedFw11VariablesBuilder seedFw11 () {
    return SeedFw11VariablesBuilder(dataConnect, );
  }
  
  
  SeedFw12VariablesBuilder seedFw12 () {
    return SeedFw12VariablesBuilder(dataConnect, );
  }
  
  
  SeedFw13VariablesBuilder seedFw13 () {
    return SeedFw13VariablesBuilder(dataConnect, );
  }
  
  
  SeedFw14VariablesBuilder seedFw14 () {
    return SeedFw14VariablesBuilder(dataConnect, );
  }
  
  
  SeedFw15VariablesBuilder seedFw15 () {
    return SeedFw15VariablesBuilder(dataConnect, );
  }
  
  
  SeedFw16VariablesBuilder seedFw16 () {
    return SeedFw16VariablesBuilder(dataConnect, );
  }
  
  
  SeedFw17VariablesBuilder seedFw17 () {
    return SeedFw17VariablesBuilder(dataConnect, );
  }
  
  
  SeedFw18VariablesBuilder seedFw18 () {
    return SeedFw18VariablesBuilder(dataConnect, );
  }
  
  
  SeedFw19VariablesBuilder seedFw19 () {
    return SeedFw19VariablesBuilder(dataConnect, );
  }
  
  
  SeedFw20VariablesBuilder seedFw20 () {
    return SeedFw20VariablesBuilder(dataConnect, );
  }
  
  
  SeedFw21VariablesBuilder seedFw21 () {
    return SeedFw21VariablesBuilder(dataConnect, );
  }
  
  
  SeedSalaryWaVariablesBuilder seedSalaryWa () {
    return SeedSalaryWaVariablesBuilder(dataConnect, );
  }
  
  
  SeedSalaryWbVariablesBuilder seedSalaryWb () {
    return SeedSalaryWbVariablesBuilder(dataConnect, );
  }
  
  
  SeedSalaryWcVariablesBuilder seedSalaryWc () {
    return SeedSalaryWcVariablesBuilder(dataConnect, );
  }
  
  
  SeedSalaryWdVariablesBuilder seedSalaryWd () {
    return SeedSalaryWdVariablesBuilder(dataConnect, );
  }
  
  
  SeedSalaryWeVariablesBuilder seedSalaryWe () {
    return SeedSalaryWeVariablesBuilder(dataConnect, );
  }
  
  
  SeedSalaryWfVariablesBuilder seedSalaryWf () {
    return SeedSalaryWfVariablesBuilder(dataConnect, );
  }
  
  
  SeedScrapSalaryWaVariablesBuilder seedScrapSalaryWa () {
    return SeedScrapSalaryWaVariablesBuilder(dataConnect, );
  }
  
  
  SeedScrapSalaryWbVariablesBuilder seedScrapSalaryWb () {
    return SeedScrapSalaryWbVariablesBuilder(dataConnect, );
  }
  
  
  SeedScrapSalaryWeVariablesBuilder seedScrapSalaryWe () {
    return SeedScrapSalaryWeVariablesBuilder(dataConnect, );
  }
  
  
  SeedScrapSalaryWfVariablesBuilder seedScrapSalaryWf () {
    return SeedScrapSalaryWfVariablesBuilder(dataConnect, );
  }
  
  
  SeedScrapSalaryWgVariablesBuilder seedScrapSalaryWg () {
    return SeedScrapSalaryWgVariablesBuilder(dataConnect, );
  }
  
  
  SeedFrameCleaning1VariablesBuilder seedFrameCleaning1 () {
    return SeedFrameCleaning1VariablesBuilder(dataConnect, );
  }
  
  
  SeedFrameCleaning2VariablesBuilder seedFrameCleaning2 () {
    return SeedFrameCleaning2VariablesBuilder(dataConnect, );
  }
  
  
  SeedFrameCleaning3VariablesBuilder seedFrameCleaning3 () {
    return SeedFrameCleaning3VariablesBuilder(dataConnect, );
  }
  
  
  SeedFrameCleaning4VariablesBuilder seedFrameCleaning4 () {
    return SeedFrameCleaning4VariablesBuilder(dataConnect, );
  }
  
  
  SeedFrameCleaning5VariablesBuilder seedFrameCleaning5 () {
    return SeedFrameCleaning5VariablesBuilder(dataConnect, );
  }
  
  
  SeedFrameTools1VariablesBuilder seedFrameTools1 () {
    return SeedFrameTools1VariablesBuilder(dataConnect, );
  }
  
  
  SeedFrameTools2VariablesBuilder seedFrameTools2 () {
    return SeedFrameTools2VariablesBuilder(dataConnect, );
  }
  
  
  SeedFrameTools3VariablesBuilder seedFrameTools3 () {
    return SeedFrameTools3VariablesBuilder(dataConnect, );
  }
  
  
  SeedFrameTools4VariablesBuilder seedFrameTools4 () {
    return SeedFrameTools4VariablesBuilder(dataConnect, );
  }
  
  
  SeedFrameHealth1VariablesBuilder seedFrameHealth1 () {
    return SeedFrameHealth1VariablesBuilder(dataConnect, );
  }
  
  
  SeedFrameHealth2VariablesBuilder seedFrameHealth2 () {
    return SeedFrameHealth2VariablesBuilder(dataConnect, );
  }
  
  
  SeedFrameHealth3VariablesBuilder seedFrameHealth3 () {
    return SeedFrameHealth3VariablesBuilder(dataConnect, );
  }
  
  
  SeedFrameWeight1VariablesBuilder seedFrameWeight1 () {
    return SeedFrameWeight1VariablesBuilder(dataConnect, );
  }
  
  
  SeedFrameWeight2VariablesBuilder seedFrameWeight2 () {
    return SeedFrameWeight2VariablesBuilder(dataConnect, );
  }
  
  
  SeedFrameWeight3VariablesBuilder seedFrameWeight3 () {
    return SeedFrameWeight3VariablesBuilder(dataConnect, );
  }
  
  
  SeedFrameWeight4VariablesBuilder seedFrameWeight4 () {
    return SeedFrameWeight4VariablesBuilder(dataConnect, );
  }
  
  
  SeedSheetCleaning1VariablesBuilder seedSheetCleaning1 () {
    return SeedSheetCleaning1VariablesBuilder(dataConnect, );
  }
  
  
  SeedSheetCleaning2VariablesBuilder seedSheetCleaning2 () {
    return SeedSheetCleaning2VariablesBuilder(dataConnect, );
  }
  
  
  SeedSheetCleaning3VariablesBuilder seedSheetCleaning3 () {
    return SeedSheetCleaning3VariablesBuilder(dataConnect, );
  }
  
  
  SeedSheetCleaning4VariablesBuilder seedSheetCleaning4 () {
    return SeedSheetCleaning4VariablesBuilder(dataConnect, );
  }
  
  
  SeedSheetCleaning5VariablesBuilder seedSheetCleaning5 () {
    return SeedSheetCleaning5VariablesBuilder(dataConnect, );
  }
  
  
  SeedSheetRunningFeet1VariablesBuilder seedSheetRunningFeet1 () {
    return SeedSheetRunningFeet1VariablesBuilder(dataConnect, );
  }
  
  
  SeedSheetRunningFeet2VariablesBuilder seedSheetRunningFeet2 () {
    return SeedSheetRunningFeet2VariablesBuilder(dataConnect, );
  }
  
  
  SeedSheetRunningFeet3VariablesBuilder seedSheetRunningFeet3 () {
    return SeedSheetRunningFeet3VariablesBuilder(dataConnect, );
  }
  
  
  SeedSalaryOp1VariablesBuilder seedSalaryOp1 () {
    return SeedSalaryOp1VariablesBuilder(dataConnect, );
  }
  
  
  SeedSalaryOp2VariablesBuilder seedSalaryOp2 () {
    return SeedSalaryOp2VariablesBuilder(dataConnect, );
  }
  
  
  SeedSalaryOp3VariablesBuilder seedSalaryOp3 () {
    return SeedSalaryOp3VariablesBuilder(dataConnect, );
  }
  
  
  SeedSalaryOp4VariablesBuilder seedSalaryOp4 () {
    return SeedSalaryOp4VariablesBuilder(dataConnect, );
  }
  
  
  SeedFrameWriting1VariablesBuilder seedFrameWriting1 () {
    return SeedFrameWriting1VariablesBuilder(dataConnect, );
  }
  
  
  SeedFrameWriting2VariablesBuilder seedFrameWriting2 () {
    return SeedFrameWriting2VariablesBuilder(dataConnect, );
  }
  
  
  SeedFrameWriting3VariablesBuilder seedFrameWriting3 () {
    return SeedFrameWriting3VariablesBuilder(dataConnect, );
  }
  
  
  SeedSheetWriting1VariablesBuilder seedSheetWriting1 () {
    return SeedSheetWriting1VariablesBuilder(dataConnect, );
  }
  
  
  SeedSheetWriting2VariablesBuilder seedSheetWriting2 () {
    return SeedSheetWriting2VariablesBuilder(dataConnect, );
  }
  
  
  SeedScrapOperator1VariablesBuilder seedScrapOperator1 () {
    return SeedScrapOperator1VariablesBuilder(dataConnect, );
  }
  
  
  SeedScrapOperator2VariablesBuilder seedScrapOperator2 () {
    return SeedScrapOperator2VariablesBuilder(dataConnect, );
  }
  
  
  SeedScrapCleaning1VariablesBuilder seedScrapCleaning1 () {
    return SeedScrapCleaning1VariablesBuilder(dataConnect, );
  }
  
  
  SeedScrapCleaning2VariablesBuilder seedScrapCleaning2 () {
    return SeedScrapCleaning2VariablesBuilder(dataConnect, );
  }
  
  
  SeedScrapCleaning3VariablesBuilder seedScrapCleaning3 () {
    return SeedScrapCleaning3VariablesBuilder(dataConnect, );
  }
  
  
  SeedScrapCleaning4VariablesBuilder seedScrapCleaning4 () {
    return SeedScrapCleaning4VariablesBuilder(dataConnect, );
  }
  
  
  SeedScrapTools1VariablesBuilder seedScrapTools1 () {
    return SeedScrapTools1VariablesBuilder(dataConnect, );
  }
  
  
  SeedScrapTools2VariablesBuilder seedScrapTools2 () {
    return SeedScrapTools2VariablesBuilder(dataConnect, );
  }
  
  
  SeedScrapTools3VariablesBuilder seedScrapTools3 () {
    return SeedScrapTools3VariablesBuilder(dataConnect, );
  }
  
  
  SeedScrapProdWeight1VariablesBuilder seedScrapProdWeight1 () {
    return SeedScrapProdWeight1VariablesBuilder(dataConnect, );
  }
  
  
  SeedScrapProdWeight2VariablesBuilder seedScrapProdWeight2 () {
    return SeedScrapProdWeight2VariablesBuilder(dataConnect, );
  }
  
  
  SeedScrapProdWeight3VariablesBuilder seedScrapProdWeight3 () {
    return SeedScrapProdWeight3VariablesBuilder(dataConnect, );
  }
  
  
  SeedScrapWriting1VariablesBuilder seedScrapWriting1 () {
    return SeedScrapWriting1VariablesBuilder(dataConnect, );
  }
  
  
  SeedScrapWriting2VariablesBuilder seedScrapWriting2 () {
    return SeedScrapWriting2VariablesBuilder(dataConnect, );
  }
  
  
  SeedScrapWriting3VariablesBuilder seedScrapWriting3 () {
    return SeedScrapWriting3VariablesBuilder(dataConnect, );
  }
  
  
  SeedScrapQuality1VariablesBuilder seedScrapQuality1 () {
    return SeedScrapQuality1VariablesBuilder(dataConnect, );
  }
  
  
  SeedScrapQuality2VariablesBuilder seedScrapQuality2 () {
    return SeedScrapQuality2VariablesBuilder(dataConnect, );
  }
  
  
  SeedScrapQuality3VariablesBuilder seedScrapQuality3 () {
    return SeedScrapQuality3VariablesBuilder(dataConnect, );
  }
  
  
  SeedScrapQuality4VariablesBuilder seedScrapQuality4 () {
    return SeedScrapQuality4VariablesBuilder(dataConnect, );
  }
  
  
  SeedScrapSalary1VariablesBuilder seedScrapSalary1 () {
    return SeedScrapSalary1VariablesBuilder(dataConnect, );
  }
  
  
  SeedScrapSalary2VariablesBuilder seedScrapSalary2 () {
    return SeedScrapSalary2VariablesBuilder(dataConnect, );
  }
  
  
  CreateSheetCleaningReportVariablesBuilder createSheetCleaningReport ({required DateTime date, required String machineNumber, required int machineCondition, required int groundCondition, required int mouldCondition, required int totalScore, required double percentage, required String createdBy, }) {
    return CreateSheetCleaningReportVariablesBuilder(dataConnect, date: date,machineNumber: machineNumber,machineCondition: machineCondition,groundCondition: groundCondition,mouldCondition: mouldCondition,totalScore: totalScore,percentage: percentage,createdBy: createdBy,);
  }
  
  
  ListSheetCleaningReportsVariablesBuilder listSheetCleaningReports () {
    return ListSheetCleaningReportsVariablesBuilder(dataConnect, );
  }
  
  
  CreateSheetToolsCountReportVariablesBuilder createSheetToolsCountReport ({required DateTime date, required String machineNumber, required int totalToolsGiven, required int totalToolsAvailable, required double percentageAvailable, required String createdBy, }) {
    return CreateSheetToolsCountReportVariablesBuilder(dataConnect, date: date,machineNumber: machineNumber,totalToolsGiven: totalToolsGiven,totalToolsAvailable: totalToolsAvailable,percentageAvailable: percentageAvailable,createdBy: createdBy,);
  }
  
  
  ListSheetToolsCountReportsVariablesBuilder listSheetToolsCountReports () {
    return ListSheetToolsCountReportsVariablesBuilder(dataConnect, );
  }
  
  
  CreateSheetHealthReportVariablesBuilder createSheetHealthReport ({required DateTime date, required String machineNumber, required String shift, required int totalScore, required double percentage, required String createdBy, }) {
    return CreateSheetHealthReportVariablesBuilder(dataConnect, date: date,machineNumber: machineNumber,shift: shift,totalScore: totalScore,percentage: percentage,createdBy: createdBy,);
  }
  
  
  CreateSheetHealthRatingItemVariablesBuilder createSheetHealthRatingItem ({required CreateSheetHealthRatingItemVariablesReportId reportId, required String item, required int rating, }) {
    return CreateSheetHealthRatingItemVariablesBuilder(dataConnect, reportId: reportId,item: item,rating: rating,);
  }
  
  
  ListSheetHealthReportsVariablesBuilder listSheetHealthReports () {
    return ListSheetHealthReportsVariablesBuilder(dataConnect, );
  }
  
  
  CreateSheetProductionDetailsReportVariablesBuilder createSheetProductionDetailsReport ({required DateTime date, required String machineNumber, required String shift, required int totalQuantity, required double totalWeight, required double totalRunningFeet, required String createdBy, }) {
    return CreateSheetProductionDetailsReportVariablesBuilder(dataConnect, date: date,machineNumber: machineNumber,shift: shift,totalQuantity: totalQuantity,totalWeight: totalWeight,totalRunningFeet: totalRunningFeet,createdBy: createdBy,);
  }
  
  
  CreateSheetProductionLineItemVariablesBuilder createSheetProductionLineItem ({required CreateSheetProductionLineItemVariablesReportId reportId, required String thickness, required String density, required String color, required double length, required double width, required int quantity, required double sqft, required double perPieceWeight, required double totalWeight, required double totalRunningFeet, }) {
    return CreateSheetProductionLineItemVariablesBuilder(dataConnect, reportId: reportId,thickness: thickness,density: density,color: color,length: length,width: width,quantity: quantity,sqft: sqft,perPieceWeight: perPieceWeight,totalWeight: totalWeight,totalRunningFeet: totalRunningFeet,);
  }
  
  
  ListSheetProductionDetailsReportsVariablesBuilder listSheetProductionDetailsReports () {
    return ListSheetProductionDetailsReportsVariablesBuilder(dataConnect, );
  }
  
  
  GetSheetProductionDetailsReportVariablesBuilder getSheetProductionDetailsReport ({required String machineNumber, required DateTime date, required String shift, }) {
    return GetSheetProductionDetailsReportVariablesBuilder(dataConnect, machineNumber: machineNumber,date: date,shift: shift,);
  }
  
  
  CreateSheetRunningFeetReportVariablesBuilder createSheetRunningFeetReport ({required DateTime date, required String machineNumber, required String shift, required double productionRunningFeet, required double maintenanceRunningFeet, required double totalProductionRunningFeet, required double targetRunningFeet, required double efficiencyPercentage, required String createdBy, }) {
    return CreateSheetRunningFeetReportVariablesBuilder(dataConnect, date: date,machineNumber: machineNumber,shift: shift,productionRunningFeet: productionRunningFeet,maintenanceRunningFeet: maintenanceRunningFeet,totalProductionRunningFeet: totalProductionRunningFeet,targetRunningFeet: targetRunningFeet,efficiencyPercentage: efficiencyPercentage,createdBy: createdBy,);
  }
  
  
  ListSheetRunningFeetReportsVariablesBuilder listSheetRunningFeetReports () {
    return ListSheetRunningFeetReportsVariablesBuilder(dataConnect, );
  }
  
  
  CreateSheetShiftPackingReportVariablesBuilder createSheetShiftPackingReport ({required DateTime date, required String machineNumber, required String shift, required double totalRejectedRunningFeet, required double qualityAcceptancePercentage, required double packingEfficiency, required String createdBy, }) {
    return CreateSheetShiftPackingReportVariablesBuilder(dataConnect, date: date,machineNumber: machineNumber,shift: shift,totalRejectedRunningFeet: totalRejectedRunningFeet,qualityAcceptancePercentage: qualityAcceptancePercentage,packingEfficiency: packingEfficiency,createdBy: createdBy,);
  }
  
  
  CreateSheetPackingLineItemVariablesBuilder createSheetPackingLineItem ({required CreateSheetPackingLineItemVariablesReportId reportId, required String thickness, required String density, required String color, required double length, required double width, required int productionQuantity, required double perPieceWeight, required double runningFeetPerItem, required int packed, required int onlySanding, required int sandingAndPacked, required int rejectedQuality, }) {
    return CreateSheetPackingLineItemVariablesBuilder(dataConnect, reportId: reportId,thickness: thickness,density: density,color: color,length: length,width: width,productionQuantity: productionQuantity,perPieceWeight: perPieceWeight,runningFeetPerItem: runningFeetPerItem,packed: packed,onlySanding: onlySanding,sandingAndPacked: sandingAndPacked,rejectedQuality: rejectedQuality,);
  }
  
  
  ListSheetShiftPackingReportsVariablesBuilder listSheetShiftPackingReports () {
    return ListSheetShiftPackingReportsVariablesBuilder(dataConnect, );
  }
  
  
  CreateSheetWritingEfficiencyVariablesBuilder createSheetWritingEfficiency ({required DateTime date, required String machineNumber, required String shift, required Timestamp shiftEndTime, required int score, required String operatorId, }) {
    return CreateSheetWritingEfficiencyVariablesBuilder(dataConnect, date: date,machineNumber: machineNumber,shift: shift,shiftEndTime: shiftEndTime,score: score,operatorId: operatorId,);
  }
  
  
  ListSheetWritingEfficiencyVariablesBuilder listSheetWritingEfficiency () {
    return ListSheetWritingEfficiencyVariablesBuilder(dataConnect, );
  }
  
  
  CreateSheetCustomerRejectionReportVariablesBuilder createSheetCustomerRejectionReport ({required DateTime originalProductionDate, required String machineNumber, required String shift, required double totalRejectedRunningFeet, required String createdBy, }) {
    return CreateSheetCustomerRejectionReportVariablesBuilder(dataConnect, originalProductionDate: originalProductionDate,machineNumber: machineNumber,shift: shift,totalRejectedRunningFeet: totalRejectedRunningFeet,createdBy: createdBy,);
  }
  
  
  CreateSheetCustomerRejectionItemVariablesBuilder createSheetCustomerRejectionItem ({required CreateSheetCustomerRejectionItemVariablesReportId reportId, required String thickness, required String density, required String color, required double length, required double width, required int quantity, required double sqft, required double perPieceWeight, required double totalWeight, required double totalRunningFeet, }) {
    return CreateSheetCustomerRejectionItemVariablesBuilder(dataConnect, reportId: reportId,thickness: thickness,density: density,color: color,length: length,width: width,quantity: quantity,sqft: sqft,perPieceWeight: perPieceWeight,totalWeight: totalWeight,totalRunningFeet: totalRunningFeet,);
  }
  
  
  ListSheetCustomerRejectionReportsVariablesBuilder listSheetCustomerRejectionReports () {
    return ListSheetCustomerRejectionReportsVariablesBuilder(dataConnect, );
  }
  
  
  CreateFrameCleaningReportVariablesBuilder createFrameCleaningReport ({required DateTime date, required String machineNumber, required int machineCondition, required int groundCondition, required int mouldCondition, required int totalScore, required double percentage, required String createdBy, }) {
    return CreateFrameCleaningReportVariablesBuilder(dataConnect, date: date,machineNumber: machineNumber,machineCondition: machineCondition,groundCondition: groundCondition,mouldCondition: mouldCondition,totalScore: totalScore,percentage: percentage,createdBy: createdBy,);
  }
  
  
  ListFrameCleaningReportsVariablesBuilder listFrameCleaningReports () {
    return ListFrameCleaningReportsVariablesBuilder(dataConnect, );
  }
  
  
  CreateFrameToolsCountReportVariablesBuilder createFrameToolsCountReport ({required DateTime date, required String machineNumber, required int totalToolsGiven, required int totalToolsAvailable, required double percentageAvailable, required String createdBy, }) {
    return CreateFrameToolsCountReportVariablesBuilder(dataConnect, date: date,machineNumber: machineNumber,totalToolsGiven: totalToolsGiven,totalToolsAvailable: totalToolsAvailable,percentageAvailable: percentageAvailable,createdBy: createdBy,);
  }
  
  
  ListFrameToolsCountReportsVariablesBuilder listFrameToolsCountReports () {
    return ListFrameToolsCountReportsVariablesBuilder(dataConnect, );
  }
  
  
  CreateFrameHealthReportVariablesBuilder createFrameHealthReport ({required DateTime date, required String machineNumber, required String shift, required int totalScore, required double percentage, required String createdBy, }) {
    return CreateFrameHealthReportVariablesBuilder(dataConnect, date: date,machineNumber: machineNumber,shift: shift,totalScore: totalScore,percentage: percentage,createdBy: createdBy,);
  }
  
  
  CreateFrameHealthRatingItemVariablesBuilder createFrameHealthRatingItem ({required CreateFrameHealthRatingItemVariablesReportId reportId, required String item, required int rating, }) {
    return CreateFrameHealthRatingItemVariablesBuilder(dataConnect, reportId: reportId,item: item,rating: rating,);
  }
  
  
  ListFrameHealthReportsVariablesBuilder listFrameHealthReports () {
    return ListFrameHealthReportsVariablesBuilder(dataConnect, );
  }
  
  
  CreateFrameProductionDetailsReportVariablesBuilder createFrameProductionDetailsReport ({required DateTime date, required String machineNumber, required String shift, required int totalQuantity, required double totalWeight, required String createdBy, }) {
    return CreateFrameProductionDetailsReportVariablesBuilder(dataConnect, date: date,machineNumber: machineNumber,shift: shift,totalQuantity: totalQuantity,totalWeight: totalWeight,createdBy: createdBy,);
  }
  
  
  CreateFrameProductionLineItemVariablesBuilder createFrameProductionLineItem ({required CreateFrameProductionLineItemVariablesReportId reportId, required String section, required String density, required String color, required double length, required int quantity, required double perPieceWeight, required double totalWeight, }) {
    return CreateFrameProductionLineItemVariablesBuilder(dataConnect, reportId: reportId,section: section,density: density,color: color,length: length,quantity: quantity,perPieceWeight: perPieceWeight,totalWeight: totalWeight,);
  }
  
  
  ListFrameProductionDetailsReportsVariablesBuilder listFrameProductionDetailsReports () {
    return ListFrameProductionDetailsReportsVariablesBuilder(dataConnect, );
  }
  
  
  GetFrameProductionDetailsReportVariablesBuilder getFrameProductionDetailsReport ({required String machineNumber, required DateTime date, required String shift, }) {
    return GetFrameProductionDetailsReportVariablesBuilder(dataConnect, machineNumber: machineNumber,date: date,shift: shift,);
  }
  
  
  CreateFrameProductionWeightReportVariablesBuilder createFrameProductionWeightReport ({required DateTime date, required String machineNumber, required String shift, required double productionWeight, required double maintenanceWeight, required double totalProductionWeight, required double targetWeight, required double efficiencyPercentage, required String createdBy, }) {
    return CreateFrameProductionWeightReportVariablesBuilder(dataConnect, date: date,machineNumber: machineNumber,shift: shift,productionWeight: productionWeight,maintenanceWeight: maintenanceWeight,totalProductionWeight: totalProductionWeight,targetWeight: targetWeight,efficiencyPercentage: efficiencyPercentage,createdBy: createdBy,);
  }
  
  
  ListFrameProductionWeightReportsVariablesBuilder listFrameProductionWeightReports () {
    return ListFrameProductionWeightReportsVariablesBuilder(dataConnect, );
  }
  
  
  CreateFrameShiftPackingReportVariablesBuilder createFrameShiftPackingReport ({required DateTime date, required String machineNumber, required String shift, required double totalRejectedWeight, required double qualityAcceptancePercentage, required double packingEfficiency, required String createdBy, }) {
    return CreateFrameShiftPackingReportVariablesBuilder(dataConnect, date: date,machineNumber: machineNumber,shift: shift,totalRejectedWeight: totalRejectedWeight,qualityAcceptancePercentage: qualityAcceptancePercentage,packingEfficiency: packingEfficiency,createdBy: createdBy,);
  }
  
  
  CreateFramePackingLineItemVariablesBuilder createFramePackingLineItem ({required CreateFramePackingLineItemVariablesReportId reportId, required String section, required String density, required String color, required double length, required int productionQuantity, required double perPieceWeight, required int packed, required int rejectedQuality, }) {
    return CreateFramePackingLineItemVariablesBuilder(dataConnect, reportId: reportId,section: section,density: density,color: color,length: length,productionQuantity: productionQuantity,perPieceWeight: perPieceWeight,packed: packed,rejectedQuality: rejectedQuality,);
  }
  
  
  ListFrameShiftPackingReportsVariablesBuilder listFrameShiftPackingReports () {
    return ListFrameShiftPackingReportsVariablesBuilder(dataConnect, );
  }
  
  
  CreateFrameWritingEfficiencyVariablesBuilder createFrameWritingEfficiency ({required DateTime date, required String machineNumber, required String shift, required Timestamp shiftEndTime, required int score, required String operatorId, }) {
    return CreateFrameWritingEfficiencyVariablesBuilder(dataConnect, date: date,machineNumber: machineNumber,shift: shift,shiftEndTime: shiftEndTime,score: score,operatorId: operatorId,);
  }
  
  
  ListFrameWritingEfficiencyVariablesBuilder listFrameWritingEfficiency () {
    return ListFrameWritingEfficiencyVariablesBuilder(dataConnect, );
  }
  
  
  CreateFrameCustomerRejectionReportVariablesBuilder createFrameCustomerRejectionReport ({required DateTime originalProductionDate, required DateTime rejectionDate, required String machineNumber, required String shift, required double totalRejectedWeight, required String createdBy, }) {
    return CreateFrameCustomerRejectionReportVariablesBuilder(dataConnect, originalProductionDate: originalProductionDate,rejectionDate: rejectionDate,machineNumber: machineNumber,shift: shift,totalRejectedWeight: totalRejectedWeight,createdBy: createdBy,);
  }
  
  
  CreateFrameCustomerRejectionItemVariablesBuilder createFrameCustomerRejectionItem ({required CreateFrameCustomerRejectionItemVariablesReportId reportId, required String section, required String density, required String color, required double length, required int quantity, required double perPieceWeight, required double totalWeight, }) {
    return CreateFrameCustomerRejectionItemVariablesBuilder(dataConnect, reportId: reportId,section: section,density: density,color: color,length: length,quantity: quantity,perPieceWeight: perPieceWeight,totalWeight: totalWeight,);
  }
  
  
  ListFrameCustomerRejectionReportsVariablesBuilder listFrameCustomerRejectionReports () {
    return ListFrameCustomerRejectionReportsVariablesBuilder(dataConnect, );
  }
  

  static ConnectorConfig connectorConfig = ConnectorConfig(
    'asia-south1',
    'default',
    'prabitha-operations-service',
  );

  DefaultConnector({required this.dataConnect});
  static DefaultConnector get instance {
    
    return DefaultConnector(
        dataConnect: FirebaseDataConnect.instanceFor(
            connectorConfig: connectorConfig,
            
            sdkType: CallerSDKType.generated));
  }

  FirebaseDataConnect dataConnect;
}
