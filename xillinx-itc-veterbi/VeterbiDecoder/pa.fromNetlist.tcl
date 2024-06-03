
# PlanAhead Launch Script for Post-Synthesis pin planning, created by Project Navigator

create_project -name VeterbiDecoder -dir "C:/Users/Prithvish/Desktop/xillinx-itc-veterbi/VeterbiDecoder/planAhead_run_1" -part xc3s100evq100-5
set_property design_mode GateLvl [get_property srcset [current_run -impl]]
set_property edif_top_file "C:/Users/Prithvish/Desktop/xillinx-itc-veterbi/VeterbiDecoder/convolutionale_encoding.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {C:/Users/Prithvish/Desktop/xillinx-itc-veterbi/VeterbiDecoder} }
set_param project.pinAheadLayout  yes
set_property target_constrs_file "convolutionale_encoding.ucf" [current_fileset -constrset]
add_files [list {convolutionale_encoding.ucf}] -fileset [get_property constrset [current_run]]
link_design
