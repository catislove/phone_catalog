--
-- PostgreSQL database dump
--

-- Dumped from database version 15.3
-- Dumped by pg_dump version 15.3

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: admin_event_entity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.admin_event_entity (
    id character varying(36) NOT NULL,
    admin_event_time bigint,
    realm_id character varying(255),
    operation_type character varying(255),
    auth_realm_id character varying(255),
    auth_client_id character varying(255),
    auth_user_id character varying(255),
    ip_address character varying(255),
    resource_path character varying(2550),
    representation text,
    error character varying(255),
    resource_type character varying(64)
);


ALTER TABLE public.admin_event_entity OWNER TO postgres;

--
-- Name: associated_policy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.associated_policy (
    policy_id character varying(36) NOT NULL,
    associated_policy_id character varying(36) NOT NULL
);


ALTER TABLE public.associated_policy OWNER TO postgres;

--
-- Name: authentication_execution; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authentication_execution (
    id character varying(36) NOT NULL,
    alias character varying(255),
    authenticator character varying(36),
    realm_id character varying(36),
    flow_id character varying(36),
    requirement integer,
    priority integer,
    authenticator_flow boolean DEFAULT false NOT NULL,
    auth_flow_id character varying(36),
    auth_config character varying(36)
);


ALTER TABLE public.authentication_execution OWNER TO postgres;

--
-- Name: authentication_flow; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authentication_flow (
    id character varying(36) NOT NULL,
    alias character varying(255),
    description character varying(255),
    realm_id character varying(36),
    provider_id character varying(36) DEFAULT 'basic-flow'::character varying NOT NULL,
    top_level boolean DEFAULT false NOT NULL,
    built_in boolean DEFAULT false NOT NULL
);


ALTER TABLE public.authentication_flow OWNER TO postgres;

--
-- Name: authenticator_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authenticator_config (
    id character varying(36) NOT NULL,
    alias character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.authenticator_config OWNER TO postgres;

--
-- Name: authenticator_config_entry; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authenticator_config_entry (
    authenticator_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.authenticator_config_entry OWNER TO postgres;

--
-- Name: broker_link; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.broker_link (
    identity_provider character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL,
    broker_user_id character varying(255),
    broker_username character varying(255),
    token text,
    user_id character varying(255) NOT NULL
);


ALTER TABLE public.broker_link OWNER TO postgres;

--
-- Name: client; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client (
    id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    full_scope_allowed boolean DEFAULT false NOT NULL,
    client_id character varying(255),
    not_before integer,
    public_client boolean DEFAULT false NOT NULL,
    secret character varying(255),
    base_url character varying(255),
    bearer_only boolean DEFAULT false NOT NULL,
    management_url character varying(255),
    surrogate_auth_required boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    protocol character varying(255),
    node_rereg_timeout integer DEFAULT 0,
    frontchannel_logout boolean DEFAULT false NOT NULL,
    consent_required boolean DEFAULT false NOT NULL,
    name character varying(255),
    service_accounts_enabled boolean DEFAULT false NOT NULL,
    client_authenticator_type character varying(255),
    root_url character varying(255),
    description character varying(255),
    registration_token character varying(255),
    standard_flow_enabled boolean DEFAULT true NOT NULL,
    implicit_flow_enabled boolean DEFAULT false NOT NULL,
    direct_access_grants_enabled boolean DEFAULT false NOT NULL,
    always_display_in_console boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client OWNER TO postgres;

--
-- Name: client_attributes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_attributes (
    client_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.client_attributes OWNER TO postgres;

--
-- Name: client_auth_flow_bindings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_auth_flow_bindings (
    client_id character varying(36) NOT NULL,
    flow_id character varying(36),
    binding_name character varying(255) NOT NULL
);


ALTER TABLE public.client_auth_flow_bindings OWNER TO postgres;

--
-- Name: client_initial_access; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_initial_access (
    id character varying(36) NOT NULL,
    realm_id character varying(36) NOT NULL,
    "timestamp" integer,
    expiration integer,
    count integer,
    remaining_count integer
);


ALTER TABLE public.client_initial_access OWNER TO postgres;

--
-- Name: client_node_registrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_node_registrations (
    client_id character varying(36) NOT NULL,
    value integer,
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_node_registrations OWNER TO postgres;

--
-- Name: client_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_scope (
    id character varying(36) NOT NULL,
    name character varying(255),
    realm_id character varying(36),
    description character varying(255),
    protocol character varying(255)
);


ALTER TABLE public.client_scope OWNER TO postgres;

--
-- Name: client_scope_attributes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_scope_attributes (
    scope_id character varying(36) NOT NULL,
    value character varying(2048),
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_scope_attributes OWNER TO postgres;

--
-- Name: client_scope_client; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_scope_client (
    client_id character varying(255) NOT NULL,
    scope_id character varying(255) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client_scope_client OWNER TO postgres;

--
-- Name: client_scope_role_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_scope_role_mapping (
    scope_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.client_scope_role_mapping OWNER TO postgres;

--
-- Name: client_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_session (
    id character varying(36) NOT NULL,
    client_id character varying(36),
    redirect_uri character varying(255),
    state character varying(255),
    "timestamp" integer,
    session_id character varying(36),
    auth_method character varying(255),
    realm_id character varying(255),
    auth_user_id character varying(36),
    current_action character varying(36)
);


ALTER TABLE public.client_session OWNER TO postgres;

--
-- Name: client_session_auth_status; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_session_auth_status (
    authenticator character varying(36) NOT NULL,
    status integer,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_auth_status OWNER TO postgres;

--
-- Name: client_session_note; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_session_note (
    name character varying(255) NOT NULL,
    value character varying(255),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_note OWNER TO postgres;

--
-- Name: client_session_prot_mapper; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_session_prot_mapper (
    protocol_mapper_id character varying(36) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_prot_mapper OWNER TO postgres;

--
-- Name: client_session_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_session_role (
    role_id character varying(255) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_role OWNER TO postgres;

--
-- Name: client_user_session_note; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_user_session_note (
    name character varying(255) NOT NULL,
    value character varying(2048),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_user_session_note OWNER TO postgres;

--
-- Name: component; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.component (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_id character varying(36),
    provider_id character varying(36),
    provider_type character varying(255),
    realm_id character varying(36),
    sub_type character varying(255)
);


ALTER TABLE public.component OWNER TO postgres;

--
-- Name: component_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.component_config (
    id character varying(36) NOT NULL,
    component_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(4000)
);


ALTER TABLE public.component_config OWNER TO postgres;

--
-- Name: composite_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.composite_role (
    composite character varying(36) NOT NULL,
    child_role character varying(36) NOT NULL
);


ALTER TABLE public.composite_role OWNER TO postgres;

--
-- Name: credential; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    user_id character varying(36),
    created_date bigint,
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.credential OWNER TO postgres;

--
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


ALTER TABLE public.databasechangelog OWNER TO postgres;

--
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE public.databasechangeloglock OWNER TO postgres;

--
-- Name: default_client_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.default_client_scope (
    realm_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.default_client_scope OWNER TO postgres;

--
-- Name: event_entity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.event_entity (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    details_json character varying(2550),
    error character varying(255),
    ip_address character varying(255),
    realm_id character varying(255),
    session_id character varying(255),
    event_time bigint,
    type character varying(255),
    user_id character varying(255)
);


ALTER TABLE public.event_entity OWNER TO postgres;

--
-- Name: fed_user_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_attribute (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    value character varying(2024)
);


ALTER TABLE public.fed_user_attribute OWNER TO postgres;

--
-- Name: fed_user_consent; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.fed_user_consent OWNER TO postgres;

--
-- Name: fed_user_consent_cl_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_consent_cl_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.fed_user_consent_cl_scope OWNER TO postgres;

--
-- Name: fed_user_credential; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    created_date bigint,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.fed_user_credential OWNER TO postgres;

--
-- Name: fed_user_group_membership; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_group_membership OWNER TO postgres;

--
-- Name: fed_user_required_action; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_required_action (
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_required_action OWNER TO postgres;

--
-- Name: fed_user_role_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_role_mapping (
    role_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_role_mapping OWNER TO postgres;

--
-- Name: federated_identity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.federated_identity (
    identity_provider character varying(255) NOT NULL,
    realm_id character varying(36),
    federated_user_id character varying(255),
    federated_username character varying(255),
    token text,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_identity OWNER TO postgres;

--
-- Name: federated_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.federated_user (
    id character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_user OWNER TO postgres;

--
-- Name: group_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.group_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_attribute OWNER TO postgres;

--
-- Name: group_role_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.group_role_mapping (
    role_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_role_mapping OWNER TO postgres;

--
-- Name: identity_provider; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.identity_provider (
    internal_id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    provider_alias character varying(255),
    provider_id character varying(255),
    store_token boolean DEFAULT false NOT NULL,
    authenticate_by_default boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    add_token_role boolean DEFAULT true NOT NULL,
    trust_email boolean DEFAULT false NOT NULL,
    first_broker_login_flow_id character varying(36),
    post_broker_login_flow_id character varying(36),
    provider_display_name character varying(255),
    link_only boolean DEFAULT false NOT NULL
);


ALTER TABLE public.identity_provider OWNER TO postgres;

--
-- Name: identity_provider_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.identity_provider_config (
    identity_provider_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.identity_provider_config OWNER TO postgres;

--
-- Name: identity_provider_mapper; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.identity_provider_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    idp_alias character varying(255) NOT NULL,
    idp_mapper_name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.identity_provider_mapper OWNER TO postgres;

--
-- Name: idp_mapper_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.idp_mapper_config (
    idp_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.idp_mapper_config OWNER TO postgres;

--
-- Name: keycloak_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.keycloak_group (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_group character varying(36) NOT NULL,
    realm_id character varying(36)
);


ALTER TABLE public.keycloak_group OWNER TO postgres;

--
-- Name: keycloak_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.keycloak_role (
    id character varying(36) NOT NULL,
    client_realm_constraint character varying(255),
    client_role boolean DEFAULT false NOT NULL,
    description character varying(255),
    name character varying(255),
    realm_id character varying(255),
    client character varying(36),
    realm character varying(36)
);


ALTER TABLE public.keycloak_role OWNER TO postgres;

--
-- Name: migration_model; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.migration_model (
    id character varying(36) NOT NULL,
    version character varying(36),
    update_time bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.migration_model OWNER TO postgres;

--
-- Name: offline_client_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.offline_client_session (
    user_session_id character varying(36) NOT NULL,
    client_id character varying(255) NOT NULL,
    offline_flag character varying(4) NOT NULL,
    "timestamp" integer,
    data text,
    client_storage_provider character varying(36) DEFAULT 'local'::character varying NOT NULL,
    external_client_id character varying(255) DEFAULT 'local'::character varying NOT NULL
);


ALTER TABLE public.offline_client_session OWNER TO postgres;

--
-- Name: offline_user_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.offline_user_session (
    user_session_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    created_on integer NOT NULL,
    offline_flag character varying(4) NOT NULL,
    data text,
    last_session_refresh integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.offline_user_session OWNER TO postgres;

--
-- Name: policy_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.policy_config (
    policy_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.policy_config OWNER TO postgres;

--
-- Name: protocol_mapper; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.protocol_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    protocol character varying(255) NOT NULL,
    protocol_mapper_name character varying(255) NOT NULL,
    client_id character varying(36),
    client_scope_id character varying(36)
);


ALTER TABLE public.protocol_mapper OWNER TO postgres;

--
-- Name: protocol_mapper_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.protocol_mapper_config (
    protocol_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.protocol_mapper_config OWNER TO postgres;

--
-- Name: realm; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm (
    id character varying(36) NOT NULL,
    access_code_lifespan integer,
    user_action_lifespan integer,
    access_token_lifespan integer,
    account_theme character varying(255),
    admin_theme character varying(255),
    email_theme character varying(255),
    enabled boolean DEFAULT false NOT NULL,
    events_enabled boolean DEFAULT false NOT NULL,
    events_expiration bigint,
    login_theme character varying(255),
    name character varying(255),
    not_before integer,
    password_policy character varying(2550),
    registration_allowed boolean DEFAULT false NOT NULL,
    remember_me boolean DEFAULT false NOT NULL,
    reset_password_allowed boolean DEFAULT false NOT NULL,
    social boolean DEFAULT false NOT NULL,
    ssl_required character varying(255),
    sso_idle_timeout integer,
    sso_max_lifespan integer,
    update_profile_on_soc_login boolean DEFAULT false NOT NULL,
    verify_email boolean DEFAULT false NOT NULL,
    master_admin_client character varying(36),
    login_lifespan integer,
    internationalization_enabled boolean DEFAULT false NOT NULL,
    default_locale character varying(255),
    reg_email_as_username boolean DEFAULT false NOT NULL,
    admin_events_enabled boolean DEFAULT false NOT NULL,
    admin_events_details_enabled boolean DEFAULT false NOT NULL,
    edit_username_allowed boolean DEFAULT false NOT NULL,
    otp_policy_counter integer DEFAULT 0,
    otp_policy_window integer DEFAULT 1,
    otp_policy_period integer DEFAULT 30,
    otp_policy_digits integer DEFAULT 6,
    otp_policy_alg character varying(36) DEFAULT 'HmacSHA1'::character varying,
    otp_policy_type character varying(36) DEFAULT 'totp'::character varying,
    browser_flow character varying(36),
    registration_flow character varying(36),
    direct_grant_flow character varying(36),
    reset_credentials_flow character varying(36),
    client_auth_flow character varying(36),
    offline_session_idle_timeout integer DEFAULT 0,
    revoke_refresh_token boolean DEFAULT false NOT NULL,
    access_token_life_implicit integer DEFAULT 0,
    login_with_email_allowed boolean DEFAULT true NOT NULL,
    duplicate_emails_allowed boolean DEFAULT false NOT NULL,
    docker_auth_flow character varying(36),
    refresh_token_max_reuse integer DEFAULT 0,
    allow_user_managed_access boolean DEFAULT false NOT NULL,
    sso_max_lifespan_remember_me integer DEFAULT 0 NOT NULL,
    sso_idle_timeout_remember_me integer DEFAULT 0 NOT NULL,
    default_role character varying(255)
);


ALTER TABLE public.realm OWNER TO postgres;

--
-- Name: realm_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_attribute (
    name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    value text
);


ALTER TABLE public.realm_attribute OWNER TO postgres;

--
-- Name: realm_default_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_default_groups (
    realm_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_default_groups OWNER TO postgres;

--
-- Name: realm_enabled_event_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_enabled_event_types (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_enabled_event_types OWNER TO postgres;

--
-- Name: realm_events_listeners; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_events_listeners (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_events_listeners OWNER TO postgres;

--
-- Name: realm_localizations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_localizations (
    realm_id character varying(255) NOT NULL,
    locale character varying(255) NOT NULL,
    texts text NOT NULL
);


ALTER TABLE public.realm_localizations OWNER TO postgres;

--
-- Name: realm_required_credential; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_required_credential (
    type character varying(255) NOT NULL,
    form_label character varying(255),
    input boolean DEFAULT false NOT NULL,
    secret boolean DEFAULT false NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_required_credential OWNER TO postgres;

--
-- Name: realm_smtp_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_smtp_config (
    realm_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.realm_smtp_config OWNER TO postgres;

--
-- Name: realm_supported_locales; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_supported_locales (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_supported_locales OWNER TO postgres;

--
-- Name: redirect_uris; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.redirect_uris (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.redirect_uris OWNER TO postgres;

--
-- Name: required_action_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.required_action_config (
    required_action_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.required_action_config OWNER TO postgres;

--
-- Name: required_action_provider; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.required_action_provider (
    id character varying(36) NOT NULL,
    alias character varying(255),
    name character varying(255),
    realm_id character varying(36),
    enabled boolean DEFAULT false NOT NULL,
    default_action boolean DEFAULT false NOT NULL,
    provider_id character varying(255),
    priority integer
);


ALTER TABLE public.required_action_provider OWNER TO postgres;

--
-- Name: resource_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    resource_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_attribute OWNER TO postgres;

--
-- Name: resource_policy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_policy (
    resource_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_policy OWNER TO postgres;

--
-- Name: resource_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_scope (
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_scope OWNER TO postgres;

--
-- Name: resource_server; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server (
    id character varying(36) NOT NULL,
    allow_rs_remote_mgmt boolean DEFAULT false NOT NULL,
    policy_enforce_mode smallint NOT NULL,
    decision_strategy smallint DEFAULT 1 NOT NULL
);


ALTER TABLE public.resource_server OWNER TO postgres;

--
-- Name: resource_server_perm_ticket; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server_perm_ticket (
    id character varying(36) NOT NULL,
    owner character varying(255) NOT NULL,
    requester character varying(255) NOT NULL,
    created_timestamp bigint NOT NULL,
    granted_timestamp bigint,
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36),
    resource_server_id character varying(36) NOT NULL,
    policy_id character varying(36)
);


ALTER TABLE public.resource_server_perm_ticket OWNER TO postgres;

--
-- Name: resource_server_policy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server_policy (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    type character varying(255) NOT NULL,
    decision_strategy smallint,
    logic smallint,
    resource_server_id character varying(36) NOT NULL,
    owner character varying(255)
);


ALTER TABLE public.resource_server_policy OWNER TO postgres;

--
-- Name: resource_server_resource; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server_resource (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(255),
    icon_uri character varying(255),
    owner character varying(255) NOT NULL,
    resource_server_id character varying(36) NOT NULL,
    owner_managed_access boolean DEFAULT false NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_resource OWNER TO postgres;

--
-- Name: resource_server_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server_scope (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    icon_uri character varying(255),
    resource_server_id character varying(36) NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_scope OWNER TO postgres;

--
-- Name: resource_uris; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_uris (
    resource_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.resource_uris OWNER TO postgres;

--
-- Name: role_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.role_attribute (
    id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255)
);


ALTER TABLE public.role_attribute OWNER TO postgres;

--
-- Name: scope_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.scope_mapping (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_mapping OWNER TO postgres;

--
-- Name: scope_policy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.scope_policy (
    scope_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_policy OWNER TO postgres;

--
-- Name: user_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    user_id character varying(36) NOT NULL,
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL
);


ALTER TABLE public.user_attribute OWNER TO postgres;

--
-- Name: user_consent; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(36) NOT NULL,
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.user_consent OWNER TO postgres;

--
-- Name: user_consent_client_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_consent_client_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.user_consent_client_scope OWNER TO postgres;

--
-- Name: user_entity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_entity (
    id character varying(36) NOT NULL,
    email character varying(255),
    email_constraint character varying(255),
    email_verified boolean DEFAULT false NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    federation_link character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    realm_id character varying(255),
    username character varying(255),
    created_timestamp bigint,
    service_account_client_link character varying(255),
    not_before integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.user_entity OWNER TO postgres;

--
-- Name: user_federation_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_federation_config (
    user_federation_provider_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_config OWNER TO postgres;

--
-- Name: user_federation_mapper; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_federation_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    federation_provider_id character varying(36) NOT NULL,
    federation_mapper_type character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.user_federation_mapper OWNER TO postgres;

--
-- Name: user_federation_mapper_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_federation_mapper_config (
    user_federation_mapper_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_mapper_config OWNER TO postgres;

--
-- Name: user_federation_provider; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_federation_provider (
    id character varying(36) NOT NULL,
    changed_sync_period integer,
    display_name character varying(255),
    full_sync_period integer,
    last_sync integer,
    priority integer,
    provider_name character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.user_federation_provider OWNER TO postgres;

--
-- Name: user_group_membership; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_group_membership OWNER TO postgres;

--
-- Name: user_required_action; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_required_action (
    user_id character varying(36) NOT NULL,
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL
);


ALTER TABLE public.user_required_action OWNER TO postgres;

--
-- Name: user_role_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_role_mapping (
    role_id character varying(255) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_role_mapping OWNER TO postgres;

--
-- Name: user_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_session (
    id character varying(36) NOT NULL,
    auth_method character varying(255),
    ip_address character varying(255),
    last_session_refresh integer,
    login_username character varying(255),
    realm_id character varying(255),
    remember_me boolean DEFAULT false NOT NULL,
    started integer,
    user_id character varying(255),
    user_session_state integer,
    broker_session_id character varying(255),
    broker_user_id character varying(255)
);


ALTER TABLE public.user_session OWNER TO postgres;

--
-- Name: user_session_note; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_session_note (
    user_session character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(2048)
);


ALTER TABLE public.user_session_note OWNER TO postgres;

--
-- Name: username_login_failure; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.username_login_failure (
    realm_id character varying(36) NOT NULL,
    username character varying(255) NOT NULL,
    failed_login_not_before integer,
    last_failure bigint,
    last_ip_failure character varying(255),
    num_failures integer
);


ALTER TABLE public.username_login_failure OWNER TO postgres;

--
-- Name: web_origins; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.web_origins (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.web_origins OWNER TO postgres;

--
-- Data for Name: admin_event_entity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.admin_event_entity (id, admin_event_time, realm_id, operation_type, auth_realm_id, auth_client_id, auth_user_id, ip_address, resource_path, representation, error, resource_type) FROM stdin;
\.


--
-- Data for Name: associated_policy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.associated_policy (policy_id, associated_policy_id) FROM stdin;
8c6c1e91-cdb5-4149-848c-36b99cb96760	a75ced29-ac24-4a56-af44-26a4e38ca2de
\.


--
-- Data for Name: authentication_execution; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) FROM stdin;
a721bf49-6498-49d6-aee3-58521ad080cf	\N	auth-cookie	4cf78245-f05a-4020-a9da-201ab9860d6d	2805febd-6426-4628-95cf-769d482dd9f1	2	10	f	\N	\N
78ed7aa7-e40e-4bb2-90d1-62c738d9537b	\N	auth-spnego	4cf78245-f05a-4020-a9da-201ab9860d6d	2805febd-6426-4628-95cf-769d482dd9f1	3	20	f	\N	\N
2cd3a545-70e8-4c85-ba57-e47f668e35e3	\N	identity-provider-redirector	4cf78245-f05a-4020-a9da-201ab9860d6d	2805febd-6426-4628-95cf-769d482dd9f1	2	25	f	\N	\N
b4af67e6-446a-4b31-b2a9-f579446d3f17	\N	\N	4cf78245-f05a-4020-a9da-201ab9860d6d	2805febd-6426-4628-95cf-769d482dd9f1	2	30	t	1668c9a9-c37e-4378-ab68-be22329e3163	\N
96b0193e-39f8-4f6b-a52c-0d2f709d9562	\N	auth-username-password-form	4cf78245-f05a-4020-a9da-201ab9860d6d	1668c9a9-c37e-4378-ab68-be22329e3163	0	10	f	\N	\N
7755ef2b-36c0-4dca-8a51-81328f7b4916	\N	\N	4cf78245-f05a-4020-a9da-201ab9860d6d	1668c9a9-c37e-4378-ab68-be22329e3163	1	20	t	af7a0297-8dce-4ff3-af70-70313d188fb3	\N
7aa7cf8a-09c2-45cd-a496-66736c82f4ef	\N	conditional-user-configured	4cf78245-f05a-4020-a9da-201ab9860d6d	af7a0297-8dce-4ff3-af70-70313d188fb3	0	10	f	\N	\N
d1a573f1-9bb6-464b-b3ef-05e9b15fe540	\N	auth-otp-form	4cf78245-f05a-4020-a9da-201ab9860d6d	af7a0297-8dce-4ff3-af70-70313d188fb3	0	20	f	\N	\N
708e7260-bd58-4596-adef-7a5ecac3d6a8	\N	direct-grant-validate-username	4cf78245-f05a-4020-a9da-201ab9860d6d	1224a98d-7bf8-43f6-9c52-072b04ac9046	0	10	f	\N	\N
39ddace1-e33c-4a9e-bb27-e8bf3c8d4ca4	\N	direct-grant-validate-password	4cf78245-f05a-4020-a9da-201ab9860d6d	1224a98d-7bf8-43f6-9c52-072b04ac9046	0	20	f	\N	\N
2b4892b9-2299-47dc-97e3-e223ed1af87e	\N	\N	4cf78245-f05a-4020-a9da-201ab9860d6d	1224a98d-7bf8-43f6-9c52-072b04ac9046	1	30	t	fb944d9a-18cd-4e0c-a6d0-d00ba821d07f	\N
d5b13cbd-32ca-48cd-beed-c8cc74765e44	\N	conditional-user-configured	4cf78245-f05a-4020-a9da-201ab9860d6d	fb944d9a-18cd-4e0c-a6d0-d00ba821d07f	0	10	f	\N	\N
828ed926-b760-4f6c-b1a4-ee9b0956cbd3	\N	direct-grant-validate-otp	4cf78245-f05a-4020-a9da-201ab9860d6d	fb944d9a-18cd-4e0c-a6d0-d00ba821d07f	0	20	f	\N	\N
ba11e8c0-253d-416f-9c02-1cb187a2ef3a	\N	registration-page-form	4cf78245-f05a-4020-a9da-201ab9860d6d	bcc12e4f-be83-4cee-82db-487770e6b06b	0	10	t	0add4f94-bdb1-41ed-9d2e-4514c5bd9dc0	\N
66d77a21-3439-4ee1-87a8-0e0312f10d29	\N	registration-user-creation	4cf78245-f05a-4020-a9da-201ab9860d6d	0add4f94-bdb1-41ed-9d2e-4514c5bd9dc0	0	20	f	\N	\N
55b6fec3-52e8-4d12-afe6-9d17313697a5	\N	registration-profile-action	4cf78245-f05a-4020-a9da-201ab9860d6d	0add4f94-bdb1-41ed-9d2e-4514c5bd9dc0	0	40	f	\N	\N
26bf249b-984e-489c-a680-a10f79f10048	\N	registration-password-action	4cf78245-f05a-4020-a9da-201ab9860d6d	0add4f94-bdb1-41ed-9d2e-4514c5bd9dc0	0	50	f	\N	\N
518b23b4-5a5d-4ffe-9219-cbbb07ddab2d	\N	registration-recaptcha-action	4cf78245-f05a-4020-a9da-201ab9860d6d	0add4f94-bdb1-41ed-9d2e-4514c5bd9dc0	3	60	f	\N	\N
53a502c3-60da-4943-a2a1-3d2fc03d5020	\N	reset-credentials-choose-user	4cf78245-f05a-4020-a9da-201ab9860d6d	c80116c3-9fd4-46c0-943c-a2eb7accb5b2	0	10	f	\N	\N
4b03d4c6-9f6d-47fa-8b2c-4df765af16ef	\N	reset-credential-email	4cf78245-f05a-4020-a9da-201ab9860d6d	c80116c3-9fd4-46c0-943c-a2eb7accb5b2	0	20	f	\N	\N
03168be9-ee2b-462a-9ec6-b312f68a84c2	\N	reset-password	4cf78245-f05a-4020-a9da-201ab9860d6d	c80116c3-9fd4-46c0-943c-a2eb7accb5b2	0	30	f	\N	\N
4cd27ba8-1eb8-40a0-ae90-a06dfeb866ef	\N	\N	4cf78245-f05a-4020-a9da-201ab9860d6d	c80116c3-9fd4-46c0-943c-a2eb7accb5b2	1	40	t	258f787c-c622-4254-9e69-7bdadd4349ae	\N
9cac2cb7-f35a-4010-a053-3c084cdc40be	\N	conditional-user-configured	4cf78245-f05a-4020-a9da-201ab9860d6d	258f787c-c622-4254-9e69-7bdadd4349ae	0	10	f	\N	\N
458dd8f6-053d-40be-819d-c6836b831875	\N	reset-otp	4cf78245-f05a-4020-a9da-201ab9860d6d	258f787c-c622-4254-9e69-7bdadd4349ae	0	20	f	\N	\N
68f11613-5b58-40f5-8694-f79d5be2d58e	\N	client-secret	4cf78245-f05a-4020-a9da-201ab9860d6d	7bbd9be7-d8fa-48b0-bf81-67e900185b99	2	10	f	\N	\N
2409cf17-29c6-4958-a75b-395cf962192d	\N	client-jwt	4cf78245-f05a-4020-a9da-201ab9860d6d	7bbd9be7-d8fa-48b0-bf81-67e900185b99	2	20	f	\N	\N
03706249-34e6-4acb-a280-5bc5728ad0e7	\N	client-secret-jwt	4cf78245-f05a-4020-a9da-201ab9860d6d	7bbd9be7-d8fa-48b0-bf81-67e900185b99	2	30	f	\N	\N
85ae7702-bc74-43b4-bb23-5469886a65bd	\N	client-x509	4cf78245-f05a-4020-a9da-201ab9860d6d	7bbd9be7-d8fa-48b0-bf81-67e900185b99	2	40	f	\N	\N
e2387901-e7c4-491a-b383-bd97736bcc0c	\N	idp-review-profile	4cf78245-f05a-4020-a9da-201ab9860d6d	2452cf97-bb1e-4b1a-a509-d4586ee9b515	0	10	f	\N	466fd153-6fff-4d33-a439-44dd1b458e52
9d1c0b8a-3249-41c9-88f2-53c5bb98bec6	\N	\N	4cf78245-f05a-4020-a9da-201ab9860d6d	2452cf97-bb1e-4b1a-a509-d4586ee9b515	0	20	t	9217b93d-fde2-49ae-a8f0-7f0c895751a4	\N
c038cd9f-5e85-4f2f-adfc-95e66cc6f456	\N	idp-create-user-if-unique	4cf78245-f05a-4020-a9da-201ab9860d6d	9217b93d-fde2-49ae-a8f0-7f0c895751a4	2	10	f	\N	3bd47164-cb84-4722-8cd7-a17d46870efa
96e449ec-dbec-4b96-8079-4faecd2928bd	\N	\N	4cf78245-f05a-4020-a9da-201ab9860d6d	9217b93d-fde2-49ae-a8f0-7f0c895751a4	2	20	t	67a44727-e45b-4e5a-856a-064bf26acac0	\N
46d6c012-d094-4ee9-a49b-29593b5cd582	\N	idp-confirm-link	4cf78245-f05a-4020-a9da-201ab9860d6d	67a44727-e45b-4e5a-856a-064bf26acac0	0	10	f	\N	\N
73f5aa57-c696-40b8-a2d1-ae87b33a9b37	\N	\N	4cf78245-f05a-4020-a9da-201ab9860d6d	67a44727-e45b-4e5a-856a-064bf26acac0	0	20	t	d844aba0-06a2-4be1-b366-f36fcb2a322d	\N
4e4749c2-06e2-4fb2-a181-627c4d002f71	\N	idp-email-verification	4cf78245-f05a-4020-a9da-201ab9860d6d	d844aba0-06a2-4be1-b366-f36fcb2a322d	2	10	f	\N	\N
b9630bcc-94c0-4d0a-b521-0390dfe8a7e0	\N	\N	4cf78245-f05a-4020-a9da-201ab9860d6d	d844aba0-06a2-4be1-b366-f36fcb2a322d	2	20	t	94ee3f0d-6bbe-43fa-b0b0-27df41599311	\N
57dc2471-303b-45c1-b1e5-33013c33c9c5	\N	idp-username-password-form	4cf78245-f05a-4020-a9da-201ab9860d6d	94ee3f0d-6bbe-43fa-b0b0-27df41599311	0	10	f	\N	\N
5b84abb9-e2a9-43f5-ada2-5850e2ec3976	\N	\N	4cf78245-f05a-4020-a9da-201ab9860d6d	94ee3f0d-6bbe-43fa-b0b0-27df41599311	1	20	t	70cc16c6-d730-48d9-990d-ab15fafc17a8	\N
054a5b60-5be2-4258-93bb-f419ee587cb2	\N	conditional-user-configured	4cf78245-f05a-4020-a9da-201ab9860d6d	70cc16c6-d730-48d9-990d-ab15fafc17a8	0	10	f	\N	\N
a32ea54a-2a8b-4e0a-8703-20a8902174e0	\N	auth-otp-form	4cf78245-f05a-4020-a9da-201ab9860d6d	70cc16c6-d730-48d9-990d-ab15fafc17a8	0	20	f	\N	\N
99de4a91-f0aa-48f4-995b-c6cf4b596a26	\N	http-basic-authenticator	4cf78245-f05a-4020-a9da-201ab9860d6d	bda85b59-342f-4bed-9476-e178ce7cbe5c	0	10	f	\N	\N
83ea5bf3-e306-4aba-9e02-4a57c63bfeb8	\N	docker-http-basic-authenticator	4cf78245-f05a-4020-a9da-201ab9860d6d	73442a69-7046-418b-adc3-000086d1112c	0	10	f	\N	\N
59941eb6-9af8-466a-991a-c2c640b3794c	\N	auth-cookie	e480d6f0-0699-495a-9096-dec0cacb5180	e603fa14-cfef-4fba-808c-b89c80e07553	2	10	f	\N	\N
dcd0e7cc-5524-4118-ad30-869c9f0b639b	\N	auth-spnego	e480d6f0-0699-495a-9096-dec0cacb5180	e603fa14-cfef-4fba-808c-b89c80e07553	3	20	f	\N	\N
c61500e4-8e08-47c0-b4d7-3140d7660cbb	\N	identity-provider-redirector	e480d6f0-0699-495a-9096-dec0cacb5180	e603fa14-cfef-4fba-808c-b89c80e07553	2	25	f	\N	\N
11890591-4bff-464a-8379-d325f3c9855f	\N	\N	e480d6f0-0699-495a-9096-dec0cacb5180	e603fa14-cfef-4fba-808c-b89c80e07553	2	30	t	60a89bd1-56f3-4d05-8604-e9de16305285	\N
613b3e48-19ce-4d53-a524-77a4f7402407	\N	auth-username-password-form	e480d6f0-0699-495a-9096-dec0cacb5180	60a89bd1-56f3-4d05-8604-e9de16305285	0	10	f	\N	\N
44e7ec4a-60a7-4cc5-abd7-d534d6c7ea2c	\N	\N	e480d6f0-0699-495a-9096-dec0cacb5180	60a89bd1-56f3-4d05-8604-e9de16305285	1	20	t	30b356ff-5b1a-4c78-ade2-bb60be37642d	\N
a1e1b5d6-c92d-4c10-b4b0-42c2787ca2b9	\N	conditional-user-configured	e480d6f0-0699-495a-9096-dec0cacb5180	30b356ff-5b1a-4c78-ade2-bb60be37642d	0	10	f	\N	\N
8ea65280-273d-4005-8cf6-b7075d4feec8	\N	auth-otp-form	e480d6f0-0699-495a-9096-dec0cacb5180	30b356ff-5b1a-4c78-ade2-bb60be37642d	0	20	f	\N	\N
e957e3ac-3b6b-4d7e-9d80-6415c10dfaab	\N	direct-grant-validate-username	e480d6f0-0699-495a-9096-dec0cacb5180	d248b326-dda8-4faf-9fde-f11f7e904d4a	0	10	f	\N	\N
5024970d-c7f7-4af0-be04-c2493808ba7c	\N	direct-grant-validate-password	e480d6f0-0699-495a-9096-dec0cacb5180	d248b326-dda8-4faf-9fde-f11f7e904d4a	0	20	f	\N	\N
3275cc85-329a-4d62-83cf-60af1f944e39	\N	\N	e480d6f0-0699-495a-9096-dec0cacb5180	d248b326-dda8-4faf-9fde-f11f7e904d4a	1	30	t	cef621a3-a692-4792-89fe-862107279392	\N
fcbc0729-a924-4845-ae07-bdcee812b21a	\N	conditional-user-configured	e480d6f0-0699-495a-9096-dec0cacb5180	cef621a3-a692-4792-89fe-862107279392	0	10	f	\N	\N
9a186976-8706-4d41-a956-d2b067202190	\N	direct-grant-validate-otp	e480d6f0-0699-495a-9096-dec0cacb5180	cef621a3-a692-4792-89fe-862107279392	0	20	f	\N	\N
63887a59-baba-4d02-b91f-c4343aa5b975	\N	registration-page-form	e480d6f0-0699-495a-9096-dec0cacb5180	bd939d67-e10e-41f7-ab09-00d26c395961	0	10	t	f70e4d70-7902-4845-a40c-e4ebce194e26	\N
492dad18-fb12-4735-892f-34e53d50a95c	\N	registration-user-creation	e480d6f0-0699-495a-9096-dec0cacb5180	f70e4d70-7902-4845-a40c-e4ebce194e26	0	20	f	\N	\N
e2498b68-2fb7-4ca8-a12b-d49238a2b714	\N	registration-profile-action	e480d6f0-0699-495a-9096-dec0cacb5180	f70e4d70-7902-4845-a40c-e4ebce194e26	0	40	f	\N	\N
a4d0ae80-783c-4049-a738-097a23d25fbf	\N	registration-password-action	e480d6f0-0699-495a-9096-dec0cacb5180	f70e4d70-7902-4845-a40c-e4ebce194e26	0	50	f	\N	\N
164014d6-15c0-4304-a57c-81eb92da893e	\N	registration-recaptcha-action	e480d6f0-0699-495a-9096-dec0cacb5180	f70e4d70-7902-4845-a40c-e4ebce194e26	3	60	f	\N	\N
f80b2770-de99-4eb6-b1f7-79a85464190e	\N	reset-credentials-choose-user	e480d6f0-0699-495a-9096-dec0cacb5180	f5d7fee1-9dda-47b4-bf17-ff7b984a1e91	0	10	f	\N	\N
7736762e-a926-492e-b6fb-2290a825a40e	\N	reset-credential-email	e480d6f0-0699-495a-9096-dec0cacb5180	f5d7fee1-9dda-47b4-bf17-ff7b984a1e91	0	20	f	\N	\N
737b4261-ee3c-4bd6-b20e-d5d32bfb19e6	\N	reset-password	e480d6f0-0699-495a-9096-dec0cacb5180	f5d7fee1-9dda-47b4-bf17-ff7b984a1e91	0	30	f	\N	\N
9c0dd4a7-d933-40dc-a5aa-581e24310f88	\N	\N	e480d6f0-0699-495a-9096-dec0cacb5180	f5d7fee1-9dda-47b4-bf17-ff7b984a1e91	1	40	t	deaa52e2-f056-446e-b401-12e803d3b016	\N
47a974b6-3da5-488a-bb49-09189db4a038	\N	conditional-user-configured	e480d6f0-0699-495a-9096-dec0cacb5180	deaa52e2-f056-446e-b401-12e803d3b016	0	10	f	\N	\N
afa1d973-a3df-45a6-8aa6-09e10117449f	\N	reset-otp	e480d6f0-0699-495a-9096-dec0cacb5180	deaa52e2-f056-446e-b401-12e803d3b016	0	20	f	\N	\N
95a09e99-db42-42b9-a5f3-4d94cfedbb74	\N	client-secret	e480d6f0-0699-495a-9096-dec0cacb5180	945c7900-904d-4c9d-b480-bbd6db27f5a5	2	10	f	\N	\N
8c02f233-8dee-4d2e-84d6-82b84281d2b3	\N	client-jwt	e480d6f0-0699-495a-9096-dec0cacb5180	945c7900-904d-4c9d-b480-bbd6db27f5a5	2	20	f	\N	\N
62532391-14d7-40ee-a676-3fb9bbaf86c7	\N	client-secret-jwt	e480d6f0-0699-495a-9096-dec0cacb5180	945c7900-904d-4c9d-b480-bbd6db27f5a5	2	30	f	\N	\N
a2632087-e1f5-4221-8f1c-0fb8e35b5261	\N	client-x509	e480d6f0-0699-495a-9096-dec0cacb5180	945c7900-904d-4c9d-b480-bbd6db27f5a5	2	40	f	\N	\N
0bf9474c-8ddc-4955-bb2f-fc8838d768fa	\N	idp-review-profile	e480d6f0-0699-495a-9096-dec0cacb5180	b5882c83-509d-4926-8689-afaa07cd3372	0	10	f	\N	177667d4-94b6-4631-9cc8-e4a13a9bd314
1cd14201-7398-428b-9840-b853788abc33	\N	\N	e480d6f0-0699-495a-9096-dec0cacb5180	b5882c83-509d-4926-8689-afaa07cd3372	0	20	t	02243bdd-fca9-439d-bf9d-acda00dc2f36	\N
56c2d48b-7a82-40f7-9fe0-1bdfd64fec70	\N	idp-create-user-if-unique	e480d6f0-0699-495a-9096-dec0cacb5180	02243bdd-fca9-439d-bf9d-acda00dc2f36	2	10	f	\N	a0c2951b-affd-4e6b-80e5-e21b9ae0801c
d1d68640-9983-4a86-b49a-ff7faf606f70	\N	\N	e480d6f0-0699-495a-9096-dec0cacb5180	02243bdd-fca9-439d-bf9d-acda00dc2f36	2	20	t	b361f44f-8120-4a76-a9fe-a3e48d2334a1	\N
f15f771a-e9a8-464c-881d-4d6f6c266c05	\N	idp-confirm-link	e480d6f0-0699-495a-9096-dec0cacb5180	b361f44f-8120-4a76-a9fe-a3e48d2334a1	0	10	f	\N	\N
218a5d37-cc30-4690-838e-5b42af3ab075	\N	\N	e480d6f0-0699-495a-9096-dec0cacb5180	b361f44f-8120-4a76-a9fe-a3e48d2334a1	0	20	t	05150eb3-192d-4aab-ab79-f658b7d57d43	\N
95580b61-fa32-4e41-8e15-bb67e1f75a4b	\N	idp-email-verification	e480d6f0-0699-495a-9096-dec0cacb5180	05150eb3-192d-4aab-ab79-f658b7d57d43	2	10	f	\N	\N
f8e4e087-89a8-45d7-9413-28b7ceacd6b1	\N	\N	e480d6f0-0699-495a-9096-dec0cacb5180	05150eb3-192d-4aab-ab79-f658b7d57d43	2	20	t	52fd602f-6db4-4c85-9e3e-610c72eac8df	\N
65f79fb7-a2ea-4ab1-b9df-983cdf8e4e70	\N	idp-username-password-form	e480d6f0-0699-495a-9096-dec0cacb5180	52fd602f-6db4-4c85-9e3e-610c72eac8df	0	10	f	\N	\N
4b5a2674-3d64-4c9e-96fe-df082943939c	\N	\N	e480d6f0-0699-495a-9096-dec0cacb5180	52fd602f-6db4-4c85-9e3e-610c72eac8df	1	20	t	456ba7ce-1cec-40e7-9aa1-1dc7e5b04282	\N
dc279178-5a19-4611-9077-9975396cd43c	\N	conditional-user-configured	e480d6f0-0699-495a-9096-dec0cacb5180	456ba7ce-1cec-40e7-9aa1-1dc7e5b04282	0	10	f	\N	\N
ce5115b8-b8e2-408e-bbc0-bef7d5f00957	\N	auth-otp-form	e480d6f0-0699-495a-9096-dec0cacb5180	456ba7ce-1cec-40e7-9aa1-1dc7e5b04282	0	20	f	\N	\N
9a518bdb-325f-45d9-97c8-bad036a66fda	\N	http-basic-authenticator	e480d6f0-0699-495a-9096-dec0cacb5180	695f6b12-1268-4cf0-8542-d0bf14bb5716	0	10	f	\N	\N
e9b97ddb-a04c-429b-ab3b-d6965438f31d	\N	docker-http-basic-authenticator	e480d6f0-0699-495a-9096-dec0cacb5180	216e064e-c9a2-4aab-960a-971d06679f7c	0	10	f	\N	\N
\.


--
-- Data for Name: authentication_flow; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) FROM stdin;
2805febd-6426-4628-95cf-769d482dd9f1	browser	browser based authentication	4cf78245-f05a-4020-a9da-201ab9860d6d	basic-flow	t	t
1668c9a9-c37e-4378-ab68-be22329e3163	forms	Username, password, otp and other auth forms.	4cf78245-f05a-4020-a9da-201ab9860d6d	basic-flow	f	t
af7a0297-8dce-4ff3-af70-70313d188fb3	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	4cf78245-f05a-4020-a9da-201ab9860d6d	basic-flow	f	t
1224a98d-7bf8-43f6-9c52-072b04ac9046	direct grant	OpenID Connect Resource Owner Grant	4cf78245-f05a-4020-a9da-201ab9860d6d	basic-flow	t	t
fb944d9a-18cd-4e0c-a6d0-d00ba821d07f	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	4cf78245-f05a-4020-a9da-201ab9860d6d	basic-flow	f	t
bcc12e4f-be83-4cee-82db-487770e6b06b	registration	registration flow	4cf78245-f05a-4020-a9da-201ab9860d6d	basic-flow	t	t
0add4f94-bdb1-41ed-9d2e-4514c5bd9dc0	registration form	registration form	4cf78245-f05a-4020-a9da-201ab9860d6d	form-flow	f	t
c80116c3-9fd4-46c0-943c-a2eb7accb5b2	reset credentials	Reset credentials for a user if they forgot their password or something	4cf78245-f05a-4020-a9da-201ab9860d6d	basic-flow	t	t
258f787c-c622-4254-9e69-7bdadd4349ae	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	4cf78245-f05a-4020-a9da-201ab9860d6d	basic-flow	f	t
7bbd9be7-d8fa-48b0-bf81-67e900185b99	clients	Base authentication for clients	4cf78245-f05a-4020-a9da-201ab9860d6d	client-flow	t	t
2452cf97-bb1e-4b1a-a509-d4586ee9b515	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	4cf78245-f05a-4020-a9da-201ab9860d6d	basic-flow	t	t
9217b93d-fde2-49ae-a8f0-7f0c895751a4	User creation or linking	Flow for the existing/non-existing user alternatives	4cf78245-f05a-4020-a9da-201ab9860d6d	basic-flow	f	t
67a44727-e45b-4e5a-856a-064bf26acac0	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	4cf78245-f05a-4020-a9da-201ab9860d6d	basic-flow	f	t
d844aba0-06a2-4be1-b366-f36fcb2a322d	Account verification options	Method with which to verity the existing account	4cf78245-f05a-4020-a9da-201ab9860d6d	basic-flow	f	t
94ee3f0d-6bbe-43fa-b0b0-27df41599311	Verify Existing Account by Re-authentication	Reauthentication of existing account	4cf78245-f05a-4020-a9da-201ab9860d6d	basic-flow	f	t
70cc16c6-d730-48d9-990d-ab15fafc17a8	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	4cf78245-f05a-4020-a9da-201ab9860d6d	basic-flow	f	t
bda85b59-342f-4bed-9476-e178ce7cbe5c	saml ecp	SAML ECP Profile Authentication Flow	4cf78245-f05a-4020-a9da-201ab9860d6d	basic-flow	t	t
73442a69-7046-418b-adc3-000086d1112c	docker auth	Used by Docker clients to authenticate against the IDP	4cf78245-f05a-4020-a9da-201ab9860d6d	basic-flow	t	t
e603fa14-cfef-4fba-808c-b89c80e07553	browser	browser based authentication	e480d6f0-0699-495a-9096-dec0cacb5180	basic-flow	t	t
60a89bd1-56f3-4d05-8604-e9de16305285	forms	Username, password, otp and other auth forms.	e480d6f0-0699-495a-9096-dec0cacb5180	basic-flow	f	t
30b356ff-5b1a-4c78-ade2-bb60be37642d	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	e480d6f0-0699-495a-9096-dec0cacb5180	basic-flow	f	t
d248b326-dda8-4faf-9fde-f11f7e904d4a	direct grant	OpenID Connect Resource Owner Grant	e480d6f0-0699-495a-9096-dec0cacb5180	basic-flow	t	t
cef621a3-a692-4792-89fe-862107279392	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	e480d6f0-0699-495a-9096-dec0cacb5180	basic-flow	f	t
bd939d67-e10e-41f7-ab09-00d26c395961	registration	registration flow	e480d6f0-0699-495a-9096-dec0cacb5180	basic-flow	t	t
f70e4d70-7902-4845-a40c-e4ebce194e26	registration form	registration form	e480d6f0-0699-495a-9096-dec0cacb5180	form-flow	f	t
f5d7fee1-9dda-47b4-bf17-ff7b984a1e91	reset credentials	Reset credentials for a user if they forgot their password or something	e480d6f0-0699-495a-9096-dec0cacb5180	basic-flow	t	t
deaa52e2-f056-446e-b401-12e803d3b016	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	e480d6f0-0699-495a-9096-dec0cacb5180	basic-flow	f	t
945c7900-904d-4c9d-b480-bbd6db27f5a5	clients	Base authentication for clients	e480d6f0-0699-495a-9096-dec0cacb5180	client-flow	t	t
b5882c83-509d-4926-8689-afaa07cd3372	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	e480d6f0-0699-495a-9096-dec0cacb5180	basic-flow	t	t
02243bdd-fca9-439d-bf9d-acda00dc2f36	User creation or linking	Flow for the existing/non-existing user alternatives	e480d6f0-0699-495a-9096-dec0cacb5180	basic-flow	f	t
b361f44f-8120-4a76-a9fe-a3e48d2334a1	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	e480d6f0-0699-495a-9096-dec0cacb5180	basic-flow	f	t
05150eb3-192d-4aab-ab79-f658b7d57d43	Account verification options	Method with which to verity the existing account	e480d6f0-0699-495a-9096-dec0cacb5180	basic-flow	f	t
52fd602f-6db4-4c85-9e3e-610c72eac8df	Verify Existing Account by Re-authentication	Reauthentication of existing account	e480d6f0-0699-495a-9096-dec0cacb5180	basic-flow	f	t
456ba7ce-1cec-40e7-9aa1-1dc7e5b04282	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	e480d6f0-0699-495a-9096-dec0cacb5180	basic-flow	f	t
695f6b12-1268-4cf0-8542-d0bf14bb5716	saml ecp	SAML ECP Profile Authentication Flow	e480d6f0-0699-495a-9096-dec0cacb5180	basic-flow	t	t
216e064e-c9a2-4aab-960a-971d06679f7c	docker auth	Used by Docker clients to authenticate against the IDP	e480d6f0-0699-495a-9096-dec0cacb5180	basic-flow	t	t
\.


--
-- Data for Name: authenticator_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authenticator_config (id, alias, realm_id) FROM stdin;
466fd153-6fff-4d33-a439-44dd1b458e52	review profile config	4cf78245-f05a-4020-a9da-201ab9860d6d
3bd47164-cb84-4722-8cd7-a17d46870efa	create unique user config	4cf78245-f05a-4020-a9da-201ab9860d6d
177667d4-94b6-4631-9cc8-e4a13a9bd314	review profile config	e480d6f0-0699-495a-9096-dec0cacb5180
a0c2951b-affd-4e6b-80e5-e21b9ae0801c	create unique user config	e480d6f0-0699-495a-9096-dec0cacb5180
\.


--
-- Data for Name: authenticator_config_entry; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authenticator_config_entry (authenticator_id, value, name) FROM stdin;
3bd47164-cb84-4722-8cd7-a17d46870efa	false	require.password.update.after.registration
466fd153-6fff-4d33-a439-44dd1b458e52	missing	update.profile.on.first.login
177667d4-94b6-4631-9cc8-e4a13a9bd314	missing	update.profile.on.first.login
a0c2951b-affd-4e6b-80e5-e21b9ae0801c	false	require.password.update.after.registration
\.


--
-- Data for Name: broker_link; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.broker_link (identity_provider, storage_provider_id, realm_id, broker_user_id, broker_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) FROM stdin;
354c75ff-d75f-448b-a864-a15f2a03b035	t	f	master-realm	0	f	\N	\N	t	\N	f	4cf78245-f05a-4020-a9da-201ab9860d6d	\N	0	f	f	master Realm	f	client-secret	\N	\N	\N	t	f	f	f
aa4caee7-014b-4a77-9c6e-b66a19602c9f	t	f	account	0	t	\N	/realms/master/account/	f	\N	f	4cf78245-f05a-4020-a9da-201ab9860d6d	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
4f07f38b-0e6f-426c-b5d1-369b09db7cfc	t	f	account-console	0	t	\N	/realms/master/account/	f	\N	f	4cf78245-f05a-4020-a9da-201ab9860d6d	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
d7eb9ada-bfd8-4416-8b98-98a4e20e9aa2	t	f	broker	0	f	\N	\N	t	\N	f	4cf78245-f05a-4020-a9da-201ab9860d6d	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
daf774fc-7c22-44f0-a5f2-0c88cc4e6b20	t	f	security-admin-console	0	t	\N	/admin/master/console/	f	\N	f	4cf78245-f05a-4020-a9da-201ab9860d6d	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
46fce90e-80ce-4c7d-859e-1223f904cb40	t	f	admin-cli	0	t	\N	\N	f	\N	f	4cf78245-f05a-4020-a9da-201ab9860d6d	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
6a60ad1e-acb2-4328-91aa-b79ccf6a9da6	t	f	myrealm-realm	0	f	\N	\N	t	\N	f	4cf78245-f05a-4020-a9da-201ab9860d6d	\N	0	f	f	myrealm Realm	f	client-secret	\N	\N	\N	t	f	f	f
85039379-86ca-4b27-bce9-dc45611edda9	t	f	realm-management	0	f	\N	\N	t	\N	f	e480d6f0-0699-495a-9096-dec0cacb5180	openid-connect	0	f	f	${client_realm-management}	f	client-secret	\N	\N	\N	t	f	f	f
d48ad890-9172-4e3f-9d6e-898de4412752	t	f	account	0	t	\N	/realms/myrealm/account/	f	\N	f	e480d6f0-0699-495a-9096-dec0cacb5180	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
49ecb9f6-bd6f-433d-bbcb-5579bea2b3b5	t	f	account-console	0	t	\N	/realms/myrealm/account/	f	\N	f	e480d6f0-0699-495a-9096-dec0cacb5180	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
adbbb502-79ac-41f6-97ac-b4b9b2c49327	t	f	broker	0	f	\N	\N	t	\N	f	e480d6f0-0699-495a-9096-dec0cacb5180	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
7b85e5dc-1441-431d-a843-941c35defc9c	t	f	security-admin-console	0	t	\N	/admin/myrealm/console/	f	\N	f	e480d6f0-0699-495a-9096-dec0cacb5180	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
78dbfe08-4cc5-43dd-8776-5126347d317c	t	f	admin-cli	0	t	\N	\N	f	\N	f	e480d6f0-0699-495a-9096-dec0cacb5180	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
edda3079-f9f1-49de-9d18-8840096fe1e5	t	t	phone_catalog-back	0	f	fPoemFZhNOD2aCaS3q3Ch0HCFm1tUhYl	http://localhost:8090/	f	http://localhost:8090/	f	e480d6f0-0699-495a-9096-dec0cacb5180	openid-connect	-1	t	f		t	client-secret	http://localhost:8090/		\N	t	f	t	f
\.


--
-- Data for Name: client_attributes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_attributes (client_id, name, value) FROM stdin;
aa4caee7-014b-4a77-9c6e-b66a19602c9f	post.logout.redirect.uris	+
4f07f38b-0e6f-426c-b5d1-369b09db7cfc	post.logout.redirect.uris	+
4f07f38b-0e6f-426c-b5d1-369b09db7cfc	pkce.code.challenge.method	S256
daf774fc-7c22-44f0-a5f2-0c88cc4e6b20	post.logout.redirect.uris	+
daf774fc-7c22-44f0-a5f2-0c88cc4e6b20	pkce.code.challenge.method	S256
d48ad890-9172-4e3f-9d6e-898de4412752	post.logout.redirect.uris	+
49ecb9f6-bd6f-433d-bbcb-5579bea2b3b5	post.logout.redirect.uris	+
49ecb9f6-bd6f-433d-bbcb-5579bea2b3b5	pkce.code.challenge.method	S256
7b85e5dc-1441-431d-a843-941c35defc9c	post.logout.redirect.uris	+
7b85e5dc-1441-431d-a843-941c35defc9c	pkce.code.challenge.method	S256
edda3079-f9f1-49de-9d18-8840096fe1e5	oauth2.device.authorization.grant.enabled	false
edda3079-f9f1-49de-9d18-8840096fe1e5	oidc.ciba.grant.enabled	false
edda3079-f9f1-49de-9d18-8840096fe1e5	backchannel.logout.session.required	true
edda3079-f9f1-49de-9d18-8840096fe1e5	backchannel.logout.revoke.offline.tokens	false
edda3079-f9f1-49de-9d18-8840096fe1e5	display.on.consent.screen	false
edda3079-f9f1-49de-9d18-8840096fe1e5	acr.loa.map	{}
edda3079-f9f1-49de-9d18-8840096fe1e5	use.refresh.tokens	true
edda3079-f9f1-49de-9d18-8840096fe1e5	client_credentials.use_refresh_token	false
edda3079-f9f1-49de-9d18-8840096fe1e5	token.response.type.bearer.lower-case	false
edda3079-f9f1-49de-9d18-8840096fe1e5	tls-client-certificate-bound-access-tokens	false
edda3079-f9f1-49de-9d18-8840096fe1e5	require.pushed.authorization.requests	false
edda3079-f9f1-49de-9d18-8840096fe1e5	client.secret.creation.time	1688990740
\.


--
-- Data for Name: client_auth_flow_bindings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_auth_flow_bindings (client_id, flow_id, binding_name) FROM stdin;
\.


--
-- Data for Name: client_initial_access; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_initial_access (id, realm_id, "timestamp", expiration, count, remaining_count) FROM stdin;
\.


--
-- Data for Name: client_node_registrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_node_registrations (client_id, value, name) FROM stdin;
\.


--
-- Data for Name: client_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_scope (id, name, realm_id, description, protocol) FROM stdin;
9c9f5561-5246-4169-a55f-5b488cb88686	offline_access	4cf78245-f05a-4020-a9da-201ab9860d6d	OpenID Connect built-in scope: offline_access	openid-connect
440be81e-54d6-4506-8ce3-693b4dd3469a	role_list	4cf78245-f05a-4020-a9da-201ab9860d6d	SAML role list	saml
e1cc5ddc-d574-4f0f-afc2-7f9ed0a1f3df	profile	4cf78245-f05a-4020-a9da-201ab9860d6d	OpenID Connect built-in scope: profile	openid-connect
2c25f89a-764b-4b72-bad8-882aafb9fb72	email	4cf78245-f05a-4020-a9da-201ab9860d6d	OpenID Connect built-in scope: email	openid-connect
4346a73d-86fa-4a88-bfc4-db05ca8ff733	address	4cf78245-f05a-4020-a9da-201ab9860d6d	OpenID Connect built-in scope: address	openid-connect
88bf1e09-3b74-4263-a810-8fe9d6c050aa	phone	4cf78245-f05a-4020-a9da-201ab9860d6d	OpenID Connect built-in scope: phone	openid-connect
59a9acbc-1636-4636-b212-38d9e1c8e5ff	roles	4cf78245-f05a-4020-a9da-201ab9860d6d	OpenID Connect scope for add user roles to the access token	openid-connect
1ac7e3bc-1afb-4916-98aa-89efe561aaa2	web-origins	4cf78245-f05a-4020-a9da-201ab9860d6d	OpenID Connect scope for add allowed web origins to the access token	openid-connect
9f6e53a6-d15f-4638-9b0e-771498a76368	microprofile-jwt	4cf78245-f05a-4020-a9da-201ab9860d6d	Microprofile - JWT built-in scope	openid-connect
6393064b-36ab-45dd-997c-4412d2019e39	acr	4cf78245-f05a-4020-a9da-201ab9860d6d	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
d452bb90-0717-410e-9679-4dd6a83e1731	offline_access	e480d6f0-0699-495a-9096-dec0cacb5180	OpenID Connect built-in scope: offline_access	openid-connect
f0f01578-d314-4f10-a5a7-2cdc3ab8a9f8	role_list	e480d6f0-0699-495a-9096-dec0cacb5180	SAML role list	saml
e9bd9034-5a1c-4b83-872d-1d25b73ba6c2	profile	e480d6f0-0699-495a-9096-dec0cacb5180	OpenID Connect built-in scope: profile	openid-connect
4e8e0adb-b446-4a39-a883-fed71d64b4b0	email	e480d6f0-0699-495a-9096-dec0cacb5180	OpenID Connect built-in scope: email	openid-connect
25a7f3ff-7881-420f-aff5-4bdad622bfac	address	e480d6f0-0699-495a-9096-dec0cacb5180	OpenID Connect built-in scope: address	openid-connect
c6adc16a-8f98-4614-84cf-5561d01caf5b	phone	e480d6f0-0699-495a-9096-dec0cacb5180	OpenID Connect built-in scope: phone	openid-connect
88ca64d5-d52b-40da-9d2c-addfab692877	roles	e480d6f0-0699-495a-9096-dec0cacb5180	OpenID Connect scope for add user roles to the access token	openid-connect
72bf4807-f2c0-4a86-a530-b4d7644b1203	web-origins	e480d6f0-0699-495a-9096-dec0cacb5180	OpenID Connect scope for add allowed web origins to the access token	openid-connect
64159835-6e5d-46ce-9ef8-8cae0eaa0b1e	microprofile-jwt	e480d6f0-0699-495a-9096-dec0cacb5180	Microprofile - JWT built-in scope	openid-connect
ae6e799c-12ef-41dc-82eb-08ff92083ca4	acr	e480d6f0-0699-495a-9096-dec0cacb5180	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
\.


--
-- Data for Name: client_scope_attributes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_scope_attributes (scope_id, value, name) FROM stdin;
9c9f5561-5246-4169-a55f-5b488cb88686	true	display.on.consent.screen
9c9f5561-5246-4169-a55f-5b488cb88686	${offlineAccessScopeConsentText}	consent.screen.text
440be81e-54d6-4506-8ce3-693b4dd3469a	true	display.on.consent.screen
440be81e-54d6-4506-8ce3-693b4dd3469a	${samlRoleListScopeConsentText}	consent.screen.text
e1cc5ddc-d574-4f0f-afc2-7f9ed0a1f3df	true	display.on.consent.screen
e1cc5ddc-d574-4f0f-afc2-7f9ed0a1f3df	${profileScopeConsentText}	consent.screen.text
e1cc5ddc-d574-4f0f-afc2-7f9ed0a1f3df	true	include.in.token.scope
2c25f89a-764b-4b72-bad8-882aafb9fb72	true	display.on.consent.screen
2c25f89a-764b-4b72-bad8-882aafb9fb72	${emailScopeConsentText}	consent.screen.text
2c25f89a-764b-4b72-bad8-882aafb9fb72	true	include.in.token.scope
4346a73d-86fa-4a88-bfc4-db05ca8ff733	true	display.on.consent.screen
4346a73d-86fa-4a88-bfc4-db05ca8ff733	${addressScopeConsentText}	consent.screen.text
4346a73d-86fa-4a88-bfc4-db05ca8ff733	true	include.in.token.scope
88bf1e09-3b74-4263-a810-8fe9d6c050aa	true	display.on.consent.screen
88bf1e09-3b74-4263-a810-8fe9d6c050aa	${phoneScopeConsentText}	consent.screen.text
88bf1e09-3b74-4263-a810-8fe9d6c050aa	true	include.in.token.scope
59a9acbc-1636-4636-b212-38d9e1c8e5ff	true	display.on.consent.screen
59a9acbc-1636-4636-b212-38d9e1c8e5ff	${rolesScopeConsentText}	consent.screen.text
59a9acbc-1636-4636-b212-38d9e1c8e5ff	false	include.in.token.scope
1ac7e3bc-1afb-4916-98aa-89efe561aaa2	false	display.on.consent.screen
1ac7e3bc-1afb-4916-98aa-89efe561aaa2		consent.screen.text
1ac7e3bc-1afb-4916-98aa-89efe561aaa2	false	include.in.token.scope
9f6e53a6-d15f-4638-9b0e-771498a76368	false	display.on.consent.screen
9f6e53a6-d15f-4638-9b0e-771498a76368	true	include.in.token.scope
6393064b-36ab-45dd-997c-4412d2019e39	false	display.on.consent.screen
6393064b-36ab-45dd-997c-4412d2019e39	false	include.in.token.scope
d452bb90-0717-410e-9679-4dd6a83e1731	true	display.on.consent.screen
d452bb90-0717-410e-9679-4dd6a83e1731	${offlineAccessScopeConsentText}	consent.screen.text
f0f01578-d314-4f10-a5a7-2cdc3ab8a9f8	true	display.on.consent.screen
f0f01578-d314-4f10-a5a7-2cdc3ab8a9f8	${samlRoleListScopeConsentText}	consent.screen.text
e9bd9034-5a1c-4b83-872d-1d25b73ba6c2	true	display.on.consent.screen
e9bd9034-5a1c-4b83-872d-1d25b73ba6c2	${profileScopeConsentText}	consent.screen.text
e9bd9034-5a1c-4b83-872d-1d25b73ba6c2	true	include.in.token.scope
4e8e0adb-b446-4a39-a883-fed71d64b4b0	true	display.on.consent.screen
4e8e0adb-b446-4a39-a883-fed71d64b4b0	${emailScopeConsentText}	consent.screen.text
4e8e0adb-b446-4a39-a883-fed71d64b4b0	true	include.in.token.scope
25a7f3ff-7881-420f-aff5-4bdad622bfac	true	display.on.consent.screen
25a7f3ff-7881-420f-aff5-4bdad622bfac	${addressScopeConsentText}	consent.screen.text
25a7f3ff-7881-420f-aff5-4bdad622bfac	true	include.in.token.scope
c6adc16a-8f98-4614-84cf-5561d01caf5b	true	display.on.consent.screen
c6adc16a-8f98-4614-84cf-5561d01caf5b	${phoneScopeConsentText}	consent.screen.text
c6adc16a-8f98-4614-84cf-5561d01caf5b	true	include.in.token.scope
88ca64d5-d52b-40da-9d2c-addfab692877	true	display.on.consent.screen
88ca64d5-d52b-40da-9d2c-addfab692877	${rolesScopeConsentText}	consent.screen.text
88ca64d5-d52b-40da-9d2c-addfab692877	false	include.in.token.scope
72bf4807-f2c0-4a86-a530-b4d7644b1203	false	display.on.consent.screen
72bf4807-f2c0-4a86-a530-b4d7644b1203		consent.screen.text
72bf4807-f2c0-4a86-a530-b4d7644b1203	false	include.in.token.scope
64159835-6e5d-46ce-9ef8-8cae0eaa0b1e	false	display.on.consent.screen
64159835-6e5d-46ce-9ef8-8cae0eaa0b1e	true	include.in.token.scope
ae6e799c-12ef-41dc-82eb-08ff92083ca4	false	display.on.consent.screen
ae6e799c-12ef-41dc-82eb-08ff92083ca4	false	include.in.token.scope
\.


--
-- Data for Name: client_scope_client; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_scope_client (client_id, scope_id, default_scope) FROM stdin;
aa4caee7-014b-4a77-9c6e-b66a19602c9f	1ac7e3bc-1afb-4916-98aa-89efe561aaa2	t
aa4caee7-014b-4a77-9c6e-b66a19602c9f	e1cc5ddc-d574-4f0f-afc2-7f9ed0a1f3df	t
aa4caee7-014b-4a77-9c6e-b66a19602c9f	59a9acbc-1636-4636-b212-38d9e1c8e5ff	t
aa4caee7-014b-4a77-9c6e-b66a19602c9f	2c25f89a-764b-4b72-bad8-882aafb9fb72	t
aa4caee7-014b-4a77-9c6e-b66a19602c9f	6393064b-36ab-45dd-997c-4412d2019e39	t
aa4caee7-014b-4a77-9c6e-b66a19602c9f	9f6e53a6-d15f-4638-9b0e-771498a76368	f
aa4caee7-014b-4a77-9c6e-b66a19602c9f	88bf1e09-3b74-4263-a810-8fe9d6c050aa	f
aa4caee7-014b-4a77-9c6e-b66a19602c9f	9c9f5561-5246-4169-a55f-5b488cb88686	f
aa4caee7-014b-4a77-9c6e-b66a19602c9f	4346a73d-86fa-4a88-bfc4-db05ca8ff733	f
4f07f38b-0e6f-426c-b5d1-369b09db7cfc	1ac7e3bc-1afb-4916-98aa-89efe561aaa2	t
4f07f38b-0e6f-426c-b5d1-369b09db7cfc	e1cc5ddc-d574-4f0f-afc2-7f9ed0a1f3df	t
4f07f38b-0e6f-426c-b5d1-369b09db7cfc	59a9acbc-1636-4636-b212-38d9e1c8e5ff	t
4f07f38b-0e6f-426c-b5d1-369b09db7cfc	2c25f89a-764b-4b72-bad8-882aafb9fb72	t
4f07f38b-0e6f-426c-b5d1-369b09db7cfc	6393064b-36ab-45dd-997c-4412d2019e39	t
4f07f38b-0e6f-426c-b5d1-369b09db7cfc	9f6e53a6-d15f-4638-9b0e-771498a76368	f
4f07f38b-0e6f-426c-b5d1-369b09db7cfc	88bf1e09-3b74-4263-a810-8fe9d6c050aa	f
4f07f38b-0e6f-426c-b5d1-369b09db7cfc	9c9f5561-5246-4169-a55f-5b488cb88686	f
4f07f38b-0e6f-426c-b5d1-369b09db7cfc	4346a73d-86fa-4a88-bfc4-db05ca8ff733	f
46fce90e-80ce-4c7d-859e-1223f904cb40	1ac7e3bc-1afb-4916-98aa-89efe561aaa2	t
46fce90e-80ce-4c7d-859e-1223f904cb40	e1cc5ddc-d574-4f0f-afc2-7f9ed0a1f3df	t
46fce90e-80ce-4c7d-859e-1223f904cb40	59a9acbc-1636-4636-b212-38d9e1c8e5ff	t
46fce90e-80ce-4c7d-859e-1223f904cb40	2c25f89a-764b-4b72-bad8-882aafb9fb72	t
46fce90e-80ce-4c7d-859e-1223f904cb40	6393064b-36ab-45dd-997c-4412d2019e39	t
46fce90e-80ce-4c7d-859e-1223f904cb40	9f6e53a6-d15f-4638-9b0e-771498a76368	f
46fce90e-80ce-4c7d-859e-1223f904cb40	88bf1e09-3b74-4263-a810-8fe9d6c050aa	f
46fce90e-80ce-4c7d-859e-1223f904cb40	9c9f5561-5246-4169-a55f-5b488cb88686	f
46fce90e-80ce-4c7d-859e-1223f904cb40	4346a73d-86fa-4a88-bfc4-db05ca8ff733	f
d7eb9ada-bfd8-4416-8b98-98a4e20e9aa2	1ac7e3bc-1afb-4916-98aa-89efe561aaa2	t
d7eb9ada-bfd8-4416-8b98-98a4e20e9aa2	e1cc5ddc-d574-4f0f-afc2-7f9ed0a1f3df	t
d7eb9ada-bfd8-4416-8b98-98a4e20e9aa2	59a9acbc-1636-4636-b212-38d9e1c8e5ff	t
d7eb9ada-bfd8-4416-8b98-98a4e20e9aa2	2c25f89a-764b-4b72-bad8-882aafb9fb72	t
d7eb9ada-bfd8-4416-8b98-98a4e20e9aa2	6393064b-36ab-45dd-997c-4412d2019e39	t
d7eb9ada-bfd8-4416-8b98-98a4e20e9aa2	9f6e53a6-d15f-4638-9b0e-771498a76368	f
d7eb9ada-bfd8-4416-8b98-98a4e20e9aa2	88bf1e09-3b74-4263-a810-8fe9d6c050aa	f
d7eb9ada-bfd8-4416-8b98-98a4e20e9aa2	9c9f5561-5246-4169-a55f-5b488cb88686	f
d7eb9ada-bfd8-4416-8b98-98a4e20e9aa2	4346a73d-86fa-4a88-bfc4-db05ca8ff733	f
354c75ff-d75f-448b-a864-a15f2a03b035	1ac7e3bc-1afb-4916-98aa-89efe561aaa2	t
354c75ff-d75f-448b-a864-a15f2a03b035	e1cc5ddc-d574-4f0f-afc2-7f9ed0a1f3df	t
354c75ff-d75f-448b-a864-a15f2a03b035	59a9acbc-1636-4636-b212-38d9e1c8e5ff	t
354c75ff-d75f-448b-a864-a15f2a03b035	2c25f89a-764b-4b72-bad8-882aafb9fb72	t
354c75ff-d75f-448b-a864-a15f2a03b035	6393064b-36ab-45dd-997c-4412d2019e39	t
354c75ff-d75f-448b-a864-a15f2a03b035	9f6e53a6-d15f-4638-9b0e-771498a76368	f
354c75ff-d75f-448b-a864-a15f2a03b035	88bf1e09-3b74-4263-a810-8fe9d6c050aa	f
354c75ff-d75f-448b-a864-a15f2a03b035	9c9f5561-5246-4169-a55f-5b488cb88686	f
354c75ff-d75f-448b-a864-a15f2a03b035	4346a73d-86fa-4a88-bfc4-db05ca8ff733	f
daf774fc-7c22-44f0-a5f2-0c88cc4e6b20	1ac7e3bc-1afb-4916-98aa-89efe561aaa2	t
daf774fc-7c22-44f0-a5f2-0c88cc4e6b20	e1cc5ddc-d574-4f0f-afc2-7f9ed0a1f3df	t
daf774fc-7c22-44f0-a5f2-0c88cc4e6b20	59a9acbc-1636-4636-b212-38d9e1c8e5ff	t
daf774fc-7c22-44f0-a5f2-0c88cc4e6b20	2c25f89a-764b-4b72-bad8-882aafb9fb72	t
daf774fc-7c22-44f0-a5f2-0c88cc4e6b20	6393064b-36ab-45dd-997c-4412d2019e39	t
daf774fc-7c22-44f0-a5f2-0c88cc4e6b20	9f6e53a6-d15f-4638-9b0e-771498a76368	f
daf774fc-7c22-44f0-a5f2-0c88cc4e6b20	88bf1e09-3b74-4263-a810-8fe9d6c050aa	f
daf774fc-7c22-44f0-a5f2-0c88cc4e6b20	9c9f5561-5246-4169-a55f-5b488cb88686	f
daf774fc-7c22-44f0-a5f2-0c88cc4e6b20	4346a73d-86fa-4a88-bfc4-db05ca8ff733	f
d48ad890-9172-4e3f-9d6e-898de4412752	4e8e0adb-b446-4a39-a883-fed71d64b4b0	t
d48ad890-9172-4e3f-9d6e-898de4412752	e9bd9034-5a1c-4b83-872d-1d25b73ba6c2	t
d48ad890-9172-4e3f-9d6e-898de4412752	ae6e799c-12ef-41dc-82eb-08ff92083ca4	t
d48ad890-9172-4e3f-9d6e-898de4412752	72bf4807-f2c0-4a86-a530-b4d7644b1203	t
d48ad890-9172-4e3f-9d6e-898de4412752	88ca64d5-d52b-40da-9d2c-addfab692877	t
d48ad890-9172-4e3f-9d6e-898de4412752	25a7f3ff-7881-420f-aff5-4bdad622bfac	f
d48ad890-9172-4e3f-9d6e-898de4412752	d452bb90-0717-410e-9679-4dd6a83e1731	f
d48ad890-9172-4e3f-9d6e-898de4412752	c6adc16a-8f98-4614-84cf-5561d01caf5b	f
d48ad890-9172-4e3f-9d6e-898de4412752	64159835-6e5d-46ce-9ef8-8cae0eaa0b1e	f
49ecb9f6-bd6f-433d-bbcb-5579bea2b3b5	4e8e0adb-b446-4a39-a883-fed71d64b4b0	t
49ecb9f6-bd6f-433d-bbcb-5579bea2b3b5	e9bd9034-5a1c-4b83-872d-1d25b73ba6c2	t
49ecb9f6-bd6f-433d-bbcb-5579bea2b3b5	ae6e799c-12ef-41dc-82eb-08ff92083ca4	t
49ecb9f6-bd6f-433d-bbcb-5579bea2b3b5	72bf4807-f2c0-4a86-a530-b4d7644b1203	t
49ecb9f6-bd6f-433d-bbcb-5579bea2b3b5	88ca64d5-d52b-40da-9d2c-addfab692877	t
49ecb9f6-bd6f-433d-bbcb-5579bea2b3b5	25a7f3ff-7881-420f-aff5-4bdad622bfac	f
49ecb9f6-bd6f-433d-bbcb-5579bea2b3b5	d452bb90-0717-410e-9679-4dd6a83e1731	f
49ecb9f6-bd6f-433d-bbcb-5579bea2b3b5	c6adc16a-8f98-4614-84cf-5561d01caf5b	f
49ecb9f6-bd6f-433d-bbcb-5579bea2b3b5	64159835-6e5d-46ce-9ef8-8cae0eaa0b1e	f
78dbfe08-4cc5-43dd-8776-5126347d317c	4e8e0adb-b446-4a39-a883-fed71d64b4b0	t
78dbfe08-4cc5-43dd-8776-5126347d317c	e9bd9034-5a1c-4b83-872d-1d25b73ba6c2	t
78dbfe08-4cc5-43dd-8776-5126347d317c	ae6e799c-12ef-41dc-82eb-08ff92083ca4	t
78dbfe08-4cc5-43dd-8776-5126347d317c	72bf4807-f2c0-4a86-a530-b4d7644b1203	t
78dbfe08-4cc5-43dd-8776-5126347d317c	88ca64d5-d52b-40da-9d2c-addfab692877	t
78dbfe08-4cc5-43dd-8776-5126347d317c	25a7f3ff-7881-420f-aff5-4bdad622bfac	f
78dbfe08-4cc5-43dd-8776-5126347d317c	d452bb90-0717-410e-9679-4dd6a83e1731	f
78dbfe08-4cc5-43dd-8776-5126347d317c	c6adc16a-8f98-4614-84cf-5561d01caf5b	f
78dbfe08-4cc5-43dd-8776-5126347d317c	64159835-6e5d-46ce-9ef8-8cae0eaa0b1e	f
adbbb502-79ac-41f6-97ac-b4b9b2c49327	4e8e0adb-b446-4a39-a883-fed71d64b4b0	t
adbbb502-79ac-41f6-97ac-b4b9b2c49327	e9bd9034-5a1c-4b83-872d-1d25b73ba6c2	t
adbbb502-79ac-41f6-97ac-b4b9b2c49327	ae6e799c-12ef-41dc-82eb-08ff92083ca4	t
adbbb502-79ac-41f6-97ac-b4b9b2c49327	72bf4807-f2c0-4a86-a530-b4d7644b1203	t
adbbb502-79ac-41f6-97ac-b4b9b2c49327	88ca64d5-d52b-40da-9d2c-addfab692877	t
adbbb502-79ac-41f6-97ac-b4b9b2c49327	25a7f3ff-7881-420f-aff5-4bdad622bfac	f
adbbb502-79ac-41f6-97ac-b4b9b2c49327	d452bb90-0717-410e-9679-4dd6a83e1731	f
adbbb502-79ac-41f6-97ac-b4b9b2c49327	c6adc16a-8f98-4614-84cf-5561d01caf5b	f
adbbb502-79ac-41f6-97ac-b4b9b2c49327	64159835-6e5d-46ce-9ef8-8cae0eaa0b1e	f
85039379-86ca-4b27-bce9-dc45611edda9	4e8e0adb-b446-4a39-a883-fed71d64b4b0	t
85039379-86ca-4b27-bce9-dc45611edda9	e9bd9034-5a1c-4b83-872d-1d25b73ba6c2	t
85039379-86ca-4b27-bce9-dc45611edda9	ae6e799c-12ef-41dc-82eb-08ff92083ca4	t
85039379-86ca-4b27-bce9-dc45611edda9	72bf4807-f2c0-4a86-a530-b4d7644b1203	t
85039379-86ca-4b27-bce9-dc45611edda9	88ca64d5-d52b-40da-9d2c-addfab692877	t
85039379-86ca-4b27-bce9-dc45611edda9	25a7f3ff-7881-420f-aff5-4bdad622bfac	f
85039379-86ca-4b27-bce9-dc45611edda9	d452bb90-0717-410e-9679-4dd6a83e1731	f
85039379-86ca-4b27-bce9-dc45611edda9	c6adc16a-8f98-4614-84cf-5561d01caf5b	f
85039379-86ca-4b27-bce9-dc45611edda9	64159835-6e5d-46ce-9ef8-8cae0eaa0b1e	f
7b85e5dc-1441-431d-a843-941c35defc9c	4e8e0adb-b446-4a39-a883-fed71d64b4b0	t
7b85e5dc-1441-431d-a843-941c35defc9c	e9bd9034-5a1c-4b83-872d-1d25b73ba6c2	t
7b85e5dc-1441-431d-a843-941c35defc9c	ae6e799c-12ef-41dc-82eb-08ff92083ca4	t
7b85e5dc-1441-431d-a843-941c35defc9c	72bf4807-f2c0-4a86-a530-b4d7644b1203	t
7b85e5dc-1441-431d-a843-941c35defc9c	88ca64d5-d52b-40da-9d2c-addfab692877	t
7b85e5dc-1441-431d-a843-941c35defc9c	25a7f3ff-7881-420f-aff5-4bdad622bfac	f
7b85e5dc-1441-431d-a843-941c35defc9c	d452bb90-0717-410e-9679-4dd6a83e1731	f
7b85e5dc-1441-431d-a843-941c35defc9c	c6adc16a-8f98-4614-84cf-5561d01caf5b	f
7b85e5dc-1441-431d-a843-941c35defc9c	64159835-6e5d-46ce-9ef8-8cae0eaa0b1e	f
edda3079-f9f1-49de-9d18-8840096fe1e5	4e8e0adb-b446-4a39-a883-fed71d64b4b0	t
edda3079-f9f1-49de-9d18-8840096fe1e5	e9bd9034-5a1c-4b83-872d-1d25b73ba6c2	t
edda3079-f9f1-49de-9d18-8840096fe1e5	ae6e799c-12ef-41dc-82eb-08ff92083ca4	t
edda3079-f9f1-49de-9d18-8840096fe1e5	72bf4807-f2c0-4a86-a530-b4d7644b1203	t
edda3079-f9f1-49de-9d18-8840096fe1e5	88ca64d5-d52b-40da-9d2c-addfab692877	t
edda3079-f9f1-49de-9d18-8840096fe1e5	25a7f3ff-7881-420f-aff5-4bdad622bfac	f
edda3079-f9f1-49de-9d18-8840096fe1e5	d452bb90-0717-410e-9679-4dd6a83e1731	f
edda3079-f9f1-49de-9d18-8840096fe1e5	c6adc16a-8f98-4614-84cf-5561d01caf5b	f
edda3079-f9f1-49de-9d18-8840096fe1e5	64159835-6e5d-46ce-9ef8-8cae0eaa0b1e	f
\.


--
-- Data for Name: client_scope_role_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_scope_role_mapping (scope_id, role_id) FROM stdin;
9c9f5561-5246-4169-a55f-5b488cb88686	d0239204-0da8-46cf-abb5-e0c94f5ade35
d452bb90-0717-410e-9679-4dd6a83e1731	289d6130-e2f3-4ccf-b765-48103f137640
\.


--
-- Data for Name: client_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_session (id, client_id, redirect_uri, state, "timestamp", session_id, auth_method, realm_id, auth_user_id, current_action) FROM stdin;
\.


--
-- Data for Name: client_session_auth_status; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_session_auth_status (authenticator, status, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_note; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_prot_mapper; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_session_prot_mapper (protocol_mapper_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_session_role (role_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_user_session_note; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_user_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: component; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) FROM stdin;
36cdd391-8e46-4083-97c4-7a01c543f43c	Trusted Hosts	4cf78245-f05a-4020-a9da-201ab9860d6d	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	4cf78245-f05a-4020-a9da-201ab9860d6d	anonymous
1bcb7d04-bfed-44a8-9c0e-d6766d81dd2e	Consent Required	4cf78245-f05a-4020-a9da-201ab9860d6d	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	4cf78245-f05a-4020-a9da-201ab9860d6d	anonymous
957f74d8-cfe9-4c47-ba55-6be97a227f13	Full Scope Disabled	4cf78245-f05a-4020-a9da-201ab9860d6d	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	4cf78245-f05a-4020-a9da-201ab9860d6d	anonymous
bb7d6858-7f89-4767-bc9d-07101e8fd697	Max Clients Limit	4cf78245-f05a-4020-a9da-201ab9860d6d	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	4cf78245-f05a-4020-a9da-201ab9860d6d	anonymous
0c29ceb1-eb41-4630-878c-cdb283970e92	Allowed Protocol Mapper Types	4cf78245-f05a-4020-a9da-201ab9860d6d	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	4cf78245-f05a-4020-a9da-201ab9860d6d	anonymous
e43f9453-d1f6-407f-be9b-1972978f0a85	Allowed Client Scopes	4cf78245-f05a-4020-a9da-201ab9860d6d	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	4cf78245-f05a-4020-a9da-201ab9860d6d	anonymous
a0c197f2-0738-48b0-b960-9e000d0a8522	Allowed Protocol Mapper Types	4cf78245-f05a-4020-a9da-201ab9860d6d	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	4cf78245-f05a-4020-a9da-201ab9860d6d	authenticated
e81d5805-dba8-4f32-b3b6-7fd0655f7754	Allowed Client Scopes	4cf78245-f05a-4020-a9da-201ab9860d6d	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	4cf78245-f05a-4020-a9da-201ab9860d6d	authenticated
afa59a8d-39fd-480e-b9b8-8f2cdccad7e6	rsa-generated	4cf78245-f05a-4020-a9da-201ab9860d6d	rsa-generated	org.keycloak.keys.KeyProvider	4cf78245-f05a-4020-a9da-201ab9860d6d	\N
02bb964e-d4a8-482b-9e3c-2239b4c658da	rsa-enc-generated	4cf78245-f05a-4020-a9da-201ab9860d6d	rsa-enc-generated	org.keycloak.keys.KeyProvider	4cf78245-f05a-4020-a9da-201ab9860d6d	\N
c158a762-74dd-49fe-9277-1daebce2a2a9	hmac-generated	4cf78245-f05a-4020-a9da-201ab9860d6d	hmac-generated	org.keycloak.keys.KeyProvider	4cf78245-f05a-4020-a9da-201ab9860d6d	\N
9ed0617a-d3f4-4d4f-8e97-185911a9f994	aes-generated	4cf78245-f05a-4020-a9da-201ab9860d6d	aes-generated	org.keycloak.keys.KeyProvider	4cf78245-f05a-4020-a9da-201ab9860d6d	\N
2df1f913-f14d-4655-b9a9-8b47123418c7	rsa-generated	e480d6f0-0699-495a-9096-dec0cacb5180	rsa-generated	org.keycloak.keys.KeyProvider	e480d6f0-0699-495a-9096-dec0cacb5180	\N
67e67986-c2cb-48db-8fbf-7a03ad04a32b	rsa-enc-generated	e480d6f0-0699-495a-9096-dec0cacb5180	rsa-enc-generated	org.keycloak.keys.KeyProvider	e480d6f0-0699-495a-9096-dec0cacb5180	\N
db00215d-17d2-4b11-8d8e-b99217fad0da	hmac-generated	e480d6f0-0699-495a-9096-dec0cacb5180	hmac-generated	org.keycloak.keys.KeyProvider	e480d6f0-0699-495a-9096-dec0cacb5180	\N
08fe58a4-61fa-4526-b41b-321c4b57bf5b	aes-generated	e480d6f0-0699-495a-9096-dec0cacb5180	aes-generated	org.keycloak.keys.KeyProvider	e480d6f0-0699-495a-9096-dec0cacb5180	\N
9ec19fe8-95eb-464f-b200-816465b262f7	Trusted Hosts	e480d6f0-0699-495a-9096-dec0cacb5180	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	e480d6f0-0699-495a-9096-dec0cacb5180	anonymous
4dd90ca6-0962-479a-9501-8d3c72e83deb	Consent Required	e480d6f0-0699-495a-9096-dec0cacb5180	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	e480d6f0-0699-495a-9096-dec0cacb5180	anonymous
6f7687db-b118-4359-b91a-8b4bc3710aa5	Full Scope Disabled	e480d6f0-0699-495a-9096-dec0cacb5180	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	e480d6f0-0699-495a-9096-dec0cacb5180	anonymous
187a941a-19bb-48e0-9bec-d59a8d086f81	Max Clients Limit	e480d6f0-0699-495a-9096-dec0cacb5180	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	e480d6f0-0699-495a-9096-dec0cacb5180	anonymous
b2c273cd-1a1b-495e-b4c2-e7498bacf33c	Allowed Protocol Mapper Types	e480d6f0-0699-495a-9096-dec0cacb5180	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	e480d6f0-0699-495a-9096-dec0cacb5180	anonymous
59957aaf-8949-4bdf-9d4f-b70e47052ea3	Allowed Client Scopes	e480d6f0-0699-495a-9096-dec0cacb5180	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	e480d6f0-0699-495a-9096-dec0cacb5180	anonymous
041de51e-88af-4607-b489-30f30197f346	Allowed Protocol Mapper Types	e480d6f0-0699-495a-9096-dec0cacb5180	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	e480d6f0-0699-495a-9096-dec0cacb5180	authenticated
798ef122-301a-4808-bdd0-38c9c0c596e9	Allowed Client Scopes	e480d6f0-0699-495a-9096-dec0cacb5180	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	e480d6f0-0699-495a-9096-dec0cacb5180	authenticated
e986c76e-14ff-4744-b956-b275e47ff4d0	\N	e480d6f0-0699-495a-9096-dec0cacb5180	declarative-user-profile	org.keycloak.userprofile.UserProfileProvider	e480d6f0-0699-495a-9096-dec0cacb5180	\N
\.


--
-- Data for Name: component_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.component_config (id, component_id, name, value) FROM stdin;
4b4a8b3f-05fd-4f35-a682-bb156985193c	36cdd391-8e46-4083-97c4-7a01c543f43c	host-sending-registration-request-must-match	true
ba432748-77e8-42f0-9cbb-f66f084e18b6	36cdd391-8e46-4083-97c4-7a01c543f43c	client-uris-must-match	true
1a675ab7-6551-4cc2-9ece-e1dc9106adcb	a0c197f2-0738-48b0-b960-9e000d0a8522	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
d950559e-40ce-488b-adc3-a92987fd954b	a0c197f2-0738-48b0-b960-9e000d0a8522	allowed-protocol-mapper-types	oidc-full-name-mapper
ae55fd5a-2430-4abf-a673-f7aeed25d5e2	a0c197f2-0738-48b0-b960-9e000d0a8522	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
c8ea643d-b194-45c5-a75c-47de70e6c043	a0c197f2-0738-48b0-b960-9e000d0a8522	allowed-protocol-mapper-types	oidc-address-mapper
4b7ce21b-f836-40a0-bc5e-533c535d8966	a0c197f2-0738-48b0-b960-9e000d0a8522	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
888c3bec-79d6-42d0-bc6c-bedfeb87c237	a0c197f2-0738-48b0-b960-9e000d0a8522	allowed-protocol-mapper-types	saml-user-attribute-mapper
91a0f811-e13d-4b7a-a7d0-176f1b618a47	a0c197f2-0738-48b0-b960-9e000d0a8522	allowed-protocol-mapper-types	saml-user-property-mapper
1962809e-a4f0-4590-8950-51d1f0dec366	a0c197f2-0738-48b0-b960-9e000d0a8522	allowed-protocol-mapper-types	saml-role-list-mapper
9f1f15b0-f763-45a0-944b-dd815003a269	e81d5805-dba8-4f32-b3b6-7fd0655f7754	allow-default-scopes	true
68874f7f-62bf-478b-b658-1d0fa83d1b21	bb7d6858-7f89-4767-bc9d-07101e8fd697	max-clients	200
38e8b2b5-0f00-465f-bb8d-cf33f2cb9ac3	e43f9453-d1f6-407f-be9b-1972978f0a85	allow-default-scopes	true
116097b5-8031-4784-8c61-adbe43d8d3af	0c29ceb1-eb41-4630-878c-cdb283970e92	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
41ead224-66a3-48f8-b8be-35fa8f9c2434	0c29ceb1-eb41-4630-878c-cdb283970e92	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
a25b185f-7e59-4c23-a408-b29646ed158e	0c29ceb1-eb41-4630-878c-cdb283970e92	allowed-protocol-mapper-types	oidc-address-mapper
ff064533-8dfd-4d53-8888-efc5265ec426	0c29ceb1-eb41-4630-878c-cdb283970e92	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
21b2994b-62d7-4d68-be42-24bc058be11b	0c29ceb1-eb41-4630-878c-cdb283970e92	allowed-protocol-mapper-types	oidc-full-name-mapper
21e8c2d9-12a5-41af-af67-a3a2018479dc	0c29ceb1-eb41-4630-878c-cdb283970e92	allowed-protocol-mapper-types	saml-user-property-mapper
ec09cce7-299c-423d-9968-0ffc2d7ee3da	0c29ceb1-eb41-4630-878c-cdb283970e92	allowed-protocol-mapper-types	saml-user-attribute-mapper
351e58c4-995f-4015-929e-86a178e980ee	0c29ceb1-eb41-4630-878c-cdb283970e92	allowed-protocol-mapper-types	saml-role-list-mapper
1449dea7-a574-4358-96a9-a2e67a17d100	02bb964e-d4a8-482b-9e3c-2239b4c658da	certificate	MIICmzCCAYMCBgGJMIBwZDANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjMwNzA3MTMxNjExWhcNMzMwNzA3MTMxNzUxWjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCUdA8L4S30pLLbguIYbxV2ne2uTMqkjFYTJY6OvjAGgSvbFyL25k25aNGvo05IUmHFGuaDcvkhNL8bbCasTjtcQ0NtESHG/tD8OzLrE0IEWijuhPHNI8XpvgO3zn+jJvTLkPj0wsNX7VO3PT4prMb1ZxEH5T0PdyTknL3udXiBAeziRV/264pANHHG+YlLTkO/hQjrKefJpLF4NH+ROIL9eqIR4zKme60kUmekPmf8guXZyxVW3n50sT4Fgzq+BLQWkCITNx6bIm8I2EgzdceR5ecgNtkpt4CgfDEKUMAawlauXN7O0VKx2TM48nH1akEDRNVPQMIP3WiIiMekDEb/AgMBAAEwDQYJKoZIhvcNAQELBQADggEBAAte2bBrdzCBut9Kxy4pF314LlUFS0aS00kp6w78Dxbd3g/pv7ls6BtpESv9C5mjIqtDDyEj+JgT4n+h6Qi50Fjbxpo+UBlwsWFi5fd/qMu1wWIciOv1IMyevD5LdyPRaBEruHegoYs+MMcwh664rfmldTsOLqIYWIvAc+YehdWyVQkTBI8UkfouOdshmc3hVVFyczWHi4VOX8UwHtL7rwKo+1C0wbruKKwGFcC0Gg+55o0au/OSru3/XJ5toU3/f0zqIjgxaVu6psTPX/PiV18UYn0hsYOX8vferdNBGjFKJM/dxagLiiFHrk+9kzWxc7Bdek/+hjeQLDZCBu5SG+s=
f29d3bc6-2ada-4529-9948-2f0550ea9c71	02bb964e-d4a8-482b-9e3c-2239b4c658da	priority	100
d816868f-87f3-432f-a5bd-a468f42ada90	02bb964e-d4a8-482b-9e3c-2239b4c658da	privateKey	MIIEpAIBAAKCAQEAlHQPC+Et9KSy24LiGG8Vdp3trkzKpIxWEyWOjr4wBoEr2xci9uZNuWjRr6NOSFJhxRrmg3L5ITS/G2wmrE47XENDbREhxv7Q/Dsy6xNCBFoo7oTxzSPF6b4Dt85/oyb0y5D49MLDV+1Ttz0+KazG9WcRB+U9D3ck5Jy97nV4gQHs4kVf9uuKQDRxxvmJS05Dv4UI6ynnyaSxeDR/kTiC/XqiEeMypnutJFJnpD5n/ILl2csVVt5+dLE+BYM6vgS0FpAiEzcemyJvCNhIM3XHkeXnIDbZKbeAoHwxClDAGsJWrlzeztFSsdkzOPJx9WpBA0TVT0DCD91oiIjHpAxG/wIDAQABAoIBAC2r+RcUC4HpC7e58BpJTqakFsQZjvyJyk9wrgefXoIZymbImvKvzvi8VUp+aO6aHcc4q/OD8z5yjlr+7nTzSpLrhLpw213v9larVdJ5pcVWAaLEFuogV9q+IUGyz5Tfvs9EBjuzEcsi0i8dMds7cyh7sYMm1R7Fbn3A9TQAQvcZKwGbCoRdPaDIpPLpWKD2Od3pyVfpWNGcK6fMVN/aT6upUTol0JAh/Hc6NzGZyUB6ryPJJskqt6RH3n/ArNZKb3Cvq5hSPpB3p/SKSW/EQQnVwi13nR4aLrlyG/axZFcW9rRT3+OU9t4+G0jZHe/LWzof52jJOzXEfFPWjiOaaw0CgYEAykECw7gsvnsdWlBWbtf6ipPyJyghUkZk+BClH+tSLWDhXmKOFuu32eFKX6swEleYK4ImY8KECccmk5q7Ktyxe7UOh3TRD3qDbW2Lspsnja1RJJ+zKjZ/uvhGGochTVI5Ljvxjhjp4v/0W6FJ6yX56ddXfljoMrNc3VpxVhQTVc0CgYEAu+cV+rk1mbMYZx9n9gAUZmdzObQ4YnwRqb/uImCKePXGbA+wL7is+d0mTskUzJJ2fkFEjwPBX1dEOfdNMY8YzjVYYu/WlhX1lkV8CGFJqgLdmfOoh07L3SakZJM6yUZBiam2gnHTUZ0LyHO2/bRibkyTSxT8664YiuwICumsw/sCgYEAq+SSx+q4xG74JHDQ9MXEnpBcpuDZaQaA+7+Rx04FeqGzCLe0UVCm4ZsyzZo9celWX+vuWqzP8Ut7wsknt6b3hM79eSxUHdae6prGttZcyHF73CeKax8EcdBeLF+acw+ln2C8zGrqJM4qTNIIc7zD6PTm3HANcEG2dD5QwrqvMCUCgYEArjk/+e+MsWyL7eIC5OeCAslc314pAbgEMJ7TUHCvNCS+zCdnt3fGew8AnAB6Foye7cXaqbhTrfEeQ5j3rEIAQALaZzH2h8bopWLb9HEwekCZ9EsmMf9vqyhPOSoCUemgjuIbZavgwkWZTU1tmKOOuLKrx+w37tbHzte3RVcRZ80CgYAPp8QfVcqvU0tPC/S8xg35IY9o7Ri7vjV6/e/eVfOjcsjPB4Ellx8/v9U3DDVE+ijUmak3IsMMxxnqC4HxxgYz9nhuEUJquve588MEdu3gM3E5NLe6063su+pUgIyQnRFIbcIzUgTq6fyhq3u3lVWqVoQ+nNOmF+p/7oGP7BpOEQ==
559b6d7a-2415-4898-9491-9c1f233cfa40	02bb964e-d4a8-482b-9e3c-2239b4c658da	keyUse	ENC
adda8b8d-2248-453b-8958-b835d98b0599	02bb964e-d4a8-482b-9e3c-2239b4c658da	algorithm	RSA-OAEP
2a579aad-2bf2-4adf-9682-8ec52fe05fa7	c158a762-74dd-49fe-9277-1daebce2a2a9	priority	100
20b2def7-2c26-4a41-ad7f-67337e4a4bfb	c158a762-74dd-49fe-9277-1daebce2a2a9	algorithm	HS256
286c669d-4764-4756-8b7c-6a4af481b127	c158a762-74dd-49fe-9277-1daebce2a2a9	kid	74a5361f-6919-43ef-8d58-5c660327fba2
f5b058a7-97b5-4813-8b6d-7942c230034a	c158a762-74dd-49fe-9277-1daebce2a2a9	secret	gzcWCvHJMpuVao4uPbj2QNGpnGR0zusnJYllaBNDXuEau0C3Xc1ESgbmIGx2TmCzGGmt1rxL0q5CcwTTg8umXg
44ed359c-bbde-4d5a-915f-ce12a22beb5c	9ed0617a-d3f4-4d4f-8e97-185911a9f994	kid	6ea1e313-1213-48d0-b9d3-d8b75cc39f9f
d9539f0c-80d7-424a-ae63-a5306e5965d4	9ed0617a-d3f4-4d4f-8e97-185911a9f994	priority	100
de3491f3-4db5-4032-80cf-c8678e60a83c	9ed0617a-d3f4-4d4f-8e97-185911a9f994	secret	H11l_v1hju-ZJsUDrtO6Wg
d1b9d47a-4e2b-4ed1-b33e-61992bc327b9	afa59a8d-39fd-480e-b9b8-8f2cdccad7e6	certificate	MIICmzCCAYMCBgGJMIBvAzANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjMwNzA3MTMxNjEwWhcNMzMwNzA3MTMxNzUwWjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC6yJvz/x/wT4xpIYpKtx1mCmJ493TNimJVkn6PMRsyR3ZtCeAWKWyeenBPC0hnKdZ2Y2qTtTa6aEQ/RcUvAKvCmY/V6GO6VRk2ZVlh3gs1PBDcmv5KzC/Z4jAaWVR+XzIhqrnboVgqukYqV0t9laPv0rPPHh3qmQ1tX6E+fwRIebia0ZJTSqErgIEgfZrqMY6588yciQwPjRXyBrhXaNojpfjLgu8kubczFTWNOntcck8Q3uOvUoF2796dbdwcol9UT2pTre7Zu8l5Er6tZfO+qZCEPSMdVJUUUVaAI9gjRq9Yf1n38j2AH2j9/Z5GJ+SwHMcfbNogcjEWC8BzvlFFAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAF3obn8N0DlHEMbswkAbomDF1K3DJla9DYaEfDeraf7RB8c/zdjvfFxN6gbm+tB+DBx0Bu3Y0M4/I6ztu6TQBWmlmaR3Jv+vgJNJ5tsaUHwYmCFFlq6Fh9Xx/M9pR30n1BUUtJ5ddinvpoUKkcJQfDH3okoYRUOrZhaYtgluILlQQ25DBp+G3FJX8tkm4nOiB21VV1/yGRANanqWkIhvR/VTXuIV+/ZS4Vy1JrBtnbqIe1dsTCgbORbbnPrkc45LrN+vilrVNTZ34igfJu091ZMfiCADl1rf2LIqAkZAdbZCFNU3iKzPImkXq6pcKomxtklyBCQ3iNWuPksGZnstFEA=
bd6e8e9a-cca2-4623-aa7e-6f0c62912a0c	afa59a8d-39fd-480e-b9b8-8f2cdccad7e6	privateKey	MIIEowIBAAKCAQEAusib8/8f8E+MaSGKSrcdZgpiePd0zYpiVZJ+jzEbMkd2bQngFilsnnpwTwtIZynWdmNqk7U2umhEP0XFLwCrwpmP1ehjulUZNmVZYd4LNTwQ3Jr+Sswv2eIwGllUfl8yIaq526FYKrpGKldLfZWj79Kzzx4d6pkNbV+hPn8ESHm4mtGSU0qhK4CBIH2a6jGOufPMnIkMD40V8ga4V2jaI6X4y4LvJLm3MxU1jTp7XHJPEN7jr1KBdu/enW3cHKJfVE9qU63u2bvJeRK+rWXzvqmQhD0jHVSVFFFWgCPYI0avWH9Z9/I9gB9o/f2eRifksBzHH2zaIHIxFgvAc75RRQIDAQABAoIBAAmJKVvCbXfVeoEkMGJnyS1G9XJgi8rcjZr5y31K+qz39LCqEucpaT1erzInN3nmKxKd47iJGrNXPw4N5VG6J+AGT/oR5FmEc7DmaV2eOkCXAZ4JnwGO6Bh9vDVJfzn5E971JN+fc+1b14OHiQ1EdlCi7Kwec6o2SHcKLU9lU6t8I6sIeeRd28PLCb8JjVm6vVbeNe88gd57gc3V2nYSoWuFnKXeFbHRtbgfwsHL3LrvpiWqgTfZMWv4rdIRrPoJ7Lcp5fULWnPtnbAhGVQmUT9WE9gLGNknJDUb3Rekch3PH8Lsnk/MKo8x3OiU7jlwA2AQlpZeXsOc/4QzcYYIZeECgYEA6Bpxc5GL23gMM3irwp0cifWzbG2hCcFXh4+9Rt93TnS/EjNDw3sQz9TNNsbZm5F4gUaXJpooQS/zkMrcMERXTO+DQy/FA7wq1HEe26TgbsUg467bc2dgp00HUDsrawXL/tVVfIM/OGetddkHcyczqYlQVAnQMglJlzc9jn9L4rECgYEAzgOscpoHS+58icn/i2jPqsDk0ULHVHFtbVRf/e07JtpSGGgDUeAoOzoAuDm5urZTlelYfbcwMsxkIqm2GcpgGzLgcfLuMrKLcHdVcblRwOKuwIoFThyo4VNxY0iJwXoRMrVaQRhWQj11OBzGNabMLZPIE5/58P713Os3ZWyq9NUCgYArf1knqW0mcjcHJmQ6EquYhz1a4qi9ZUh8FUoJkDORtntgc88NQXEDIgRbcaSybO7Ce3I0P8uve8cPqZTeTtB1kKVu3/LyIj98lL6NtzaAS91ADjL+S69nax4lwRD/+5Qha+WbchVVAskVPtkQkZYy/ZLaTQSBfBAYkLeujtiv4QKBgFWhr0d/gLLuMXPws7jV2yQFw9a7pDEUaMC+Bpx8xE6VBvTAH0kkHHTp2iy5SdszODEi6jZvM6iZzrGdy2SS+zmy/xo+OQZ3soAQCkMYHcRINQ0xEZ1zSjtGvOXg2+nA/G8QdLCEFi64bwXg5/6bE1mKiOqnX3Pt9nJajw8oiTL1AoGBAME4ZhXJjIo/g4r0fYB5UZyTz0vAfFWd0JvA9z6XBemc44ei6rWplhi0aGpyyXGMQUJhlz2l5OzI/E8WWPVs+WuUzjAh+DRJeouyGxeGyBJomVp4f+yUOwZUEzhmVP9tujWxvs9KFKEU0Rn40k4Jl6Zrg8znI34s9SGhNkYwTKGl
8022b055-f96f-4526-9846-019cde20f244	afa59a8d-39fd-480e-b9b8-8f2cdccad7e6	priority	100
fdf6b055-1bd2-4c45-b2e6-05fc225484ee	afa59a8d-39fd-480e-b9b8-8f2cdccad7e6	keyUse	SIG
a2af01c9-176a-4fc9-9381-e283a243e7c5	67e67986-c2cb-48db-8fbf-7a03ad04a32b	privateKey	MIIEogIBAAKCAQEAsYEWZMlW0A31LhQgCcQ4+iM3dkytzg7CcabyvMd56vSYG107XbixGh71P1PXkG5c5jaNcQnwA+9ju0Mo3Bd1PLi+4kwpuN6vL47npdNLhxtwe9/zp6DtepSBR1gJ/trtWAVitshBNFp2WPqQDjWbQD7rPiicH4jn0aP/o+Uxwo8JmucKej1iqtiN5SonUk17xkzQKkwbEjxH1ELLsj4EfAW3PGwEY6YAr4nBYgug0vETWZgqAVfLdLRawqwkcaqwAnyvdkdJR6S+Z1tmKrYh1rXeo1JM09OpsH2vCJYYdgdn0AkCu1wyhzN2sZ4UwgmVqUz+69hIRAP1kTxt3obatwIDAQABAoIBAEqMMF97v535frMveJUhd9x11eE1KvmTcU5SEzf9ftKSjx9O9JPT8W1K+yzxhWL/NrzoxFZpGghNDdGjzxFAONibrm9UFWGzBFgw6FDYgKvpdkBQOgB4scP9gp3395q1T2DcQi0JxXi7VWDhOob9NIqy4hFk9My5rsJ44fBvXYqb3DZ9+G9k7WqmHYInnsVvL47c4cqgIdFD4rdgSJz8M5fb6y403D4Q7v23V82gcR3L+LDUZRRIDv+4eJ454kIn88RGb+0DLypw1cxQSYewiRAr9KVcED8yer3P6iWLt76wqzxjulbuZybjhkaAutyAsENudyEP3vn0r96K9IV7GuECgYEA64iag9BrRFsUryPSLVdyFRxfpbsY6E3mKLFot/VyWE6HDTAMDSvvg7dawY6Z0Opr4njB1olMIGWCHOKFVYWzQz7eSS5jwFFCgUeoVo9fPdlHJEdahyPzHyxNVwsI0tScjJKU5JCAUWPig7En9R80j+HJHZs8/NVBj8Bnn9XC550CgYEAwO2h/kxjnYQA9Ry+Pcr1GYVjW0AegkI38w5vrI8tESYFdoBNRD1bXbGMhAohzFpkKv4bSMj9nKBVZW95lRtE8JzU8EZyNdV1UnfacVd11lReWcQFQyU65CzPNGjxMIz9FkXVh4qT3ttDuyPQeqmbf4vtJLINjCaDNWIpHhfMnWMCgYB841v61MJr5lebXkUNobZuFzNoL0LPuq51mUxLbqwIwuq9RWK+gTNpBgnrY++PZR17Ykh1tytUaj6JjlrgtBoPaAB5kU13Jh87aYGLFE6N/u3IAMWxrpA1UUpZAxLUp8Oyje7BGxXPEkWDSqZDRR6bxD7dofi+n106Ge1YRQIpyQKBgApHny4Rm+00r2hgE7LvMYgel2CxVe7S4HBPAJxNNLWJNRlPVM6iBlBDuZz/fTWKS3QO/h0uuHS0BljVS8EqJs47TQ1Qc51ytkGiqT0Iz/qPnEdkLnOZdD3cNV4xiUhw+rtJFUuXkrF5NW6vRdiDWQm+xvABnL8u/ibGCDLWSczJAoGAOahG0XWBtGvR0Pf4WnxOEOAeB3MmXSdXBIMHl5c5kcgXf3WxiSD0dy7xkwYrfLnEJcpsnIu4mNU+0QS/OsFf8+VxaT3x/PBKfJisr1t9y7KyHIj9jrzgkQH+dkirORDu61PHsY73zR94XOl88NOkNBt/8zaNEME/kIadK3xZwMM=
4ac9d8af-05eb-494a-b1f0-283ccb692dd7	67e67986-c2cb-48db-8fbf-7a03ad04a32b	algorithm	RSA-OAEP
f7af0b57-c7ca-4f83-a676-fd09e148b21d	67e67986-c2cb-48db-8fbf-7a03ad04a32b	certificate	MIICnTCCAYUCBgGJP15aBDANBgkqhkiG9w0BAQsFADASMRAwDgYDVQQDDAdteXJlYWxtMB4XDTIzMDcxMDEwMzMxNVoXDTMzMDcxMDEwMzQ1NVowEjEQMA4GA1UEAwwHbXlyZWFsbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBALGBFmTJVtAN9S4UIAnEOPojN3ZMrc4OwnGm8rzHeer0mBtdO124sRoe9T9T15BuXOY2jXEJ8APvY7tDKNwXdTy4vuJMKbjery+O56XTS4cbcHvf86eg7XqUgUdYCf7a7VgFYrbIQTRadlj6kA41m0A+6z4onB+I59Gj/6PlMcKPCZrnCno9YqrYjeUqJ1JNe8ZM0CpMGxI8R9RCy7I+BHwFtzxsBGOmAK+JwWILoNLxE1mYKgFXy3S0WsKsJHGqsAJ8r3ZHSUekvmdbZiq2Ida13qNSTNPTqbB9rwiWGHYHZ9AJArtcMoczdrGeFMIJlalM/uvYSEQD9ZE8bd6G2rcCAwEAATANBgkqhkiG9w0BAQsFAAOCAQEAdscOAqXFvYWbcD8VHOjej+AtqqSHYN+WThIqOWjLMXhl9W6LveCEMqvh10I/5Iu95OI5/v/BPLyakLuEfnS99Dfg/kIugZRRJ+H/nIXhstpUW/mYQYTocT9u0kr3nG6SZ9lx8kxZlwgTpQYs/ztaZrzPiPZMBAAF055DjJ6+Jz1MsMkZrIOS0ALXYxRG1hRqv6SMt05ChBU8Yj14uFe0q71Fs4xbv9clwzXAnkzeMM67qLiq0wHDHLU+skuA3vWVniVfkZHIDlCDInCpbgdqD1u/fSWU/zN4YZGtpQRxApsjFa+IXKH0aBOAAb35zLW4wZPvZ8M/kLUMx3TX1Ge0SA==
128cf0a1-cfd0-4069-ab99-2fa566c3baf0	67e67986-c2cb-48db-8fbf-7a03ad04a32b	priority	100
f2879279-5c42-4caf-b811-ab8ae9996f84	67e67986-c2cb-48db-8fbf-7a03ad04a32b	keyUse	ENC
da2d1288-8760-4888-aefd-cb2287dc49ce	2df1f913-f14d-4655-b9a9-8b47123418c7	privateKey	MIIEowIBAAKCAQEAzPNYcf8wPxjq6GPKI7yGtmqQoLfm8k5/Zf4Y8CMIFVUVZks+yEWiU7MMTZWZJhc7PZvDTwPN/hh6rgpfa+HSkhN/fcjNm/DfivODUasu9b+xkFejcbU4csFcpXHzFK79LfQyGtGDanUGqtY/1QtQeLLgNes5wAWZLSsHCXRScIYgp38+QpxcODsjZG3UZhILZa+g6/LCe9qgy2MtQGhoGFgiuk753YDpxL+d/jiB4iyfcAO4JaCSoWoysJHtZSH+p/n4LOTzYEzvRSIvLxzQMGxhFfBB1f3cqWTyVsOK7ePjTmfy6qPREK89Ok+LetsJD6/3sNam5cV+BICB1ZEFrwIDAQABAoIBAC2aZg8zh5I6oqZj8eoCvHzheF3ynaZD1jAlGnpwaQ+KF5Fj48vfRq/WEsI+q82gdLOQMaSmxZKo8r9AGpxgKqELSp577FgrACqkZY9qBjBzX3itL3aRKsbKBKnhkYOELlynzfBOty2cbYfc1WY7tsOslZwZw4dZF4zH2rB9XAyiPbkBCLGsaDuqO37CKkP4Ad8qCZeMIBaFKCWusNDrurcyzI61eosqKDpurB2l2n1amUFx9kTUmCfdncdUPmn3qmxRHFZqYhEPyT7hZEJVW6O+SmeKl7Y9+rdXx30FzRMFsEqm+GQ93S2FYYRU1tgtINVogjz1UdJc9qkEtWhPFYkCgYEA5h9wzFYoANrGMgC5zsbCo8enfKiZu4Vg98ju6+Yb2PH8TY2h4mNVVO3dfi3XHY1o5kW/kzCbeCJCfP6jn0oW4IvS3wyVzjzxWTR/X57mYFr+RjOW1bbF75HNUOSF8omTY2FZ4I9cfe6dmeU1JsFZD61uoAJYX4NIP/zJiyyx8qcCgYEA4/9FF1WwG6NaknNcFkwnnlWJ8OLTMSwDusdCslzp+9y7SPyS8owSt1n86a03vVUxbuNNy8emk8lxvyQH9TgxTWL82392twqFBSJmRxflOf+m29HbLYXO5wDrc4rrEy936iNmy50h/q02CcpHRT0sQGKyZ59VUUPgZydaBLHeXbkCgYEAiZ653WmU6NXs+1BVzmQtWLb44eMOdQeR8v1WbPsjIj2tLlAKRRI0oOLTuDb/06uS1UtXA1ZpU5Hhg1DhV0x+m/DivgOPv1PQ3hE4L14e1fb049TMWqjAfMIMMFlKBb7ixuccUeBKZwGBfNyHSdMNSQPmCYj9grlHRwUNHs8u6DcCgYAr+vf28l6QVkiIa5xd6L7TuihrwTWADL+DbiCdi3LPVNsDz0UBaKfLmp5A7VsNOLvaahp9rruhUoCQoICwevB3vxqLtODPmkXioaodGKztLTWgvbCL7X3l7bV9ilSiVMvK7J1NtbfzCrKb3Ns2rgA1Q1SqzH+Gt5M4Es04jp8YcQKBgEuqpYQuAt9oyHH8t6OCxHBKqUo8k/pp4d0oMN4hW5sRpUxOyNv48qEg4EGOCMPx6g0GhnXGqYOLcHUeOlUdUCJgRO70uy8QopuRE/3UEZAgkL4BSpNjN30dCTQ0VsrBsbWxdvR2JMbMR5BYNKAW4Vi2nVvd0UMkjswtrOGxXyxw
afa4c1cb-e2f5-429e-94ae-d484c7baa27b	2df1f913-f14d-4655-b9a9-8b47123418c7	priority	100
44e6b2da-4c36-418f-9da6-2d7924a5df77	2df1f913-f14d-4655-b9a9-8b47123418c7	keyUse	SIG
b01ea3e8-59fc-4c65-ab81-7d48a48557ab	2df1f913-f14d-4655-b9a9-8b47123418c7	certificate	MIICnTCCAYUCBgGJP15ZeDANBgkqhkiG9w0BAQsFADASMRAwDgYDVQQDDAdteXJlYWxtMB4XDTIzMDcxMDEwMzMxNVoXDTMzMDcxMDEwMzQ1NVowEjEQMA4GA1UEAwwHbXlyZWFsbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMzzWHH/MD8Y6uhjyiO8hrZqkKC35vJOf2X+GPAjCBVVFWZLPshFolOzDE2VmSYXOz2bw08Dzf4Yeq4KX2vh0pITf33IzZvw34rzg1GrLvW/sZBXo3G1OHLBXKVx8xSu/S30MhrRg2p1BqrWP9ULUHiy4DXrOcAFmS0rBwl0UnCGIKd/PkKcXDg7I2Rt1GYSC2WvoOvywnvaoMtjLUBoaBhYIrpO+d2A6cS/nf44geIsn3ADuCWgkqFqMrCR7WUh/qf5+Czk82BM70UiLy8c0DBsYRXwQdX93Klk8lbDiu3j405n8uqj0RCvPTpPi3rbCQ+v97DWpuXFfgSAgdWRBa8CAwEAATANBgkqhkiG9w0BAQsFAAOCAQEAqqss90KxSZ8WT8SsL8VH9uY3ybl/hqC4y99QHkJzJOdIdSV+FLYHgB/eIosS9Q7+yFOKoaRgVPVriyPdryaiwXIUNtAb0wo9PMx5hTB5COR7P/QHlFaM9v6pC7nY2YUsyyCcgjigh8rfneg8AWGko1stR71TllTvbDaE+wpDbrOwcOERJkFLtlmYihdT7jKGTHlLETSnm0531rg/KlPVuJ0ExoMYDyn0g2pzss92xtf+kJ8nDuij/ISiW5c1YHA8Gizz/+/HMgywABRtz0eFuWms5GLojDPPq5YAxGfMs/WByEwYqtsUytQI5qOzhpcsf0UxNOKCTnaOtc16Y+vRYg==
60aae7dc-0402-4f75-ba95-525d8a10f328	08fe58a4-61fa-4526-b41b-321c4b57bf5b	kid	c4da64ce-5496-414d-bdfb-760490de6ac8
262d2ecd-f982-4172-a9cf-fe462a46a205	08fe58a4-61fa-4526-b41b-321c4b57bf5b	secret	c7ETNowII7XZ7cKzMkDzog
ca83cf55-8705-494c-9511-4f7beb243bc2	08fe58a4-61fa-4526-b41b-321c4b57bf5b	priority	100
d771b6dd-2d2e-4d59-a645-3b8672b6c347	db00215d-17d2-4b11-8d8e-b99217fad0da	kid	63afb2d8-4cc0-43fb-8f38-8215dfe8c322
0147350d-744d-4578-8921-cb008c855370	db00215d-17d2-4b11-8d8e-b99217fad0da	algorithm	HS256
c25ece18-4c6a-4972-ab99-ec0739914c93	db00215d-17d2-4b11-8d8e-b99217fad0da	priority	100
62cbed82-d522-4edd-9cd1-a2deefc437ec	db00215d-17d2-4b11-8d8e-b99217fad0da	secret	NnYy6vc72hVnVYi6QsssrH5PpAwBu2rcB44goXmF8Gjij-E79FDmuLKbLRy8KDrpFvwILPKhfx_S2icH0484Ew
30bd18c5-7881-4814-b77a-896e131eb2b5	041de51e-88af-4607-b489-30f30197f346	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
9b3afd84-1c61-4b10-8334-21cc5f6acad6	041de51e-88af-4607-b489-30f30197f346	allowed-protocol-mapper-types	saml-role-list-mapper
92a2a9c9-0d13-41a2-b508-988f57619695	041de51e-88af-4607-b489-30f30197f346	allowed-protocol-mapper-types	oidc-full-name-mapper
39fcf646-b189-41e9-930e-f7ec59b1ada9	041de51e-88af-4607-b489-30f30197f346	allowed-protocol-mapper-types	saml-user-property-mapper
27bfe4b5-d60b-4875-921b-a8bc705f2e08	041de51e-88af-4607-b489-30f30197f346	allowed-protocol-mapper-types	saml-user-attribute-mapper
c10a53c6-607b-4f8e-bbe4-15ba77172e91	041de51e-88af-4607-b489-30f30197f346	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
00c6c5fd-0eb0-4c08-8b21-089c4bbd809a	041de51e-88af-4607-b489-30f30197f346	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
88d154a9-17a4-4251-aadc-8d6007337bd9	041de51e-88af-4607-b489-30f30197f346	allowed-protocol-mapper-types	oidc-address-mapper
73eb437f-e146-49db-b6bd-e23c81206678	9ec19fe8-95eb-464f-b200-816465b262f7	host-sending-registration-request-must-match	true
60a8c86a-c927-461b-beb9-6c9e98db2101	9ec19fe8-95eb-464f-b200-816465b262f7	client-uris-must-match	true
976338a8-ac05-4aa9-99bf-dfd769bd4860	798ef122-301a-4808-bdd0-38c9c0c596e9	allow-default-scopes	true
f1ef3677-c4e0-407e-9c5c-c2f563a16e6e	b2c273cd-1a1b-495e-b4c2-e7498bacf33c	allowed-protocol-mapper-types	saml-user-property-mapper
952e3bc4-62b7-4e94-84ca-ec656a3bbd54	b2c273cd-1a1b-495e-b4c2-e7498bacf33c	allowed-protocol-mapper-types	oidc-address-mapper
41f664be-c795-4da5-887d-a2832b23199a	b2c273cd-1a1b-495e-b4c2-e7498bacf33c	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
a1d85968-9d23-4a65-80c5-b68651ec775e	b2c273cd-1a1b-495e-b4c2-e7498bacf33c	allowed-protocol-mapper-types	oidc-full-name-mapper
e6ab8217-9a3e-49f5-9a45-ecaef688b4be	b2c273cd-1a1b-495e-b4c2-e7498bacf33c	allowed-protocol-mapper-types	saml-user-attribute-mapper
fb90bca8-7a29-4bca-a304-b7ef21c48c9c	b2c273cd-1a1b-495e-b4c2-e7498bacf33c	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
65ef5ae6-dc51-4475-8bc4-4724921a8a47	b2c273cd-1a1b-495e-b4c2-e7498bacf33c	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
f25763c4-3a48-46ba-a579-9e9316ff4287	b2c273cd-1a1b-495e-b4c2-e7498bacf33c	allowed-protocol-mapper-types	saml-role-list-mapper
dd24b998-c341-4c7e-9108-5d9fc601fe11	187a941a-19bb-48e0-9bec-d59a8d086f81	max-clients	200
7b0e9ba5-77a6-4142-9b75-e079e4ec83b0	59957aaf-8949-4bdf-9d4f-b70e47052ea3	allow-default-scopes	true
\.


--
-- Data for Name: composite_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.composite_role (composite, child_role) FROM stdin;
a02f6e37-02bc-47f8-b0cf-0cdc7b73328f	3fa04ca6-ff11-446e-ae8a-06ce6aa9d76a
a02f6e37-02bc-47f8-b0cf-0cdc7b73328f	daef8909-9505-413a-b623-024c2e8611c4
a02f6e37-02bc-47f8-b0cf-0cdc7b73328f	a5d07b94-1b47-43d1-90cc-4731d0f3b844
a02f6e37-02bc-47f8-b0cf-0cdc7b73328f	7e195df3-b194-4700-a02d-3f00fdc512a4
a02f6e37-02bc-47f8-b0cf-0cdc7b73328f	78edf0a2-fa3b-43d5-8c1e-95e9c4c8c091
a02f6e37-02bc-47f8-b0cf-0cdc7b73328f	64ff60f4-7ade-4c02-aa35-3148976be20d
a02f6e37-02bc-47f8-b0cf-0cdc7b73328f	37518be7-f145-4f2a-ae80-c9aeac9cdd9f
a02f6e37-02bc-47f8-b0cf-0cdc7b73328f	a901dfe5-bd6b-4061-9004-4cf68775edba
a02f6e37-02bc-47f8-b0cf-0cdc7b73328f	533125be-3dd1-4151-b444-56c2934fa653
a02f6e37-02bc-47f8-b0cf-0cdc7b73328f	646593b1-e879-4ccd-8e9c-f6d573b8fbbd
a02f6e37-02bc-47f8-b0cf-0cdc7b73328f	2faead6e-87d8-4dfc-ad20-73cb39ae4ead
a02f6e37-02bc-47f8-b0cf-0cdc7b73328f	98da3826-75ef-45d3-93c3-ff9e51631c32
a02f6e37-02bc-47f8-b0cf-0cdc7b73328f	be623b3c-1636-4353-bc34-b016305f0247
a02f6e37-02bc-47f8-b0cf-0cdc7b73328f	6c80bd01-f59a-4139-95d3-f587b829cb52
a02f6e37-02bc-47f8-b0cf-0cdc7b73328f	694d6798-ab02-45c8-9364-32b42f57637d
a02f6e37-02bc-47f8-b0cf-0cdc7b73328f	b5177b2d-d33d-4bc5-9ca6-65c1a7bbf16d
a02f6e37-02bc-47f8-b0cf-0cdc7b73328f	7259e9b1-2ce1-45d0-a2a2-3b9b5bbd0190
a02f6e37-02bc-47f8-b0cf-0cdc7b73328f	5170dae2-35a5-4141-aece-442d3c97791f
78edf0a2-fa3b-43d5-8c1e-95e9c4c8c091	b5177b2d-d33d-4bc5-9ca6-65c1a7bbf16d
7e195df3-b194-4700-a02d-3f00fdc512a4	5170dae2-35a5-4141-aece-442d3c97791f
7e195df3-b194-4700-a02d-3f00fdc512a4	694d6798-ab02-45c8-9364-32b42f57637d
8347d92a-da11-4d52-bc3c-a1b8ade43860	b9f8088e-0386-45a7-88da-bea181202fa2
8347d92a-da11-4d52-bc3c-a1b8ade43860	ecab7f9f-e33a-4b2d-bafb-4fedc3ea0f0d
ecab7f9f-e33a-4b2d-bafb-4fedc3ea0f0d	bf02b4a4-946b-4180-a349-bdf422725cf3
fe97e251-542f-41e8-baad-5c7d7faccd34	5b7c12d3-d85f-4db6-932b-c8c8408240ef
a02f6e37-02bc-47f8-b0cf-0cdc7b73328f	527bbf55-8443-43b0-82a6-7f446db2d8a0
8347d92a-da11-4d52-bc3c-a1b8ade43860	d0239204-0da8-46cf-abb5-e0c94f5ade35
8347d92a-da11-4d52-bc3c-a1b8ade43860	cabe88de-574a-4c8f-b49d-d08fa2ae19c4
a02f6e37-02bc-47f8-b0cf-0cdc7b73328f	dd0509ee-b187-42dc-909c-b9a225ffe448
a02f6e37-02bc-47f8-b0cf-0cdc7b73328f	2c4d25c1-527d-4066-bc3b-6fbc7a564861
a02f6e37-02bc-47f8-b0cf-0cdc7b73328f	88ea6abb-e897-4153-a9d6-3c0449a0e42b
a02f6e37-02bc-47f8-b0cf-0cdc7b73328f	8acacfc5-5418-4eb7-8e86-c64417db1547
a02f6e37-02bc-47f8-b0cf-0cdc7b73328f	fe3f25aa-0146-4c35-a62f-22d328e3bb40
a02f6e37-02bc-47f8-b0cf-0cdc7b73328f	8c2249f1-50b4-413b-91ad-d5d7a8f0956f
a02f6e37-02bc-47f8-b0cf-0cdc7b73328f	10cd4f64-daea-49fa-b384-578b218fa999
a02f6e37-02bc-47f8-b0cf-0cdc7b73328f	432dc261-01f6-4267-ae0d-8d0d4d905714
a02f6e37-02bc-47f8-b0cf-0cdc7b73328f	fe483fb0-109c-4da6-b4e0-b78147907288
a02f6e37-02bc-47f8-b0cf-0cdc7b73328f	0837bbf1-4d84-45bf-9edd-e6149c15bda9
a02f6e37-02bc-47f8-b0cf-0cdc7b73328f	99be3cec-3467-4171-81a7-89d50d7113bc
a02f6e37-02bc-47f8-b0cf-0cdc7b73328f	604d14c3-2ef7-4363-bdb1-76f3d049af05
a02f6e37-02bc-47f8-b0cf-0cdc7b73328f	5b07ed4a-e7bf-4776-a7a6-409a46c6a577
a02f6e37-02bc-47f8-b0cf-0cdc7b73328f	7b3e1df7-7978-450c-80b8-f02092b664a7
a02f6e37-02bc-47f8-b0cf-0cdc7b73328f	57ada925-baab-4163-89cc-1893ed954c5c
a02f6e37-02bc-47f8-b0cf-0cdc7b73328f	967d4437-e039-4a19-9262-71d5c0fb1557
a02f6e37-02bc-47f8-b0cf-0cdc7b73328f	60ce9b8e-03bb-45d1-87bb-89cdeb949c8f
88ea6abb-e897-4153-a9d6-3c0449a0e42b	7b3e1df7-7978-450c-80b8-f02092b664a7
88ea6abb-e897-4153-a9d6-3c0449a0e42b	60ce9b8e-03bb-45d1-87bb-89cdeb949c8f
8acacfc5-5418-4eb7-8e86-c64417db1547	57ada925-baab-4163-89cc-1893ed954c5c
4e371f9d-5cfd-4d26-a859-c5f4e8dfb3cd	293bf478-205f-4801-8ee2-608419492356
4e371f9d-5cfd-4d26-a859-c5f4e8dfb3cd	0bc576d4-8220-4d73-8541-c83f5a0513e0
4e371f9d-5cfd-4d26-a859-c5f4e8dfb3cd	e936180d-cc11-4914-80cd-3ad1dd8cef3a
4e371f9d-5cfd-4d26-a859-c5f4e8dfb3cd	b14d2618-7729-42a4-94a1-d0f6d8fd9041
4e371f9d-5cfd-4d26-a859-c5f4e8dfb3cd	fff1c008-67de-45d6-8135-e4ab7a6aaa12
4e371f9d-5cfd-4d26-a859-c5f4e8dfb3cd	41381315-c726-49a9-8be7-46a9e5c36677
4e371f9d-5cfd-4d26-a859-c5f4e8dfb3cd	e222695a-8b2b-483e-9b10-10d52f2fde5f
4e371f9d-5cfd-4d26-a859-c5f4e8dfb3cd	bd7b1158-3643-4e3b-8156-1133be99c5bf
4e371f9d-5cfd-4d26-a859-c5f4e8dfb3cd	da5493b9-048a-4b4a-802d-c79fd9ceccf8
4e371f9d-5cfd-4d26-a859-c5f4e8dfb3cd	80f078f8-2f78-4a17-8eba-3dbac0fd638b
4e371f9d-5cfd-4d26-a859-c5f4e8dfb3cd	5cbdd13a-8411-45bc-83c6-ec275dfa5bea
4e371f9d-5cfd-4d26-a859-c5f4e8dfb3cd	313cb287-67ca-41ae-8d99-75d6058d405e
4e371f9d-5cfd-4d26-a859-c5f4e8dfb3cd	53ffcc3a-03e9-4181-bb26-a8aa9a01b1bd
4e371f9d-5cfd-4d26-a859-c5f4e8dfb3cd	f1f3f5b2-c539-4bc1-8fe7-f5d0fccc1848
4e371f9d-5cfd-4d26-a859-c5f4e8dfb3cd	b9b6cb90-8875-41c8-a02b-01c6fbb937f8
4e371f9d-5cfd-4d26-a859-c5f4e8dfb3cd	609d067a-af4e-41a1-a7cf-971359d1d012
4e371f9d-5cfd-4d26-a859-c5f4e8dfb3cd	9b94336d-9f3e-421c-9f60-4558397ae2a1
60c243a8-5856-494c-b920-08ef509d1efa	b07f457a-1337-4789-b365-809989adab9c
b14d2618-7729-42a4-94a1-d0f6d8fd9041	b9b6cb90-8875-41c8-a02b-01c6fbb937f8
e936180d-cc11-4914-80cd-3ad1dd8cef3a	f1f3f5b2-c539-4bc1-8fe7-f5d0fccc1848
e936180d-cc11-4914-80cd-3ad1dd8cef3a	9b94336d-9f3e-421c-9f60-4558397ae2a1
60c243a8-5856-494c-b920-08ef509d1efa	c4b0099a-ce9f-47c3-8d5d-33e1102987d3
c4b0099a-ce9f-47c3-8d5d-33e1102987d3	ef525b77-8759-4f66-9ea3-5d7843431d41
bbb4a55e-0e09-4960-b26f-f804405ac64d	42046c56-d859-46d3-be58-a3332ea188ff
a02f6e37-02bc-47f8-b0cf-0cdc7b73328f	88cd3137-6617-427c-82f0-a7b55f18d5cb
4e371f9d-5cfd-4d26-a859-c5f4e8dfb3cd	e02f0e80-8a43-49e4-b8bf-7a77c5d27a2b
60c243a8-5856-494c-b920-08ef509d1efa	289d6130-e2f3-4ccf-b765-48103f137640
60c243a8-5856-494c-b920-08ef509d1efa	fd96c760-3bd5-463a-aec4-3e8ce3b3dab8
\.


--
-- Data for Name: credential; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.credential (id, salt, type, user_id, created_date, user_label, secret_data, credential_data, priority) FROM stdin;
2f7635b7-3dd5-420c-971c-05e66a363193	\N	password	71940903-dc03-4753-bac3-c5e8de99ada8	1688984885368	My password	{"value":"Ku7ZyAnzUT0eSst922wxCsKDZOMyOwXnH28RNZHTL9uPmr7pPCASicIXKc3HrzrXMTMY4oSjCY1U4tNOrPK9iQ==","salt":"mivFUwCqEe9aCWJ5wW9lPQ==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
d6d78638-6f24-4c4e-9d5a-b2bb4ff9b5e6	\N	password	0f45f5fe-f12b-42ac-b174-cb6b45d93e6c	1688984915513	My password	{"value":"jY2UjEQEROCfV+fzip4AamErz85SP8H3oe4QN7/CUPS2y+vfmNFO4cc01V7e7en/Io6hPO8LJ1DOJz83+KYc1g==","salt":"EEWMRA3vpDbMBqLYXxBTdw==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
f7bc49f0-4710-4c02-9ec5-7dc6213f10c1	\N	password	c7529a35-ec12-461a-a437-e22b1d3a682b	1688735873526	\N	{"value":"/zkrxdluM3Ari/WAiOVzlkzgB2YSA8ApKY59LAMwLp8=","salt":"fJ9Nq+76plJmN7ub6O9XqA==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
36ee49ae-bd92-443f-98f8-2e50f1d4d9f6	\N	password	23583b7b-3c63-4cd1-a865-57d027ed2f48	1688985319177	My password	{"value":"YIncVYnKY6Ueg0HMfiJru/5xZZSHCZzD3NzKe2MBpYI=","salt":"x9cMHSNNosBA6eN7PhKRzg==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
1f729318-a57c-4bdc-97b4-712ea38a27d2	\N	password	109ce5c2-fe9b-4a45-86a5-d0499dd64e3c	1688985414627	My password	{"value":"IYu6hhGF8lEHv2DsfhpM15ya7RY7cBMeiuDHhv2W1FY=","salt":"e1ztMFAytBxX83I7IOD/+g==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
d096edbf-226a-42da-912b-44a431419521	\N	password	2b2518fb-6697-4b48-8561-1d4896fc2dc1	1688985366058	My password	{"value":"Bg+3vCKWzj75UGG1B+EpFMK2+8h+Xo1Qp2Z+OgnrcgM=","salt":"jzTApeLw7yL8gZb7CX7xdQ==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
\.


--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/jpa-changelog-1.0.0.Final.xml	2023-07-07 13:17:35.797221	1	EXECUTED	8:bda77d94bf90182a1e30c24f1c155ec7	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.8.0	\N	\N	8735853635
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/db2-jpa-changelog-1.0.0.Final.xml	2023-07-07 13:17:35.816685	2	MARK_RAN	8:1ecb330f30986693d1cba9ab579fa219	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.8.0	\N	\N	8735853635
1.1.0.Beta1	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Beta1.xml	2023-07-07 13:17:36.021843	3	EXECUTED	8:cb7ace19bc6d959f305605d255d4c843	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...		\N	4.8.0	\N	\N	8735853635
1.1.0.Final	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Final.xml	2023-07-07 13:17:36.041725	4	EXECUTED	8:80230013e961310e6872e871be424a63	renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY		\N	4.8.0	\N	\N	8735853635
1.2.0.Beta1	psilva@redhat.com	META-INF/jpa-changelog-1.2.0.Beta1.xml	2023-07-07 13:17:36.555206	5	EXECUTED	8:67f4c20929126adc0c8e9bf48279d244	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.8.0	\N	\N	8735853635
1.2.0.Beta1	psilva@redhat.com	META-INF/db2-jpa-changelog-1.2.0.Beta1.xml	2023-07-07 13:17:36.569528	6	MARK_RAN	8:7311018b0b8179ce14628ab412bb6783	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.8.0	\N	\N	8735853635
1.2.0.RC1	bburke@redhat.com	META-INF/jpa-changelog-1.2.0.CR1.xml	2023-07-07 13:17:37.037064	7	EXECUTED	8:037ba1216c3640f8785ee6b8e7c8e3c1	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.8.0	\N	\N	8735853635
1.2.0.RC1	bburke@redhat.com	META-INF/db2-jpa-changelog-1.2.0.CR1.xml	2023-07-07 13:17:37.057641	8	MARK_RAN	8:7fe6ffe4af4df289b3157de32c624263	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.8.0	\N	\N	8735853635
1.2.0.Final	keycloak	META-INF/jpa-changelog-1.2.0.Final.xml	2023-07-07 13:17:37.070542	9	EXECUTED	8:9c136bc3187083a98745c7d03bc8a303	update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT		\N	4.8.0	\N	\N	8735853635
1.3.0	bburke@redhat.com	META-INF/jpa-changelog-1.3.0.xml	2023-07-07 13:17:37.544139	10	EXECUTED	8:b5f09474dca81fb56a97cf5b6553d331	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...		\N	4.8.0	\N	\N	8735853635
1.4.0	bburke@redhat.com	META-INF/jpa-changelog-1.4.0.xml	2023-07-07 13:17:37.777405	11	EXECUTED	8:ca924f31bd2a3b219fdcfe78c82dacf4	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.8.0	\N	\N	8735853635
1.4.0	bburke@redhat.com	META-INF/db2-jpa-changelog-1.4.0.xml	2023-07-07 13:17:37.786327	12	MARK_RAN	8:8acad7483e106416bcfa6f3b824a16cd	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.8.0	\N	\N	8735853635
1.5.0	bburke@redhat.com	META-INF/jpa-changelog-1.5.0.xml	2023-07-07 13:17:37.846234	13	EXECUTED	8:9b1266d17f4f87c78226f5055408fd5e	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.8.0	\N	\N	8735853635
1.6.1_from15	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2023-07-07 13:17:37.927016	14	EXECUTED	8:d80ec4ab6dbfe573550ff72396c7e910	addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...		\N	4.8.0	\N	\N	8735853635
1.6.1_from16-pre	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2023-07-07 13:17:37.931136	15	MARK_RAN	8:d86eb172171e7c20b9c849b584d147b2	delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION		\N	4.8.0	\N	\N	8735853635
1.6.1_from16	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2023-07-07 13:17:37.940559	16	MARK_RAN	8:5735f46f0fa60689deb0ecdc2a0dea22	dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...		\N	4.8.0	\N	\N	8735853635
1.6.1	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2023-07-07 13:17:37.948841	17	EXECUTED	8:d41d8cd98f00b204e9800998ecf8427e	empty		\N	4.8.0	\N	\N	8735853635
1.7.0	bburke@redhat.com	META-INF/jpa-changelog-1.7.0.xml	2023-07-07 13:17:38.161813	18	EXECUTED	8:5c1a8fd2014ac7fc43b90a700f117b23	createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...		\N	4.8.0	\N	\N	8735853635
1.8.0	mposolda@redhat.com	META-INF/jpa-changelog-1.8.0.xml	2023-07-07 13:17:38.408436	19	EXECUTED	8:1f6c2c2dfc362aff4ed75b3f0ef6b331	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.8.0	\N	\N	8735853635
1.8.0-2	keycloak	META-INF/jpa-changelog-1.8.0.xml	2023-07-07 13:17:38.434066	20	EXECUTED	8:dee9246280915712591f83a127665107	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.8.0	\N	\N	8735853635
authz-3.4.0.CR1-resource-server-pk-change-part1	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2023-07-07 13:17:40.359483	45	EXECUTED	8:a164ae073c56ffdbc98a615493609a52	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE		\N	4.8.0	\N	\N	8735853635
1.8.0	mposolda@redhat.com	META-INF/db2-jpa-changelog-1.8.0.xml	2023-07-07 13:17:38.442254	21	MARK_RAN	8:9eb2ee1fa8ad1c5e426421a6f8fdfa6a	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.8.0	\N	\N	8735853635
1.8.0-2	keycloak	META-INF/db2-jpa-changelog-1.8.0.xml	2023-07-07 13:17:38.455686	22	MARK_RAN	8:dee9246280915712591f83a127665107	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.8.0	\N	\N	8735853635
1.9.0	mposolda@redhat.com	META-INF/jpa-changelog-1.9.0.xml	2023-07-07 13:17:38.57549	23	EXECUTED	8:d9fa18ffa355320395b86270680dd4fe	update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...		\N	4.8.0	\N	\N	8735853635
1.9.1	keycloak	META-INF/jpa-changelog-1.9.1.xml	2023-07-07 13:17:38.585995	24	EXECUTED	8:90cff506fedb06141ffc1c71c4a1214c	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.8.0	\N	\N	8735853635
1.9.1	keycloak	META-INF/db2-jpa-changelog-1.9.1.xml	2023-07-07 13:17:38.593484	25	MARK_RAN	8:11a788aed4961d6d29c427c063af828c	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.8.0	\N	\N	8735853635
1.9.2	keycloak	META-INF/jpa-changelog-1.9.2.xml	2023-07-07 13:17:38.720219	26	EXECUTED	8:a4218e51e1faf380518cce2af5d39b43	createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...		\N	4.8.0	\N	\N	8735853635
authz-2.0.0	psilva@redhat.com	META-INF/jpa-changelog-authz-2.0.0.xml	2023-07-07 13:17:39.086719	27	EXECUTED	8:d9e9a1bfaa644da9952456050f07bbdc	createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...		\N	4.8.0	\N	\N	8735853635
authz-2.5.1	psilva@redhat.com	META-INF/jpa-changelog-authz-2.5.1.xml	2023-07-07 13:17:39.112272	28	EXECUTED	8:d1bf991a6163c0acbfe664b615314505	update tableName=RESOURCE_SERVER_POLICY		\N	4.8.0	\N	\N	8735853635
2.1.0-KEYCLOAK-5461	bburke@redhat.com	META-INF/jpa-changelog-2.1.0.xml	2023-07-07 13:17:39.405369	29	EXECUTED	8:88a743a1e87ec5e30bf603da68058a8c	createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...		\N	4.8.0	\N	\N	8735853635
2.2.0	bburke@redhat.com	META-INF/jpa-changelog-2.2.0.xml	2023-07-07 13:17:39.476989	30	EXECUTED	8:c5517863c875d325dea463d00ec26d7a	addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...		\N	4.8.0	\N	\N	8735853635
2.3.0	bburke@redhat.com	META-INF/jpa-changelog-2.3.0.xml	2023-07-07 13:17:39.543079	31	EXECUTED	8:ada8b4833b74a498f376d7136bc7d327	createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...		\N	4.8.0	\N	\N	8735853635
2.4.0	bburke@redhat.com	META-INF/jpa-changelog-2.4.0.xml	2023-07-07 13:17:39.552882	32	EXECUTED	8:b9b73c8ea7299457f99fcbb825c263ba	customChange		\N	4.8.0	\N	\N	8735853635
2.5.0	bburke@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2023-07-07 13:17:39.566844	33	EXECUTED	8:07724333e625ccfcfc5adc63d57314f3	customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION		\N	4.8.0	\N	\N	8735853635
2.5.0-unicode-oracle	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2023-07-07 13:17:39.573758	34	MARK_RAN	8:8b6fd445958882efe55deb26fc541a7b	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.8.0	\N	\N	8735853635
2.5.0-unicode-other-dbs	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2023-07-07 13:17:39.704017	35	EXECUTED	8:29b29cfebfd12600897680147277a9d7	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.8.0	\N	\N	8735853635
2.5.0-duplicate-email-support	slawomir@dabek.name	META-INF/jpa-changelog-2.5.0.xml	2023-07-07 13:17:39.718457	36	EXECUTED	8:73ad77ca8fd0410c7f9f15a471fa52bc	addColumn tableName=REALM		\N	4.8.0	\N	\N	8735853635
2.5.0-unique-group-names	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2023-07-07 13:17:39.739749	37	EXECUTED	8:64f27a6fdcad57f6f9153210f2ec1bdb	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.8.0	\N	\N	8735853635
2.5.1	bburke@redhat.com	META-INF/jpa-changelog-2.5.1.xml	2023-07-07 13:17:39.749028	38	EXECUTED	8:27180251182e6c31846c2ddab4bc5781	addColumn tableName=FED_USER_CONSENT		\N	4.8.0	\N	\N	8735853635
3.0.0	bburke@redhat.com	META-INF/jpa-changelog-3.0.0.xml	2023-07-07 13:17:39.758196	39	EXECUTED	8:d56f201bfcfa7a1413eb3e9bc02978f9	addColumn tableName=IDENTITY_PROVIDER		\N	4.8.0	\N	\N	8735853635
3.2.0-fix	keycloak	META-INF/jpa-changelog-3.2.0.xml	2023-07-07 13:17:39.764289	40	MARK_RAN	8:91f5522bf6afdc2077dfab57fbd3455c	addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS		\N	4.8.0	\N	\N	8735853635
3.2.0-fix-with-keycloak-5416	keycloak	META-INF/jpa-changelog-3.2.0.xml	2023-07-07 13:17:39.775841	41	MARK_RAN	8:0f01b554f256c22caeb7d8aee3a1cdc8	dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS		\N	4.8.0	\N	\N	8735853635
3.2.0-fix-offline-sessions	hmlnarik	META-INF/jpa-changelog-3.2.0.xml	2023-07-07 13:17:39.788517	42	EXECUTED	8:ab91cf9cee415867ade0e2df9651a947	customChange		\N	4.8.0	\N	\N	8735853635
3.2.0-fixed	keycloak	META-INF/jpa-changelog-3.2.0.xml	2023-07-07 13:17:40.33899	43	EXECUTED	8:ceac9b1889e97d602caf373eadb0d4b7	addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...		\N	4.8.0	\N	\N	8735853635
3.3.0	keycloak	META-INF/jpa-changelog-3.3.0.xml	2023-07-07 13:17:40.347624	44	EXECUTED	8:84b986e628fe8f7fd8fd3c275c5259f2	addColumn tableName=USER_ENTITY		\N	4.8.0	\N	\N	8735853635
authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2023-07-07 13:17:40.371647	46	EXECUTED	8:70a2b4f1f4bd4dbf487114bdb1810e64	customChange		\N	4.8.0	\N	\N	8735853635
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2023-07-07 13:17:40.378114	47	MARK_RAN	8:7be68b71d2f5b94b8df2e824f2860fa2	dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE		\N	4.8.0	\N	\N	8735853635
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2023-07-07 13:17:40.557616	48	EXECUTED	8:bab7c631093c3861d6cf6144cd944982	addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...		\N	4.8.0	\N	\N	8735853635
authn-3.4.0.CR1-refresh-token-max-reuse	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2023-07-07 13:17:40.570372	49	EXECUTED	8:fa809ac11877d74d76fe40869916daad	addColumn tableName=REALM		\N	4.8.0	\N	\N	8735853635
3.4.0	keycloak	META-INF/jpa-changelog-3.4.0.xml	2023-07-07 13:17:40.753505	50	EXECUTED	8:fac23540a40208f5f5e326f6ceb4d291	addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...		\N	4.8.0	\N	\N	8735853635
3.4.0-KEYCLOAK-5230	hmlnarik@redhat.com	META-INF/jpa-changelog-3.4.0.xml	2023-07-07 13:17:40.873133	51	EXECUTED	8:2612d1b8a97e2b5588c346e817307593	createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...		\N	4.8.0	\N	\N	8735853635
3.4.1	psilva@redhat.com	META-INF/jpa-changelog-3.4.1.xml	2023-07-07 13:17:40.882123	52	EXECUTED	8:9842f155c5db2206c88bcb5d1046e941	modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	8735853635
3.4.2	keycloak	META-INF/jpa-changelog-3.4.2.xml	2023-07-07 13:17:40.891086	53	EXECUTED	8:2e12e06e45498406db72d5b3da5bbc76	update tableName=REALM		\N	4.8.0	\N	\N	8735853635
3.4.2-KEYCLOAK-5172	mkanis@redhat.com	META-INF/jpa-changelog-3.4.2.xml	2023-07-07 13:17:40.901008	54	EXECUTED	8:33560e7c7989250c40da3abdabdc75a4	update tableName=CLIENT		\N	4.8.0	\N	\N	8735853635
4.0.0-KEYCLOAK-6335	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2023-07-07 13:17:40.923789	55	EXECUTED	8:87a8d8542046817a9107c7eb9cbad1cd	createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS		\N	4.8.0	\N	\N	8735853635
4.0.0-CLEANUP-UNUSED-TABLE	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2023-07-07 13:17:40.947668	56	EXECUTED	8:3ea08490a70215ed0088c273d776311e	dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING		\N	4.8.0	\N	\N	8735853635
4.0.0-KEYCLOAK-6228	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2023-07-07 13:17:41.030349	57	EXECUTED	8:2d56697c8723d4592ab608ce14b6ed68	dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...		\N	4.8.0	\N	\N	8735853635
4.0.0-KEYCLOAK-5579-fixed	mposolda@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2023-07-07 13:17:41.537975	58	EXECUTED	8:3e423e249f6068ea2bbe48bf907f9d86	dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...		\N	4.8.0	\N	\N	8735853635
authz-4.0.0.CR1	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.CR1.xml	2023-07-07 13:17:41.666765	59	EXECUTED	8:15cabee5e5df0ff099510a0fc03e4103	createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...		\N	4.8.0	\N	\N	8735853635
authz-4.0.0.Beta3	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.Beta3.xml	2023-07-07 13:17:41.69268	60	EXECUTED	8:4b80200af916ac54d2ffbfc47918ab0e	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY		\N	4.8.0	\N	\N	8735853635
authz-4.2.0.Final	mhajas@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2023-07-07 13:17:41.71976	61	EXECUTED	8:66564cd5e168045d52252c5027485bbb	createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...		\N	4.8.0	\N	\N	8735853635
authz-4.2.0.Final-KEYCLOAK-9944	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2023-07-07 13:17:41.737448	62	EXECUTED	8:1c7064fafb030222be2bd16ccf690f6f	addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS		\N	4.8.0	\N	\N	8735853635
4.2.0-KEYCLOAK-6313	wadahiro@gmail.com	META-INF/jpa-changelog-4.2.0.xml	2023-07-07 13:17:41.745677	63	EXECUTED	8:2de18a0dce10cdda5c7e65c9b719b6e5	addColumn tableName=REQUIRED_ACTION_PROVIDER		\N	4.8.0	\N	\N	8735853635
4.3.0-KEYCLOAK-7984	wadahiro@gmail.com	META-INF/jpa-changelog-4.3.0.xml	2023-07-07 13:17:41.758823	64	EXECUTED	8:03e413dd182dcbd5c57e41c34d0ef682	update tableName=REQUIRED_ACTION_PROVIDER		\N	4.8.0	\N	\N	8735853635
4.6.0-KEYCLOAK-7950	psilva@redhat.com	META-INF/jpa-changelog-4.6.0.xml	2023-07-07 13:17:41.767293	65	EXECUTED	8:d27b42bb2571c18fbe3fe4e4fb7582a7	update tableName=RESOURCE_SERVER_RESOURCE		\N	4.8.0	\N	\N	8735853635
4.6.0-KEYCLOAK-8377	keycloak	META-INF/jpa-changelog-4.6.0.xml	2023-07-07 13:17:41.823643	66	EXECUTED	8:698baf84d9fd0027e9192717c2154fb8	createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...		\N	4.8.0	\N	\N	8735853635
4.6.0-KEYCLOAK-8555	gideonray@gmail.com	META-INF/jpa-changelog-4.6.0.xml	2023-07-07 13:17:41.841606	67	EXECUTED	8:ced8822edf0f75ef26eb51582f9a821a	createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT		\N	4.8.0	\N	\N	8735853635
4.7.0-KEYCLOAK-1267	sguilhen@redhat.com	META-INF/jpa-changelog-4.7.0.xml	2023-07-07 13:17:41.851864	68	EXECUTED	8:f0abba004cf429e8afc43056df06487d	addColumn tableName=REALM		\N	4.8.0	\N	\N	8735853635
4.7.0-KEYCLOAK-7275	keycloak	META-INF/jpa-changelog-4.7.0.xml	2023-07-07 13:17:41.888108	69	EXECUTED	8:6662f8b0b611caa359fcf13bf63b4e24	renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...		\N	4.8.0	\N	\N	8735853635
4.8.0-KEYCLOAK-8835	sguilhen@redhat.com	META-INF/jpa-changelog-4.8.0.xml	2023-07-07 13:17:41.907138	70	EXECUTED	8:9e6b8009560f684250bdbdf97670d39e	addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM		\N	4.8.0	\N	\N	8735853635
authz-7.0.0-KEYCLOAK-10443	psilva@redhat.com	META-INF/jpa-changelog-authz-7.0.0.xml	2023-07-07 13:17:41.917869	71	EXECUTED	8:4223f561f3b8dc655846562b57bb502e	addColumn tableName=RESOURCE_SERVER		\N	4.8.0	\N	\N	8735853635
8.0.0-adding-credential-columns	keycloak	META-INF/jpa-changelog-8.0.0.xml	2023-07-07 13:17:41.93413	72	EXECUTED	8:215a31c398b363ce383a2b301202f29e	addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL		\N	4.8.0	\N	\N	8735853635
8.0.0-updating-credential-data-not-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2023-07-07 13:17:41.960076	73	EXECUTED	8:83f7a671792ca98b3cbd3a1a34862d3d	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.8.0	\N	\N	8735853635
8.0.0-updating-credential-data-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2023-07-07 13:17:41.970088	74	MARK_RAN	8:f58ad148698cf30707a6efbdf8061aa7	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.8.0	\N	\N	8735853635
8.0.0-credential-cleanup-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2023-07-07 13:17:42.059983	75	EXECUTED	8:79e4fd6c6442980e58d52ffc3ee7b19c	dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...		\N	4.8.0	\N	\N	8735853635
8.0.0-resource-tag-support	keycloak	META-INF/jpa-changelog-8.0.0.xml	2023-07-07 13:17:42.078732	76	EXECUTED	8:87af6a1e6d241ca4b15801d1f86a297d	addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL		\N	4.8.0	\N	\N	8735853635
9.0.0-always-display-client	keycloak	META-INF/jpa-changelog-9.0.0.xml	2023-07-07 13:17:42.08756	77	EXECUTED	8:b44f8d9b7b6ea455305a6d72a200ed15	addColumn tableName=CLIENT		\N	4.8.0	\N	\N	8735853635
9.0.0-drop-constraints-for-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2023-07-07 13:17:42.09229	78	MARK_RAN	8:2d8ed5aaaeffd0cb004c046b4a903ac5	dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...		\N	4.8.0	\N	\N	8735853635
9.0.0-increase-column-size-federated-fk	keycloak	META-INF/jpa-changelog-9.0.0.xml	2023-07-07 13:17:42.1569	79	EXECUTED	8:e290c01fcbc275326c511633f6e2acde	modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...		\N	4.8.0	\N	\N	8735853635
9.0.0-recreate-constraints-after-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2023-07-07 13:17:42.162017	80	MARK_RAN	8:c9db8784c33cea210872ac2d805439f8	addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...		\N	4.8.0	\N	\N	8735853635
9.0.1-add-index-to-client.client_id	keycloak	META-INF/jpa-changelog-9.0.1.xml	2023-07-07 13:17:42.180841	81	EXECUTED	8:95b676ce8fc546a1fcfb4c92fae4add5	createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT		\N	4.8.0	\N	\N	8735853635
9.0.1-KEYCLOAK-12579-drop-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2023-07-07 13:17:42.184582	82	MARK_RAN	8:38a6b2a41f5651018b1aca93a41401e5	dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.8.0	\N	\N	8735853635
9.0.1-KEYCLOAK-12579-add-not-null-constraint	keycloak	META-INF/jpa-changelog-9.0.1.xml	2023-07-07 13:17:42.197573	83	EXECUTED	8:3fb99bcad86a0229783123ac52f7609c	addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP		\N	4.8.0	\N	\N	8735853635
9.0.1-KEYCLOAK-12579-recreate-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2023-07-07 13:17:42.201548	84	MARK_RAN	8:64f27a6fdcad57f6f9153210f2ec1bdb	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.8.0	\N	\N	8735853635
9.0.1-add-index-to-events	keycloak	META-INF/jpa-changelog-9.0.1.xml	2023-07-07 13:17:42.216174	85	EXECUTED	8:ab4f863f39adafd4c862f7ec01890abc	createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY		\N	4.8.0	\N	\N	8735853635
map-remove-ri	keycloak	META-INF/jpa-changelog-11.0.0.xml	2023-07-07 13:17:42.226673	86	EXECUTED	8:13c419a0eb336e91ee3a3bf8fda6e2a7	dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9		\N	4.8.0	\N	\N	8735853635
map-remove-ri	keycloak	META-INF/jpa-changelog-12.0.0.xml	2023-07-07 13:17:42.241791	87	EXECUTED	8:e3fb1e698e0471487f51af1ed80fe3ac	dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...		\N	4.8.0	\N	\N	8735853635
12.1.0-add-realm-localization-table	keycloak	META-INF/jpa-changelog-12.0.0.xml	2023-07-07 13:17:42.28279	88	EXECUTED	8:babadb686aab7b56562817e60bf0abd0	createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS		\N	4.8.0	\N	\N	8735853635
default-roles	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-07-07 13:17:42.300931	89	EXECUTED	8:72d03345fda8e2f17093d08801947773	addColumn tableName=REALM; customChange		\N	4.8.0	\N	\N	8735853635
default-roles-cleanup	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-07-07 13:17:42.355758	90	EXECUTED	8:61c9233951bd96ffecd9ba75f7d978a4	dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES		\N	4.8.0	\N	\N	8735853635
13.0.0-KEYCLOAK-16844	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-07-07 13:17:42.372815	91	EXECUTED	8:ea82e6ad945cec250af6372767b25525	createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION		\N	4.8.0	\N	\N	8735853635
map-remove-ri-13.0.0	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-07-07 13:17:42.407839	92	EXECUTED	8:d3f4a33f41d960ddacd7e2ef30d126b3	dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...		\N	4.8.0	\N	\N	8735853635
13.0.0-KEYCLOAK-17992-drop-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-07-07 13:17:42.411023	93	MARK_RAN	8:1284a27fbd049d65831cb6fc07c8a783	dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT		\N	4.8.0	\N	\N	8735853635
13.0.0-increase-column-size-federated	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-07-07 13:17:42.436131	94	EXECUTED	8:9d11b619db2ae27c25853b8a37cd0dea	modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT		\N	4.8.0	\N	\N	8735853635
13.0.0-KEYCLOAK-17992-recreate-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-07-07 13:17:42.440439	95	MARK_RAN	8:3002bb3997451bb9e8bac5c5cd8d6327	addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...		\N	4.8.0	\N	\N	8735853635
json-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-07-07 13:17:42.457052	96	EXECUTED	8:dfbee0d6237a23ef4ccbb7a4e063c163	addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE		\N	4.8.0	\N	\N	8735853635
14.0.0-KEYCLOAK-11019	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-07-07 13:17:42.493258	97	EXECUTED	8:75f3e372df18d38c62734eebb986b960	createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION		\N	4.8.0	\N	\N	8735853635
14.0.0-KEYCLOAK-18286	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-07-07 13:17:42.498194	98	MARK_RAN	8:7fee73eddf84a6035691512c85637eef	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	8735853635
14.0.0-KEYCLOAK-18286-revert	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-07-07 13:17:42.529243	99	MARK_RAN	8:7a11134ab12820f999fbf3bb13c3adc8	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	8735853635
14.0.0-KEYCLOAK-18286-supported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-07-07 13:17:42.543448	100	EXECUTED	8:c0f6eaac1f3be773ffe54cb5b8482b70	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	8735853635
14.0.0-KEYCLOAK-18286-unsupported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-07-07 13:17:42.546815	101	MARK_RAN	8:18186f0008b86e0f0f49b0c4d0e842ac	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	8735853635
KEYCLOAK-17267-add-index-to-user-attributes	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-07-07 13:17:42.561624	102	EXECUTED	8:09c2780bcb23b310a7019d217dc7b433	createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE		\N	4.8.0	\N	\N	8735853635
KEYCLOAK-18146-add-saml-art-binding-identifier	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-07-07 13:17:42.570887	103	EXECUTED	8:276a44955eab693c970a42880197fff2	customChange		\N	4.8.0	\N	\N	8735853635
15.0.0-KEYCLOAK-18467	keycloak	META-INF/jpa-changelog-15.0.0.xml	2023-07-07 13:17:42.587628	104	EXECUTED	8:ba8ee3b694d043f2bfc1a1079d0760d7	addColumn tableName=REALM_LOCALIZATIONS; update tableName=REALM_LOCALIZATIONS; dropColumn columnName=TEXTS, tableName=REALM_LOCALIZATIONS; renameColumn newColumnName=TEXTS, oldColumnName=TEXTS_NEW, tableName=REALM_LOCALIZATIONS; addNotNullConstrai...		\N	4.8.0	\N	\N	8735853635
17.0.0-9562	keycloak	META-INF/jpa-changelog-17.0.0.xml	2023-07-07 13:17:42.601458	105	EXECUTED	8:5e06b1d75f5d17685485e610c2851b17	createIndex indexName=IDX_USER_SERVICE_ACCOUNT, tableName=USER_ENTITY		\N	4.8.0	\N	\N	8735853635
18.0.0-10625-IDX_ADMIN_EVENT_TIME	keycloak	META-INF/jpa-changelog-18.0.0.xml	2023-07-07 13:17:42.615019	106	EXECUTED	8:4b80546c1dc550ac552ee7b24a4ab7c0	createIndex indexName=IDX_ADMIN_EVENT_TIME, tableName=ADMIN_EVENT_ENTITY		\N	4.8.0	\N	\N	8735853635
19.0.0-10135	keycloak	META-INF/jpa-changelog-19.0.0.xml	2023-07-07 13:17:42.624383	107	EXECUTED	8:af510cd1bb2ab6339c45372f3e491696	customChange		\N	4.8.0	\N	\N	8735853635
20.0.0-12964-supported-dbs	keycloak	META-INF/jpa-changelog-20.0.0.xml	2023-07-07 13:17:42.638159	108	EXECUTED	8:05c99fc610845ef66ee812b7921af0ef	createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE		\N	4.8.0	\N	\N	8735853635
20.0.0-12964-unsupported-dbs	keycloak	META-INF/jpa-changelog-20.0.0.xml	2023-07-07 13:17:42.64122	109	MARK_RAN	8:314e803baf2f1ec315b3464e398b8247	createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE		\N	4.8.0	\N	\N	8735853635
client-attributes-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-20.0.0.xml	2023-07-07 13:17:42.660903	110	EXECUTED	8:56e4677e7e12556f70b604c573840100	addColumn tableName=CLIENT_ATTRIBUTES; update tableName=CLIENT_ATTRIBUTES; dropColumn columnName=VALUE, tableName=CLIENT_ATTRIBUTES; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	8735853635
21.0.2-17277	keycloak	META-INF/jpa-changelog-21.0.2.xml	2023-07-10 13:32:19.437069	111	EXECUTED	8:8806cb33d2a546ce770384bf98cf6eac	customChange		\N	4.16.1	\N	\N	8995938602
21.1.0-19404	keycloak	META-INF/jpa-changelog-21.1.0.xml	2023-07-10 13:32:19.684185	112	EXECUTED	8:fdb2924649d30555ab3a1744faba4928	modifyDataType columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=LOGIC, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=POLICY_ENFORCE_MODE, tableName=RESOURCE_SERVER		\N	4.16.1	\N	\N	8995938602
21.1.0-19404-2	keycloak	META-INF/jpa-changelog-21.1.0.xml	2023-07-10 13:32:19.697774	113	MARK_RAN	8:1c96cc2b10903bd07a03670098d67fd6	addColumn tableName=RESOURCE_SERVER_POLICY; update tableName=RESOURCE_SERVER_POLICY; dropColumn columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; renameColumn newColumnName=DECISION_STRATEGY, oldColumnName=DECISION_STRATEGY_NEW, tabl...		\N	4.16.1	\N	\N	8995938602
22.0.0-17484	keycloak	META-INF/jpa-changelog-22.0.0.xml	2023-07-11 18:02:53.185022	114	EXECUTED	8:4c3d4e8b142a66fcdf21b89a4dd33301	customChange		\N	4.20.0	\N	\N	9098573027
\.


--
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
1000	f	\N	\N
1001	f	\N	\N
\.


--
-- Data for Name: default_client_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.default_client_scope (realm_id, scope_id, default_scope) FROM stdin;
4cf78245-f05a-4020-a9da-201ab9860d6d	9c9f5561-5246-4169-a55f-5b488cb88686	f
4cf78245-f05a-4020-a9da-201ab9860d6d	440be81e-54d6-4506-8ce3-693b4dd3469a	t
4cf78245-f05a-4020-a9da-201ab9860d6d	e1cc5ddc-d574-4f0f-afc2-7f9ed0a1f3df	t
4cf78245-f05a-4020-a9da-201ab9860d6d	2c25f89a-764b-4b72-bad8-882aafb9fb72	t
4cf78245-f05a-4020-a9da-201ab9860d6d	4346a73d-86fa-4a88-bfc4-db05ca8ff733	f
4cf78245-f05a-4020-a9da-201ab9860d6d	88bf1e09-3b74-4263-a810-8fe9d6c050aa	f
4cf78245-f05a-4020-a9da-201ab9860d6d	59a9acbc-1636-4636-b212-38d9e1c8e5ff	t
4cf78245-f05a-4020-a9da-201ab9860d6d	1ac7e3bc-1afb-4916-98aa-89efe561aaa2	t
4cf78245-f05a-4020-a9da-201ab9860d6d	9f6e53a6-d15f-4638-9b0e-771498a76368	f
4cf78245-f05a-4020-a9da-201ab9860d6d	6393064b-36ab-45dd-997c-4412d2019e39	t
e480d6f0-0699-495a-9096-dec0cacb5180	d452bb90-0717-410e-9679-4dd6a83e1731	f
e480d6f0-0699-495a-9096-dec0cacb5180	f0f01578-d314-4f10-a5a7-2cdc3ab8a9f8	t
e480d6f0-0699-495a-9096-dec0cacb5180	e9bd9034-5a1c-4b83-872d-1d25b73ba6c2	t
e480d6f0-0699-495a-9096-dec0cacb5180	4e8e0adb-b446-4a39-a883-fed71d64b4b0	t
e480d6f0-0699-495a-9096-dec0cacb5180	25a7f3ff-7881-420f-aff5-4bdad622bfac	f
e480d6f0-0699-495a-9096-dec0cacb5180	c6adc16a-8f98-4614-84cf-5561d01caf5b	f
e480d6f0-0699-495a-9096-dec0cacb5180	88ca64d5-d52b-40da-9d2c-addfab692877	t
e480d6f0-0699-495a-9096-dec0cacb5180	72bf4807-f2c0-4a86-a530-b4d7644b1203	t
e480d6f0-0699-495a-9096-dec0cacb5180	64159835-6e5d-46ce-9ef8-8cae0eaa0b1e	f
e480d6f0-0699-495a-9096-dec0cacb5180	ae6e799c-12ef-41dc-82eb-08ff92083ca4	t
\.


--
-- Data for Name: event_entity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.event_entity (id, client_id, details_json, error, ip_address, realm_id, session_id, event_time, type, user_id) FROM stdin;
1329fcfb-bae1-43bb-9d2b-0b8d3bb40357	phone_catalog-back	{"redirect_uri":"http://phone_catalog-back:8090/auth?auth_callback=1"}	invalid_redirect_uri	172.24.0.1	e480d6f0-0699-495a-9096-dec0cacb5180	\N	1689151274835	LOGIN_ERROR	\N
f9df7c24-9ff9-4ff3-abb2-6bad15fa75f1	phone_catalog-back	{"redirect_uri":"http://phone_catalog-back:8090/auth?auth_callback=1"}	invalid_redirect_uri	172.25.0.1	e480d6f0-0699-495a-9096-dec0cacb5180	\N	1689151422629	LOGIN_ERROR	\N
9cd35680-ea92-4a82-ac10-a083f7f76788	phone_catalog-back	{"redirect_uri":"http://localhost/auth?auth_callback=1"}	invalid_redirect_uri	172.25.0.1	e480d6f0-0699-495a-9096-dec0cacb5180	\N	1689151425608	LOGIN_ERROR	\N
c65b06b4-f065-48e1-8232-816fd41afdc0	phone_catalog-back	{"grant_type":"authorization_code","client_auth_method":"client-secret"}	invalid_code	192.168.48.1	e480d6f0-0699-495a-9096-dec0cacb5180	\N	1689153472414	CODE_TO_TOKEN_ERROR	\N
\.


--
-- Data for Name: fed_user_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_attribute (id, name, user_id, realm_id, storage_provider_id, value) FROM stdin;
\.


--
-- Data for Name: fed_user_consent; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_consent (id, client_id, user_id, realm_id, storage_provider_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: fed_user_consent_cl_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_consent_cl_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: fed_user_credential; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_credential (id, salt, type, created_date, user_id, realm_id, storage_provider_id, user_label, secret_data, credential_data, priority) FROM stdin;
\.


--
-- Data for Name: fed_user_group_membership; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_group_membership (group_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_required_action; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_required_action (required_action, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_role_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_role_mapping (role_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: federated_identity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.federated_identity (identity_provider, realm_id, federated_user_id, federated_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: federated_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.federated_user (id, storage_provider_id, realm_id) FROM stdin;
\.


--
-- Data for Name: group_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.group_attribute (id, name, value, group_id) FROM stdin;
\.


--
-- Data for Name: group_role_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.group_role_mapping (role_id, group_id) FROM stdin;
\.


--
-- Data for Name: identity_provider; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.identity_provider (internal_id, enabled, provider_alias, provider_id, store_token, authenticate_by_default, realm_id, add_token_role, trust_email, first_broker_login_flow_id, post_broker_login_flow_id, provider_display_name, link_only) FROM stdin;
\.


--
-- Data for Name: identity_provider_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.identity_provider_config (identity_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: identity_provider_mapper; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.identity_provider_mapper (id, name, idp_alias, idp_mapper_name, realm_id) FROM stdin;
\.


--
-- Data for Name: idp_mapper_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.idp_mapper_config (idp_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: keycloak_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.keycloak_group (id, name, parent_group, realm_id) FROM stdin;
\.


--
-- Data for Name: keycloak_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) FROM stdin;
8347d92a-da11-4d52-bc3c-a1b8ade43860	4cf78245-f05a-4020-a9da-201ab9860d6d	f	${role_default-roles}	default-roles-master	4cf78245-f05a-4020-a9da-201ab9860d6d	\N	\N
3fa04ca6-ff11-446e-ae8a-06ce6aa9d76a	4cf78245-f05a-4020-a9da-201ab9860d6d	f	${role_create-realm}	create-realm	4cf78245-f05a-4020-a9da-201ab9860d6d	\N	\N
a02f6e37-02bc-47f8-b0cf-0cdc7b73328f	4cf78245-f05a-4020-a9da-201ab9860d6d	f	${role_admin}	admin	4cf78245-f05a-4020-a9da-201ab9860d6d	\N	\N
daef8909-9505-413a-b623-024c2e8611c4	354c75ff-d75f-448b-a864-a15f2a03b035	t	${role_create-client}	create-client	4cf78245-f05a-4020-a9da-201ab9860d6d	354c75ff-d75f-448b-a864-a15f2a03b035	\N
a5d07b94-1b47-43d1-90cc-4731d0f3b844	354c75ff-d75f-448b-a864-a15f2a03b035	t	${role_view-realm}	view-realm	4cf78245-f05a-4020-a9da-201ab9860d6d	354c75ff-d75f-448b-a864-a15f2a03b035	\N
7e195df3-b194-4700-a02d-3f00fdc512a4	354c75ff-d75f-448b-a864-a15f2a03b035	t	${role_view-users}	view-users	4cf78245-f05a-4020-a9da-201ab9860d6d	354c75ff-d75f-448b-a864-a15f2a03b035	\N
78edf0a2-fa3b-43d5-8c1e-95e9c4c8c091	354c75ff-d75f-448b-a864-a15f2a03b035	t	${role_view-clients}	view-clients	4cf78245-f05a-4020-a9da-201ab9860d6d	354c75ff-d75f-448b-a864-a15f2a03b035	\N
64ff60f4-7ade-4c02-aa35-3148976be20d	354c75ff-d75f-448b-a864-a15f2a03b035	t	${role_view-events}	view-events	4cf78245-f05a-4020-a9da-201ab9860d6d	354c75ff-d75f-448b-a864-a15f2a03b035	\N
37518be7-f145-4f2a-ae80-c9aeac9cdd9f	354c75ff-d75f-448b-a864-a15f2a03b035	t	${role_view-identity-providers}	view-identity-providers	4cf78245-f05a-4020-a9da-201ab9860d6d	354c75ff-d75f-448b-a864-a15f2a03b035	\N
a901dfe5-bd6b-4061-9004-4cf68775edba	354c75ff-d75f-448b-a864-a15f2a03b035	t	${role_view-authorization}	view-authorization	4cf78245-f05a-4020-a9da-201ab9860d6d	354c75ff-d75f-448b-a864-a15f2a03b035	\N
533125be-3dd1-4151-b444-56c2934fa653	354c75ff-d75f-448b-a864-a15f2a03b035	t	${role_manage-realm}	manage-realm	4cf78245-f05a-4020-a9da-201ab9860d6d	354c75ff-d75f-448b-a864-a15f2a03b035	\N
646593b1-e879-4ccd-8e9c-f6d573b8fbbd	354c75ff-d75f-448b-a864-a15f2a03b035	t	${role_manage-users}	manage-users	4cf78245-f05a-4020-a9da-201ab9860d6d	354c75ff-d75f-448b-a864-a15f2a03b035	\N
2faead6e-87d8-4dfc-ad20-73cb39ae4ead	354c75ff-d75f-448b-a864-a15f2a03b035	t	${role_manage-clients}	manage-clients	4cf78245-f05a-4020-a9da-201ab9860d6d	354c75ff-d75f-448b-a864-a15f2a03b035	\N
98da3826-75ef-45d3-93c3-ff9e51631c32	354c75ff-d75f-448b-a864-a15f2a03b035	t	${role_manage-events}	manage-events	4cf78245-f05a-4020-a9da-201ab9860d6d	354c75ff-d75f-448b-a864-a15f2a03b035	\N
be623b3c-1636-4353-bc34-b016305f0247	354c75ff-d75f-448b-a864-a15f2a03b035	t	${role_manage-identity-providers}	manage-identity-providers	4cf78245-f05a-4020-a9da-201ab9860d6d	354c75ff-d75f-448b-a864-a15f2a03b035	\N
6c80bd01-f59a-4139-95d3-f587b829cb52	354c75ff-d75f-448b-a864-a15f2a03b035	t	${role_manage-authorization}	manage-authorization	4cf78245-f05a-4020-a9da-201ab9860d6d	354c75ff-d75f-448b-a864-a15f2a03b035	\N
694d6798-ab02-45c8-9364-32b42f57637d	354c75ff-d75f-448b-a864-a15f2a03b035	t	${role_query-users}	query-users	4cf78245-f05a-4020-a9da-201ab9860d6d	354c75ff-d75f-448b-a864-a15f2a03b035	\N
b5177b2d-d33d-4bc5-9ca6-65c1a7bbf16d	354c75ff-d75f-448b-a864-a15f2a03b035	t	${role_query-clients}	query-clients	4cf78245-f05a-4020-a9da-201ab9860d6d	354c75ff-d75f-448b-a864-a15f2a03b035	\N
7259e9b1-2ce1-45d0-a2a2-3b9b5bbd0190	354c75ff-d75f-448b-a864-a15f2a03b035	t	${role_query-realms}	query-realms	4cf78245-f05a-4020-a9da-201ab9860d6d	354c75ff-d75f-448b-a864-a15f2a03b035	\N
5170dae2-35a5-4141-aece-442d3c97791f	354c75ff-d75f-448b-a864-a15f2a03b035	t	${role_query-groups}	query-groups	4cf78245-f05a-4020-a9da-201ab9860d6d	354c75ff-d75f-448b-a864-a15f2a03b035	\N
b9f8088e-0386-45a7-88da-bea181202fa2	aa4caee7-014b-4a77-9c6e-b66a19602c9f	t	${role_view-profile}	view-profile	4cf78245-f05a-4020-a9da-201ab9860d6d	aa4caee7-014b-4a77-9c6e-b66a19602c9f	\N
ecab7f9f-e33a-4b2d-bafb-4fedc3ea0f0d	aa4caee7-014b-4a77-9c6e-b66a19602c9f	t	${role_manage-account}	manage-account	4cf78245-f05a-4020-a9da-201ab9860d6d	aa4caee7-014b-4a77-9c6e-b66a19602c9f	\N
bf02b4a4-946b-4180-a349-bdf422725cf3	aa4caee7-014b-4a77-9c6e-b66a19602c9f	t	${role_manage-account-links}	manage-account-links	4cf78245-f05a-4020-a9da-201ab9860d6d	aa4caee7-014b-4a77-9c6e-b66a19602c9f	\N
e5396591-e84c-45e1-b115-6df55dbe621b	aa4caee7-014b-4a77-9c6e-b66a19602c9f	t	${role_view-applications}	view-applications	4cf78245-f05a-4020-a9da-201ab9860d6d	aa4caee7-014b-4a77-9c6e-b66a19602c9f	\N
5b7c12d3-d85f-4db6-932b-c8c8408240ef	aa4caee7-014b-4a77-9c6e-b66a19602c9f	t	${role_view-consent}	view-consent	4cf78245-f05a-4020-a9da-201ab9860d6d	aa4caee7-014b-4a77-9c6e-b66a19602c9f	\N
fe97e251-542f-41e8-baad-5c7d7faccd34	aa4caee7-014b-4a77-9c6e-b66a19602c9f	t	${role_manage-consent}	manage-consent	4cf78245-f05a-4020-a9da-201ab9860d6d	aa4caee7-014b-4a77-9c6e-b66a19602c9f	\N
c22c8706-8805-4f95-add9-c7d0653da296	aa4caee7-014b-4a77-9c6e-b66a19602c9f	t	${role_view-groups}	view-groups	4cf78245-f05a-4020-a9da-201ab9860d6d	aa4caee7-014b-4a77-9c6e-b66a19602c9f	\N
132df0bf-41a3-4516-99c6-bb871d6bb344	aa4caee7-014b-4a77-9c6e-b66a19602c9f	t	${role_delete-account}	delete-account	4cf78245-f05a-4020-a9da-201ab9860d6d	aa4caee7-014b-4a77-9c6e-b66a19602c9f	\N
b9d62fea-eb8c-470e-92bd-4ad402a294af	d7eb9ada-bfd8-4416-8b98-98a4e20e9aa2	t	${role_read-token}	read-token	4cf78245-f05a-4020-a9da-201ab9860d6d	d7eb9ada-bfd8-4416-8b98-98a4e20e9aa2	\N
527bbf55-8443-43b0-82a6-7f446db2d8a0	354c75ff-d75f-448b-a864-a15f2a03b035	t	${role_impersonation}	impersonation	4cf78245-f05a-4020-a9da-201ab9860d6d	354c75ff-d75f-448b-a864-a15f2a03b035	\N
d0239204-0da8-46cf-abb5-e0c94f5ade35	4cf78245-f05a-4020-a9da-201ab9860d6d	f	${role_offline-access}	offline_access	4cf78245-f05a-4020-a9da-201ab9860d6d	\N	\N
cabe88de-574a-4c8f-b49d-d08fa2ae19c4	4cf78245-f05a-4020-a9da-201ab9860d6d	f	${role_uma_authorization}	uma_authorization	4cf78245-f05a-4020-a9da-201ab9860d6d	\N	\N
b4e95889-65bc-4993-b382-80d51fbd2998	4cf78245-f05a-4020-a9da-201ab9860d6d	f		can_report	4cf78245-f05a-4020-a9da-201ab9860d6d	\N	\N
d6dae02e-af32-4bf2-8b6d-bdb9d6d0cb26	4cf78245-f05a-4020-a9da-201ab9860d6d	f		can_look	4cf78245-f05a-4020-a9da-201ab9860d6d	\N	\N
9aa3fbf6-97ac-4955-90ad-e37699628ee7	4cf78245-f05a-4020-a9da-201ab9860d6d	f		can_edit	4cf78245-f05a-4020-a9da-201ab9860d6d	\N	\N
ef798bac-367e-4f98-bc4a-a1af8261fb62	4cf78245-f05a-4020-a9da-201ab9860d6d	f		can_add	4cf78245-f05a-4020-a9da-201ab9860d6d	\N	\N
60c243a8-5856-494c-b920-08ef509d1efa	e480d6f0-0699-495a-9096-dec0cacb5180	f	${role_default-roles}	default-roles-myrealm	e480d6f0-0699-495a-9096-dec0cacb5180	\N	\N
dd0509ee-b187-42dc-909c-b9a225ffe448	6a60ad1e-acb2-4328-91aa-b79ccf6a9da6	t	${role_create-client}	create-client	4cf78245-f05a-4020-a9da-201ab9860d6d	6a60ad1e-acb2-4328-91aa-b79ccf6a9da6	\N
2c4d25c1-527d-4066-bc3b-6fbc7a564861	6a60ad1e-acb2-4328-91aa-b79ccf6a9da6	t	${role_view-realm}	view-realm	4cf78245-f05a-4020-a9da-201ab9860d6d	6a60ad1e-acb2-4328-91aa-b79ccf6a9da6	\N
88ea6abb-e897-4153-a9d6-3c0449a0e42b	6a60ad1e-acb2-4328-91aa-b79ccf6a9da6	t	${role_view-users}	view-users	4cf78245-f05a-4020-a9da-201ab9860d6d	6a60ad1e-acb2-4328-91aa-b79ccf6a9da6	\N
8acacfc5-5418-4eb7-8e86-c64417db1547	6a60ad1e-acb2-4328-91aa-b79ccf6a9da6	t	${role_view-clients}	view-clients	4cf78245-f05a-4020-a9da-201ab9860d6d	6a60ad1e-acb2-4328-91aa-b79ccf6a9da6	\N
fe3f25aa-0146-4c35-a62f-22d328e3bb40	6a60ad1e-acb2-4328-91aa-b79ccf6a9da6	t	${role_view-events}	view-events	4cf78245-f05a-4020-a9da-201ab9860d6d	6a60ad1e-acb2-4328-91aa-b79ccf6a9da6	\N
8c2249f1-50b4-413b-91ad-d5d7a8f0956f	6a60ad1e-acb2-4328-91aa-b79ccf6a9da6	t	${role_view-identity-providers}	view-identity-providers	4cf78245-f05a-4020-a9da-201ab9860d6d	6a60ad1e-acb2-4328-91aa-b79ccf6a9da6	\N
10cd4f64-daea-49fa-b384-578b218fa999	6a60ad1e-acb2-4328-91aa-b79ccf6a9da6	t	${role_view-authorization}	view-authorization	4cf78245-f05a-4020-a9da-201ab9860d6d	6a60ad1e-acb2-4328-91aa-b79ccf6a9da6	\N
432dc261-01f6-4267-ae0d-8d0d4d905714	6a60ad1e-acb2-4328-91aa-b79ccf6a9da6	t	${role_manage-realm}	manage-realm	4cf78245-f05a-4020-a9da-201ab9860d6d	6a60ad1e-acb2-4328-91aa-b79ccf6a9da6	\N
fe483fb0-109c-4da6-b4e0-b78147907288	6a60ad1e-acb2-4328-91aa-b79ccf6a9da6	t	${role_manage-users}	manage-users	4cf78245-f05a-4020-a9da-201ab9860d6d	6a60ad1e-acb2-4328-91aa-b79ccf6a9da6	\N
0837bbf1-4d84-45bf-9edd-e6149c15bda9	6a60ad1e-acb2-4328-91aa-b79ccf6a9da6	t	${role_manage-clients}	manage-clients	4cf78245-f05a-4020-a9da-201ab9860d6d	6a60ad1e-acb2-4328-91aa-b79ccf6a9da6	\N
99be3cec-3467-4171-81a7-89d50d7113bc	6a60ad1e-acb2-4328-91aa-b79ccf6a9da6	t	${role_manage-events}	manage-events	4cf78245-f05a-4020-a9da-201ab9860d6d	6a60ad1e-acb2-4328-91aa-b79ccf6a9da6	\N
604d14c3-2ef7-4363-bdb1-76f3d049af05	6a60ad1e-acb2-4328-91aa-b79ccf6a9da6	t	${role_manage-identity-providers}	manage-identity-providers	4cf78245-f05a-4020-a9da-201ab9860d6d	6a60ad1e-acb2-4328-91aa-b79ccf6a9da6	\N
5b07ed4a-e7bf-4776-a7a6-409a46c6a577	6a60ad1e-acb2-4328-91aa-b79ccf6a9da6	t	${role_manage-authorization}	manage-authorization	4cf78245-f05a-4020-a9da-201ab9860d6d	6a60ad1e-acb2-4328-91aa-b79ccf6a9da6	\N
7b3e1df7-7978-450c-80b8-f02092b664a7	6a60ad1e-acb2-4328-91aa-b79ccf6a9da6	t	${role_query-users}	query-users	4cf78245-f05a-4020-a9da-201ab9860d6d	6a60ad1e-acb2-4328-91aa-b79ccf6a9da6	\N
57ada925-baab-4163-89cc-1893ed954c5c	6a60ad1e-acb2-4328-91aa-b79ccf6a9da6	t	${role_query-clients}	query-clients	4cf78245-f05a-4020-a9da-201ab9860d6d	6a60ad1e-acb2-4328-91aa-b79ccf6a9da6	\N
967d4437-e039-4a19-9262-71d5c0fb1557	6a60ad1e-acb2-4328-91aa-b79ccf6a9da6	t	${role_query-realms}	query-realms	4cf78245-f05a-4020-a9da-201ab9860d6d	6a60ad1e-acb2-4328-91aa-b79ccf6a9da6	\N
60ce9b8e-03bb-45d1-87bb-89cdeb949c8f	6a60ad1e-acb2-4328-91aa-b79ccf6a9da6	t	${role_query-groups}	query-groups	4cf78245-f05a-4020-a9da-201ab9860d6d	6a60ad1e-acb2-4328-91aa-b79ccf6a9da6	\N
4e371f9d-5cfd-4d26-a859-c5f4e8dfb3cd	85039379-86ca-4b27-bce9-dc45611edda9	t	${role_realm-admin}	realm-admin	e480d6f0-0699-495a-9096-dec0cacb5180	85039379-86ca-4b27-bce9-dc45611edda9	\N
293bf478-205f-4801-8ee2-608419492356	85039379-86ca-4b27-bce9-dc45611edda9	t	${role_create-client}	create-client	e480d6f0-0699-495a-9096-dec0cacb5180	85039379-86ca-4b27-bce9-dc45611edda9	\N
0bc576d4-8220-4d73-8541-c83f5a0513e0	85039379-86ca-4b27-bce9-dc45611edda9	t	${role_view-realm}	view-realm	e480d6f0-0699-495a-9096-dec0cacb5180	85039379-86ca-4b27-bce9-dc45611edda9	\N
e936180d-cc11-4914-80cd-3ad1dd8cef3a	85039379-86ca-4b27-bce9-dc45611edda9	t	${role_view-users}	view-users	e480d6f0-0699-495a-9096-dec0cacb5180	85039379-86ca-4b27-bce9-dc45611edda9	\N
b14d2618-7729-42a4-94a1-d0f6d8fd9041	85039379-86ca-4b27-bce9-dc45611edda9	t	${role_view-clients}	view-clients	e480d6f0-0699-495a-9096-dec0cacb5180	85039379-86ca-4b27-bce9-dc45611edda9	\N
fff1c008-67de-45d6-8135-e4ab7a6aaa12	85039379-86ca-4b27-bce9-dc45611edda9	t	${role_view-events}	view-events	e480d6f0-0699-495a-9096-dec0cacb5180	85039379-86ca-4b27-bce9-dc45611edda9	\N
41381315-c726-49a9-8be7-46a9e5c36677	85039379-86ca-4b27-bce9-dc45611edda9	t	${role_view-identity-providers}	view-identity-providers	e480d6f0-0699-495a-9096-dec0cacb5180	85039379-86ca-4b27-bce9-dc45611edda9	\N
e222695a-8b2b-483e-9b10-10d52f2fde5f	85039379-86ca-4b27-bce9-dc45611edda9	t	${role_view-authorization}	view-authorization	e480d6f0-0699-495a-9096-dec0cacb5180	85039379-86ca-4b27-bce9-dc45611edda9	\N
bd7b1158-3643-4e3b-8156-1133be99c5bf	85039379-86ca-4b27-bce9-dc45611edda9	t	${role_manage-realm}	manage-realm	e480d6f0-0699-495a-9096-dec0cacb5180	85039379-86ca-4b27-bce9-dc45611edda9	\N
da5493b9-048a-4b4a-802d-c79fd9ceccf8	85039379-86ca-4b27-bce9-dc45611edda9	t	${role_manage-users}	manage-users	e480d6f0-0699-495a-9096-dec0cacb5180	85039379-86ca-4b27-bce9-dc45611edda9	\N
80f078f8-2f78-4a17-8eba-3dbac0fd638b	85039379-86ca-4b27-bce9-dc45611edda9	t	${role_manage-clients}	manage-clients	e480d6f0-0699-495a-9096-dec0cacb5180	85039379-86ca-4b27-bce9-dc45611edda9	\N
5cbdd13a-8411-45bc-83c6-ec275dfa5bea	85039379-86ca-4b27-bce9-dc45611edda9	t	${role_manage-events}	manage-events	e480d6f0-0699-495a-9096-dec0cacb5180	85039379-86ca-4b27-bce9-dc45611edda9	\N
313cb287-67ca-41ae-8d99-75d6058d405e	85039379-86ca-4b27-bce9-dc45611edda9	t	${role_manage-identity-providers}	manage-identity-providers	e480d6f0-0699-495a-9096-dec0cacb5180	85039379-86ca-4b27-bce9-dc45611edda9	\N
53ffcc3a-03e9-4181-bb26-a8aa9a01b1bd	85039379-86ca-4b27-bce9-dc45611edda9	t	${role_manage-authorization}	manage-authorization	e480d6f0-0699-495a-9096-dec0cacb5180	85039379-86ca-4b27-bce9-dc45611edda9	\N
f1f3f5b2-c539-4bc1-8fe7-f5d0fccc1848	85039379-86ca-4b27-bce9-dc45611edda9	t	${role_query-users}	query-users	e480d6f0-0699-495a-9096-dec0cacb5180	85039379-86ca-4b27-bce9-dc45611edda9	\N
b9b6cb90-8875-41c8-a02b-01c6fbb937f8	85039379-86ca-4b27-bce9-dc45611edda9	t	${role_query-clients}	query-clients	e480d6f0-0699-495a-9096-dec0cacb5180	85039379-86ca-4b27-bce9-dc45611edda9	\N
609d067a-af4e-41a1-a7cf-971359d1d012	85039379-86ca-4b27-bce9-dc45611edda9	t	${role_query-realms}	query-realms	e480d6f0-0699-495a-9096-dec0cacb5180	85039379-86ca-4b27-bce9-dc45611edda9	\N
9b94336d-9f3e-421c-9f60-4558397ae2a1	85039379-86ca-4b27-bce9-dc45611edda9	t	${role_query-groups}	query-groups	e480d6f0-0699-495a-9096-dec0cacb5180	85039379-86ca-4b27-bce9-dc45611edda9	\N
b07f457a-1337-4789-b365-809989adab9c	d48ad890-9172-4e3f-9d6e-898de4412752	t	${role_view-profile}	view-profile	e480d6f0-0699-495a-9096-dec0cacb5180	d48ad890-9172-4e3f-9d6e-898de4412752	\N
c4b0099a-ce9f-47c3-8d5d-33e1102987d3	d48ad890-9172-4e3f-9d6e-898de4412752	t	${role_manage-account}	manage-account	e480d6f0-0699-495a-9096-dec0cacb5180	d48ad890-9172-4e3f-9d6e-898de4412752	\N
ef525b77-8759-4f66-9ea3-5d7843431d41	d48ad890-9172-4e3f-9d6e-898de4412752	t	${role_manage-account-links}	manage-account-links	e480d6f0-0699-495a-9096-dec0cacb5180	d48ad890-9172-4e3f-9d6e-898de4412752	\N
903f9d38-6f5c-41a6-93a6-4a0064835b96	d48ad890-9172-4e3f-9d6e-898de4412752	t	${role_view-applications}	view-applications	e480d6f0-0699-495a-9096-dec0cacb5180	d48ad890-9172-4e3f-9d6e-898de4412752	\N
42046c56-d859-46d3-be58-a3332ea188ff	d48ad890-9172-4e3f-9d6e-898de4412752	t	${role_view-consent}	view-consent	e480d6f0-0699-495a-9096-dec0cacb5180	d48ad890-9172-4e3f-9d6e-898de4412752	\N
bbb4a55e-0e09-4960-b26f-f804405ac64d	d48ad890-9172-4e3f-9d6e-898de4412752	t	${role_manage-consent}	manage-consent	e480d6f0-0699-495a-9096-dec0cacb5180	d48ad890-9172-4e3f-9d6e-898de4412752	\N
07b123e9-8745-4a7d-99ef-bf7efeb55cbc	d48ad890-9172-4e3f-9d6e-898de4412752	t	${role_view-groups}	view-groups	e480d6f0-0699-495a-9096-dec0cacb5180	d48ad890-9172-4e3f-9d6e-898de4412752	\N
d9d3bd6d-4042-4a2e-9574-704a01104a7d	d48ad890-9172-4e3f-9d6e-898de4412752	t	${role_delete-account}	delete-account	e480d6f0-0699-495a-9096-dec0cacb5180	d48ad890-9172-4e3f-9d6e-898de4412752	\N
88cd3137-6617-427c-82f0-a7b55f18d5cb	6a60ad1e-acb2-4328-91aa-b79ccf6a9da6	t	${role_impersonation}	impersonation	4cf78245-f05a-4020-a9da-201ab9860d6d	6a60ad1e-acb2-4328-91aa-b79ccf6a9da6	\N
e02f0e80-8a43-49e4-b8bf-7a77c5d27a2b	85039379-86ca-4b27-bce9-dc45611edda9	t	${role_impersonation}	impersonation	e480d6f0-0699-495a-9096-dec0cacb5180	85039379-86ca-4b27-bce9-dc45611edda9	\N
e4d3c31c-089f-4d7b-9afe-95f254dc2162	adbbb502-79ac-41f6-97ac-b4b9b2c49327	t	${role_read-token}	read-token	e480d6f0-0699-495a-9096-dec0cacb5180	adbbb502-79ac-41f6-97ac-b4b9b2c49327	\N
289d6130-e2f3-4ccf-b765-48103f137640	e480d6f0-0699-495a-9096-dec0cacb5180	f	${role_offline-access}	offline_access	e480d6f0-0699-495a-9096-dec0cacb5180	\N	\N
fd96c760-3bd5-463a-aec4-3e8ce3b3dab8	e480d6f0-0699-495a-9096-dec0cacb5180	f	${role_uma_authorization}	uma_authorization	e480d6f0-0699-495a-9096-dec0cacb5180	\N	\N
fbfe5ce0-0483-452b-8dc8-53333b6a6a86	e480d6f0-0699-495a-9096-dec0cacb5180	f		can_read	e480d6f0-0699-495a-9096-dec0cacb5180	\N	\N
1ab7ed83-5270-43bc-adea-583357d65b5e	e480d6f0-0699-495a-9096-dec0cacb5180	f		can_add	e480d6f0-0699-495a-9096-dec0cacb5180	\N	\N
227e04bf-39a6-4be4-b486-ae390faa7ae8	e480d6f0-0699-495a-9096-dec0cacb5180	f		can_edit	e480d6f0-0699-495a-9096-dec0cacb5180	\N	\N
43707abe-f8a2-40e7-bece-e57b69a219e4	e480d6f0-0699-495a-9096-dec0cacb5180	f		can_report	e480d6f0-0699-495a-9096-dec0cacb5180	\N	\N
02024df6-f3bc-4d98-ba6b-3226376412e5	edda3079-f9f1-49de-9d18-8840096fe1e5	t	\N	uma_protection	e480d6f0-0699-495a-9096-dec0cacb5180	edda3079-f9f1-49de-9d18-8840096fe1e5	\N
1225579e-a176-4d8b-bc42-7f0592c65091	e480d6f0-0699-495a-9096-dec0cacb5180	f		admin	e480d6f0-0699-495a-9096-dec0cacb5180	\N	\N
\.


--
-- Data for Name: migration_model; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.migration_model (id, version, update_time) FROM stdin;
e7bi0	20.0.0	1688735863
e4yn5	21.1.2	1688995944
hj61u	22.0.0	1689098577
\.


--
-- Data for Name: offline_client_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.offline_client_session (user_session_id, client_id, offline_flag, "timestamp", data, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: offline_user_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.offline_user_session (user_session_id, user_id, realm_id, created_on, offline_flag, data, last_session_refresh) FROM stdin;
\.


--
-- Data for Name: policy_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.policy_config (policy_id, name, value) FROM stdin;
a75ced29-ac24-4a56-af44-26a4e38ca2de	code	// by default, grants any permission associated with this policy\n$evaluation.grant();\n
8c6c1e91-cdb5-4149-848c-36b99cb96760	defaultResourceType	urn:phone_catalog-back:resources:default
\.


--
-- Data for Name: protocol_mapper; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) FROM stdin;
72833d40-5cda-4ec3-a280-8acbd5b2255a	audience resolve	openid-connect	oidc-audience-resolve-mapper	4f07f38b-0e6f-426c-b5d1-369b09db7cfc	\N
e3947b7a-176d-4f41-8bae-63c369c227cd	locale	openid-connect	oidc-usermodel-attribute-mapper	daf774fc-7c22-44f0-a5f2-0c88cc4e6b20	\N
54c45b46-024f-4e9b-9aa1-b0b916fe6c53	role list	saml	saml-role-list-mapper	\N	440be81e-54d6-4506-8ce3-693b4dd3469a
7120aa15-277b-4c5f-a748-704acfd0df30	full name	openid-connect	oidc-full-name-mapper	\N	e1cc5ddc-d574-4f0f-afc2-7f9ed0a1f3df
4ca89a2c-1d9f-4b7a-a1c1-4ddab24d8920	family name	openid-connect	oidc-usermodel-property-mapper	\N	e1cc5ddc-d574-4f0f-afc2-7f9ed0a1f3df
45ffa10a-c392-43f0-b970-5df9fc099d5a	given name	openid-connect	oidc-usermodel-property-mapper	\N	e1cc5ddc-d574-4f0f-afc2-7f9ed0a1f3df
b94700b6-e684-4e31-ba1d-bdb8473a7e4b	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	e1cc5ddc-d574-4f0f-afc2-7f9ed0a1f3df
ba45903d-f4e6-4660-8e44-d01322de36f5	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	e1cc5ddc-d574-4f0f-afc2-7f9ed0a1f3df
d291db68-4038-4904-a9ca-51379d9a93e8	username	openid-connect	oidc-usermodel-property-mapper	\N	e1cc5ddc-d574-4f0f-afc2-7f9ed0a1f3df
a91481b7-a792-4600-a353-de29b2c01afe	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	e1cc5ddc-d574-4f0f-afc2-7f9ed0a1f3df
234fc3d0-0c6a-4dba-85a1-aae69d0ab85d	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	e1cc5ddc-d574-4f0f-afc2-7f9ed0a1f3df
5b28bbdc-65fa-4db5-ac27-cefbc6132d31	website	openid-connect	oidc-usermodel-attribute-mapper	\N	e1cc5ddc-d574-4f0f-afc2-7f9ed0a1f3df
2f64f1a3-cb7a-4b05-9b43-745aaf63ad21	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	e1cc5ddc-d574-4f0f-afc2-7f9ed0a1f3df
5e2d1b84-f80c-4723-bfbd-3c2314198cfc	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	e1cc5ddc-d574-4f0f-afc2-7f9ed0a1f3df
e49d0bc4-0882-434f-92b7-f4f763d75de7	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	e1cc5ddc-d574-4f0f-afc2-7f9ed0a1f3df
f51c7463-b778-4d7c-93c0-6501077033df	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	e1cc5ddc-d574-4f0f-afc2-7f9ed0a1f3df
4a408446-1f6c-4807-a68b-a0d8a838f41d	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	e1cc5ddc-d574-4f0f-afc2-7f9ed0a1f3df
5c200e1c-215e-4638-921b-d50328aa8418	email	openid-connect	oidc-usermodel-property-mapper	\N	2c25f89a-764b-4b72-bad8-882aafb9fb72
a3dafbea-9532-4718-b5db-18b3b0a593c1	email verified	openid-connect	oidc-usermodel-property-mapper	\N	2c25f89a-764b-4b72-bad8-882aafb9fb72
ad69f7d1-cfe7-4bad-bc55-ff7932d54950	address	openid-connect	oidc-address-mapper	\N	4346a73d-86fa-4a88-bfc4-db05ca8ff733
07bec2ee-0aca-48f8-b193-b32beeceefa9	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	88bf1e09-3b74-4263-a810-8fe9d6c050aa
735c7527-31f5-4fc3-baa0-e8706f138d9b	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	88bf1e09-3b74-4263-a810-8fe9d6c050aa
2cbf498c-25b2-4089-b464-1b0278ad6c5e	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	59a9acbc-1636-4636-b212-38d9e1c8e5ff
26e88d1d-7bd0-40c4-9721-9ee4732d5099	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	59a9acbc-1636-4636-b212-38d9e1c8e5ff
4cd9c7e3-82d3-42d8-a3f1-22f9787ba253	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	59a9acbc-1636-4636-b212-38d9e1c8e5ff
cec3b377-661a-4aa1-846a-1e71e48bebfc	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	1ac7e3bc-1afb-4916-98aa-89efe561aaa2
f3f7cc70-a63f-433e-bfc6-1b6aa26d2925	upn	openid-connect	oidc-usermodel-property-mapper	\N	9f6e53a6-d15f-4638-9b0e-771498a76368
a15df072-63b8-498f-8d87-217652569454	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	9f6e53a6-d15f-4638-9b0e-771498a76368
8e073b3c-b3ab-4471-923f-d75dbc814dc7	acr loa level	openid-connect	oidc-acr-mapper	\N	6393064b-36ab-45dd-997c-4412d2019e39
a33d0f4f-80f1-4c77-918b-c79cf2cb47fe	audience resolve	openid-connect	oidc-audience-resolve-mapper	49ecb9f6-bd6f-433d-bbcb-5579bea2b3b5	\N
76e4b6aa-6d05-4cf7-839d-7853e0234c9f	role list	saml	saml-role-list-mapper	\N	f0f01578-d314-4f10-a5a7-2cdc3ab8a9f8
61369572-7576-4379-8da1-9e5d2662114a	full name	openid-connect	oidc-full-name-mapper	\N	e9bd9034-5a1c-4b83-872d-1d25b73ba6c2
926a3675-ed48-4d29-8f9d-6e7796575aea	family name	openid-connect	oidc-usermodel-property-mapper	\N	e9bd9034-5a1c-4b83-872d-1d25b73ba6c2
afcd272a-e91d-4765-b146-34a08b346149	given name	openid-connect	oidc-usermodel-property-mapper	\N	e9bd9034-5a1c-4b83-872d-1d25b73ba6c2
e658061b-396d-450d-8dc3-19e84b42454c	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	e9bd9034-5a1c-4b83-872d-1d25b73ba6c2
0fb2ac67-36a3-4c75-9892-c97460a1a220	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	e9bd9034-5a1c-4b83-872d-1d25b73ba6c2
4cc3f294-53dc-4c2e-bcbc-946f89394859	username	openid-connect	oidc-usermodel-property-mapper	\N	e9bd9034-5a1c-4b83-872d-1d25b73ba6c2
455e43b3-de10-4e77-bd63-95a217d7d3ed	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	e9bd9034-5a1c-4b83-872d-1d25b73ba6c2
ab18db09-4ca2-4bec-8fdc-463e2fd38fbe	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	e9bd9034-5a1c-4b83-872d-1d25b73ba6c2
4671c6ae-a9d4-4bdf-a9f1-f89e90ce722a	website	openid-connect	oidc-usermodel-attribute-mapper	\N	e9bd9034-5a1c-4b83-872d-1d25b73ba6c2
13ec71bd-5952-46d6-a7d2-fe9a0d1ccb64	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	e9bd9034-5a1c-4b83-872d-1d25b73ba6c2
04c00966-74db-48d9-9d03-7837dd881071	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	e9bd9034-5a1c-4b83-872d-1d25b73ba6c2
e66c98d0-9c8d-4605-84d9-029acc8d39f9	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	e9bd9034-5a1c-4b83-872d-1d25b73ba6c2
0b26edf4-ff94-415f-84a5-0a175255e9fe	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	e9bd9034-5a1c-4b83-872d-1d25b73ba6c2
d3c8edc6-8c96-409c-911b-635145099958	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	e9bd9034-5a1c-4b83-872d-1d25b73ba6c2
cfe180df-61b9-4d3c-9fa9-fbd5063de16a	email	openid-connect	oidc-usermodel-property-mapper	\N	4e8e0adb-b446-4a39-a883-fed71d64b4b0
46c9892b-78c8-47a1-aa69-f5bdf9defc31	email verified	openid-connect	oidc-usermodel-property-mapper	\N	4e8e0adb-b446-4a39-a883-fed71d64b4b0
fb5b20ba-8a7f-420a-90e6-6c2cfcf0f5d4	address	openid-connect	oidc-address-mapper	\N	25a7f3ff-7881-420f-aff5-4bdad622bfac
e81b2cd7-6de7-4396-9cfe-a1268987c8fb	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	c6adc16a-8f98-4614-84cf-5561d01caf5b
279dc3bc-056e-4364-bf53-9227b5b90ec9	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	c6adc16a-8f98-4614-84cf-5561d01caf5b
e32bca0e-9447-4353-8dd8-7d4da48d2dd5	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	88ca64d5-d52b-40da-9d2c-addfab692877
ee1eff27-3bf2-4edb-b046-1eab26f585b7	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	88ca64d5-d52b-40da-9d2c-addfab692877
87c0a83b-61e8-463f-9362-4f91cb965751	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	88ca64d5-d52b-40da-9d2c-addfab692877
435335a8-8e92-4f73-ae82-e287447919e9	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	72bf4807-f2c0-4a86-a530-b4d7644b1203
3d89c7ce-ca48-497e-803d-6cc9802ce9ad	upn	openid-connect	oidc-usermodel-property-mapper	\N	64159835-6e5d-46ce-9ef8-8cae0eaa0b1e
c4519b2b-1fc8-4265-932c-7afe266a9466	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	64159835-6e5d-46ce-9ef8-8cae0eaa0b1e
c0bcbb69-e1cc-4e37-b5fe-1c8004cf0b01	acr loa level	openid-connect	oidc-acr-mapper	\N	ae6e799c-12ef-41dc-82eb-08ff92083ca4
b97e3147-ffa1-4bc1-965b-5418b56f1687	locale	openid-connect	oidc-usermodel-attribute-mapper	7b85e5dc-1441-431d-a843-941c35defc9c	\N
9ac51100-8878-4e17-8fa6-8ae085341dc9	Client ID	openid-connect	oidc-usersessionmodel-note-mapper	edda3079-f9f1-49de-9d18-8840096fe1e5	\N
a862dc19-b69d-4085-a819-cfaf4bbe4e89	Client Host	openid-connect	oidc-usersessionmodel-note-mapper	edda3079-f9f1-49de-9d18-8840096fe1e5	\N
84e15161-3603-45fb-bd7f-23282a335558	Client IP Address	openid-connect	oidc-usersessionmodel-note-mapper	edda3079-f9f1-49de-9d18-8840096fe1e5	\N
\.


--
-- Data for Name: protocol_mapper_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.protocol_mapper_config (protocol_mapper_id, value, name) FROM stdin;
e3947b7a-176d-4f41-8bae-63c369c227cd	true	userinfo.token.claim
e3947b7a-176d-4f41-8bae-63c369c227cd	locale	user.attribute
e3947b7a-176d-4f41-8bae-63c369c227cd	true	id.token.claim
e3947b7a-176d-4f41-8bae-63c369c227cd	true	access.token.claim
e3947b7a-176d-4f41-8bae-63c369c227cd	locale	claim.name
e3947b7a-176d-4f41-8bae-63c369c227cd	String	jsonType.label
54c45b46-024f-4e9b-9aa1-b0b916fe6c53	false	single
54c45b46-024f-4e9b-9aa1-b0b916fe6c53	Basic	attribute.nameformat
54c45b46-024f-4e9b-9aa1-b0b916fe6c53	Role	attribute.name
234fc3d0-0c6a-4dba-85a1-aae69d0ab85d	true	userinfo.token.claim
234fc3d0-0c6a-4dba-85a1-aae69d0ab85d	picture	user.attribute
234fc3d0-0c6a-4dba-85a1-aae69d0ab85d	true	id.token.claim
234fc3d0-0c6a-4dba-85a1-aae69d0ab85d	true	access.token.claim
234fc3d0-0c6a-4dba-85a1-aae69d0ab85d	picture	claim.name
234fc3d0-0c6a-4dba-85a1-aae69d0ab85d	String	jsonType.label
2f64f1a3-cb7a-4b05-9b43-745aaf63ad21	true	userinfo.token.claim
2f64f1a3-cb7a-4b05-9b43-745aaf63ad21	gender	user.attribute
2f64f1a3-cb7a-4b05-9b43-745aaf63ad21	true	id.token.claim
2f64f1a3-cb7a-4b05-9b43-745aaf63ad21	true	access.token.claim
2f64f1a3-cb7a-4b05-9b43-745aaf63ad21	gender	claim.name
2f64f1a3-cb7a-4b05-9b43-745aaf63ad21	String	jsonType.label
45ffa10a-c392-43f0-b970-5df9fc099d5a	true	userinfo.token.claim
45ffa10a-c392-43f0-b970-5df9fc099d5a	firstName	user.attribute
45ffa10a-c392-43f0-b970-5df9fc099d5a	true	id.token.claim
45ffa10a-c392-43f0-b970-5df9fc099d5a	true	access.token.claim
45ffa10a-c392-43f0-b970-5df9fc099d5a	given_name	claim.name
45ffa10a-c392-43f0-b970-5df9fc099d5a	String	jsonType.label
4a408446-1f6c-4807-a68b-a0d8a838f41d	true	userinfo.token.claim
4a408446-1f6c-4807-a68b-a0d8a838f41d	updatedAt	user.attribute
4a408446-1f6c-4807-a68b-a0d8a838f41d	true	id.token.claim
4a408446-1f6c-4807-a68b-a0d8a838f41d	true	access.token.claim
4a408446-1f6c-4807-a68b-a0d8a838f41d	updated_at	claim.name
4a408446-1f6c-4807-a68b-a0d8a838f41d	long	jsonType.label
4ca89a2c-1d9f-4b7a-a1c1-4ddab24d8920	true	userinfo.token.claim
4ca89a2c-1d9f-4b7a-a1c1-4ddab24d8920	lastName	user.attribute
4ca89a2c-1d9f-4b7a-a1c1-4ddab24d8920	true	id.token.claim
4ca89a2c-1d9f-4b7a-a1c1-4ddab24d8920	true	access.token.claim
4ca89a2c-1d9f-4b7a-a1c1-4ddab24d8920	family_name	claim.name
4ca89a2c-1d9f-4b7a-a1c1-4ddab24d8920	String	jsonType.label
5b28bbdc-65fa-4db5-ac27-cefbc6132d31	true	userinfo.token.claim
5b28bbdc-65fa-4db5-ac27-cefbc6132d31	website	user.attribute
5b28bbdc-65fa-4db5-ac27-cefbc6132d31	true	id.token.claim
5b28bbdc-65fa-4db5-ac27-cefbc6132d31	true	access.token.claim
5b28bbdc-65fa-4db5-ac27-cefbc6132d31	website	claim.name
5b28bbdc-65fa-4db5-ac27-cefbc6132d31	String	jsonType.label
5e2d1b84-f80c-4723-bfbd-3c2314198cfc	true	userinfo.token.claim
5e2d1b84-f80c-4723-bfbd-3c2314198cfc	birthdate	user.attribute
5e2d1b84-f80c-4723-bfbd-3c2314198cfc	true	id.token.claim
5e2d1b84-f80c-4723-bfbd-3c2314198cfc	true	access.token.claim
5e2d1b84-f80c-4723-bfbd-3c2314198cfc	birthdate	claim.name
5e2d1b84-f80c-4723-bfbd-3c2314198cfc	String	jsonType.label
7120aa15-277b-4c5f-a748-704acfd0df30	true	userinfo.token.claim
7120aa15-277b-4c5f-a748-704acfd0df30	true	id.token.claim
7120aa15-277b-4c5f-a748-704acfd0df30	true	access.token.claim
a91481b7-a792-4600-a353-de29b2c01afe	true	userinfo.token.claim
a91481b7-a792-4600-a353-de29b2c01afe	profile	user.attribute
a91481b7-a792-4600-a353-de29b2c01afe	true	id.token.claim
a91481b7-a792-4600-a353-de29b2c01afe	true	access.token.claim
a91481b7-a792-4600-a353-de29b2c01afe	profile	claim.name
a91481b7-a792-4600-a353-de29b2c01afe	String	jsonType.label
b94700b6-e684-4e31-ba1d-bdb8473a7e4b	true	userinfo.token.claim
b94700b6-e684-4e31-ba1d-bdb8473a7e4b	middleName	user.attribute
b94700b6-e684-4e31-ba1d-bdb8473a7e4b	true	id.token.claim
b94700b6-e684-4e31-ba1d-bdb8473a7e4b	true	access.token.claim
b94700b6-e684-4e31-ba1d-bdb8473a7e4b	middle_name	claim.name
b94700b6-e684-4e31-ba1d-bdb8473a7e4b	String	jsonType.label
ba45903d-f4e6-4660-8e44-d01322de36f5	true	userinfo.token.claim
ba45903d-f4e6-4660-8e44-d01322de36f5	nickname	user.attribute
ba45903d-f4e6-4660-8e44-d01322de36f5	true	id.token.claim
ba45903d-f4e6-4660-8e44-d01322de36f5	true	access.token.claim
ba45903d-f4e6-4660-8e44-d01322de36f5	nickname	claim.name
ba45903d-f4e6-4660-8e44-d01322de36f5	String	jsonType.label
d291db68-4038-4904-a9ca-51379d9a93e8	true	userinfo.token.claim
d291db68-4038-4904-a9ca-51379d9a93e8	username	user.attribute
d291db68-4038-4904-a9ca-51379d9a93e8	true	id.token.claim
d291db68-4038-4904-a9ca-51379d9a93e8	true	access.token.claim
d291db68-4038-4904-a9ca-51379d9a93e8	preferred_username	claim.name
d291db68-4038-4904-a9ca-51379d9a93e8	String	jsonType.label
e49d0bc4-0882-434f-92b7-f4f763d75de7	true	userinfo.token.claim
e49d0bc4-0882-434f-92b7-f4f763d75de7	zoneinfo	user.attribute
e49d0bc4-0882-434f-92b7-f4f763d75de7	true	id.token.claim
e49d0bc4-0882-434f-92b7-f4f763d75de7	true	access.token.claim
e49d0bc4-0882-434f-92b7-f4f763d75de7	zoneinfo	claim.name
e49d0bc4-0882-434f-92b7-f4f763d75de7	String	jsonType.label
f51c7463-b778-4d7c-93c0-6501077033df	true	userinfo.token.claim
f51c7463-b778-4d7c-93c0-6501077033df	locale	user.attribute
f51c7463-b778-4d7c-93c0-6501077033df	true	id.token.claim
f51c7463-b778-4d7c-93c0-6501077033df	true	access.token.claim
f51c7463-b778-4d7c-93c0-6501077033df	locale	claim.name
f51c7463-b778-4d7c-93c0-6501077033df	String	jsonType.label
5c200e1c-215e-4638-921b-d50328aa8418	true	userinfo.token.claim
5c200e1c-215e-4638-921b-d50328aa8418	email	user.attribute
5c200e1c-215e-4638-921b-d50328aa8418	true	id.token.claim
5c200e1c-215e-4638-921b-d50328aa8418	true	access.token.claim
5c200e1c-215e-4638-921b-d50328aa8418	email	claim.name
5c200e1c-215e-4638-921b-d50328aa8418	String	jsonType.label
a3dafbea-9532-4718-b5db-18b3b0a593c1	true	userinfo.token.claim
a3dafbea-9532-4718-b5db-18b3b0a593c1	emailVerified	user.attribute
a3dafbea-9532-4718-b5db-18b3b0a593c1	true	id.token.claim
a3dafbea-9532-4718-b5db-18b3b0a593c1	true	access.token.claim
a3dafbea-9532-4718-b5db-18b3b0a593c1	email_verified	claim.name
a3dafbea-9532-4718-b5db-18b3b0a593c1	boolean	jsonType.label
ad69f7d1-cfe7-4bad-bc55-ff7932d54950	formatted	user.attribute.formatted
ad69f7d1-cfe7-4bad-bc55-ff7932d54950	country	user.attribute.country
ad69f7d1-cfe7-4bad-bc55-ff7932d54950	postal_code	user.attribute.postal_code
ad69f7d1-cfe7-4bad-bc55-ff7932d54950	true	userinfo.token.claim
ad69f7d1-cfe7-4bad-bc55-ff7932d54950	street	user.attribute.street
ad69f7d1-cfe7-4bad-bc55-ff7932d54950	true	id.token.claim
ad69f7d1-cfe7-4bad-bc55-ff7932d54950	region	user.attribute.region
ad69f7d1-cfe7-4bad-bc55-ff7932d54950	true	access.token.claim
ad69f7d1-cfe7-4bad-bc55-ff7932d54950	locality	user.attribute.locality
07bec2ee-0aca-48f8-b193-b32beeceefa9	true	userinfo.token.claim
07bec2ee-0aca-48f8-b193-b32beeceefa9	phoneNumber	user.attribute
07bec2ee-0aca-48f8-b193-b32beeceefa9	true	id.token.claim
07bec2ee-0aca-48f8-b193-b32beeceefa9	true	access.token.claim
07bec2ee-0aca-48f8-b193-b32beeceefa9	phone_number	claim.name
07bec2ee-0aca-48f8-b193-b32beeceefa9	String	jsonType.label
735c7527-31f5-4fc3-baa0-e8706f138d9b	true	userinfo.token.claim
735c7527-31f5-4fc3-baa0-e8706f138d9b	phoneNumberVerified	user.attribute
735c7527-31f5-4fc3-baa0-e8706f138d9b	true	id.token.claim
735c7527-31f5-4fc3-baa0-e8706f138d9b	true	access.token.claim
735c7527-31f5-4fc3-baa0-e8706f138d9b	phone_number_verified	claim.name
735c7527-31f5-4fc3-baa0-e8706f138d9b	boolean	jsonType.label
26e88d1d-7bd0-40c4-9721-9ee4732d5099	true	multivalued
26e88d1d-7bd0-40c4-9721-9ee4732d5099	foo	user.attribute
26e88d1d-7bd0-40c4-9721-9ee4732d5099	true	access.token.claim
26e88d1d-7bd0-40c4-9721-9ee4732d5099	resource_access.${client_id}.roles	claim.name
26e88d1d-7bd0-40c4-9721-9ee4732d5099	String	jsonType.label
2cbf498c-25b2-4089-b464-1b0278ad6c5e	true	multivalued
2cbf498c-25b2-4089-b464-1b0278ad6c5e	foo	user.attribute
2cbf498c-25b2-4089-b464-1b0278ad6c5e	true	access.token.claim
2cbf498c-25b2-4089-b464-1b0278ad6c5e	realm_access.roles	claim.name
2cbf498c-25b2-4089-b464-1b0278ad6c5e	String	jsonType.label
a15df072-63b8-498f-8d87-217652569454	true	multivalued
a15df072-63b8-498f-8d87-217652569454	foo	user.attribute
a15df072-63b8-498f-8d87-217652569454	true	id.token.claim
a15df072-63b8-498f-8d87-217652569454	true	access.token.claim
a15df072-63b8-498f-8d87-217652569454	groups	claim.name
a15df072-63b8-498f-8d87-217652569454	String	jsonType.label
f3f7cc70-a63f-433e-bfc6-1b6aa26d2925	true	userinfo.token.claim
f3f7cc70-a63f-433e-bfc6-1b6aa26d2925	username	user.attribute
f3f7cc70-a63f-433e-bfc6-1b6aa26d2925	true	id.token.claim
f3f7cc70-a63f-433e-bfc6-1b6aa26d2925	true	access.token.claim
f3f7cc70-a63f-433e-bfc6-1b6aa26d2925	upn	claim.name
f3f7cc70-a63f-433e-bfc6-1b6aa26d2925	String	jsonType.label
8e073b3c-b3ab-4471-923f-d75dbc814dc7	true	id.token.claim
8e073b3c-b3ab-4471-923f-d75dbc814dc7	true	access.token.claim
76e4b6aa-6d05-4cf7-839d-7853e0234c9f	false	single
76e4b6aa-6d05-4cf7-839d-7853e0234c9f	Basic	attribute.nameformat
76e4b6aa-6d05-4cf7-839d-7853e0234c9f	Role	attribute.name
04c00966-74db-48d9-9d03-7837dd881071	true	userinfo.token.claim
04c00966-74db-48d9-9d03-7837dd881071	birthdate	user.attribute
04c00966-74db-48d9-9d03-7837dd881071	true	id.token.claim
04c00966-74db-48d9-9d03-7837dd881071	true	access.token.claim
04c00966-74db-48d9-9d03-7837dd881071	birthdate	claim.name
04c00966-74db-48d9-9d03-7837dd881071	String	jsonType.label
0b26edf4-ff94-415f-84a5-0a175255e9fe	true	userinfo.token.claim
0b26edf4-ff94-415f-84a5-0a175255e9fe	locale	user.attribute
0b26edf4-ff94-415f-84a5-0a175255e9fe	true	id.token.claim
0b26edf4-ff94-415f-84a5-0a175255e9fe	true	access.token.claim
0b26edf4-ff94-415f-84a5-0a175255e9fe	locale	claim.name
0b26edf4-ff94-415f-84a5-0a175255e9fe	String	jsonType.label
0fb2ac67-36a3-4c75-9892-c97460a1a220	true	userinfo.token.claim
0fb2ac67-36a3-4c75-9892-c97460a1a220	nickname	user.attribute
0fb2ac67-36a3-4c75-9892-c97460a1a220	true	id.token.claim
0fb2ac67-36a3-4c75-9892-c97460a1a220	true	access.token.claim
0fb2ac67-36a3-4c75-9892-c97460a1a220	nickname	claim.name
0fb2ac67-36a3-4c75-9892-c97460a1a220	String	jsonType.label
13ec71bd-5952-46d6-a7d2-fe9a0d1ccb64	true	userinfo.token.claim
13ec71bd-5952-46d6-a7d2-fe9a0d1ccb64	gender	user.attribute
13ec71bd-5952-46d6-a7d2-fe9a0d1ccb64	true	id.token.claim
13ec71bd-5952-46d6-a7d2-fe9a0d1ccb64	true	access.token.claim
13ec71bd-5952-46d6-a7d2-fe9a0d1ccb64	gender	claim.name
13ec71bd-5952-46d6-a7d2-fe9a0d1ccb64	String	jsonType.label
455e43b3-de10-4e77-bd63-95a217d7d3ed	true	userinfo.token.claim
455e43b3-de10-4e77-bd63-95a217d7d3ed	profile	user.attribute
455e43b3-de10-4e77-bd63-95a217d7d3ed	true	id.token.claim
455e43b3-de10-4e77-bd63-95a217d7d3ed	true	access.token.claim
455e43b3-de10-4e77-bd63-95a217d7d3ed	profile	claim.name
455e43b3-de10-4e77-bd63-95a217d7d3ed	String	jsonType.label
4671c6ae-a9d4-4bdf-a9f1-f89e90ce722a	true	userinfo.token.claim
4671c6ae-a9d4-4bdf-a9f1-f89e90ce722a	website	user.attribute
4671c6ae-a9d4-4bdf-a9f1-f89e90ce722a	true	id.token.claim
4671c6ae-a9d4-4bdf-a9f1-f89e90ce722a	true	access.token.claim
4671c6ae-a9d4-4bdf-a9f1-f89e90ce722a	website	claim.name
4671c6ae-a9d4-4bdf-a9f1-f89e90ce722a	String	jsonType.label
4cc3f294-53dc-4c2e-bcbc-946f89394859	true	userinfo.token.claim
4cc3f294-53dc-4c2e-bcbc-946f89394859	username	user.attribute
4cc3f294-53dc-4c2e-bcbc-946f89394859	true	id.token.claim
4cc3f294-53dc-4c2e-bcbc-946f89394859	true	access.token.claim
4cc3f294-53dc-4c2e-bcbc-946f89394859	preferred_username	claim.name
4cc3f294-53dc-4c2e-bcbc-946f89394859	String	jsonType.label
61369572-7576-4379-8da1-9e5d2662114a	true	userinfo.token.claim
61369572-7576-4379-8da1-9e5d2662114a	true	id.token.claim
61369572-7576-4379-8da1-9e5d2662114a	true	access.token.claim
926a3675-ed48-4d29-8f9d-6e7796575aea	true	userinfo.token.claim
926a3675-ed48-4d29-8f9d-6e7796575aea	lastName	user.attribute
926a3675-ed48-4d29-8f9d-6e7796575aea	true	id.token.claim
926a3675-ed48-4d29-8f9d-6e7796575aea	true	access.token.claim
926a3675-ed48-4d29-8f9d-6e7796575aea	family_name	claim.name
926a3675-ed48-4d29-8f9d-6e7796575aea	String	jsonType.label
ab18db09-4ca2-4bec-8fdc-463e2fd38fbe	true	userinfo.token.claim
ab18db09-4ca2-4bec-8fdc-463e2fd38fbe	picture	user.attribute
ab18db09-4ca2-4bec-8fdc-463e2fd38fbe	true	id.token.claim
ab18db09-4ca2-4bec-8fdc-463e2fd38fbe	true	access.token.claim
ab18db09-4ca2-4bec-8fdc-463e2fd38fbe	picture	claim.name
ab18db09-4ca2-4bec-8fdc-463e2fd38fbe	String	jsonType.label
afcd272a-e91d-4765-b146-34a08b346149	true	userinfo.token.claim
afcd272a-e91d-4765-b146-34a08b346149	firstName	user.attribute
afcd272a-e91d-4765-b146-34a08b346149	true	id.token.claim
afcd272a-e91d-4765-b146-34a08b346149	true	access.token.claim
afcd272a-e91d-4765-b146-34a08b346149	given_name	claim.name
afcd272a-e91d-4765-b146-34a08b346149	String	jsonType.label
d3c8edc6-8c96-409c-911b-635145099958	true	userinfo.token.claim
d3c8edc6-8c96-409c-911b-635145099958	updatedAt	user.attribute
d3c8edc6-8c96-409c-911b-635145099958	true	id.token.claim
d3c8edc6-8c96-409c-911b-635145099958	true	access.token.claim
d3c8edc6-8c96-409c-911b-635145099958	updated_at	claim.name
d3c8edc6-8c96-409c-911b-635145099958	long	jsonType.label
e658061b-396d-450d-8dc3-19e84b42454c	true	userinfo.token.claim
e658061b-396d-450d-8dc3-19e84b42454c	middleName	user.attribute
e658061b-396d-450d-8dc3-19e84b42454c	true	id.token.claim
e658061b-396d-450d-8dc3-19e84b42454c	true	access.token.claim
e658061b-396d-450d-8dc3-19e84b42454c	middle_name	claim.name
e658061b-396d-450d-8dc3-19e84b42454c	String	jsonType.label
e66c98d0-9c8d-4605-84d9-029acc8d39f9	true	userinfo.token.claim
e66c98d0-9c8d-4605-84d9-029acc8d39f9	zoneinfo	user.attribute
e66c98d0-9c8d-4605-84d9-029acc8d39f9	true	id.token.claim
e66c98d0-9c8d-4605-84d9-029acc8d39f9	true	access.token.claim
e66c98d0-9c8d-4605-84d9-029acc8d39f9	zoneinfo	claim.name
e66c98d0-9c8d-4605-84d9-029acc8d39f9	String	jsonType.label
46c9892b-78c8-47a1-aa69-f5bdf9defc31	true	userinfo.token.claim
46c9892b-78c8-47a1-aa69-f5bdf9defc31	emailVerified	user.attribute
46c9892b-78c8-47a1-aa69-f5bdf9defc31	true	id.token.claim
46c9892b-78c8-47a1-aa69-f5bdf9defc31	true	access.token.claim
46c9892b-78c8-47a1-aa69-f5bdf9defc31	email_verified	claim.name
46c9892b-78c8-47a1-aa69-f5bdf9defc31	boolean	jsonType.label
cfe180df-61b9-4d3c-9fa9-fbd5063de16a	true	userinfo.token.claim
cfe180df-61b9-4d3c-9fa9-fbd5063de16a	email	user.attribute
cfe180df-61b9-4d3c-9fa9-fbd5063de16a	true	id.token.claim
cfe180df-61b9-4d3c-9fa9-fbd5063de16a	true	access.token.claim
cfe180df-61b9-4d3c-9fa9-fbd5063de16a	email	claim.name
cfe180df-61b9-4d3c-9fa9-fbd5063de16a	String	jsonType.label
fb5b20ba-8a7f-420a-90e6-6c2cfcf0f5d4	formatted	user.attribute.formatted
fb5b20ba-8a7f-420a-90e6-6c2cfcf0f5d4	country	user.attribute.country
fb5b20ba-8a7f-420a-90e6-6c2cfcf0f5d4	postal_code	user.attribute.postal_code
fb5b20ba-8a7f-420a-90e6-6c2cfcf0f5d4	true	userinfo.token.claim
fb5b20ba-8a7f-420a-90e6-6c2cfcf0f5d4	street	user.attribute.street
fb5b20ba-8a7f-420a-90e6-6c2cfcf0f5d4	true	id.token.claim
fb5b20ba-8a7f-420a-90e6-6c2cfcf0f5d4	region	user.attribute.region
fb5b20ba-8a7f-420a-90e6-6c2cfcf0f5d4	true	access.token.claim
fb5b20ba-8a7f-420a-90e6-6c2cfcf0f5d4	locality	user.attribute.locality
279dc3bc-056e-4364-bf53-9227b5b90ec9	true	userinfo.token.claim
279dc3bc-056e-4364-bf53-9227b5b90ec9	phoneNumberVerified	user.attribute
279dc3bc-056e-4364-bf53-9227b5b90ec9	true	id.token.claim
279dc3bc-056e-4364-bf53-9227b5b90ec9	true	access.token.claim
279dc3bc-056e-4364-bf53-9227b5b90ec9	phone_number_verified	claim.name
279dc3bc-056e-4364-bf53-9227b5b90ec9	boolean	jsonType.label
e81b2cd7-6de7-4396-9cfe-a1268987c8fb	true	userinfo.token.claim
e81b2cd7-6de7-4396-9cfe-a1268987c8fb	phoneNumber	user.attribute
e81b2cd7-6de7-4396-9cfe-a1268987c8fb	true	id.token.claim
e81b2cd7-6de7-4396-9cfe-a1268987c8fb	true	access.token.claim
e81b2cd7-6de7-4396-9cfe-a1268987c8fb	phone_number	claim.name
e81b2cd7-6de7-4396-9cfe-a1268987c8fb	String	jsonType.label
e32bca0e-9447-4353-8dd8-7d4da48d2dd5	true	multivalued
e32bca0e-9447-4353-8dd8-7d4da48d2dd5	foo	user.attribute
e32bca0e-9447-4353-8dd8-7d4da48d2dd5	true	access.token.claim
e32bca0e-9447-4353-8dd8-7d4da48d2dd5	realm_access.roles	claim.name
e32bca0e-9447-4353-8dd8-7d4da48d2dd5	String	jsonType.label
ee1eff27-3bf2-4edb-b046-1eab26f585b7	true	multivalued
ee1eff27-3bf2-4edb-b046-1eab26f585b7	foo	user.attribute
ee1eff27-3bf2-4edb-b046-1eab26f585b7	true	access.token.claim
ee1eff27-3bf2-4edb-b046-1eab26f585b7	resource_access.${client_id}.roles	claim.name
ee1eff27-3bf2-4edb-b046-1eab26f585b7	String	jsonType.label
3d89c7ce-ca48-497e-803d-6cc9802ce9ad	true	userinfo.token.claim
3d89c7ce-ca48-497e-803d-6cc9802ce9ad	username	user.attribute
3d89c7ce-ca48-497e-803d-6cc9802ce9ad	true	id.token.claim
3d89c7ce-ca48-497e-803d-6cc9802ce9ad	true	access.token.claim
3d89c7ce-ca48-497e-803d-6cc9802ce9ad	upn	claim.name
3d89c7ce-ca48-497e-803d-6cc9802ce9ad	String	jsonType.label
c4519b2b-1fc8-4265-932c-7afe266a9466	true	multivalued
c4519b2b-1fc8-4265-932c-7afe266a9466	foo	user.attribute
c4519b2b-1fc8-4265-932c-7afe266a9466	true	id.token.claim
c4519b2b-1fc8-4265-932c-7afe266a9466	true	access.token.claim
c4519b2b-1fc8-4265-932c-7afe266a9466	groups	claim.name
c4519b2b-1fc8-4265-932c-7afe266a9466	String	jsonType.label
c0bcbb69-e1cc-4e37-b5fe-1c8004cf0b01	true	id.token.claim
c0bcbb69-e1cc-4e37-b5fe-1c8004cf0b01	true	access.token.claim
b97e3147-ffa1-4bc1-965b-5418b56f1687	true	userinfo.token.claim
b97e3147-ffa1-4bc1-965b-5418b56f1687	locale	user.attribute
b97e3147-ffa1-4bc1-965b-5418b56f1687	true	id.token.claim
b97e3147-ffa1-4bc1-965b-5418b56f1687	true	access.token.claim
b97e3147-ffa1-4bc1-965b-5418b56f1687	locale	claim.name
b97e3147-ffa1-4bc1-965b-5418b56f1687	String	jsonType.label
84e15161-3603-45fb-bd7f-23282a335558	clientAddress	user.session.note
84e15161-3603-45fb-bd7f-23282a335558	true	id.token.claim
84e15161-3603-45fb-bd7f-23282a335558	true	access.token.claim
84e15161-3603-45fb-bd7f-23282a335558	clientAddress	claim.name
84e15161-3603-45fb-bd7f-23282a335558	String	jsonType.label
9ac51100-8878-4e17-8fa6-8ae085341dc9	clientId	user.session.note
9ac51100-8878-4e17-8fa6-8ae085341dc9	true	id.token.claim
9ac51100-8878-4e17-8fa6-8ae085341dc9	true	access.token.claim
9ac51100-8878-4e17-8fa6-8ae085341dc9	clientId	claim.name
9ac51100-8878-4e17-8fa6-8ae085341dc9	String	jsonType.label
a862dc19-b69d-4085-a819-cfaf4bbe4e89	clientHost	user.session.note
a862dc19-b69d-4085-a819-cfaf4bbe4e89	true	id.token.claim
a862dc19-b69d-4085-a819-cfaf4bbe4e89	true	access.token.claim
a862dc19-b69d-4085-a819-cfaf4bbe4e89	clientHost	claim.name
a862dc19-b69d-4085-a819-cfaf4bbe4e89	String	jsonType.label
\.


--
-- Data for Name: realm; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm (id, access_code_lifespan, user_action_lifespan, access_token_lifespan, account_theme, admin_theme, email_theme, enabled, events_enabled, events_expiration, login_theme, name, not_before, password_policy, registration_allowed, remember_me, reset_password_allowed, social, ssl_required, sso_idle_timeout, sso_max_lifespan, update_profile_on_soc_login, verify_email, master_admin_client, login_lifespan, internationalization_enabled, default_locale, reg_email_as_username, admin_events_enabled, admin_events_details_enabled, edit_username_allowed, otp_policy_counter, otp_policy_window, otp_policy_period, otp_policy_digits, otp_policy_alg, otp_policy_type, browser_flow, registration_flow, direct_grant_flow, reset_credentials_flow, client_auth_flow, offline_session_idle_timeout, revoke_refresh_token, access_token_life_implicit, login_with_email_allowed, duplicate_emails_allowed, docker_auth_flow, refresh_token_max_reuse, allow_user_managed_access, sso_max_lifespan_remember_me, sso_idle_timeout_remember_me, default_role) FROM stdin;
e480d6f0-0699-495a-9096-dec0cacb5180	60	300	300	\N	\N	\N	t	f	0	\N	myrealm	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	6a60ad1e-acb2-4328-91aa-b79ccf6a9da6	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	e603fa14-cfef-4fba-808c-b89c80e07553	bd939d67-e10e-41f7-ab09-00d26c395961	d248b326-dda8-4faf-9fde-f11f7e904d4a	f5d7fee1-9dda-47b4-bf17-ff7b984a1e91	945c7900-904d-4c9d-b480-bbd6db27f5a5	2592000	f	900	t	f	216e064e-c9a2-4aab-960a-971d06679f7c	0	f	0	0	60c243a8-5856-494c-b920-08ef509d1efa
4cf78245-f05a-4020-a9da-201ab9860d6d	60	300	60	\N	\N	\N	t	f	0	\N	master	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	354c75ff-d75f-448b-a864-a15f2a03b035	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	2805febd-6426-4628-95cf-769d482dd9f1	bcc12e4f-be83-4cee-82db-487770e6b06b	1224a98d-7bf8-43f6-9c52-072b04ac9046	c80116c3-9fd4-46c0-943c-a2eb7accb5b2	7bbd9be7-d8fa-48b0-bf81-67e900185b99	2592000	f	900	t	f	73442a69-7046-418b-adc3-000086d1112c	0	f	0	0	8347d92a-da11-4d52-bc3c-a1b8ade43860
\.


--
-- Data for Name: realm_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_attribute (name, realm_id, value) FROM stdin;
_browser_header.contentSecurityPolicyReportOnly	4cf78245-f05a-4020-a9da-201ab9860d6d
_browser_header.xContentTypeOptions	4cf78245-f05a-4020-a9da-201ab9860d6d	nosniff
_browser_header.xRobotsTag	4cf78245-f05a-4020-a9da-201ab9860d6d	none
_browser_header.xFrameOptions	4cf78245-f05a-4020-a9da-201ab9860d6d	SAMEORIGIN
_browser_header.contentSecurityPolicy	4cf78245-f05a-4020-a9da-201ab9860d6d	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	4cf78245-f05a-4020-a9da-201ab9860d6d	1; mode=block
_browser_header.strictTransportSecurity	4cf78245-f05a-4020-a9da-201ab9860d6d	max-age=31536000; includeSubDomains
bruteForceProtected	4cf78245-f05a-4020-a9da-201ab9860d6d	false
permanentLockout	4cf78245-f05a-4020-a9da-201ab9860d6d	false
maxFailureWaitSeconds	4cf78245-f05a-4020-a9da-201ab9860d6d	900
minimumQuickLoginWaitSeconds	4cf78245-f05a-4020-a9da-201ab9860d6d	60
waitIncrementSeconds	4cf78245-f05a-4020-a9da-201ab9860d6d	60
quickLoginCheckMilliSeconds	4cf78245-f05a-4020-a9da-201ab9860d6d	1000
maxDeltaTimeSeconds	4cf78245-f05a-4020-a9da-201ab9860d6d	43200
failureFactor	4cf78245-f05a-4020-a9da-201ab9860d6d	30
realmReusableOtpCode	4cf78245-f05a-4020-a9da-201ab9860d6d	false
displayName	4cf78245-f05a-4020-a9da-201ab9860d6d	Keycloak
displayNameHtml	4cf78245-f05a-4020-a9da-201ab9860d6d	<div class="kc-logo-text"><span>Keycloak</span></div>
defaultSignatureAlgorithm	4cf78245-f05a-4020-a9da-201ab9860d6d	RS256
offlineSessionMaxLifespanEnabled	4cf78245-f05a-4020-a9da-201ab9860d6d	false
offlineSessionMaxLifespan	4cf78245-f05a-4020-a9da-201ab9860d6d	5184000
realmReusableOtpCode	e480d6f0-0699-495a-9096-dec0cacb5180	false
oauth2DeviceCodeLifespan	e480d6f0-0699-495a-9096-dec0cacb5180	600
oauth2DevicePollingInterval	e480d6f0-0699-495a-9096-dec0cacb5180	5
cibaBackchannelTokenDeliveryMode	e480d6f0-0699-495a-9096-dec0cacb5180	poll
cibaExpiresIn	e480d6f0-0699-495a-9096-dec0cacb5180	120
cibaInterval	e480d6f0-0699-495a-9096-dec0cacb5180	5
cibaAuthRequestedUserHint	e480d6f0-0699-495a-9096-dec0cacb5180	login_hint
parRequestUriLifespan	e480d6f0-0699-495a-9096-dec0cacb5180	60
acr.loa.map	e480d6f0-0699-495a-9096-dec0cacb5180	{}
frontendUrl	e480d6f0-0699-495a-9096-dec0cacb5180
clientSessionIdleTimeout	e480d6f0-0699-495a-9096-dec0cacb5180	0
clientSessionMaxLifespan	e480d6f0-0699-495a-9096-dec0cacb5180	0
clientOfflineSessionIdleTimeout	e480d6f0-0699-495a-9096-dec0cacb5180	0
clientOfflineSessionMaxLifespan	e480d6f0-0699-495a-9096-dec0cacb5180	0
displayName	e480d6f0-0699-495a-9096-dec0cacb5180	myrealm
displayNameHtml	e480d6f0-0699-495a-9096-dec0cacb5180
bruteForceProtected	e480d6f0-0699-495a-9096-dec0cacb5180	false
permanentLockout	e480d6f0-0699-495a-9096-dec0cacb5180	false
maxFailureWaitSeconds	e480d6f0-0699-495a-9096-dec0cacb5180	900
minimumQuickLoginWaitSeconds	e480d6f0-0699-495a-9096-dec0cacb5180	60
waitIncrementSeconds	e480d6f0-0699-495a-9096-dec0cacb5180	60
quickLoginCheckMilliSeconds	e480d6f0-0699-495a-9096-dec0cacb5180	1000
maxDeltaTimeSeconds	e480d6f0-0699-495a-9096-dec0cacb5180	43200
failureFactor	e480d6f0-0699-495a-9096-dec0cacb5180	30
actionTokenGeneratedByAdminLifespan	e480d6f0-0699-495a-9096-dec0cacb5180	43200
actionTokenGeneratedByUserLifespan	e480d6f0-0699-495a-9096-dec0cacb5180	300
defaultSignatureAlgorithm	e480d6f0-0699-495a-9096-dec0cacb5180	RS256
offlineSessionMaxLifespanEnabled	e480d6f0-0699-495a-9096-dec0cacb5180	false
offlineSessionMaxLifespan	e480d6f0-0699-495a-9096-dec0cacb5180	5184000
webAuthnPolicyRpEntityName	e480d6f0-0699-495a-9096-dec0cacb5180	keycloak
webAuthnPolicySignatureAlgorithms	e480d6f0-0699-495a-9096-dec0cacb5180	ES256
webAuthnPolicyRpId	e480d6f0-0699-495a-9096-dec0cacb5180
webAuthnPolicyAttestationConveyancePreference	e480d6f0-0699-495a-9096-dec0cacb5180	not specified
webAuthnPolicyAuthenticatorAttachment	e480d6f0-0699-495a-9096-dec0cacb5180	not specified
webAuthnPolicyRequireResidentKey	e480d6f0-0699-495a-9096-dec0cacb5180	not specified
webAuthnPolicyUserVerificationRequirement	e480d6f0-0699-495a-9096-dec0cacb5180	not specified
webAuthnPolicyCreateTimeout	e480d6f0-0699-495a-9096-dec0cacb5180	0
webAuthnPolicyAvoidSameAuthenticatorRegister	e480d6f0-0699-495a-9096-dec0cacb5180	false
webAuthnPolicyRpEntityNamePasswordless	e480d6f0-0699-495a-9096-dec0cacb5180	keycloak
webAuthnPolicySignatureAlgorithmsPasswordless	e480d6f0-0699-495a-9096-dec0cacb5180	ES256
webAuthnPolicyRpIdPasswordless	e480d6f0-0699-495a-9096-dec0cacb5180
webAuthnPolicyAttestationConveyancePreferencePasswordless	e480d6f0-0699-495a-9096-dec0cacb5180	not specified
webAuthnPolicyAuthenticatorAttachmentPasswordless	e480d6f0-0699-495a-9096-dec0cacb5180	not specified
webAuthnPolicyRequireResidentKeyPasswordless	e480d6f0-0699-495a-9096-dec0cacb5180	not specified
webAuthnPolicyUserVerificationRequirementPasswordless	e480d6f0-0699-495a-9096-dec0cacb5180	not specified
webAuthnPolicyCreateTimeoutPasswordless	e480d6f0-0699-495a-9096-dec0cacb5180	0
webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless	e480d6f0-0699-495a-9096-dec0cacb5180	false
client-policies.profiles	e480d6f0-0699-495a-9096-dec0cacb5180	{"profiles":[]}
client-policies.policies	e480d6f0-0699-495a-9096-dec0cacb5180	{"policies":[]}
_browser_header.contentSecurityPolicyReportOnly	e480d6f0-0699-495a-9096-dec0cacb5180
_browser_header.xContentTypeOptions	e480d6f0-0699-495a-9096-dec0cacb5180	nosniff
_browser_header.xRobotsTag	e480d6f0-0699-495a-9096-dec0cacb5180	none
_browser_header.xFrameOptions	e480d6f0-0699-495a-9096-dec0cacb5180	SAMEORIGIN
_browser_header.contentSecurityPolicy	e480d6f0-0699-495a-9096-dec0cacb5180	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	e480d6f0-0699-495a-9096-dec0cacb5180	1; mode=block
_browser_header.strictTransportSecurity	e480d6f0-0699-495a-9096-dec0cacb5180	max-age=31536000; includeSubDomains
\.


--
-- Data for Name: realm_default_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_default_groups (realm_id, group_id) FROM stdin;
\.


--
-- Data for Name: realm_enabled_event_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_enabled_event_types (realm_id, value) FROM stdin;
\.


--
-- Data for Name: realm_events_listeners; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_events_listeners (realm_id, value) FROM stdin;
4cf78245-f05a-4020-a9da-201ab9860d6d	jboss-logging
e480d6f0-0699-495a-9096-dec0cacb5180	jboss-logging
\.


--
-- Data for Name: realm_localizations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_localizations (realm_id, locale, texts) FROM stdin;
\.


--
-- Data for Name: realm_required_credential; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_required_credential (type, form_label, input, secret, realm_id) FROM stdin;
password	password	t	t	4cf78245-f05a-4020-a9da-201ab9860d6d
password	password	t	t	e480d6f0-0699-495a-9096-dec0cacb5180
\.


--
-- Data for Name: realm_smtp_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_smtp_config (realm_id, value, name) FROM stdin;
\.


--
-- Data for Name: realm_supported_locales; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_supported_locales (realm_id, value) FROM stdin;
\.


--
-- Data for Name: redirect_uris; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.redirect_uris (client_id, value) FROM stdin;
aa4caee7-014b-4a77-9c6e-b66a19602c9f	/realms/master/account/*
4f07f38b-0e6f-426c-b5d1-369b09db7cfc	/realms/master/account/*
daf774fc-7c22-44f0-a5f2-0c88cc4e6b20	/admin/master/console/*
d48ad890-9172-4e3f-9d6e-898de4412752	/realms/myrealm/account/*
49ecb9f6-bd6f-433d-bbcb-5579bea2b3b5	/realms/myrealm/account/*
7b85e5dc-1441-431d-a843-941c35defc9c	/admin/myrealm/console/*
edda3079-f9f1-49de-9d18-8840096fe1e5	http://localhost/
edda3079-f9f1-49de-9d18-8840096fe1e5	http://localhost:8090
edda3079-f9f1-49de-9d18-8840096fe1e5	http://localhost:8090/*
edda3079-f9f1-49de-9d18-8840096fe1e5	http://localhost/*
edda3079-f9f1-49de-9d18-8840096fe1e5	http://localhost
edda3079-f9f1-49de-9d18-8840096fe1e5	http://localhost:8090/
\.


--
-- Data for Name: required_action_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.required_action_config (required_action_id, value, name) FROM stdin;
\.


--
-- Data for Name: required_action_provider; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) FROM stdin;
4925f074-4cba-4a9a-9d45-f08728ca68b1	VERIFY_EMAIL	Verify Email	4cf78245-f05a-4020-a9da-201ab9860d6d	t	f	VERIFY_EMAIL	50
f24d7274-e16a-4bc2-af81-3aa18dafd71a	UPDATE_PROFILE	Update Profile	4cf78245-f05a-4020-a9da-201ab9860d6d	t	f	UPDATE_PROFILE	40
69dbb68b-9f6f-4c06-a4d5-ed5a35a7b426	CONFIGURE_TOTP	Configure OTP	4cf78245-f05a-4020-a9da-201ab9860d6d	t	f	CONFIGURE_TOTP	10
20c954e5-2d0a-4cf6-a793-494354483da6	UPDATE_PASSWORD	Update Password	4cf78245-f05a-4020-a9da-201ab9860d6d	t	f	UPDATE_PASSWORD	30
bed20255-9f83-43c2-ace6-5780f80f9271	delete_account	Delete Account	4cf78245-f05a-4020-a9da-201ab9860d6d	f	f	delete_account	60
4ee66a4a-126a-4b00-a8b1-c1fb1f3b51c5	update_user_locale	Update User Locale	4cf78245-f05a-4020-a9da-201ab9860d6d	t	f	update_user_locale	1000
a62e46a8-0002-4525-87ad-59f781c336a6	webauthn-register	Webauthn Register	4cf78245-f05a-4020-a9da-201ab9860d6d	t	f	webauthn-register	70
8d56a3c6-bcf4-4ba0-9f31-908414e83262	webauthn-register-passwordless	Webauthn Register Passwordless	4cf78245-f05a-4020-a9da-201ab9860d6d	t	f	webauthn-register-passwordless	80
661492e8-2ca3-45c8-97ce-9caa139095c7	VERIFY_EMAIL	Verify Email	e480d6f0-0699-495a-9096-dec0cacb5180	t	f	VERIFY_EMAIL	50
969c0083-f3b3-4807-a47b-0edbac06fc4e	UPDATE_PROFILE	Update Profile	e480d6f0-0699-495a-9096-dec0cacb5180	t	f	UPDATE_PROFILE	40
dda6cb06-7554-40f9-97aa-88a1a874a014	CONFIGURE_TOTP	Configure OTP	e480d6f0-0699-495a-9096-dec0cacb5180	t	f	CONFIGURE_TOTP	10
cb4ee7de-a349-4d87-ac5d-711d0ff58f90	UPDATE_PASSWORD	Update Password	e480d6f0-0699-495a-9096-dec0cacb5180	t	f	UPDATE_PASSWORD	30
8508ba51-1d1b-4572-83d1-bd3b42c4718e	delete_account	Delete Account	e480d6f0-0699-495a-9096-dec0cacb5180	f	f	delete_account	60
b6d34c7a-f1ac-419b-9e9d-e354c76e2baa	update_user_locale	Update User Locale	e480d6f0-0699-495a-9096-dec0cacb5180	t	f	update_user_locale	1000
5b2d938d-3fb6-4867-8a3f-d86563e2ab85	webauthn-register	Webauthn Register	e480d6f0-0699-495a-9096-dec0cacb5180	t	f	webauthn-register	70
1bef947a-446d-4f15-b10a-a17e3b4b9f69	webauthn-register-passwordless	Webauthn Register Passwordless	e480d6f0-0699-495a-9096-dec0cacb5180	t	f	webauthn-register-passwordless	80
3cf5d742-9986-4594-89ef-db9bd10583bd	TERMS_AND_CONDITIONS	Terms and Conditions	4cf78245-f05a-4020-a9da-201ab9860d6d	f	f	TERMS_AND_CONDITIONS	20
0cbba2e0-51d4-4f9a-8d26-3104b32dc9ed	TERMS_AND_CONDITIONS	Terms and Conditions	e480d6f0-0699-495a-9096-dec0cacb5180	f	f	TERMS_AND_CONDITIONS	20
\.


--
-- Data for Name: resource_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_attribute (id, name, value, resource_id) FROM stdin;
\.


--
-- Data for Name: resource_policy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_policy (resource_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_scope (resource_id, scope_id) FROM stdin;
\.


--
-- Data for Name: resource_server; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_server (id, allow_rs_remote_mgmt, policy_enforce_mode, decision_strategy) FROM stdin;
edda3079-f9f1-49de-9d18-8840096fe1e5	t	1	0
\.


--
-- Data for Name: resource_server_perm_ticket; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_server_perm_ticket (id, owner, requester, created_timestamp, granted_timestamp, resource_id, scope_id, resource_server_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_server_policy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_server_policy (id, name, description, type, decision_strategy, logic, resource_server_id, owner) FROM stdin;
a75ced29-ac24-4a56-af44-26a4e38ca2de	Default Policy	A policy that grants access only for users within this realm	js	0	0	edda3079-f9f1-49de-9d18-8840096fe1e5	\N
8c6c1e91-cdb5-4149-848c-36b99cb96760	Default Permission	A permission that applies to the default resource type	resource	1	0	edda3079-f9f1-49de-9d18-8840096fe1e5	\N
\.


--
-- Data for Name: resource_server_resource; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_server_resource (id, name, type, icon_uri, owner, resource_server_id, owner_managed_access, display_name) FROM stdin;
7c4823b5-7fc8-41d2-8fc8-531139e14107	Default Resource	urn:phone_catalog-back:resources:default	\N	edda3079-f9f1-49de-9d18-8840096fe1e5	edda3079-f9f1-49de-9d18-8840096fe1e5	f	\N
\.


--
-- Data for Name: resource_server_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_server_scope (id, name, icon_uri, resource_server_id, display_name) FROM stdin;
\.


--
-- Data for Name: resource_uris; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_uris (resource_id, value) FROM stdin;
7c4823b5-7fc8-41d2-8fc8-531139e14107	/*
\.


--
-- Data for Name: role_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.role_attribute (id, role_id, name, value) FROM stdin;
\.


--
-- Data for Name: scope_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.scope_mapping (client_id, role_id) FROM stdin;
4f07f38b-0e6f-426c-b5d1-369b09db7cfc	ecab7f9f-e33a-4b2d-bafb-4fedc3ea0f0d
4f07f38b-0e6f-426c-b5d1-369b09db7cfc	c22c8706-8805-4f95-add9-c7d0653da296
49ecb9f6-bd6f-433d-bbcb-5579bea2b3b5	c4b0099a-ce9f-47c3-8d5d-33e1102987d3
49ecb9f6-bd6f-433d-bbcb-5579bea2b3b5	07b123e9-8745-4a7d-99ef-bf7efeb55cbc
\.


--
-- Data for Name: scope_policy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.scope_policy (scope_id, policy_id) FROM stdin;
\.


--
-- Data for Name: user_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_attribute (name, value, user_id, id) FROM stdin;
\.


--
-- Data for Name: user_consent; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_consent (id, client_id, user_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: user_consent_client_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_consent_client_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: user_entity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_entity (id, email, email_constraint, email_verified, enabled, federation_link, first_name, last_name, realm_id, username, created_timestamp, service_account_client_link, not_before) FROM stdin;
c7529a35-ec12-461a-a437-e22b1d3a682b	\N	da0f1f4a-829e-4b75-bed4-c06ec1ec26db	f	t	\N	\N	\N	4cf78245-f05a-4020-a9da-201ab9860d6d	admin	1688735873230	\N	0
71940903-dc03-4753-bac3-c5e8de99ada8	\N	c6134500-6290-41cc-9d4b-c97317314888	f	t	\N			4cf78245-f05a-4020-a9da-201ab9860d6d	reader	1688984851546	\N	0
0f45f5fe-f12b-42ac-b174-cb6b45d93e6c	\N	b88b2d51-8c88-49fa-b25a-5e9ae9e44669	f	t	\N			4cf78245-f05a-4020-a9da-201ab9860d6d	editor	1688984905097	\N	0
23583b7b-3c63-4cd1-a865-57d027ed2f48	\N	187207bb-a24f-47b8-90ec-db258d087ad3	f	t	\N			e480d6f0-0699-495a-9096-dec0cacb5180	admin	1688985311083	\N	0
2b2518fb-6697-4b48-8561-1d4896fc2dc1	\N	537168e7-31d0-492e-8b57-36c33806222c	f	t	\N			e480d6f0-0699-495a-9096-dec0cacb5180	reader	1688985358684	\N	0
109ce5c2-fe9b-4a45-86a5-d0499dd64e3c	\N	98b1bcb2-b577-44b3-98e0-fab57bff12a1	f	t	\N			e480d6f0-0699-495a-9096-dec0cacb5180	editor	1688985406094	\N	0
af33f61b-8e1d-409e-9149-100ccb3372e7	\N	4ab1a57d-02e9-4709-b3f0-291ed0966d72	f	t	\N	\N	\N	e480d6f0-0699-495a-9096-dec0cacb5180	service-account-phone_catalog-back	1688990740298	edda3079-f9f1-49de-9d18-8840096fe1e5	0
\.


--
-- Data for Name: user_federation_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_federation_config (user_federation_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_federation_mapper (id, name, federation_provider_id, federation_mapper_type, realm_id) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_federation_mapper_config (user_federation_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_provider; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_federation_provider (id, changed_sync_period, display_name, full_sync_period, last_sync, priority, provider_name, realm_id) FROM stdin;
\.


--
-- Data for Name: user_group_membership; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_group_membership (group_id, user_id) FROM stdin;
\.


--
-- Data for Name: user_required_action; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_required_action (user_id, required_action) FROM stdin;
\.


--
-- Data for Name: user_role_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_role_mapping (role_id, user_id) FROM stdin;
8347d92a-da11-4d52-bc3c-a1b8ade43860	c7529a35-ec12-461a-a437-e22b1d3a682b
a02f6e37-02bc-47f8-b0cf-0cdc7b73328f	c7529a35-ec12-461a-a437-e22b1d3a682b
8347d92a-da11-4d52-bc3c-a1b8ade43860	71940903-dc03-4753-bac3-c5e8de99ada8
8347d92a-da11-4d52-bc3c-a1b8ade43860	0f45f5fe-f12b-42ac-b174-cb6b45d93e6c
ef798bac-367e-4f98-bc4a-a1af8261fb62	c7529a35-ec12-461a-a437-e22b1d3a682b
9aa3fbf6-97ac-4955-90ad-e37699628ee7	c7529a35-ec12-461a-a437-e22b1d3a682b
d6dae02e-af32-4bf2-8b6d-bdb9d6d0cb26	c7529a35-ec12-461a-a437-e22b1d3a682b
b4e95889-65bc-4993-b382-80d51fbd2998	c7529a35-ec12-461a-a437-e22b1d3a682b
9aa3fbf6-97ac-4955-90ad-e37699628ee7	0f45f5fe-f12b-42ac-b174-cb6b45d93e6c
d6dae02e-af32-4bf2-8b6d-bdb9d6d0cb26	0f45f5fe-f12b-42ac-b174-cb6b45d93e6c
b4e95889-65bc-4993-b382-80d51fbd2998	0f45f5fe-f12b-42ac-b174-cb6b45d93e6c
d6dae02e-af32-4bf2-8b6d-bdb9d6d0cb26	71940903-dc03-4753-bac3-c5e8de99ada8
b4e95889-65bc-4993-b382-80d51fbd2998	71940903-dc03-4753-bac3-c5e8de99ada8
dd0509ee-b187-42dc-909c-b9a225ffe448	c7529a35-ec12-461a-a437-e22b1d3a682b
2c4d25c1-527d-4066-bc3b-6fbc7a564861	c7529a35-ec12-461a-a437-e22b1d3a682b
88ea6abb-e897-4153-a9d6-3c0449a0e42b	c7529a35-ec12-461a-a437-e22b1d3a682b
8acacfc5-5418-4eb7-8e86-c64417db1547	c7529a35-ec12-461a-a437-e22b1d3a682b
fe3f25aa-0146-4c35-a62f-22d328e3bb40	c7529a35-ec12-461a-a437-e22b1d3a682b
8c2249f1-50b4-413b-91ad-d5d7a8f0956f	c7529a35-ec12-461a-a437-e22b1d3a682b
10cd4f64-daea-49fa-b384-578b218fa999	c7529a35-ec12-461a-a437-e22b1d3a682b
432dc261-01f6-4267-ae0d-8d0d4d905714	c7529a35-ec12-461a-a437-e22b1d3a682b
fe483fb0-109c-4da6-b4e0-b78147907288	c7529a35-ec12-461a-a437-e22b1d3a682b
0837bbf1-4d84-45bf-9edd-e6149c15bda9	c7529a35-ec12-461a-a437-e22b1d3a682b
99be3cec-3467-4171-81a7-89d50d7113bc	c7529a35-ec12-461a-a437-e22b1d3a682b
604d14c3-2ef7-4363-bdb1-76f3d049af05	c7529a35-ec12-461a-a437-e22b1d3a682b
5b07ed4a-e7bf-4776-a7a6-409a46c6a577	c7529a35-ec12-461a-a437-e22b1d3a682b
7b3e1df7-7978-450c-80b8-f02092b664a7	c7529a35-ec12-461a-a437-e22b1d3a682b
57ada925-baab-4163-89cc-1893ed954c5c	c7529a35-ec12-461a-a437-e22b1d3a682b
967d4437-e039-4a19-9262-71d5c0fb1557	c7529a35-ec12-461a-a437-e22b1d3a682b
60ce9b8e-03bb-45d1-87bb-89cdeb949c8f	c7529a35-ec12-461a-a437-e22b1d3a682b
60c243a8-5856-494c-b920-08ef509d1efa	23583b7b-3c63-4cd1-a865-57d027ed2f48
60c243a8-5856-494c-b920-08ef509d1efa	2b2518fb-6697-4b48-8561-1d4896fc2dc1
fbfe5ce0-0483-452b-8dc8-53333b6a6a86	2b2518fb-6697-4b48-8561-1d4896fc2dc1
43707abe-f8a2-40e7-bece-e57b69a219e4	2b2518fb-6697-4b48-8561-1d4896fc2dc1
1ab7ed83-5270-43bc-adea-583357d65b5e	23583b7b-3c63-4cd1-a865-57d027ed2f48
227e04bf-39a6-4be4-b486-ae390faa7ae8	23583b7b-3c63-4cd1-a865-57d027ed2f48
fbfe5ce0-0483-452b-8dc8-53333b6a6a86	23583b7b-3c63-4cd1-a865-57d027ed2f48
43707abe-f8a2-40e7-bece-e57b69a219e4	23583b7b-3c63-4cd1-a865-57d027ed2f48
60c243a8-5856-494c-b920-08ef509d1efa	109ce5c2-fe9b-4a45-86a5-d0499dd64e3c
227e04bf-39a6-4be4-b486-ae390faa7ae8	109ce5c2-fe9b-4a45-86a5-d0499dd64e3c
fbfe5ce0-0483-452b-8dc8-53333b6a6a86	109ce5c2-fe9b-4a45-86a5-d0499dd64e3c
43707abe-f8a2-40e7-bece-e57b69a219e4	109ce5c2-fe9b-4a45-86a5-d0499dd64e3c
60c243a8-5856-494c-b920-08ef509d1efa	af33f61b-8e1d-409e-9149-100ccb3372e7
02024df6-f3bc-4d98-ba6b-3226376412e5	af33f61b-8e1d-409e-9149-100ccb3372e7
fd96c760-3bd5-463a-aec4-3e8ce3b3dab8	23583b7b-3c63-4cd1-a865-57d027ed2f48
289d6130-e2f3-4ccf-b765-48103f137640	23583b7b-3c63-4cd1-a865-57d027ed2f48
1225579e-a176-4d8b-bc42-7f0592c65091	23583b7b-3c63-4cd1-a865-57d027ed2f48
\.


--
-- Data for Name: user_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_session (id, auth_method, ip_address, last_session_refresh, login_username, realm_id, remember_me, started, user_id, user_session_state, broker_session_id, broker_user_id) FROM stdin;
\.


--
-- Data for Name: user_session_note; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_session_note (user_session, name, value) FROM stdin;
\.


--
-- Data for Name: username_login_failure; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.username_login_failure (realm_id, username, failed_login_not_before, last_failure, last_ip_failure, num_failures) FROM stdin;
\.


--
-- Data for Name: web_origins; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.web_origins (client_id, value) FROM stdin;
daf774fc-7c22-44f0-a5f2-0c88cc4e6b20	+
7b85e5dc-1441-431d-a843-941c35defc9c	+
edda3079-f9f1-49de-9d18-8840096fe1e5	http://localhost:8090
edda3079-f9f1-49de-9d18-8840096fe1e5	http://localhost:8090/*
edda3079-f9f1-49de-9d18-8840096fe1e5	http://localhost:8090/
\.


--
-- Name: username_login_failure CONSTRAINT_17-2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.username_login_failure
    ADD CONSTRAINT "CONSTRAINT_17-2" PRIMARY KEY (realm_id, username);


--
-- Name: keycloak_role UK_J3RWUVD56ONTGSUHOGM184WW2-2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT "UK_J3RWUVD56ONTGSUHOGM184WW2-2" UNIQUE (name, client_realm_constraint);


--
-- Name: client_auth_flow_bindings c_cli_flow_bind; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_auth_flow_bindings
    ADD CONSTRAINT c_cli_flow_bind PRIMARY KEY (client_id, binding_name);


--
-- Name: client_scope_client c_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT c_cli_scope_bind PRIMARY KEY (client_id, scope_id);


--
-- Name: client_initial_access cnstr_client_init_acc_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT cnstr_client_init_acc_pk PRIMARY KEY (id);


--
-- Name: realm_default_groups con_group_id_def_groups; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT con_group_id_def_groups UNIQUE (group_id);


--
-- Name: broker_link constr_broker_link_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.broker_link
    ADD CONSTRAINT constr_broker_link_pk PRIMARY KEY (identity_provider, user_id);


--
-- Name: client_user_session_note constr_cl_usr_ses_note; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT constr_cl_usr_ses_note PRIMARY KEY (client_session, name);


--
-- Name: component_config constr_component_config_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT constr_component_config_pk PRIMARY KEY (id);


--
-- Name: component constr_component_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT constr_component_pk PRIMARY KEY (id);


--
-- Name: fed_user_required_action constr_fed_required_action; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_required_action
    ADD CONSTRAINT constr_fed_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: fed_user_attribute constr_fed_user_attr_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_attribute
    ADD CONSTRAINT constr_fed_user_attr_pk PRIMARY KEY (id);


--
-- Name: fed_user_consent constr_fed_user_consent_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_consent
    ADD CONSTRAINT constr_fed_user_consent_pk PRIMARY KEY (id);


--
-- Name: fed_user_credential constr_fed_user_cred_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_credential
    ADD CONSTRAINT constr_fed_user_cred_pk PRIMARY KEY (id);


--
-- Name: fed_user_group_membership constr_fed_user_group; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_group_membership
    ADD CONSTRAINT constr_fed_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: fed_user_role_mapping constr_fed_user_role; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_role_mapping
    ADD CONSTRAINT constr_fed_user_role PRIMARY KEY (role_id, user_id);


--
-- Name: federated_user constr_federated_user; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.federated_user
    ADD CONSTRAINT constr_federated_user PRIMARY KEY (id);


--
-- Name: realm_default_groups constr_realm_default_groups; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT constr_realm_default_groups PRIMARY KEY (realm_id, group_id);


--
-- Name: realm_enabled_event_types constr_realm_enabl_event_types; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT constr_realm_enabl_event_types PRIMARY KEY (realm_id, value);


--
-- Name: realm_events_listeners constr_realm_events_listeners; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT constr_realm_events_listeners PRIMARY KEY (realm_id, value);


--
-- Name: realm_supported_locales constr_realm_supported_locales; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT constr_realm_supported_locales PRIMARY KEY (realm_id, value);


--
-- Name: identity_provider constraint_2b; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT constraint_2b PRIMARY KEY (internal_id);


--
-- Name: client_attributes constraint_3c; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT constraint_3c PRIMARY KEY (client_id, name);


--
-- Name: event_entity constraint_4; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_entity
    ADD CONSTRAINT constraint_4 PRIMARY KEY (id);


--
-- Name: federated_identity constraint_40; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT constraint_40 PRIMARY KEY (identity_provider, user_id);


--
-- Name: realm constraint_4a; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT constraint_4a PRIMARY KEY (id);


--
-- Name: client_session_role constraint_5; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT constraint_5 PRIMARY KEY (client_session, role_id);


--
-- Name: user_session constraint_57; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_session
    ADD CONSTRAINT constraint_57 PRIMARY KEY (id);


--
-- Name: user_federation_provider constraint_5c; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT constraint_5c PRIMARY KEY (id);


--
-- Name: client_session_note constraint_5e; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT constraint_5e PRIMARY KEY (client_session, name);


--
-- Name: client constraint_7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT constraint_7 PRIMARY KEY (id);


--
-- Name: client_session constraint_8; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT constraint_8 PRIMARY KEY (id);


--
-- Name: scope_mapping constraint_81; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT constraint_81 PRIMARY KEY (client_id, role_id);


--
-- Name: client_node_registrations constraint_84; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT constraint_84 PRIMARY KEY (client_id, name);


--
-- Name: realm_attribute constraint_9; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT constraint_9 PRIMARY KEY (name, realm_id);


--
-- Name: realm_required_credential constraint_92; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT constraint_92 PRIMARY KEY (realm_id, type);


--
-- Name: keycloak_role constraint_a; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT constraint_a PRIMARY KEY (id);


--
-- Name: admin_event_entity constraint_admin_event_entity; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin_event_entity
    ADD CONSTRAINT constraint_admin_event_entity PRIMARY KEY (id);


--
-- Name: authenticator_config_entry constraint_auth_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authenticator_config_entry
    ADD CONSTRAINT constraint_auth_cfg_pk PRIMARY KEY (authenticator_id, name);


--
-- Name: authentication_execution constraint_auth_exec_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT constraint_auth_exec_pk PRIMARY KEY (id);


--
-- Name: authentication_flow constraint_auth_flow_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT constraint_auth_flow_pk PRIMARY KEY (id);


--
-- Name: authenticator_config constraint_auth_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT constraint_auth_pk PRIMARY KEY (id);


--
-- Name: client_session_auth_status constraint_auth_status_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT constraint_auth_status_pk PRIMARY KEY (client_session, authenticator);


--
-- Name: user_role_mapping constraint_c; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT constraint_c PRIMARY KEY (role_id, user_id);


--
-- Name: composite_role constraint_composite_role; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT constraint_composite_role PRIMARY KEY (composite, child_role);


--
-- Name: client_session_prot_mapper constraint_cs_pmp_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT constraint_cs_pmp_pk PRIMARY KEY (client_session, protocol_mapper_id);


--
-- Name: identity_provider_config constraint_d; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT constraint_d PRIMARY KEY (identity_provider_id, name);


--
-- Name: policy_config constraint_dpc; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT constraint_dpc PRIMARY KEY (policy_id, name);


--
-- Name: realm_smtp_config constraint_e; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT constraint_e PRIMARY KEY (realm_id, name);


--
-- Name: credential constraint_f; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT constraint_f PRIMARY KEY (id);


--
-- Name: user_federation_config constraint_f9; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT constraint_f9 PRIMARY KEY (user_federation_provider_id, name);


--
-- Name: resource_server_perm_ticket constraint_fapmt; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT constraint_fapmt PRIMARY KEY (id);


--
-- Name: resource_server_resource constraint_farsr; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT constraint_farsr PRIMARY KEY (id);


--
-- Name: resource_server_policy constraint_farsrp; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT constraint_farsrp PRIMARY KEY (id);


--
-- Name: associated_policy constraint_farsrpap; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT constraint_farsrpap PRIMARY KEY (policy_id, associated_policy_id);


--
-- Name: resource_policy constraint_farsrpp; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT constraint_farsrpp PRIMARY KEY (resource_id, policy_id);


--
-- Name: resource_server_scope constraint_farsrs; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT constraint_farsrs PRIMARY KEY (id);


--
-- Name: resource_scope constraint_farsrsp; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT constraint_farsrsp PRIMARY KEY (resource_id, scope_id);


--
-- Name: scope_policy constraint_farsrsps; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT constraint_farsrsps PRIMARY KEY (scope_id, policy_id);


--
-- Name: user_entity constraint_fb; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT constraint_fb PRIMARY KEY (id);


--
-- Name: user_federation_mapper_config constraint_fedmapper_cfg_pm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT constraint_fedmapper_cfg_pm PRIMARY KEY (user_federation_mapper_id, name);


--
-- Name: user_federation_mapper constraint_fedmapperpm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT constraint_fedmapperpm PRIMARY KEY (id);


--
-- Name: fed_user_consent_cl_scope constraint_fgrntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_consent_cl_scope
    ADD CONSTRAINT constraint_fgrntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent_client_scope constraint_grntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT constraint_grntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent constraint_grntcsnt_pm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT constraint_grntcsnt_pm PRIMARY KEY (id);


--
-- Name: keycloak_group constraint_group; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT constraint_group PRIMARY KEY (id);


--
-- Name: group_attribute constraint_group_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT constraint_group_attribute_pk PRIMARY KEY (id);


--
-- Name: group_role_mapping constraint_group_role; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT constraint_group_role PRIMARY KEY (role_id, group_id);


--
-- Name: identity_provider_mapper constraint_idpm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT constraint_idpm PRIMARY KEY (id);


--
-- Name: idp_mapper_config constraint_idpmconfig; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT constraint_idpmconfig PRIMARY KEY (idp_mapper_id, name);


--
-- Name: migration_model constraint_migmod; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migration_model
    ADD CONSTRAINT constraint_migmod PRIMARY KEY (id);


--
-- Name: offline_client_session constraint_offl_cl_ses_pk3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.offline_client_session
    ADD CONSTRAINT constraint_offl_cl_ses_pk3 PRIMARY KEY (user_session_id, client_id, client_storage_provider, external_client_id, offline_flag);


--
-- Name: offline_user_session constraint_offl_us_ses_pk2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.offline_user_session
    ADD CONSTRAINT constraint_offl_us_ses_pk2 PRIMARY KEY (user_session_id, offline_flag);


--
-- Name: protocol_mapper constraint_pcm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT constraint_pcm PRIMARY KEY (id);


--
-- Name: protocol_mapper_config constraint_pmconfig; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT constraint_pmconfig PRIMARY KEY (protocol_mapper_id, name);


--
-- Name: redirect_uris constraint_redirect_uris; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT constraint_redirect_uris PRIMARY KEY (client_id, value);


--
-- Name: required_action_config constraint_req_act_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.required_action_config
    ADD CONSTRAINT constraint_req_act_cfg_pk PRIMARY KEY (required_action_id, name);


--
-- Name: required_action_provider constraint_req_act_prv_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT constraint_req_act_prv_pk PRIMARY KEY (id);


--
-- Name: user_required_action constraint_required_action; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT constraint_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: resource_uris constraint_resour_uris_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT constraint_resour_uris_pk PRIMARY KEY (resource_id, value);


--
-- Name: role_attribute constraint_role_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT constraint_role_attribute_pk PRIMARY KEY (id);


--
-- Name: user_attribute constraint_user_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT constraint_user_attribute_pk PRIMARY KEY (id);


--
-- Name: user_group_membership constraint_user_group; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT constraint_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: user_session_note constraint_usn_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT constraint_usn_pk PRIMARY KEY (user_session, name);


--
-- Name: web_origins constraint_web_origins; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT constraint_web_origins PRIMARY KEY (client_id, value);


--
-- Name: databasechangeloglock databasechangeloglock_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT databasechangeloglock_pkey PRIMARY KEY (id);


--
-- Name: client_scope_attributes pk_cl_tmpl_attr; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT pk_cl_tmpl_attr PRIMARY KEY (scope_id, name);


--
-- Name: client_scope pk_cli_template; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT pk_cli_template PRIMARY KEY (id);


--
-- Name: resource_server pk_resource_server; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server
    ADD CONSTRAINT pk_resource_server PRIMARY KEY (id);


--
-- Name: client_scope_role_mapping pk_template_scope; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT pk_template_scope PRIMARY KEY (scope_id, role_id);


--
-- Name: default_client_scope r_def_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT r_def_cli_scope_bind PRIMARY KEY (realm_id, scope_id);


--
-- Name: realm_localizations realm_localizations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_localizations
    ADD CONSTRAINT realm_localizations_pkey PRIMARY KEY (realm_id, locale);


--
-- Name: resource_attribute res_attr_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT res_attr_pk PRIMARY KEY (id);


--
-- Name: keycloak_group sibling_names; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT sibling_names UNIQUE (realm_id, parent_group, name);


--
-- Name: identity_provider uk_2daelwnibji49avxsrtuf6xj33; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT uk_2daelwnibji49avxsrtuf6xj33 UNIQUE (provider_alias, realm_id);


--
-- Name: client uk_b71cjlbenv945rb6gcon438at; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT uk_b71cjlbenv945rb6gcon438at UNIQUE (realm_id, client_id);


--
-- Name: client_scope uk_cli_scope; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT uk_cli_scope UNIQUE (realm_id, name);


--
-- Name: user_entity uk_dykn684sl8up1crfei6eckhd7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_dykn684sl8up1crfei6eckhd7 UNIQUE (realm_id, email_constraint);


--
-- Name: resource_server_resource uk_frsr6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5ha6 UNIQUE (name, owner, resource_server_id);


--
-- Name: resource_server_perm_ticket uk_frsr6t700s9v50bu18ws5pmt; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5pmt UNIQUE (owner, requester, resource_server_id, resource_id, scope_id);


--
-- Name: resource_server_policy uk_frsrpt700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT uk_frsrpt700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: resource_server_scope uk_frsrst700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT uk_frsrst700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: user_consent uk_jkuwuvd56ontgsuhogm8uewrt; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_jkuwuvd56ontgsuhogm8uewrt UNIQUE (client_id, client_storage_provider, external_client_id, user_id);


--
-- Name: realm uk_orvsdmla56612eaefiq6wl5oi; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT uk_orvsdmla56612eaefiq6wl5oi UNIQUE (name);


--
-- Name: user_entity uk_ru8tt6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_ru8tt6t700s9v50bu18ws5ha6 UNIQUE (realm_id, username);


--
-- Name: idx_admin_event_time; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_admin_event_time ON public.admin_event_entity USING btree (realm_id, admin_event_time);


--
-- Name: idx_assoc_pol_assoc_pol_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_assoc_pol_assoc_pol_id ON public.associated_policy USING btree (associated_policy_id);


--
-- Name: idx_auth_config_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_auth_config_realm ON public.authenticator_config USING btree (realm_id);


--
-- Name: idx_auth_exec_flow; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_auth_exec_flow ON public.authentication_execution USING btree (flow_id);


--
-- Name: idx_auth_exec_realm_flow; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_auth_exec_realm_flow ON public.authentication_execution USING btree (realm_id, flow_id);


--
-- Name: idx_auth_flow_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_auth_flow_realm ON public.authentication_flow USING btree (realm_id);


--
-- Name: idx_cl_clscope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_cl_clscope ON public.client_scope_client USING btree (scope_id);


--
-- Name: idx_client_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_client_id ON public.client USING btree (client_id);


--
-- Name: idx_client_init_acc_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_client_init_acc_realm ON public.client_initial_access USING btree (realm_id);


--
-- Name: idx_client_session_session; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_client_session_session ON public.client_session USING btree (session_id);


--
-- Name: idx_clscope_attrs; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_clscope_attrs ON public.client_scope_attributes USING btree (scope_id);


--
-- Name: idx_clscope_cl; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_clscope_cl ON public.client_scope_client USING btree (client_id);


--
-- Name: idx_clscope_protmap; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_clscope_protmap ON public.protocol_mapper USING btree (client_scope_id);


--
-- Name: idx_clscope_role; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_clscope_role ON public.client_scope_role_mapping USING btree (scope_id);


--
-- Name: idx_compo_config_compo; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_compo_config_compo ON public.component_config USING btree (component_id);


--
-- Name: idx_component_provider_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_component_provider_type ON public.component USING btree (provider_type);


--
-- Name: idx_component_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_component_realm ON public.component USING btree (realm_id);


--
-- Name: idx_composite; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_composite ON public.composite_role USING btree (composite);


--
-- Name: idx_composite_child; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_composite_child ON public.composite_role USING btree (child_role);


--
-- Name: idx_defcls_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_defcls_realm ON public.default_client_scope USING btree (realm_id);


--
-- Name: idx_defcls_scope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_defcls_scope ON public.default_client_scope USING btree (scope_id);


--
-- Name: idx_event_time; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_event_time ON public.event_entity USING btree (realm_id, event_time);


--
-- Name: idx_fedidentity_feduser; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fedidentity_feduser ON public.federated_identity USING btree (federated_user_id);


--
-- Name: idx_fedidentity_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fedidentity_user ON public.federated_identity USING btree (user_id);


--
-- Name: idx_fu_attribute; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_attribute ON public.fed_user_attribute USING btree (user_id, realm_id, name);


--
-- Name: idx_fu_cnsnt_ext; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_cnsnt_ext ON public.fed_user_consent USING btree (user_id, client_storage_provider, external_client_id);


--
-- Name: idx_fu_consent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_consent ON public.fed_user_consent USING btree (user_id, client_id);


--
-- Name: idx_fu_consent_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_consent_ru ON public.fed_user_consent USING btree (realm_id, user_id);


--
-- Name: idx_fu_credential; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_credential ON public.fed_user_credential USING btree (user_id, type);


--
-- Name: idx_fu_credential_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_credential_ru ON public.fed_user_credential USING btree (realm_id, user_id);


--
-- Name: idx_fu_group_membership; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_group_membership ON public.fed_user_group_membership USING btree (user_id, group_id);


--
-- Name: idx_fu_group_membership_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_group_membership_ru ON public.fed_user_group_membership USING btree (realm_id, user_id);


--
-- Name: idx_fu_required_action; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_required_action ON public.fed_user_required_action USING btree (user_id, required_action);


--
-- Name: idx_fu_required_action_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_required_action_ru ON public.fed_user_required_action USING btree (realm_id, user_id);


--
-- Name: idx_fu_role_mapping; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_role_mapping ON public.fed_user_role_mapping USING btree (user_id, role_id);


--
-- Name: idx_fu_role_mapping_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_role_mapping_ru ON public.fed_user_role_mapping USING btree (realm_id, user_id);


--
-- Name: idx_group_att_by_name_value; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_group_att_by_name_value ON public.group_attribute USING btree (name, ((value)::character varying(250)));


--
-- Name: idx_group_attr_group; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_group_attr_group ON public.group_attribute USING btree (group_id);


--
-- Name: idx_group_role_mapp_group; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_group_role_mapp_group ON public.group_role_mapping USING btree (group_id);


--
-- Name: idx_id_prov_mapp_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_id_prov_mapp_realm ON public.identity_provider_mapper USING btree (realm_id);


--
-- Name: idx_ident_prov_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_ident_prov_realm ON public.identity_provider USING btree (realm_id);


--
-- Name: idx_keycloak_role_client; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_keycloak_role_client ON public.keycloak_role USING btree (client);


--
-- Name: idx_keycloak_role_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_keycloak_role_realm ON public.keycloak_role USING btree (realm);


--
-- Name: idx_offline_css_preload; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offline_css_preload ON public.offline_client_session USING btree (client_id, offline_flag);


--
-- Name: idx_offline_uss_by_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offline_uss_by_user ON public.offline_user_session USING btree (user_id, realm_id, offline_flag);


--
-- Name: idx_offline_uss_by_usersess; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offline_uss_by_usersess ON public.offline_user_session USING btree (realm_id, offline_flag, user_session_id);


--
-- Name: idx_offline_uss_createdon; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offline_uss_createdon ON public.offline_user_session USING btree (created_on);


--
-- Name: idx_offline_uss_preload; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offline_uss_preload ON public.offline_user_session USING btree (offline_flag, created_on, user_session_id);


--
-- Name: idx_protocol_mapper_client; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_protocol_mapper_client ON public.protocol_mapper USING btree (client_id);


--
-- Name: idx_realm_attr_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_attr_realm ON public.realm_attribute USING btree (realm_id);


--
-- Name: idx_realm_clscope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_clscope ON public.client_scope USING btree (realm_id);


--
-- Name: idx_realm_def_grp_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_def_grp_realm ON public.realm_default_groups USING btree (realm_id);


--
-- Name: idx_realm_evt_list_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_evt_list_realm ON public.realm_events_listeners USING btree (realm_id);


--
-- Name: idx_realm_evt_types_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_evt_types_realm ON public.realm_enabled_event_types USING btree (realm_id);


--
-- Name: idx_realm_master_adm_cli; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_master_adm_cli ON public.realm USING btree (master_admin_client);


--
-- Name: idx_realm_supp_local_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_supp_local_realm ON public.realm_supported_locales USING btree (realm_id);


--
-- Name: idx_redir_uri_client; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_redir_uri_client ON public.redirect_uris USING btree (client_id);


--
-- Name: idx_req_act_prov_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_req_act_prov_realm ON public.required_action_provider USING btree (realm_id);


--
-- Name: idx_res_policy_policy; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_policy_policy ON public.resource_policy USING btree (policy_id);


--
-- Name: idx_res_scope_scope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_scope_scope ON public.resource_scope USING btree (scope_id);


--
-- Name: idx_res_serv_pol_res_serv; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_serv_pol_res_serv ON public.resource_server_policy USING btree (resource_server_id);


--
-- Name: idx_res_srv_res_res_srv; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_srv_res_res_srv ON public.resource_server_resource USING btree (resource_server_id);


--
-- Name: idx_res_srv_scope_res_srv; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_srv_scope_res_srv ON public.resource_server_scope USING btree (resource_server_id);


--
-- Name: idx_role_attribute; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_role_attribute ON public.role_attribute USING btree (role_id);


--
-- Name: idx_role_clscope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_role_clscope ON public.client_scope_role_mapping USING btree (role_id);


--
-- Name: idx_scope_mapping_role; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_scope_mapping_role ON public.scope_mapping USING btree (role_id);


--
-- Name: idx_scope_policy_policy; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_scope_policy_policy ON public.scope_policy USING btree (policy_id);


--
-- Name: idx_update_time; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_update_time ON public.migration_model USING btree (update_time);


--
-- Name: idx_us_sess_id_on_cl_sess; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_us_sess_id_on_cl_sess ON public.offline_client_session USING btree (user_session_id);


--
-- Name: idx_usconsent_clscope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usconsent_clscope ON public.user_consent_client_scope USING btree (user_consent_id);


--
-- Name: idx_user_attribute; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_attribute ON public.user_attribute USING btree (user_id);


--
-- Name: idx_user_attribute_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_attribute_name ON public.user_attribute USING btree (name, value);


--
-- Name: idx_user_consent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_consent ON public.user_consent USING btree (user_id);


--
-- Name: idx_user_credential; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_credential ON public.credential USING btree (user_id);


--
-- Name: idx_user_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_email ON public.user_entity USING btree (email);


--
-- Name: idx_user_group_mapping; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_group_mapping ON public.user_group_membership USING btree (user_id);


--
-- Name: idx_user_reqactions; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_reqactions ON public.user_required_action USING btree (user_id);


--
-- Name: idx_user_role_mapping; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_role_mapping ON public.user_role_mapping USING btree (user_id);


--
-- Name: idx_user_service_account; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_service_account ON public.user_entity USING btree (realm_id, service_account_client_link);


--
-- Name: idx_usr_fed_map_fed_prv; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usr_fed_map_fed_prv ON public.user_federation_mapper USING btree (federation_provider_id);


--
-- Name: idx_usr_fed_map_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usr_fed_map_realm ON public.user_federation_mapper USING btree (realm_id);


--
-- Name: idx_usr_fed_prv_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usr_fed_prv_realm ON public.user_federation_provider USING btree (realm_id);


--
-- Name: idx_web_orig_client; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_web_orig_client ON public.web_origins USING btree (client_id);


--
-- Name: client_session_auth_status auth_status_constraint; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT auth_status_constraint FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: identity_provider fk2b4ebc52ae5c3b34; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT fk2b4ebc52ae5c3b34 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_attributes fk3c47c64beacca966; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT fk3c47c64beacca966 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: federated_identity fk404288b92ef007a6; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT fk404288b92ef007a6 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_node_registrations fk4129723ba992f594; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT fk4129723ba992f594 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: client_session_note fk5edfb00ff51c2736; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT fk5edfb00ff51c2736 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: user_session_note fk5edfb00ff51d3472; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT fk5edfb00ff51d3472 FOREIGN KEY (user_session) REFERENCES public.user_session(id);


--
-- Name: client_session_role fk_11b7sgqw18i532811v7o2dv76; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT fk_11b7sgqw18i532811v7o2dv76 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: redirect_uris fk_1burs8pb4ouj97h5wuppahv9f; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT fk_1burs8pb4ouj97h5wuppahv9f FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: user_federation_provider fk_1fj32f6ptolw2qy60cd8n01e8; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT fk_1fj32f6ptolw2qy60cd8n01e8 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session_prot_mapper fk_33a8sgqw18i532811v7o2dk89; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT fk_33a8sgqw18i532811v7o2dk89 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: realm_required_credential fk_5hg65lybevavkqfki3kponh9v; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT fk_5hg65lybevavkqfki3kponh9v FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_attribute fk_5hrm2vlf9ql5fu022kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu022kqepovbr FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: user_attribute fk_5hrm2vlf9ql5fu043kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu043kqepovbr FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: user_required_action fk_6qj3w1jw9cvafhe19bwsiuvmd; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT fk_6qj3w1jw9cvafhe19bwsiuvmd FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: keycloak_role fk_6vyqfe4cn4wlq8r6kt5vdsj5c; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT fk_6vyqfe4cn4wlq8r6kt5vdsj5c FOREIGN KEY (realm) REFERENCES public.realm(id);


--
-- Name: realm_smtp_config fk_70ej8xdxgxd0b9hh6180irr0o; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT fk_70ej8xdxgxd0b9hh6180irr0o FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_attribute fk_8shxd6l3e9atqukacxgpffptw; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT fk_8shxd6l3e9atqukacxgpffptw FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: composite_role fk_a63wvekftu8jo1pnj81e7mce2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_a63wvekftu8jo1pnj81e7mce2 FOREIGN KEY (composite) REFERENCES public.keycloak_role(id);


--
-- Name: authentication_execution fk_auth_exec_flow; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_flow FOREIGN KEY (flow_id) REFERENCES public.authentication_flow(id);


--
-- Name: authentication_execution fk_auth_exec_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authentication_flow fk_auth_flow_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT fk_auth_flow_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authenticator_config fk_auth_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT fk_auth_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session fk_b4ao2vcvat6ukau74wbwtfqo1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT fk_b4ao2vcvat6ukau74wbwtfqo1 FOREIGN KEY (session_id) REFERENCES public.user_session(id);


--
-- Name: user_role_mapping fk_c4fqv34p1mbylloxang7b1q3l; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT fk_c4fqv34p1mbylloxang7b1q3l FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_scope_attributes fk_cl_scope_attr_scope; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT fk_cl_scope_attr_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_scope_role_mapping fk_cl_scope_rm_scope; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT fk_cl_scope_rm_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_user_session_note fk_cl_usr_ses_note; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT fk_cl_usr_ses_note FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: protocol_mapper fk_cli_scope_mapper; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_cli_scope_mapper FOREIGN KEY (client_scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_initial_access fk_client_init_acc_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT fk_client_init_acc_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: component_config fk_component_config; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT fk_component_config FOREIGN KEY (component_id) REFERENCES public.component(id);


--
-- Name: component fk_component_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT fk_component_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_default_groups fk_def_groups_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT fk_def_groups_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_mapper_config fk_fedmapper_cfg; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT fk_fedmapper_cfg FOREIGN KEY (user_federation_mapper_id) REFERENCES public.user_federation_mapper(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_fedprv; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_fedprv FOREIGN KEY (federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: associated_policy fk_frsr5s213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsr5s213xcx4wnkog82ssrfy FOREIGN KEY (associated_policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrasp13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrasp13xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog82sspmt; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82sspmt FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_resource fk_frsrho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog83sspmt; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog83sspmt FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog84sspmt; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog84sspmt FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: associated_policy fk_frsrpas14xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsrpas14xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrpass3xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrpass3xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_perm_ticket fk_frsrpo2128cx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrpo2128cx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_policy fk_frsrpo213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT fk_frsrpo213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_scope fk_frsrpos13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrpos13xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpos53xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpos53xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpp213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpp213xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_scope fk_frsrps213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrps213xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_scope fk_frsrso213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT fk_frsrso213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: composite_role fk_gr7thllb9lu8q4vqa4524jjy8; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_gr7thllb9lu8q4vqa4524jjy8 FOREIGN KEY (child_role) REFERENCES public.keycloak_role(id);


--
-- Name: user_consent_client_scope fk_grntcsnt_clsc_usc; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT fk_grntcsnt_clsc_usc FOREIGN KEY (user_consent_id) REFERENCES public.user_consent(id);


--
-- Name: user_consent fk_grntcsnt_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT fk_grntcsnt_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: group_attribute fk_group_attribute_group; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT fk_group_attribute_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: group_role_mapping fk_group_role_group; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT fk_group_role_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: realm_enabled_event_types fk_h846o4h0w8epx5nwedrf5y69j; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT fk_h846o4h0w8epx5nwedrf5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_events_listeners fk_h846o4h0w8epx5nxev9f5y69j; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT fk_h846o4h0w8epx5nxev9f5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: identity_provider_mapper fk_idpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT fk_idpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: idp_mapper_config fk_idpmconfig; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT fk_idpmconfig FOREIGN KEY (idp_mapper_id) REFERENCES public.identity_provider_mapper(id);


--
-- Name: web_origins fk_lojpho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT fk_lojpho213xcx4wnkog82ssrfy FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: scope_mapping fk_ouse064plmlr732lxjcn1q5f1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT fk_ouse064plmlr732lxjcn1q5f1 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: protocol_mapper fk_pcm_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_pcm_realm FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: credential fk_pfyr0glasqyl0dei3kl69r6v0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT fk_pfyr0glasqyl0dei3kl69r6v0 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: protocol_mapper_config fk_pmconfig; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT fk_pmconfig FOREIGN KEY (protocol_mapper_id) REFERENCES public.protocol_mapper(id);


--
-- Name: default_client_scope fk_r_def_cli_scope_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT fk_r_def_cli_scope_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: required_action_provider fk_req_act_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT fk_req_act_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_uris fk_resource_server_uris; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT fk_resource_server_uris FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: role_attribute fk_role_attribute_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT fk_role_attribute_id FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: realm_supported_locales fk_supported_locales_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT fk_supported_locales_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_config fk_t13hpu1j94r2ebpekr39x5eu5; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT fk_t13hpu1j94r2ebpekr39x5eu5 FOREIGN KEY (user_federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_group_membership fk_user_group_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT fk_user_group_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: policy_config fkdc34197cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT fkdc34197cf864c4e43 FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: identity_provider_config fkdc4897cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT fkdc4897cf864c4e43 FOREIGN KEY (identity_provider_id) REFERENCES public.identity_provider(internal_id);


--
-- PostgreSQL database dump complete
--

