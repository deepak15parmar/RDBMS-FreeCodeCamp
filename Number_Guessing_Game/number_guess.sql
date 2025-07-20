--
-- PostgreSQL database dump
--

-- Dumped from database version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)
-- Dumped by pg_dump version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)

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

DROP DATABASE number_guess;
--
-- Name: number_guess; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE number_guess WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE number_guess OWNER TO freecodecamp;

\connect number_guess

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
-- Name: game_history; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.game_history (
    game_id integer NOT NULL,
    number_of_guess integer NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.game_history OWNER TO freecodecamp;

--
-- Name: game_history_game_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.game_history_game_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.game_history_game_id_seq OWNER TO freecodecamp;

--
-- Name: game_history_game_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.game_history_game_id_seq OWNED BY public.game_history.game_id;


--
-- Name: userbase; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.userbase (
    user_id integer NOT NULL,
    username character varying(22) NOT NULL
);


ALTER TABLE public.userbase OWNER TO freecodecamp;

--
-- Name: userbase_user_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.userbase_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.userbase_user_id_seq OWNER TO freecodecamp;

--
-- Name: userbase_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.userbase_user_id_seq OWNED BY public.userbase.user_id;


--
-- Name: game_history game_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.game_history ALTER COLUMN game_id SET DEFAULT nextval('public.game_history_game_id_seq'::regclass);


--
-- Name: userbase user_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.userbase ALTER COLUMN user_id SET DEFAULT nextval('public.userbase_user_id_seq'::regclass);


--
-- Data for Name: game_history; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.game_history VALUES (91, 11, 31);
INSERT INTO public.game_history VALUES (92, 549, 32);
INSERT INTO public.game_history VALUES (93, 509, 32);
INSERT INTO public.game_history VALUES (94, 470, 33);
INSERT INTO public.game_history VALUES (95, 820, 33);
INSERT INTO public.game_history VALUES (96, 948, 32);
INSERT INTO public.game_history VALUES (97, 529, 32);
INSERT INTO public.game_history VALUES (98, 117, 32);
INSERT INTO public.game_history VALUES (99, 373, 34);
INSERT INTO public.game_history VALUES (100, 617, 34);
INSERT INTO public.game_history VALUES (101, 760, 35);
INSERT INTO public.game_history VALUES (102, 721, 35);
INSERT INTO public.game_history VALUES (103, 218, 34);
INSERT INTO public.game_history VALUES (104, 944, 34);
INSERT INTO public.game_history VALUES (105, 701, 34);
INSERT INTO public.game_history VALUES (106, 287, 36);
INSERT INTO public.game_history VALUES (107, 610, 36);
INSERT INTO public.game_history VALUES (108, 796, 37);
INSERT INTO public.game_history VALUES (109, 875, 37);
INSERT INTO public.game_history VALUES (110, 355, 36);
INSERT INTO public.game_history VALUES (111, 379, 36);
INSERT INTO public.game_history VALUES (112, 874, 36);
INSERT INTO public.game_history VALUES (113, 429, 38);
INSERT INTO public.game_history VALUES (114, 665, 38);
INSERT INTO public.game_history VALUES (115, 830, 39);
INSERT INTO public.game_history VALUES (116, 819, 39);
INSERT INTO public.game_history VALUES (117, 720, 38);
INSERT INTO public.game_history VALUES (118, 210, 38);
INSERT INTO public.game_history VALUES (119, 644, 38);


--
-- Data for Name: userbase; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.userbase VALUES (31, 'Deepak');
INSERT INTO public.userbase VALUES (32, 'user_1753033336138');
INSERT INTO public.userbase VALUES (33, 'user_1753033336137');
INSERT INTO public.userbase VALUES (34, 'user_1753033369487');
INSERT INTO public.userbase VALUES (35, 'user_1753033369486');
INSERT INTO public.userbase VALUES (36, 'user_1753033423781');
INSERT INTO public.userbase VALUES (37, 'user_1753033423780');
INSERT INTO public.userbase VALUES (38, 'user_1753033462345');
INSERT INTO public.userbase VALUES (39, 'user_1753033462344');


--
-- Name: game_history_game_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.game_history_game_id_seq', 119, true);


--
-- Name: userbase_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.userbase_user_id_seq', 39, true);


--
-- Name: game_history game_history_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.game_history
    ADD CONSTRAINT game_history_pkey PRIMARY KEY (game_id);


--
-- Name: userbase userbase_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.userbase
    ADD CONSTRAINT userbase_pkey PRIMARY KEY (user_id);


--
-- Name: game_history game_history_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.game_history
    ADD CONSTRAINT game_history_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.userbase(user_id);


--
-- PostgreSQL database dump complete
--

