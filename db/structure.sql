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

--
-- Name: order_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.order_status AS ENUM (
    'awaiting_delivery',
    'delivered'
);


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: admins; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.admins (
    id bigint NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: admins_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.admins_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: admins_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.admins_id_seq OWNED BY public.admins.id;


--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: company_values; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.company_values (
    id bigint NOT NULL,
    title character varying NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: company_values_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.company_values_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: company_values_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.company_values_id_seq OWNED BY public.company_values.id;


--
-- Name: employees; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.employees (
    id bigint NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    number_of_available_kudos integer DEFAULT 10 NOT NULL,
    points numeric DEFAULT 0.0 NOT NULL
);


--
-- Name: employees_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.employees_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: employees_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.employees_id_seq OWNED BY public.employees.id;


--
-- Name: kudos; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.kudos (
    id bigint NOT NULL,
    title character varying NOT NULL,
    content text NOT NULL,
    giver_id bigint NOT NULL,
    receiver_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    company_value_id bigint NOT NULL
);


--
-- Name: kudos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.kudos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: kudos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.kudos_id_seq OWNED BY public.kudos.id;


--
-- Name: orders; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.orders (
    id bigint NOT NULL,
    reward text NOT NULL,
    buyer_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    status public.order_status DEFAULT 'awaiting_delivery'::public.order_status NOT NULL
);


--
-- Name: orders_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.orders_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.orders_id_seq OWNED BY public.orders.id;


--
-- Name: rewards; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.rewards (
    id bigint NOT NULL,
    title character varying NOT NULL,
    description text NOT NULL,
    price numeric NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: rewards_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.rewards_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: rewards_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.rewards_id_seq OWNED BY public.rewards.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: admins id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admins ALTER COLUMN id SET DEFAULT nextval('public.admins_id_seq'::regclass);


--
-- Name: company_values id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.company_values ALTER COLUMN id SET DEFAULT nextval('public.company_values_id_seq'::regclass);


--
-- Name: employees id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.employees ALTER COLUMN id SET DEFAULT nextval('public.employees_id_seq'::regclass);


--
-- Name: kudos id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.kudos ALTER COLUMN id SET DEFAULT nextval('public.kudos_id_seq'::regclass);


--
-- Name: orders id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orders ALTER COLUMN id SET DEFAULT nextval('public.orders_id_seq'::regclass);


--
-- Name: rewards id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rewards ALTER COLUMN id SET DEFAULT nextval('public.rewards_id_seq'::regclass);


--
-- Name: admins admins_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admins
    ADD CONSTRAINT admins_pkey PRIMARY KEY (id);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: company_values company_values_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.company_values
    ADD CONSTRAINT company_values_pkey PRIMARY KEY (id);


--
-- Name: employees employees_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_pkey PRIMARY KEY (id);


--
-- Name: kudos kudos_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.kudos
    ADD CONSTRAINT kudos_pkey PRIMARY KEY (id);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- Name: rewards rewards_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rewards
    ADD CONSTRAINT rewards_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: index_admins_on_email; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_admins_on_email ON public.admins USING btree (email);


--
-- Name: index_admins_on_reset_password_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_admins_on_reset_password_token ON public.admins USING btree (reset_password_token);


--
-- Name: index_employees_on_email; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_employees_on_email ON public.employees USING btree (email);


--
-- Name: index_employees_on_reset_password_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_employees_on_reset_password_token ON public.employees USING btree (reset_password_token);


--
-- Name: index_kudos_on_company_value_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_kudos_on_company_value_id ON public.kudos USING btree (company_value_id);


--
-- Name: index_kudos_on_giver_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_kudos_on_giver_id ON public.kudos USING btree (giver_id);


--
-- Name: index_kudos_on_receiver_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_kudos_on_receiver_id ON public.kudos USING btree (receiver_id);


--
-- Name: index_orders_on_buyer_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_orders_on_buyer_id ON public.orders USING btree (buyer_id);


--
-- Name: index_orders_on_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_orders_on_status ON public.orders USING btree (status);


--
-- Name: unique_titles; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX unique_titles ON public.company_values USING btree (title);


--
-- Name: kudos fk_rails_7fc56424b0; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.kudos
    ADD CONSTRAINT fk_rails_7fc56424b0 FOREIGN KEY (receiver_id) REFERENCES public.employees(id);


--
-- Name: kudos fk_rails_864252c69c; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.kudos
    ADD CONSTRAINT fk_rails_864252c69c FOREIGN KEY (giver_id) REFERENCES public.employees(id);


--
-- Name: kudos fk_rails_a9001c0220; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.kudos
    ADD CONSTRAINT fk_rails_a9001c0220 FOREIGN KEY (company_value_id) REFERENCES public.company_values(id);


--
-- Name: orders fk_rails_d3775977e3; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT fk_rails_d3775977e3 FOREIGN KEY (buyer_id) REFERENCES public.employees(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20220427143152'),
('20220427201809'),
('20220506092549'),
('20220508022656'),
('20220516132758'),
('20220520134952'),
('20220520150418'),
('20220523210536'),
('20220609202525'),
('20220630011606'),
('20220723222313');


