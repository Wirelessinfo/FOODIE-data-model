
DROP SCHEMA  IF EXISTS foodie CASCADE ;

CREATE SCHEMA foodie;

SET search_path TO foodie, public;

CREATE TABLE holding (
	holding_id bigint,
	inspire_id_code text,
	inspire_id_code_space text,
	inspire_id_code_version timestamp with time zone,
	geometry geometry,
	holding_name text,
	valid_from timestamp with time zone,
	valid_to timestamp with time zone,
	begin_life_span_version timestamp with time zone,
	end_life_span_version timestamp with time zone,
	user_id text
	) ;

ALTER TABLE holding ADD CONSTRAINT pk_holding 
	PRIMARY KEY (holding_id);

CREATE TABLE holding_thematic_id (
	holding_thematic_id bigint,
	thematic_id text,
	holding_id bigint
	) ;

ALTER TABLE holding_thematic_id ADD CONSTRAINT pk_holding_thematic_id 
	PRIMARY KEY (holding_thematic_id);

CREATE TABLE  holding_function(
	holding_function_id bigint,
	holding_id bigint,
	holding_function text
	) ;

ALTER TABLE holding_function ADD CONSTRAINT pk_holding_function_id
	PRIMARY KEY (holding_function_id );

CREATE TABLE site(
	site_id bigint,
	code text,
	code_space text,
	code_version timestamp with time zone,
	geometry geometry,
	valid_from timestamp with time zone,
	valid_to timestamp with time zone,
	begin_life_span_version timestamp with time zone,
	end_life_span_version timestamp with time zone,
	holding_id bigint, --contains (aggregation)
	site_name text
	) ;

ALTER TABLE site ADD CONSTRAINT pk_site 
	PRIMARY KEY (site_id);

CREATE TABLE site_activity(
	site_activity_id bigint,
	site_id bigint,
	economic_activity_nace_value_id bigint
	) ;

ALTER TABLE site_activity add CONSTRAINT pk_site_activity
	PRIMARY KEY (site_activity_id);	

CREATE TABLE economic_activity_nace_value(
	economic_activity_nace_value_id bigint,
	economic_activity_nace_value_name text
	) ;

ALTER TABLE economic_activity_nace_value add CONSTRAINT pk_economic_activity_nace_value
	PRIMARY KEY (economic_activity_nace_value_id);

CREATE TABLE plot ( 
	plot_id bigint,
	code text,
	code_space text,
	code_version timestamp,
	valid_from timestamp with time zone,
	valid_to timestamp with time zone,
	begin_life_span_version timestamp with time zone,
	end_life_span_version timestamp with time zone,
	geometry geometry,
	description text,
	origin_type_value_id bigint,
	site_id bigint --containsPlot (aggregation)
	) ;

ALTER TABLE plot ADD CONSTRAINT pk_plot 
	PRIMARY KEY (plot_id);

CREATE TABLE origin_type_value ( 
	origin_type_value_id bigint,
	origin_type_value_name text
	) ;

ALTER TABLE origin_type_value ADD CONSTRAINT pk_origin_type_value 
	PRIMARY KEY (origin_type_value_id);

CREATE TABLE crop_species (
	crop_species_id bigint,
	crop_type_id bigint,
	valid_from timestamp with time zone,
	valid_to timestamp with time zone,
	begin_life_span_version timestamp with time zone,
	end_life_span_version timestamp with time zone,
	crop_area geometry
	--plot_id bigint --speciesPlot
	) ;

ALTER TABLE crop_species ADD CONSTRAINT pk_crop_species 
	PRIMARY KEY (crop_species_id);

CREATE TABLE  crop_species_plot(
	crop_species_plot_id bigint,
	crop_species_id bigint,
	plot_id bigint
	) ;

ALTER TABLE crop_species_plot ADD CONSTRAINT pk_crop_species_plot
	PRIMARY KEY (crop_species_plot_id);

CREATE TABLE crop_type (
	crop_type_id bigint,
	code text,
	description text,
	crop_type_family text,
	genus text,
	species text,
	notes text,
	variety text
	) ;
		
ALTER TABLE crop_type ADD CONSTRAINT pk_crop_type
	PRIMARY KEY (crop_type_id);

CREATE TABLE crop_type_name (
	crop_type_name_id bigint,
	crop_type_id bigint,
	crop_type_name text
	) ;

ALTER TABLE crop_type_name ADD CONSTRAINT pk_crop_type_name
	PRIMARY KEY (crop_type_name_id);

CREATE TABLE production_type ( --CHANGED NAME, WAS: production
	production_type_id bigint,
	production_date date,
	variety text,
	production_amount_value double precision,
	production_amount_uom_name text
	--crop_species_id bigint --production in CropSpecies
	) ;

ALTER TABLE production_type ADD CONSTRAINT pk_production_type
	PRIMARY KEY (production_type_id);

CREATE TABLE  production_type_production_property(
	production_type_production_property_id bigint,
	production_type_id bigint,
	property_type_id bigint
	) ;	

ALTER TABLE production_type_production_property ADD CONSTRAINT pk_production_type_production_property
	PRIMARY KEY (production_type_production_property_id);
	
CREATE TABLE  crop_species_production_type(
	crop_species_production_type_id bigint,
	crop_species_id bigint,
	production_type_id bigint
	) ;

ALTER TABLE crop_species_production_type ADD CONSTRAINT pk_crop_species_production_type
	PRIMARY KEY (crop_species_production_type_id);		

CREATE TABLE property_type ( 
	property_type_id bigint,
	property_name text,
	analysis_date date,
	non_guantitative_property text,
	quantitative_property_value double precision,
	quantitative_property_uom_name text,
	property_type_value_id bigint
	) ;

ALTER TABLE property_type ADD CONSTRAINT pk_property_type
	PRIMARY KEY (property_type_id);


CREATE TABLE alert (
	alert_id bigint,
	code text,
	code_space text,
	code_version timestamp with time zone,
	description text,
	alert_date date,
	alert_geometry geometry
	) ;
	
ALTER TABLE alert ADD CONSTRAINT pk_alert
	PRIMARY KEY (alert_id);

CREATE TABLE alert_type (
	alert_type_id bigint,
	alert_id bigint,
	alert_type text
	) ;
	
ALTER TABLE alert_type ADD CONSTRAINT pk_alert_type
	PRIMARY KEY (alert_type_id);

CREATE TABLE alert_plot ( --alertPlot, plotAlert
	alert_plot_id bigint,
	alert_id bigint,
	plot_id bigint
	) ;
	
ALTER TABLE alert_plot ADD CONSTRAINT pk_alert_plot
	PRIMARY KEY (alert_plot_id);

CREATE TABLE alert_crop_species ( --alertSpecies, speciesAlert
	alert_crop_species_id bigint,
	alert_id bigint,
	crop_species_id bigint
	) ;

ALTER TABLE alert_crop_species ADD CONSTRAINT pk_alert_crop_species
	PRIMARY KEY (alert_crop_species_id);

CREATE TABLE management_zone(
	management_zone_id bigint,
	code text,
	code_space text,
	code_version timestamp with time zone,
	valid_from timestamp with time zone,
	valid_to timestamp with time zone,
	begin_life_span_version timestamp with time zone,
	end_life_span_zone timestamp with time zone,
	geometry geometry,
	notes text,
	plot_id bigint --containsZone (aggregation)
	) ;

ALTER TABLE management_zone ADD CONSTRAINT pk_management_zone
	PRIMARY KEY (management_zone_id);

CREATE TABLE management_zone_soil_property (
	management_zone_soil_property_id bigint,
	management_zone_id bigint,
	property_type_id bigint
	) ;

ALTER TABLE management_zone_soil_property ADD CONSTRAINT pk_management_zone_soil_property
	PRIMARY KEY (management_zone_soil_property_id);

CREATE TABLE alert_management_zone ( --alertZone, zoneAlert
	alert_management_zone_id bigint,
	alert_id bigint,
	management_zone_id bigint
	) ;
	
ALTER TABLE alert_management_zone ADD CONSTRAINT pk_alert_management_zone
	PRIMARY KEY (alert_management_zone_id);

CREATE TABLE intervention
( intervention_id bigint,
  description text,
  notes text,
  price text,
  status text,
  creation_date_time timestamp with time zone,
  intervention_start timestamp with time zone,
  intervention_end timestamp with time zone,
  intervention_geometry geometry,
  intervention_type_value_id bigint,
  plot_id bigint --interventionPlot
  ) ;

ALTER TABLE intervention ADD CONSTRAINT pk_intervention
	PRIMARY KEY (intervention_id);

CREATE TABLE treatment
( treatment_id bigint,
  price text,
  quantity_value double precision,
  quantity_uom_name text,
  motion_speed_value double precision,
  motion_speed_oum_name text,
  pressure_value double precision,
  pressure_uom_name text,
  flow_adjustment_value double precision,
  flow_adjustment_uom_name text,
  application_width_value double precision,
  application_width_uom_name text,
  area_dose_minimum_value double precision,
  area_dose_minimum_uom_name text,
  area_dose_maximum_value double precision,
  area_dose_maximum_uom_name text,
  form_of_treatment_value_id bigint,
  treatment_plan_id bigint, --plan
  treatment_description text,
  intervention_id bigint not null
  ) ;

ALTER TABLE treatment ADD CONSTRAINT pk_treatment
	PRIMARY KEY (treatment_id);

CREATE TABLE tractor_type ( --NAME CHANGED WAS: tractor_id
	tractor_type_id bigint,
	tractor_code text
	) ;

ALTER TABLE tractor_type ADD CONSTRAINT pk_tractor_type
	PRIMARY KEY (tractor_type_id);

CREATE TABLE machine_type ( --NAME CHANGED WAS: machine_id
	machine_type_id bigint,
	machine_code text
	);

ALTER TABLE machine_type ADD CONSTRAINT pk_machine_type
	PRIMARY KEY (machine_type_id);

CREATE TABLE intervention_machine ( --NAME CHANGED WAS: machine_id
	intervention_machine_id bigint,
	intervention_id bigint,
	machine_type_id bigint
	);

ALTER TABLE intervention_machine ADD CONSTRAINT pk_intervention_machine
	PRIMARY KEY (intervention_machine_id);

CREATE TABLE holding_machine ( --NAME CHANGED WAS: machine_id
	holding_machine_id bigint,
	holding_id bigint,
	machine_type_id bigint
	);

ALTER TABLE holding_machine ADD CONSTRAINT pk_holding_machine
	PRIMARY KEY (holding_machine_id);

CREATE TABLE intervention_tractor ( --NAME CHANGED WAS: machine_id
	intervention_tractor_id bigint,
	intervention_id bigint,
	tractor_type_id bigint
	);

ALTER TABLE intervention_tractor ADD CONSTRAINT pk_intervention_tractor
	PRIMARY KEY (intervention_tractor_id);

CREATE TABLE holding_tractor ( --NAME CHANGED WAS: machine_id
	holding_tractor_id bigint,
	holding_id bigint,
	tractor_type_id bigint
	);

ALTER TABLE holding_tractor ADD CONSTRAINT pk_holding_tractor
	PRIMARY KEY (holding_tractor_id);
	
CREATE TABLE intervention_management_zone ( --NAME CHANGED WAS: machine_id
	intervention_management_zone_id bigint,
	management_zone_id bigint,
	intervention_id bigint
	);

ALTER TABLE intervention_management_zone ADD CONSTRAINT pk_intervention_management_zone
	PRIMARY KEY (intervention_management_zone_id);


CREATE TABLE product(
	product_id bigint,
	product_kind_value_id bigint,
	description text,
	safety_instructions text,
	storage_handling text,
	product_type text,
	price text
	) ;

ALTER TABLE product ADD CONSTRAINT pk_product
	PRIMARY KEY (product_id);

CREATE TABLE product_code(
	product_code_id bigint,
	product_id bigint,
	product_code text	
	) ;

ALTER TABLE product_code ADD CONSTRAINT pk_product_code
	PRIMARY KEY (product_code_id);

CREATE TABLE product_name(
	product_name_id bigint,
	product_id bigint,
	product_name text	
	) ;

ALTER TABLE product_name ADD CONSTRAINT pk_product_name
	PRIMARY KEY (product_name_id);

CREATE TABLE product_sub_type(
	product_sub_type_id bigint,
	product_id bigint,
	product_sub_type text
	) ;

ALTER TABLE product_sub_type ADD CONSTRAINT pk_product_sub_type
	PRIMARY KEY (product_sub_type_id);

CREATE TABLE product_register_url(
	product_register_url_id bigint,
	product_id bigint,
	register_url text
	) ;

ALTER TABLE product_register_url ADD CONSTRAINT pk_product_register_url
	PRIMARY KEY (product_register_url_id);

CREATE TABLE product_registration_code(
	product_registration_code_id bigint,
	product_id bigint,
	registration_code text
	) ;

ALTER TABLE product_registration_code ADD CONSTRAINT pk_product_registration_code
	PRIMARY KEY (product_registration_code_id);

CREATE TABLE product_treatment( --productTreatment, treatmentProduct
	product_treatment_id bigint,
	product_id bigint,
	treatment_id bigint
	) ;

ALTER TABLE product_treatment ADD CONSTRAINT pk_product_treatment
	PRIMARY KEY (product_treatment_id);

CREATE TABLE treatment_plan(
	treatment_plan_id bigint,
	treatment_plan_code text,
	description text,
	treatment_plan_creation timestamp with time zone,
	notes text,
	treatment_plan_type_value_id bigint
	) ;	

ALTER TABLE treatment_plan ADD CONSTRAINT pk_treatment_plan
	PRIMARY KEY (treatment_plan_id);

CREATE TABLE campaign_type(
	campaign_type_id bigint,
	campaign_begin timestamp with time zone,
	campaign_end timestamp with time zone
	) ;	
	
ALTER TABLE campaign_type ADD CONSTRAINT pk_campaign
	PRIMARY KEY (campaign_type_id);

CREATE TABLE treatment_plan_campaign(
	treatment_plan_campaign_id bigint,
	treatment_plan_id bigint,
	campaign_type_id bigint
	) ;	
	
ALTER TABLE treatment_plan_campaign ADD CONSTRAINT pk_treatment_plan_campaign
	PRIMARY KEY (treatment_plan_campaign_id);

CREATE TABLE product_treatment_plan( --productPlan, planProduct
	product_treatment_plan_id bigint,
	product_id bigint,
	treatment_plan_id bigint
	) ;	

ALTER TABLE product_treatment_plan ADD CONSTRAINT pk_product_treatment_plan
	PRIMARY KEY (product_treatment_plan_id);

CREATE TABLE product_preparation(
	product_preparation_id bigint,
	product_quantity_value double precision,
	product_quantity_uom_name text,
	solvent_quantity_value double precision,
	solvent_quantity_uom_name text,
	safety_period_begin timestamp with time zone,
	safety_period_end timestamp with time zone,
	treatment_plan_id bigint, --preparationPlan (aggregation->special)
	product_id bigint
	) ;	

ALTER TABLE product_preparation ADD CONSTRAINT pk_product_preparation_id
	PRIMARY KEY (product_preparation_id);


CREATE TABLE soil_nutrients(
	soil_nutrients_id bigint,
	management_zone_id bigint, --zoneNutrients (aggregation)
	nutrient_amount_value double precision,
	nutrient_amount_uom_name text,
	nutrients_measure text,
	nutrient_name text
	) ;	

ALTER TABLE soil_nutrients ADD CONSTRAINT pk_soil_nutrients
	PRIMARY KEY (soil_nutrients_id);

CREATE TABLE product_nutrients(
	product_nutrients_id bigint,
	product_id bigint, --nutrient (aggregation)
	nutrient_amount_value double precision,
	nutrient_amount_uom_name text,
	nutrients_measure text,
	nutrient_name text
	) ;	

ALTER TABLE product_nutrients ADD CONSTRAINT pk_product_nutrients
	PRIMARY KEY (product_nutrients_id);

CREATE TABLE form_of_treatment_value( --for treatment
	form_of_treatment_value_id bigint,
	form_of_treatment_value_name text
	) ;	
	
ALTER TABLE form_of_treatment_value ADD CONSTRAINT pk_form_of_treatment_value
	PRIMARY KEY (form_of_treatment_value_id);

CREATE TABLE treatment_purpose ( --for treatment CHANGED NAME WAS treatment_purpose
	treatment_purpose_id bigint,
	treatment_id bigint,
	treatment_purpose_value_id bigint
	) ;

ALTER TABLE treatment_purpose ADD CONSTRAINT pk_treatment_purpose
	PRIMARY KEY (treatment_purpose_id);

CREATE TABLE treatment_purpose_value(
	treatment_purpose_value_id bigint,
	treatment_purpose_value_name text
	) ;

ALTER TABLE treatment_purpose_value ADD CONSTRAINT pk_treatment_purpose_value
	PRIMARY KEY (treatment_purpose_value_id);

CREATE TABLE product_kind_value( --for product
	product_kind_value_id bigint,
	product_kind_value_name text
	) ;

ALTER TABLE product_kind_value add CONSTRAINT pk_product_kind_value
	PRIMARY KEY (product_kind_value_id);

CREATE TABLE property_type_value( --for property_type
	property_type_value_id bigint,
	property_type_value_name text
	) ;

ALTER TABLE property_type_value add CONSTRAINT pk_property_type_value
	PRIMARY KEY (property_type_value_id);

CREATE TABLE cl_responsible_party( 
	cl_responsible_party_id bigint,
	cl_contact_id bigint,
	individual_name text,
	organisation_name text,
	position_name text,
	cl_responsible_party_role_id bigint
	) ;

ALTER TABLE cl_responsible_party add CONSTRAINT pk_cl_responsible_party
	PRIMARY KEY (cl_responsible_party_id);

CREATE TABLE cl_contact(
	cl_contact_id bigint,
	cl_address_id bigint,
	contact_instructions text,
	hours_of_service text,
	cl_online_resource_id bigint,
	cl_phone_id bigint
	) ;

ALTER TABLE cl_contact add CONSTRAINT pk_cl_contact
	PRIMARY KEY (cl_contact_id);

CREATE TABLE cl_telephone(
	cl_telephone_id bigint
	) ;

ALTER TABLE cl_telephone add CONSTRAINT pk_cl_telephone
	PRIMARY KEY (cl_telephone_id);

CREATE TABLE facsimile(
	facsimile_id bigint,
	cl_telephone_id bigint,
	facsimile  text
	) ;

ALTER TABLE facsimile add CONSTRAINT pk_facsimile
	PRIMARY KEY (facsimile_id);
	
CREATE TABLE voice(
	voice_id bigint,
	cl_telephone_id bigint,
	voice  text
	) ;

ALTER TABLE voice add CONSTRAINT pk_voice
	PRIMARY KEY (voice_id);

CREATE TABLE cl_address(
	cl_address_id bigint,
	administrative_area text,
	city text,
	country text,
	postal_code text
	) ;

ALTER TABLE cl_address add CONSTRAINT pk_cl_address
	PRIMARY KEY (cl_address_id);

CREATE TABLE delivery_point(
	delivery_point_id bigint,
	cl_address_id bigint,
	delivery_point text
	) ;

ALTER TABLE delivery_point add CONSTRAINT pk_delivery_point
	PRIMARY KEY (delivery_point_id);

CREATE TABLE electronic_mail_address(
	electronic_mail_adress_id bigint,
	cl_address_id bigint,
	electronic_mail_adress text
	) ;

ALTER TABLE electronic_mail_address add CONSTRAINT pk_electronic_mail_adress
	PRIMARY KEY (electronic_mail_adress_id);

CREATE TABLE cl_online_resource(
	cl_online_resource_id bigint,
	description text,
	cl_online_function_code_id bigint,
	linkage text,
	application_profile text,
	cl_online_resource_name text,
	protocol text	
	) ;

ALTER TABLE cl_online_resource add CONSTRAINT pk_cl_conline_resource
	PRIMARY KEY (cl_online_resource_id);
	
CREATE TABLE cl_online_function_code(
	cl_online_function_code_id bigint,
	cl_online_function_code_name text
	) ;

ALTER TABLE cl_online_function_code add CONSTRAINT pk_cl_online_function_code
	PRIMARY KEY (cl_online_function_code_id);

CREATE TABLE cl_role_code(
	cl_role_code_id bigint,
	cl_role_code_name text
	) ;

ALTER TABLE cl_role_code add CONSTRAINT pk_cl_role_code
	PRIMARY KEY (cl_role_code_id);


CREATE TABLE intervention_supervisor(
	supervisor_id bigint,
	intervention_id bigint,
	cl_responsible_party_id bigint
	) ;

ALTER TABLE intervention_supervisor add CONSTRAINT pk_intervention_supervisor
	PRIMARY KEY (supervisor_id);


CREATE TABLE intervention_evidence_party(
	evidence_party_id bigint,
	intervention_id bigint,
	cl_responsible_party_id bigint
	) ;

ALTER TABLE intervention_evidence_party add CONSTRAINT pk_intervention_evidence_party
	PRIMARY KEY (evidence_party_id);

CREATE TABLE intervention_operator(
	operator_id bigint,
	intervention_id bigint,
	cl_responsible_party_id bigint
	) ;

ALTER TABLE intervention_operator add CONSTRAINT pk_intervention_operator
	PRIMARY KEY (operator_id);

CREATE TABLE product_manufacturer (
	product_manufacturer_id bigint,
	product_id bigint,
	cl_responsible_party_id bigint
	) ;

ALTER TABLE product_manufacturer add CONSTRAINT pk_product_manufacturer
	PRIMARY KEY (product_manufacturer_id);

CREATE TABLE active_ingredients (
	active_ingredients_id bigint,
	code text,
	code_space text,
	code_version timestamp with time zone,
	ingredient_name text,
	ingredient_amount_value double precision,
	ingredient_amount_uom_name text,
	product_id bigint --ingredientProduct (aggregation->special)
	) ;

ALTER TABLE active_ingredients add CONSTRAINT PK_active_ingredients
	PRIMARY KEY (active_ingredients_id);

CREATE TABLE user_check_type (
	user_check_type_id bigint,
	alert_id bigint,
	cl_responsible_party_id bigint,
	checked_by_user boolean
	
	) ;


ALTER TABLE user_check_type add CONSTRAINT PK_user_check_type
	PRIMARY KEY (user_check_type_id);

CREATE TABLE treatment_plan_type_value (
	treatment_plan_type_value_id bigint,
	treatment_plan_type_value_name text
	
	) ;


ALTER TABLE treatment_plan_type_value add CONSTRAINT PK_treatment_plan_type_value
	PRIMARY KEY (treatment_plan_type_value_id);

CREATE TABLE intervention_type_value (
	intervention_type_value_id bigint,
	intervention_type_value_name text
	
	) ;


ALTER TABLE intervention_type_value add CONSTRAINT PK_intervention_type_value_id
	PRIMARY KEY (intervention_type_value_id);

CREATE TABLE farm_animal_species( 
	farm_animal_species_id bigint,
	livestock_type text,
	livestock_number integer
	) ;

ALTER TABLE farm_animal_species ADD CONSTRAINT pk_farm_animal_species
	PRIMARY KEY (farm_animal_species_id);

CREATE TABLE site_includes_animal( 
	site_includes_animal_id bigint,
	site_id bigint,
	farm_animal_species_id bigint
	);

ALTER TABLE site_includes_animal ADD CONSTRAINT pk_site_includes_animal
	PRIMARY KEY (site_includes_animal_id);


CREATE TABLE livestock_species_value( 
	livestock_species_value_id bigint,
	livestock_species_value_name text
	);
	

ALTER TABLE livestock_species_value ADD CONSTRAINT pk_livestock_species_value
	PRIMARY KEY (livestock_species_value_id);


CREATE TABLE farm_animal_species_livestock( 
	farm_animal_species_livestock_id bigint,
	livestock_species_value_id bigint,
	farm_animal_species_id bigint
	);
	

ALTER TABLE farm_animal_species_livestock ADD CONSTRAINT pk_farm_animal_species_livestock
	PRIMARY KEY (farm_animal_species_livestock_id);

CREATE TABLE aquaculture_species_value( 
	aquaculture_species_value_id bigint,
	aquaculture_species_value_name text
	);
	

ALTER TABLE aquaculture_species_value ADD CONSTRAINT pk_aquaculture_species_value
	PRIMARY KEY (aquaculture_species_value_id);


CREATE TABLE farm_animal_species_aquaculture( 
	farm_animal_species_aquaculture_id bigint,
	aquaculture_species_value_id bigint,
	farm_animal_species_id bigint
	);
	

ALTER TABLE farm_animal_species_aquaculture ADD CONSTRAINT pk_farm_animal_species_aquaculture
	PRIMARY KEY (farm_animal_species_aquaculture_id);
----------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------

ALTER TABLE site
  ADD CONSTRAINT fk_site__holding FOREIGN KEY (holding_id)
      REFERENCES holding (holding_id);

ALTER TABLE site_activity  
	ADD CONSTRAINT fk_site_activity__site FOREIGN KEY (site_id)
      REFERENCES site(site_id);

ALTER TABLE site_activity  
	ADD CONSTRAINT fk_site_activity__economic_activity_nace_value FOREIGN KEY (economic_activity_nace_value_id)
      REFERENCES economic_activity_nace_value(economic_activity_nace_value_id);

ALTER TABLE plot
  ADD CONSTRAINT fk_plot__site FOREIGN KEY (site_id)
      REFERENCES site (site_id);

ALTER TABLE plot 
	ADD CONSTRAINT fk_plot__origin_type_value FOREIGN KEY (origin_type_value_id) 
			REFERENCES origin_type_value (origin_type_value_id);

	
ALTER TABLE crop_species_plot 
	ADD CONSTRAINT fk_crop_species_plot__crop_species FOREIGN KEY (crop_species_id) 
			REFERENCES crop_species (crop_species_id);

ALTER TABLE crop_species_plot 
	ADD CONSTRAINT fk_crop_species_plot__plot FOREIGN KEY (plot_id) 
			REFERENCES plot (plot_id);

ALTER TABLE crop_species_production_type
  ADD CONSTRAINT fk_crop_species_production_type__crop_species FOREIGN KEY (crop_species_id)
      REFERENCES crop_species (crop_species_id);

ALTER TABLE crop_species_production_type
  ADD CONSTRAINT fk_crop_species_production_type__production_type FOREIGN KEY (production_type_id)
      REFERENCES production_type (production_type_id);

ALTER TABLE crop_species
  ADD CONSTRAINT fk_crop_species__crop_type FOREIGN KEY (crop_type_id)
      REFERENCES crop_type (crop_type_id);

ALTER TABLE crop_type_name
  ADD CONSTRAINT fk_crop_type_name__crop_type FOREIGN KEY (crop_type_id)
      REFERENCES crop_type (crop_type_id);


-- ALTER TABLE production_property
--  ADD CONSTRAINT fk_production_property__productin FOREIGN KEY (production_id)
--      REFERENCES production (production_id);



ALTER TABLE alert_plot
  ADD CONSTRAINT fk_alert_plot__alert FOREIGN KEY (alert_id)
      REFERENCES alert (alert_id);

ALTER TABLE alert_plot
  ADD CONSTRAINT fk_alert_plot__plot FOREIGN KEY (plot_id)
      REFERENCES plot(plot_id);

ALTER TABLE alert_crop_species
  ADD CONSTRAINT fk_alert_crop_species__crop_species FOREIGN KEY (crop_species_id)
      REFERENCES crop_species(crop_species_id);

ALTER TABLE alert_crop_species
  ADD CONSTRAINT fk_alert_crop_species__alert FOREIGN KEY (alert_id)
      REFERENCES alert(alert_id);

ALTER TABLE management_zone  
	ADD CONSTRAINT fk_management_zone__plot FOREIGN KEY (plot_id)
      REFERENCES plot(plot_id);

ALTER TABLE	management_zone_soil_property  
	ADD CONSTRAINT fk_management_zone_soil_property__management_zone FOREIGN KEY (management_zone_id)
      REFERENCES management_zone(management_zone_id);

ALTER TABLE alert_management_zone
  ADD CONSTRAINT fk_alert_management_zones__management_zone FOREIGN KEY (management_zone_id)
      REFERENCES management_zone(management_zone_id);

ALTER TABLE alert_management_zone
  ADD CONSTRAINT fk_alert_management_zone__alert FOREIGN KEY (alert_id)
      REFERENCES alert(alert_id);

ALTER TABLE intervention
  ADD CONSTRAINT fk_intervention_treatement__plot FOREIGN KEY (plot_id)
      REFERENCES plot (plot_id);
      
ALTER TABLE product_code
  ADD CONSTRAINt fk_product_code__product FOREIGN KEY (product_id)
      REFERENCES product (product_id);

ALTER TABLE product_name
  ADD CONSTRAINt fk_product_name__product FOREIGN KEY (product_id)
      REFERENCES product (product_id);

ALTER TABLE product_sub_type
  ADD CONSTRAINt fk_product_sub_type__product FOREIGN KEY (product_id)
      REFERENCES product (product_id);

ALTER TABLE product_register_url
  ADD CONSTRAINt fk_product_register_url__product FOREIGN KEY (product_id)
      REFERENCES product (product_id);

ALTER TABLE product_registration_code
  ADD CONSTRAINt fk_product_registration_code__product FOREIGN KEY (product_id)
      REFERENCES product (product_id);

ALTER TABLE product_treatment
  ADD CONSTRAINt fk_product_treatment__treatment FOREIGN KEY (treatment_id)
      REFERENCES treatment (treatment_id); 

ALTER TABLE product_treatment
  ADD CONSTRAINt fk_product_intervention_treatement__product FOREIGN KEY (product_id)
      REFERENCES product (product_id); 

 ALTER TABLE treatment_plan_campaign
  ADD CONSTRAINt fk_treatment_plan_campaignn__treatment_plan FOREIGN KEY (treatment_plan_id)
      REFERENCES treatment_plan (treatment_plan_id);

  ALTER TABLE treatment_plan_campaign
  ADD CONSTRAINt fk_treatment_plan_campaignn__campaign_type FOREIGN KEY (campaign_type_id)
      REFERENCES campaign_type (campaign_type_id);

 ALTER TABLE product_treatment_plan
  ADD CONSTRAINt fk_product_treatment_plan__product FOREIGN KEY (product_id)
      REFERENCES product (product_id); 

  ALTER TABLE product_treatment_plan
  ADD CONSTRAINt fk_product_treatment_plan__treatment_plan FOREIGN KEY (treatment_plan_id)
      REFERENCES treatment_plan (treatment_plan_id); 

 ALTER TABLE treatment
  ADD CONSTRAINt fk_treatment__treatment_plan FOREIGN KEY (treatment_plan_id)
      REFERENCES treatment_plan (treatment_plan_id); 

 ALTER TABLE product_preparation
  ADD CONSTRAINt fk_product_preparation__treatment_plan FOREIGN KEY (treatment_plan_id)
      REFERENCES treatment_plan (treatment_plan_id); 

 ALTER TABLE product_preparation
  ADD CONSTRAINt fk_product_preparation__product FOREIGN KEY (product_id)
      REFERENCES product (product_id); 


 ALTER TABLE soil_nutrients
  ADD CONSTRAINt fk_soil_nutrients__management_zone FOREIGN KEY (management_zone_id)
      REFERENCES management_zone (management_zone_id);
      
 ALTER TABLE product_nutrients
  ADD CONSTRAINt fk_product_nutrients__product FOREIGN KEY (product_id)
      REFERENCES product (product_id);

ALTER TABLE treatment  
	ADD CONSTRAINT fk_treatment__form_of_treatment_value FOREIGN KEY (form_of_treatment_value_id)
      REFERENCES form_of_treatment_value(form_of_treatment_value_id);

ALTER TABLE treatment_purpose  
	ADD CONSTRAINT fk_treatment_purpose__treatment_purpose_value FOREIGN KEY (treatment_purpose_value_id)
      REFERENCES treatment_purpose_value(treatment_purpose_value_id);

ALTER TABLE treatment_purpose  
	ADD CONSTRAINT fk_treatment_purpose__treatment FOREIGN KEY (treatment_id)
      REFERENCES treatment(treatment_id);

ALTER TABLE product  
	ADD CONSTRAINT fk_product__product_kind_value FOREIGN KEY (product_kind_value_id)
      REFERENCES product_kind_value(product_kind_value_id);

ALTER TABLE management_zone_soil_property  
	ADD CONSTRAINT fk_management_zone_soil_property__property_type_value FOREIGN KEY (property_type_id)
      REFERENCES property_type(property_type_id);

ALTER TABLE property_type  
	ADD CONSTRAINT fk_property_type__property_type_value FOREIGN KEY (property_type_value_id)
      REFERENCES property_type_value(property_type_value_id);

ALTER TABLE cl_responsible_party  
	ADD CONSTRAINT fk_cl_responsible_party__cl_role_code FOREIGN KEY (cl_responsible_party_role_id)
      REFERENCES cl_role_code(cl_role_code_id);
	
ALTER TABLE cl_responsible_party  
	ADD CONSTRAINT fk_cl_responsible_party__cl_contact FOREIGN KEY (cl_contact_id)
      REFERENCES cl_contact(cl_contact_id);

ALTER TABLE cl_contact  
	ADD CONSTRAINT fk_cl_contact__cl_online_resource FOREIGN KEY (cl_online_resource_id)
      REFERENCES cl_online_resource(cl_online_resource_id);

ALTER TABLE cl_contact  
	ADD CONSTRAINT fk_cl_contact__cl_address FOREIGN KEY (cl_address_id)
      REFERENCES cl_address(cl_address_id);

ALTER TABLE cl_contact  
	ADD CONSTRAINT fk_cl_contact__cl_telephone FOREIGN KEY (cl_phone_id)
      REFERENCES cl_telephone(cl_telephone_id);

ALTER TABLE cl_online_resource  
	ADD CONSTRAINT fk_cl_online_resource__cl_online_function_code FOREIGN KEY (cl_online_function_code_id)
      REFERENCES cl_online_function_code(cl_online_function_code_id);

ALTER TABLE intervention_supervisor  
	ADD CONSTRAINT fk_intervention_supervisor__cl_responsible_party FOREIGN KEY (cl_responsible_party_id)
      REFERENCES cl_responsible_party(cl_responsible_party_id);

ALTER TABLE intervention_supervisor  
	ADD CONSTRAINT fk_intervention_supervisor__intervention FOREIGN KEY (intervention_id)
      REFERENCES intervention(intervention_id);

ALTER TABLE intervention_evidence_party  
	ADD CONSTRAINT fk_intervention_evidence_party__cl_responsible_party FOREIGN KEY (cl_responsible_party_id)
      REFERENCES cl_responsible_party(cl_responsible_party_id);

ALTER TABLE intervention_evidence_party  
	ADD CONSTRAINT fk_intervention_evidence_party__intervention FOREIGN KEY (intervention_id)
      REFERENCES intervention(intervention_id);

ALTER TABLE intervention_operator  
	ADD CONSTRAINT fk_intervention_operator__cl_responsible_party FOREIGN KEY (cl_responsible_party_id)
      REFERENCES cl_responsible_party(cl_responsible_party_id);

ALTER TABLE intervention_operator 
	ADD CONSTRAINT fk_intervention_operator__intervention FOREIGN KEY (intervention_id)
      REFERENCES intervention(intervention_id);

ALTER TABLE product_manufacturer  
	ADD CONSTRAINT fk_product_manufacturer__product FOREIGN KEY (product_id)
      REFERENCES product(product_id);

ALTER TABLE product_manufacturer  
	ADD CONSTRAINT fk_product_manufacturer__cl_responsible_party FOREIGN KEY (cl_responsible_party_id)
      REFERENCES cl_responsible_party(cl_responsible_party_id);

ALTER TABLE delivery_point  
	ADD CONSTRAINT fk_delivery_point__cl_address FOREIGN KEY (cl_address_id)
      REFERENCES cl_address(cl_address_id);

 
ALTER TABLE electronic_mail_address  
	ADD CONSTRAINT fk_electronic_mail_address__cl_address FOREIGN KEY (cl_address_id)
      REFERENCES cl_address(cl_address_id);

ALTER TABLE facsimile  
	ADD CONSTRAINT fk_facsimile__cl_telephone FOREIGN KEY (cl_telephone_id)
      REFERENCES cl_telephone(cl_telephone_id);

ALTER TABLE voice  
	ADD CONSTRAINT fk_voice__cl_telephone FOREIGN KEY (cl_telephone_id)
      REFERENCES cl_telephone(cl_telephone_id);

ALTER TABLE holding_thematic_id  
	ADD CONSTRAINT fk_holding_thematic_id__holding FOREIGN KEY (holding_id)
      REFERENCES holding(holding_id);

ALTER TABLE alert_type  
	ADD CONSTRAINT fk_alert_type__alert FOREIGN KEY (alert_id)
      REFERENCES alert(alert_id);

ALTER TABLE holding_function 
	ADD CONSTRAINT fk_holding_function__holding FOREIGN KEY (holding_id)
      REFERENCES holding(holding_id);

ALTER TABLE active_ingredients  
	ADD CONSTRAINT fk_active_ingredients__product FOREIGN KEY (product_id)
      REFERENCES product(product_id);

ALTER TABLE production_type_production_property
	ADD CONSTRAINT fk_production_type_property_type__production_type FOREIGN KEY (production_type_id)
      REFERENCES production_type(production_type_id);

ALTER TABLE production_type_production_property
	ADD CONSTRAINT fk_production_type_property_type__property_type FOREIGN KEY (property_type_id)
      REFERENCES property_type(property_type_id);

ALTER TABLE intervention_management_zone
	ADD CONSTRAINT intervention_management_zone__intervention FOREIGN KEY (intervention_id)
      REFERENCES intervention(intervention_id);

 ALTER TABLE intervention_management_zone
	ADD CONSTRAINT intervention_management_zone__management_zone FOREIGN KEY (management_zone_id)
      REFERENCES management_zone(management_zone_id);

 ALTER TABLE user_check_type
	ADD CONSTRAINT user_check_type__alert FOREIGN KEY (alert_id)
      REFERENCES alert(alert_id);

ALTER TABLE user_check_type
	ADD CONSTRAINT checked_by_user__cl_responsible_party FOREIGN KEY (cl_responsible_party_id)
      REFERENCES cl_responsible_party(cl_responsible_party_id);
      
ALTER TABLE treatment_plan
	ADD CONSTRAINT treatment_plan__treatment_plan_type_value FOREIGN KEY (treatment_plan_type_value_id)
      REFERENCES treatment_plan_type_value(treatment_plan_type_value_id);

ALTER TABLE treatment
	ADD CONSTRAINT treatment__intervention FOREIGN KEY (intervention_id)
      REFERENCES intervention(intervention_id);

ALTER TABLE intervention
	ADD CONSTRAINT intervention__intervention_type_value FOREIGN KEY (intervention_type_value_id)
      REFERENCES intervention_type_value(intervention_type_value_id);

ALTER TABLE intervention_tractor
	ADD CONSTRAINT intervention_tractor__tractor_type FOREIGN KEY (tractor_type_id)
      REFERENCES tractor_type(tractor_type_id);

ALTER TABLE intervention_tractor
	ADD CONSTRAINT intervention_tractor__intervention FOREIGN KEY (intervention_id)
      REFERENCES intervention(intervention_id);

ALTER TABLE holding_tractor
	ADD CONSTRAINT holding_tractor__tractor_type FOREIGN KEY (tractor_type_id)
      REFERENCES tractor_type(tractor_type_id);

ALTER TABLE holding_tractor
	ADD CONSTRAINT holding_tractor__holding FOREIGN KEY (holding_id)
      REFERENCES holding(holding_id);

ALTER TABLE intervention_machine
	ADD CONSTRAINT intervention_machine__machine_type FOREIGN KEY (machine_type_id)
      REFERENCES machine_type(machine_type_id);

ALTER TABLE intervention_machine
	ADD CONSTRAINT intervention_machine__intervention FOREIGN KEY (intervention_id)
      REFERENCES intervention(intervention_id);

ALTER TABLE holding_machine
	ADD CONSTRAINT holding_machine__machine_type FOREIGN KEY (machine_type_id)
      REFERENCES machine_type(machine_type_id);

ALTER TABLE holding_machine
	ADD CONSTRAINT holding_machine__holding FOREIGN KEY (holding_id)
      REFERENCES holding(holding_id);

 ALTER TABLE site_includes_animal
	ADD CONSTRAINT site_includes_animal__site FOREIGN KEY (site_id)
      REFERENCES site(site_id);

 ALTER TABLE site_includes_animal
	ADD CONSTRAINT site_includes_animal__farm_animal_species FOREIGN KEY (farm_animal_species_id)
      REFERENCES farm_animal_species(farm_animal_species_id);

  ALTER TABLE farm_animal_species_livestock
	ADD CONSTRAINT farm_animal_species_livestock__farm_animal_species FOREIGN KEY (farm_animal_species_id)
      REFERENCES farm_animal_species(farm_animal_species_id);

  ALTER TABLE farm_animal_species_livestock
	ADD CONSTRAINT farm_animal_species_livestock__livestock_species_value FOREIGN KEY (livestock_species_value_id)
      REFERENCES livestock_species_value(livestock_species_value_id);

 ALTER TABLE farm_animal_species_aquaculture
	ADD CONSTRAINT farm_animal_species_aquaculture__farm_animal_species FOREIGN KEY (farm_animal_species_id)
      REFERENCES farm_animal_species(farm_animal_species_id);

  ALTER TABLE farm_animal_species_aquaculture
	ADD CONSTRAINT farm_animal_species_aquaculture__aquaculture_species_value FOREIGN KEY (aquaculture_species_value_id)
      REFERENCES aquaculture_species_value(aquaculture_species_value_id);
   