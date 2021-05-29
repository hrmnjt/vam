CREATE
OR REPLACE VIEW public.user_ddl AS (
	-- create roles
	SELECT
		0 as grant_order,
		name principal_name,
		'CREATE ROLE "' || name || '"' || ';' AS sql,
		'NONE' as object_type,
		'NONE' as object_name
	FROM
		roles
)
UNION
ALL (
	-- create users based on
		-- account lock
		-- grace period
		-- idle session timeout
		-- max connection
		-- memory cap
		-- profile
		-- resource pool
		-- run time cap
		-- search path
		-- temp space cap
	SELECT
		1 AS step,
		user_name,
		'CREATE USER "' || user_name || '"' || DECODE(is_locked, TRUE, ' ACCOUNT LOCK', '')
		|| DECODE(
			grace_period,
			'undefined',
			'',
			' GRACEPERIOD  ''' || grace_period || ''''
		) || DECODE(
			idle_session_timeout,
			'unlimited',
			'',
			' IDLESESSIONTIMEOUT ''' || idle_session_timeout || ''''
		) || DECODE(
			max_connections,
			'unlimited',
			'',
			' MAXCONNECTIONS ' || max_connections || ' ON ' || connection_limit_mode
		) || DECODE(
			memory_cap_kb,
			'unlimited',
			'',
			' MEMORYCAP ''' || memory_cap_kb || 'K'''
		) || DECODE(
			profile_name,
			'default',
			'',
			' PROFILE ' || profile_name
		) || DECODE(
			resource_pool,
			'general',
			'',
			' RESOURCE POOL ' || resource_pool
		) || DECODE(
			run_time_cap,
			'unlimited',
			'',
			' RUNTIMECAP ''' || run_time_cap || ''''
		) || DECODE(
			search_path,
			'',
			'',
			' SEARCH_PATH ' || search_path
		) || DECODE(
			temp_space_cap_kb,
			'unlimited',
			'',
			' TEMPSPACECAP ''' || temp_space_cap_kb || 'K'''
		) || ';' AS sql,
		'NONE' as object_type,
		'NONE' as object_name
	FROM
		users
)
UNION
ALL (
	-- grant access toss
		-- resource pool
		-- storage location
		-- client authentication
		-- database
		-- library
		-- procedures
			-- procedure type
			-- procedure_argument_types
		-- role
		-- table
		-- view
	SELECT
		2,
		grantee,
		'GRANT ' || REPLACE(
			TRIM(
				BOTH ' '
				FROM
					words
			),
			'*',
			''
		) || CASE
			WHEN object_type = 'RESOURCEPOOL' THEN ' ON RESOURCE POOL '
			WHEN object_type = 'STORAGELOCATION' THEN ' ON STORAGE LOCATION '
			WHEN object_type = 'CLIENTAUTHENTICATION' THEN 'AUTHENTICATION '
			WHEN object_type IN (
				'DATABASE',
				'LIBRARY',
				'MODEL',
				'SEQUENCE',
				'SCHEMA'
			) THEN ' ON ' || object_type || ' '
			WHEN object_type = 'PROCEDURE' THEN (
				SELECT
					' ON ' || CASE
						REPLACE(procedure_type, 'User Defined ', '')
						WHEN 'Transform' THEN 'TRANSFORM FUNCTION '
						WHEN 'Aggregate' THEN 'AGGREGATE FUNCTION '
						WHEN 'Analytic' THEN 'ANALYTIC FUNCTION '
						ELSE UPPER(REPLACE(procedure_type, 'User Defined ', '')) || ' '
					END
				FROM
					vs_procedures
				WHERE
					proc_oid = object_id
			)
			WHEN object_type = 'ROLE' THEN ''
			ELSE ' ON '
		END || NVL2(object_schema, object_schema || '.', '') || object_name || CASE
			WHEN object_type = 'PROCEDURE' THEN (
				SELECT
					DECODE(
						procedure_argument_types,
						'',
						'()',
						'(' || procedure_argument_types || ')'
					)
				FROM
					vs_procedures
				WHERE
					proc_oid = object_id
			)
			ELSE ''
		END || ' TO ' || grantee || CASE
			WHEN INSTR(words, '*') > 0 THEN ' WITH GRANT OPTION'
			ELSE ''
		END || ';',
		object_type,
		object_name
	FROM
		(
			SELECT
				grantee,
				object_type,
				object_schema,
				object_name,
				object_id,
				v_txtindex.StringTokenizerDelim(
					DECODE(
						privileges_description,
						'',
						',',
						privileges_description
					),
					','
				) OVER (
					PARTITION BY grantee,
					object_type,
					object_schema,
					object_name,
					object_id
				)
			FROM
				grants
		) foo
	ORDER BY
		CASE
			REPLACE(
				TRIM(
					BOTH ' '
					FROM
						words
				),
				'*',
				''
			)
			WHEN 'USAGE' THEN 1
			ELSE 2
		END
)
UNION
ALL (
	-- grant default roles
	SELECT
		3,
		-- Default ROLEs
		user_name,
		'ALTER USER "' || user_name || '"' || DECODE(
			default_roles,
			'',
			'',
			' DEFAULT ROLE ' || REPLACE(default_roles, '*', '')
		) || ';',
		'NONE' as object_type,
		'NONE' as object_name
	FROM
		users
	WHERE
		default_roles <> ''
)
UNION
ALL
(
	-- grant admin options options
	SELECT
		4,
		user_name,
		'GRANT ' || REPLACE(
			TRIM(
				BOTH ' '
				FROM
					words
			),
			'*',
			''
		) || ' TO ' || user_name || ' WITH ADMIN OPTION;',
		'NONE' as object_type,
		'NONE' as object_name
	FROM
		(
			SELECT
				user_name,
				v_txtindex.StringTokenizerDelim(DECODE(all_roles, '', ',', all_roles), ',') OVER (PARTITION BY user_name)
			FROM
				users
			WHERE
				all_roles <> ''
		) foo
	WHERE
		INSTR(words, '*') > 0
)
UNION
ALL (
	-- grant schema priveleges
	select
		5,
		'public',
		'ALTER SCHEMA ' || name || ' DEFAULT ' || CASE
			WHEN defaultinheritprivileges THEN ' INCLUDE  PRIVILEGES'
			ELSE ' EXCLUDE  PRIVILEGES ;'
		END,
		'SCHEMA',
		name
	from
		vs_schemata
)
UNION
ALL (
	-- grant inherit priveleges for database
	select
		6,
		'public',
		'ALTER DATABASE  ' || database_name || ' SET disableinheritedprivileges = ' || current_value || ';',
		'DATABASE',
		database_name
	from
		vs_configuration_parameters
		cross join databases
	where
		parameter_name ilike 'DisableInheritedPrivileges'
)
UNION
ALL
(
	-- table priveleges inheritence
	SELECT
		7,
		'public',
		'ALTER TABLE ' || table_schema || '.' || table_name || CASE
			WHEN inheritprivileges THEN ' INCLUDE  PRIVILEGES ;'
			ELSE ' EXCLUDE  PRIVILEGES ;'
		END,
		'TABLE' as object_type,
		table_schema || '.' || table_name as object_name
	from
		v_internal.vs_tables
		join v_catalog.tables on (table_id = oid)
)
UNION
ALL
(
	-- view priveleges inheritence
	SELECT
		8,
		'public',
		'ALTER VIEW ' || table_schema || '.' || table_name || CASE
			WHEN inherit_privileges THEN ' INCLUDE  PRIVILEGES ;'
			ELSE ' EXCLUDE  PRIVILEGES ; '
		END,
		'TABLE' as object_type,
		table_schema || '.' || table_name as object_name
	from
		v_catalog.views
)
UNION
ALL (
	-- change owner for tables
	select
		9,
		owner_name,
		'ALTER TABLE ' || table_schema || '.' || table_name || ' OWNER TO ' || owner_name || ';',
		'TABLE',
		table_schema || '.' || table_name
	from
		v_catalog.tables
)
UNION
ALL (
	-- change owner for views
	select
		10,
		owner_name,
		'ALTER VIEW ' || table_schema || '.' || table_name || ' OWNER TO ' || owner_name || ';',
		'TABLE',
		table_schema || '.' || table_name
	from
		v_catalog.views
);
