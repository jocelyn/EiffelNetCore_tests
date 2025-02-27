note
	description: "Project root class"
	assembly_metadata: create {TARGET_FRAMEWORK_ATTRIBUTE}.make(".NETCoreApp,Version=v7.0") end,
	                   create {APPLICATION_PART_ATTRIBUTE}.make("Microsoft.AspNetCore.OpenApi")end

class
	APPLICATION

inherit
	SYSTEM_OBJECT
	ARGUMENTS

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		local
			l_controler: WEATHER_FORECAST_CONTROLLER
			builder: WEB_APPLICATION_BUILDER
			l_native: NATIVE_ARRAY [SYSTEM_STRING]
			--l_service: SWAGGER_GEN_SERVICE_COLLECTION_EXTENSIONS
			l_mvc_builder: IMVC_BUILDER
			l_service_collection: ISERVICE_COLLECTION
			l_app: WEB_APPLICATION
			l_swagger_ui: SWAGGER_UI_OPTIONS
			l_endpoint: ENDPOINT_ROUTE_BUILDER_EXTENSIONS
			l_services : ISERVICE_COLLECTION
			l_current: SYSTEM_OBJECT
			l_enumerator: IENUMERATOR
			l_stop: BOOLEAN
			l_web_options: WEB_APPLICATION_OPTIONS
		do
			{ENVIRONMENT}.set_environment_variable_string_string_environment_variable_target("ASPNETCORE_ENVIRONMENT", "Development", {ENVIRONMENT_VARIABLE_TARGET}.process )

--			builder := {WEB_APPLICATION}.create_builder_web_application_options({WEB_APPLICATION_OPTIONS_FACTORY}.create_web_application_options("Development", "my_first_api"))

			builder := {WEB_APPLICATION}.create_builder()

			--{JSON_CONFIGURATION_EXTENSIONS}.add_json_file(builder.configuration, "appsettings.Development.json", True, True).do_nothing()

				-- Add services to the container
			l_services := builder.services

			--{HTTPS_REDIRECTION_SERVICES_EXTENSIONS}.add_https_redirection()

			{MVC_SERVICE_COLLECTION_EXTENSIONS}.add_controllers (l_services).do_nothing()
					-- Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
			{ENDPOINT_METADATA_API_EXPLORER_SERVICE_COLLECTION_EXTENSIONS}.add_endpoints_api_explorer (l_services).do_nothing
			--{SWAGGER_GEN_SERVICE_COLLECTION_EXTENSIONS}.add_swagger_gen(l_services).do_nothing
				-- Adding swagger raise a null pointer exceptions	

			l_app := builder.build

				-- Configure the HTTP request pipeline.
			if attached {HOSTING_ENVIRONMENT} l_app.environment as l_environment and then {HOST_ENVIRONMENT_ENV_EXTENSIONS}.is_development(l_environment) then
				print("%NDeveloping Mode%N")
				--{SWAGGER_BUILDER_EXTENSIONS}.use_swagger (l_app, Void).do_nothing()
				--{SWAGGER_UI_BUILDER_EXTENSIONS}.use_swagger_ui (l_app, Void).do_nothing()

			end

			{HTTPS_POLICY_BUILDER_EXTENSIONS}.use_https_redirection (l_app).do_nothing()

			{AUTHORIZATION_APP_BUILDER_EXTENSIONS}.use_authorization (l_app).do_nothing()

			{CONTROLLER_ENDPOINT_ROUTE_BUILDER_EXTENSIONS}.map_controllers (l_app).do_nothing()

			l_app.run(Void)

		end



end
