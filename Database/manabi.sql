PGDMP     :                    y            manabi    10.19    10.19 N    i           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                       false            j           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                       false            k           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                       false            l           1262    16456    manabi    DATABASE     �   CREATE DATABASE manabi WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'Italian_Italy.1252' LC_CTYPE = 'Italian_Italy.1252';
    DROP DATABASE manabi;
             postgres    false                        2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
             postgres    false            m           0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                  postgres    false    3                        3079    12924    plpgsql 	   EXTENSION     ?   CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;
    DROP EXTENSION plpgsql;
                  false            n           0    0    EXTENSION plpgsql    COMMENT     @   COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';
                       false    1            �            1255    16645    aggiorna_punteggiotot()    FUNCTION     j  CREATE FUNCTION public.aggiorna_punteggiotot() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
username STUDENTE.USERNAME_S%TYPE;
punteggio STUDENTE.PUNTEGGIO_TOT%TYPE;
Voto CORREZIONE.VOTO_TEST%TYPE;
BEGIN

	SELECT CORREZIONE.VOTO_TEST, CORREZIONE.USERNAME_S INTO voto, username
	FROM CORREZIONE
	WHERE CORREZIONE.VOTO_TEST = NEW.VOTO_TEST;

SELECT STUDENTE.PUNTEGGIO_TOT INTO punteggio
	FROM STUDENTE
	WHERE STUDENTE.USERNAME_S = username;

	punteggio := punteggio + voto;
                UPDATE STUDENTE
	SET STUDENTE.PUNTEGGIO_TOT = punteggio
	WHERE (STUDENTE.USERNAME_S = username);
RETURN NULL;
END;

$$;
 .   DROP FUNCTION public.aggiorna_punteggiotot();
       public       postgres    false    3    1            �            1255    16674    aggiorna_voto_a()    FUNCTION     <  CREATE FUNCTION public.aggiorna_voto_a() RETURNS trigger
    LANGUAGE plpgsql
    AS $$ 
DECLARE
punteggio RISPOSTA_APERTA.PUNTEGGIO_RISA%TYPE;
username RISPOSTA_APERTA.USERNAME_S%TYPE;
idra RISPOSTA_APERTA.IDR_A%TYPE;
idTestQ QUESITO_APERTO.ID_TEST%TYPE;
voto CORREZIONE.VOTO_TEST%TYPE;

BEGIN
SELECT RISPOSTA_APERTA.PUNTEGGIO_RISA, RISPOSTA_APERTE.USERNAME_S, RISPOSTA_APERTA.IDR_A INTO punteggio, username, idra
FROM RISPOSTA_APERTA
WHERE RISPOSTA_APERTA.PUNTEGIO_RISA = NEW.PUNTEGGIO_RISA;

SELECT QUESITO_APERTO.ID_TEST INTO idTestQ
FROM QUESITO_APERTO
WHERE QUESITO_APERTO.ID_A = idra;

SELECT CORREZIONE.VOTO_TEST INTO voto
FROM CORREZIONE
WHERE CORREZIONE.ID_TEST = idTestQ;

voto := voto + punteggio;

UPDATE CORREZIONE
SET CORREZIONE.VOTO_TEST = voto
WHERE CORREZIONE.USERNAME_S = username; 



RETURN NULL;
END;

$$;
 (   DROP FUNCTION public.aggiorna_voto_a();
       public       postgres    false    1    3            �            1255    16649    assegna_bool()    FUNCTION     K  CREATE FUNCTION public.assegna_bool() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
Rispostad RISPOSTA_APERTA.RISPOSTA_DATA%type;
runo QUESITO_MULTIPLO.R_UNOC%type;
idrm RISPOSTE_MULTIPLE.IDR_M%type;
Idm RISPOSTE_MULTIPLE.IDR_M%type;

BEGIN

SELECT RISPOSTE_APERTE.RISPOSTA_DATA into rispostad
FROM RISPOSTE_APERTE
WHERE RISPOSTE_APERTE.RISPOSTA_DATA = NEW.RISPOSTA_DATA;

SELECT QUESITI_MULTIPLI.R_UNOC into runo
FROM QUESITI_MULTIPLI
WHERE QUESITI_MULTIPLI.R_UNOC = NEW.R_UNOC;

SELECT RISPOSTE_MULTIPLE.IDR_M INTO idrm
FROM RISPOSTE_MULTIPLE
WHERE RISPOSTE_MULTIPLE.IDR_M = NEW.IDR_M;

SELECT RISPOSTE_MULTIPLE.IDR_M INTO idm
FROM RISPOSTE_MULTIPLE
WHERE RISPOSTE_MULTIPLE.IDR_M = NEW.IDR_M;

    IF(rispostad= runoc AND idrm = idm) THEN
		UPDATE RISPOSTE_MULTIPLE
		SET NEW.CORRETTA = TRUE
		WHERE RISPOSTE_MULTIPLE.IDR_M = QUESITI_MULTIPLI.ID_M;
	END IF;
		UPDATE RISPOSTE_MULTIPLE
		SET NEW.PUNTEGGIO_RISM = QUESITI_MULTIPLI.PUNTEGGIO_CORRETTO
		WHERE RISPOSTE_MULTIPLE.IDR_M = QUESITI_MULTIPLI.ID_M;
		
	IF (rispostad <> runo AND idrm = idm) THEN
		UPDATE RISPOSTE_MULTIPLE
		SET NEW.CORRETTA = FALSE
		WHERE RISPOSTE_MULTIPLE.IDR_M = QUESITI_MULTIPLI.ID_M;
		END IF;
		
		UPDATE RISPOSTE_MULTIPLE
		SET NEW.PUNTEGGIO_RISM = QUESITI_MULTIPLI.PUNTEGGIO_ERRATO
		WHERE RISPOSTE_MULTIPLE.IDR_M = QUESITI_MULTIPLI.ID_M;
RETURN NULL;
END;

$$;
 %   DROP FUNCTION public.assegna_bool();
       public       postgres    false    1    3            �            1255    16658    controllo_lunghezza_ins()    FUNCTION     �  CREATE FUNCTION public.controllo_lunghezza_ins() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
username INSEGNANTE.USERNAME_I%TYPE;
password_i INSEGNANTE.PASSWORD_I%TYPE;
nome INSEGNANTE.NOME%TYPE;
cognome INSEGNANTE.COGNOME%TYPE;
BEGIN

	SELECT INSEGNANTE.USERNAME_I, INSEGNANTE.PASSWORD_I, INSEGNANTE.NOME, INSEGNANTE.COGNOME INTO username, password_i, nome, cognome
	FROM INSEGNANTE
	WHERE INSEGNANTE.USERNAME_I = NEW.USERNAME_I AND INSEGNANTE.PASSWORD_I = NEW.PASSWORD_I AND INSEGNANTE.NOME = NEW.NOME AND INSEGNANTE.COGNOME = NEW.COGNOME;
	
	IF(LENGTH(username) < 8 OR LENGTH(password_i) < 8) THEN
		RAISE EXCEPTION 'Username non valido'
		USING HINT = 'Prova a inserire un username più lungo';
	END IF;
	IF(LENGTH(nome) < 2 OR LENGTH(cognome) < 2) THEN
		RAISE EXCEPTION 'Nome o cognome non valido'
		USING HINT = 'Prova a inserire un nome e cognome vero!';
	END IF;
RETURN NULL;
END;

$$;
 0   DROP FUNCTION public.controllo_lunghezza_ins();
       public       postgres    false    3    1            �            1255    16656    controllo_lunghezza_stu()    FUNCTION     �  CREATE FUNCTION public.controllo_lunghezza_stu() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
username STUDENTE.USERNAME_S%TYPE;
NOME STUDENTE.NOME%TYPE;
COGNOME STUDENTE.COGNOME%TYPE;
BEGIN

	SELECT STUDENTE.USERNAME_S, STUDENTE.NOME, STUDENTE.COGNOME INTO username
	FROM STUDENTE
	WHERE STUDENTE.USERNAME_S = NEW.USERNAME_S AND STUDENTE.NOME = NEW.NOME AND STUDENTE.COGNOME = NEW.COGNOME;
	
	IF(LENGTH(username) < 8) THEN
		RAISE EXCEPTION 'Username non valido'
		USING HINT = 'Prova a inserire un username più lungo';
	END IF;
	IF(LENGTH(nome) < 2 OR LENGTH(cognome) < 2) THEN
		RAISE EXCEPTION 'Nome o cognome non valido'
		USING HINT = 'Prova a inserire un nome e cognome vero!';
	END IF;
RETURN NULL;
END;

$$;
 0   DROP FUNCTION public.controllo_lunghezza_stu();
       public       postgres    false    3    1            �            1255    16638    controllo_risa()    FUNCTION     �  CREATE FUNCTION public.controllo_risa() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
Var1 RISPOSTA_APERTA.PUNTEGGIO_RISA%type;
Var2 QUESITO_APERTO.PUNTEGGIO_MAX%type;
Var3 QUESITO_APERTO.PUNTEGGIO_MIN%type;
idquiz RISPOSTA_APERTA.IDR_A%TYPE;
BEGIN
SELECT RISPOSTA_APERTA.PUNTEGGIO_RISA, RISPOSTA_APERTA.IDR_A INTO VAR1, idquiz
FROM RISPOSTA_APERTA
WHERE PUNTEGGIO_RISA = NEW.PUNTEGGIO_RISA;

SELECT QUESITO_APERTO.PUNTEGGIO_MAX, QUESITO_APERTO.PUNTEGGIO_MIN INTO VAR2, VAR2
FROM QUIZ_APERTO
WHERE QUESITO_APERTO.ID_A = idquiz;

IF (VAR1>VAR2 AND VAR1<VAR3)
THEN
RAISE EXCEPTION 'ERROR punteggio non valido';
RETURN NULL;
END IF;
END;
$$;
 '   DROP FUNCTION public.controllo_risa();
       public       postgres    false    1    3            �            1255    16651    controllo_risposta()    FUNCTION     �  CREATE FUNCTION public.controllo_risposta() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
rispostaData RISPOSTE_MULTIPLE.RISPOSTA_DATA%type;
rispostaU RISPOSTE_MULTIPLE.RISPOSTA_DATA%type;
rispostaD RISPOSTE_MULTIPLE.RISPOSTA_DATA%type;
rispostaT RISPOSTE_MULTIPLE.RISPOSTA_DATA%type;
rispostaQ RISPOSTE_MULTIPLE.RISPOSTA_DATA%type;
rispostaC RISPOSTE_MULTIPLE.RISPOSTA_DATA%type;

BEGIN
	SELECT RISPOSTE_MULTIPLE.RISPOSTA_DATA INTO rispostaData
	FROM RISPOSTE_MULTIPLE
	WHERE RISPOSTE_MULTIPLE.RISPOSTA_DATA = NEW.RISPOSTADATA;

	SELECT QUESITO_MULTIPLO.R_UNOC INTO rispostaU
FROM QUESITO_MULTIPLO
WHERE QUESITO_MULTIPLO.ID_M = RISPOSTE_MULTIPLE.IDR_M;

SELECT QUESITO_MULTIPLO.R_DUE INTO rispostaD
FROM QUESITO_MULTIPLO
WHERE QUESITO_MULTIPLO.ID_M = RISPOSTE_MULTIPLE.IDR_M;

SELECT QUESITO_MULTIPLO.R_TRE INTO rispostaT
FROM QUESITO_MULTIPLO
WHERE QUESITO_MULTIPLO.ID_M = RISPOSTE_MULTIPLE.IDR_M;

SELECT QUESITO_MULTIPLO.R_QUATTRO INTO rispostaQ
FROM QUESITO_MULTIPLO
WHERE QUESITO_MULTIPLO.ID_M = RISPOSTE_MULTIPLE.IDR_M;


SELECT QUESITO_MULTIPLO.R_CINQUE INTO rispostaC
FROM QUESITO_MULTIPLO
WHERE QUESITO_MULTIPLO.ID_M = RISPOSTE_MULTIPLE.IDR_M;

		IF(rispostaData <> rispostaU AND rispostaData<> rispostaD
		AND rispostaT IS NULL AND rispostaQ IS NULL AND rispostaC IS NULL)
		THEN RAISE EXCEPTION 'Risposta data non valida.';
		END IF;
		
		IF(rispostaData <> rispostaU AND rispostaData<> rispostaD
		AND (rispostaT IS NOT NULL AND rispostaData <> rispostaT) AND rispostaQ IS NULL AND rispostaC IS NULL)
		THEN RAISE EXCEPTION 'Risposta data non valida.';
		END IF;
		
		IF(rispostaData <> rispostaU AND rispostaData<> rispostaD
		AND (rispostaT IS NOT NULL AND rispostaData <> rispostaT)  AND 
		    (rispostaQ IS NOT NULL AND rispostaD<> rispostaQ) AND rispostaC IS NULL)
		THEN RAISE EXCEPTION 'Risposta data non valida.';
		END IF;
			
		IF (rispostaData <> rispostaU AND rispostaData<> rispostaD
		AND (rispostaT IS NOT NULL AND rispostaData <> rispostaT)  AND 
		    (rispostaQ IS NOT NULL AND rispostaD<> rispostaQ) AND
			(rispostaC IS NOT NULL AND rispostaD <> rispostaC))
		THEN RAISE EXCEPTION 'Risposta data non valida.';
		END IF;

RETURN NULL;
END;

$$;
 +   DROP FUNCTION public.controllo_risposta();
       public       postgres    false    1    3            �            1255    16647    controllo_tempo()    FUNCTION     �  CREATE FUNCTION public.controllo_tempo() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE 
tempo TIME;
BEGIN
SELECT TEST.TEMPO_SVOLGIMENTO INTO tempo
FROM TEST
WHERE TEST.TEMPO_SVOLGIMENTO = NEW.TEMPO_SVOLGIMENTO;

    IF(tempo < '00:15:00' AND tempo IS NOT NULL) THEN
	RAISE EXCEPTION 'Tempo insufficiente per svolgere il test.'
		USING HINT = 'Prova ad assegnare maggior tempo (>= 15 min)';
		END IF;
RETURN NULL;
END;

$$;
 (   DROP FUNCTION public.controllo_tempo();
       public       postgres    false    1    3            �            1255    16653    controllo_username()    FUNCTION     &  CREATE FUNCTION public.controllo_username() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
username_s VARCHAR(25);
username_i VARCHAR(25);
BEGIN
	SELECT INSEGNANTE.USERNAME_I INTO username_i
	FROM INSEGNANTE
	WHERE INSEGNANTE.USERNAME_I = NEW.USERNAME_I;

	SELECT STUDENTE.USERNAME_S INTO username_s
	FROM STUDENTE
	WHERE STUDENTE.USERNAME_S = NEW.USERNAME_S;
	IF(username_s = username_i) THEN
	RAISE EXCEPTION 'Questo username non è disponibile.'
		USING HINT = 'Prova con un inserire un username diverso.';
	END IF;
RETURN NULL;
END;

$$;
 +   DROP FUNCTION public.controllo_username();
       public       postgres    false    1    3            �            1255    16666    inserisci_icorrezione()    FUNCTION     �   CREATE FUNCTION public.inserisci_icorrezione() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
INSERT INTO CORREZIONE(USERNAME_I) VALUES
(INSEGNANTE.USERNAME_I);
END;

$$;
 .   DROP FUNCTION public.inserisci_icorrezione();
       public       postgres    false    3    1            �            1255    16664    inserisci_tcorrezione()    FUNCTION     7  CREATE FUNCTION public.inserisci_tcorrezione() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
idT INT;
BEGIN
	SELECT TEST.ID_TEST INTO idT
	FROM TEST
	WHERE TEST.ID_TEST = NEW.ID_TEST;
UPDATE CORREZIONE
SET CORREZIONE.ID_TEST = idT
WHERE TEST.USERNAME_S = CORREZIONE.USERNAME_S; 
RETURN NULL;
END;

$$;
 .   DROP FUNCTION public.inserisci_tcorrezione();
       public       postgres    false    3    1            �            1255    16676    somma_mul()    FUNCTION     e  CREATE FUNCTION public.somma_mul() RETURNS trigger
    LANGUAGE plpgsql
    AS $$ 
DECLARE
punteggio RISPOSTE_MULTIPLE.PUNTEGGIO_RM%TYPE;
username RISPOSTE_MULTIPLE.USERNAME_S%TYPE;
idrm RISPOSTE_MULTIPLE.IDR_M%TYPE;
idTestQ QUESITO_MULTIPLO.ID_TEST%TYPE;
voto CORREZIONE.VOTO_TEST%TYPE;
idTestC CORREZIONE.ID_TEST%TYPE;

BEGIN
SELECT RISPOSTE_MULTIPLE.PUNTEGGIO_RM, RISPOSTE_MULTIPLE.USERNAME_S, RISPOSTE_MULTIPLE.IDR_M INTO punteggio, username, idrm
FROM RISPOSTE_MULTIPLE
WHERE RISPOSTE_MULTIPLE.PUNTEGIO_RM = NEW.PUNTEGGIO_RM;

SELECT QUESITO_MULTIPLO.ID_TEST INTO idTestQ
FROM QUESITO_MULTIPLO
WHERE QUESITO_MULTIPLO.ID_M = idrm;

SELECT CORREZIONE.VOTO_TEST INTO voto
FROM CORREZIONE
WHERE CORREZIONE.ID_TEST = idTestQ;

voto := voto + punteggio;

UPDATE CORREZIONE
SET CORREZIONE.VOTO_TEST = voto
WHERE CORREZIONE.USERNAME_S = username; 

RETURN NULL;
END;

$$;
 "   DROP FUNCTION public.somma_mul();
       public       postgres    false    1    3            �            1255    16681    verifica_insegnantecorrezione()    FUNCTION     '  CREATE FUNCTION public.verifica_insegnantecorrezione() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
username INSEGNANTE.USERNAME_I%TYPE;
idTest TEST.ID_TEST%TYPE;
f TEST.ID_TEST%TYPE;
BEGIN
	
	SELECT INSEGNANTE.USERNAME_I, INSEGNANTE.ID_TEST INTO username, idTest
	FROM CORREZIONE
	WHERE INSEGNANTE.USERNAME_I = NEW.USERNAME_I;
	
	SELECT TEST.ID_TEST into f
	FROM TEST
	WHERE TEST.USERNAME_I = username AND TEST.ID_TEST = idTest;
	
IF (f is null) THEN
RAISE EXCEPTION '% non ha creato nessun test', username;
END IF;


RETURN NULL;
END;
$$;
 6   DROP FUNCTION public.verifica_insegnantecorrezione();
       public       postgres    false    3    1            �            1255    16660    verifica_ipassword()    FUNCTION     �  CREATE FUNCTION public.verifica_ipassword() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
pass insegnante.password_i%type;
BEGIN
	SELECT INSEGNANTE.PASSWORD_I INTO pass
	FROM INSEGNANTE
	WHERE INSEGNANTE.PASSWORD_I = NEW.PASSWORD_I;

	IF(LENGTH(pass) < 8) THEN
	RAISE EXCEPTION 'Password % non valida', pass
		USING HINT = 'Prova a inserire una password più lunga!';
	END IF;
RETURN NULL;
END;

$$;
 +   DROP FUNCTION public.verifica_ipassword();
       public       postgres    false    3    1            �            1255    16662    verifica_spassword()    FUNCTION     �  CREATE FUNCTION public.verifica_spassword() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
spassword STUDENTE.PASSWORD_S%TYPE;
BEGIN
	SELECT PASSWORD_S INTO spassword
	FROM STUDENTE
	WHERE STUDENTE.PASSWORD_S = NEW.PASSWORD_S;
	
	IF(LENGTH(spassword) < 8) THEN
	RAISE EXCEPTION 'Password non valida'
		USING HINT = 'Prova a inserire una password più lunga!';
	END IF;
RETURN NULL;
END;

$$;
 +   DROP FUNCTION public.verifica_spassword();
       public       postgres    false    1    3            �            1259    16477 
   correzione    TABLE     �   CREATE TABLE public.correzione (
    username_i character varying(25) NOT NULL,
    username_s character varying(25) NOT NULL,
    id_test integer NOT NULL,
    corretto boolean DEFAULT false,
    voto_test double precision DEFAULT 0
);
    DROP TABLE public.correzione;
       public         postgres    false    3            �            1259    16457 
   insegnante    TABLE     �   CREATE TABLE public.insegnante (
    username_i character varying(25) NOT NULL,
    password_i character varying(25) NOT NULL,
    nome character varying(25),
    cognome character varying(25)
);
    DROP TABLE public.insegnante;
       public         postgres    false    3            �            1259    16467    test    TABLE     H  CREATE TABLE public.test (
    id_test integer NOT NULL,
    username_i character varying(25) NOT NULL,
    nome_test character varying(25) NOT NULL,
    tempo_svolgimento time without time zone,
    materia_test character varying(25),
    descrizione character varying(100) DEFAULT 'Nessuna descrizione.'::character varying
);
    DROP TABLE public.test;
       public         postgres    false    3            �            1259    16670    media_categoria    VIEW     X  CREATE VIEW public.media_categoria AS
 SELECT t.nome_test,
    t.materia_test AS materia,
    c.username_s AS studente,
    avg(c.voto_test) AS media
   FROM public.test t,
    public.test p,
    public.correzione c
  GROUP BY t.nome_test, t.materia_test, c.username_s, p.materia_test
 HAVING ((t.materia_test)::text = (p.materia_test)::text);
 "   DROP VIEW public.media_categoria;
       public       postgres    false    199    199    198    198    3            �            1259    16497    quesito_aperto    TABLE     +  CREATE TABLE public.quesito_aperto (
    id_a integer NOT NULL,
    id_test integer NOT NULL,
    punteggio_min double precision NOT NULL,
    punteggio_max double precision NOT NULL,
    domanda character varying(50) NOT NULL,
    CONSTRAINT controllo_pa CHECK ((punteggio_min < punteggio_max))
);
 "   DROP TABLE public.quesito_aperto;
       public         postgres    false    3            �            1259    16527    quesito_multiplo    TABLE     �  CREATE TABLE public.quesito_multiplo (
    id_m integer NOT NULL,
    id_test integer NOT NULL,
    punteggio_corretto double precision NOT NULL,
    punteggio_errato double precision NOT NULL,
    domanda character varying(200) NOT NULL,
    r_unoc character varying(50) NOT NULL,
    r_due character varying(50) NOT NULL,
    r_tre character varying(50),
    r_quattro character varying(50),
    r_cinque character varying(50),
    CONSTRAINT controllo_pm1 CHECK ((punteggio_corretto > punteggio_errato)),
    CONSTRAINT controllo_pm2 CHECK ((punteggio_corretto > (0)::double precision)),
    CONSTRAINT controllo_pm3 CHECK ((punteggio_errato <= (0)::double precision))
);
 $   DROP TABLE public.quesito_multiplo;
       public         postgres    false    3            �            1259    16507    risposta_aperta    TABLE     N  CREATE TABLE public.risposta_aperta (
    idr_a integer NOT NULL,
    username_s character varying(25) NOT NULL,
    username_i character varying(25) NOT NULL,
    risposta_data character varying(200),
    commento character varying(200) DEFAULT 'Nessun commento.'::character varying,
    punteggio_risa double precision DEFAULT 0
);
 #   DROP TABLE public.risposta_aperta;
       public         postgres    false    3            �            1259    16537    risposte_multiple    TABLE     �   CREATE TABLE public.risposte_multiple (
    idr_m integer NOT NULL,
    username_s character varying(25) NOT NULL,
    risposta_data character varying(50) DEFAULT 0 NOT NULL,
    corretta boolean,
    punteggio_rm double precision DEFAULT 0
);
 %   DROP TABLE public.risposte_multiple;
       public         postgres    false    3            �            1259    16596    risposte_errate    VIEW     �  CREATE VIEW public.risposte_errate AS
 SELECT r.username_s AS studente,
    (count(r.punteggio_risa) + count(w.corretta)) AS errate,
    q.id_test AS test
   FROM public.risposta_aperta r,
    public.quesito_aperto q,
    public.quesito_multiplo m,
    public.risposte_multiple w,
    public.risposta_aperta f,
    public.risposte_multiple y
  WHERE (((r.punteggio_risa = q.punteggio_min) OR (w.corretta = false)) AND ((r.username_s)::text = (w.username_s)::text) AND ((r.username_s)::text = (f.username_s)::text) AND ((w.username_s)::text = (y.username_s)::text) AND (q.id_test = m.id_test) AND (m.id_m = w.idr_m) AND (r.idr_a = q.id_a))
  GROUP BY r.username_s, q.id_test;
 "   DROP VIEW public.risposte_errate;
       public       postgres    false    200    200    200    201    201    201    202    202    203    203    203    3            �            1259    16591    risposte_esatte    VIEW     �  CREATE VIEW public.risposte_esatte AS
 SELECT r.username_s AS studente,
    (count(r.punteggio_risa) + count(w.corretta)) AS esatte,
    q.id_test AS test
   FROM public.risposta_aperta r,
    public.quesito_aperto q,
    public.quesito_multiplo m,
    public.risposte_multiple w,
    public.risposta_aperta f,
    public.risposte_multiple y
  WHERE (((r.punteggio_risa > q.punteggio_min) OR (w.corretta = true)) AND ((r.username_s)::text = (w.username_s)::text) AND ((r.username_s)::text = (f.username_s)::text) AND ((w.username_s)::text = (y.username_s)::text) AND (q.id_test = m.id_test) AND (m.id_m = w.idr_m) AND (r.idr_a = q.id_a))
  GROUP BY r.username_s, q.id_test;
 "   DROP VIEW public.risposte_esatte;
       public       postgres    false    201    200    200    200    202    203    203    203    202    201    201    3            �            1259    16462    studente    TABLE     �   CREATE TABLE public.studente (
    username_s character varying(25) NOT NULL,
    password_s character varying(25) NOT NULL,
    nome character varying(25),
    cognome character varying(25),
    punteggio_tot double precision DEFAULT 0
);
    DROP TABLE public.studente;
       public         postgres    false    3            �            1259    16567    visualizza_dati_studente    VIEW     �   CREATE VIEW public.visualizza_dati_studente AS
 SELECT t.nome_test,
    count(c.username_s) AS n_studenti
   FROM public.correzione c,
    public.test t
  WHERE (c.id_test = t.id_test)
  GROUP BY t.nome_test;
 +   DROP VIEW public.visualizza_dati_studente;
       public       postgres    false    199    199    198    198    3            �            1259    16601    visualizza_risultati    VIEW     k  CREATE VIEW public.visualizza_risultati AS
 SELECT c.username_s AS nome_stu,
    t.nome_test,
    c.username_i AS nome_ins,
    e.esatte AS ris_esatte,
    r.errate AS ris_errate,
    c.voto_test AS voto
   FROM public.correzione c,
    public.risposte_esatte e,
    public.risposte_errate r,
    public.test t,
    public.test y
  WHERE (t.id_test = y.id_test);
 '   DROP VIEW public.visualizza_risultati;
       public       postgres    false    198    198    206    205    199    199    199    3            b          0    16477 
   correzione 
   TABLE DATA               Z   COPY public.correzione (username_i, username_s, id_test, corretto, voto_test) FROM stdin;
    public       postgres    false    199   ̒       _          0    16457 
   insegnante 
   TABLE DATA               K   COPY public.insegnante (username_i, password_i, nome, cognome) FROM stdin;
    public       postgres    false    196   �       c          0    16497    quesito_aperto 
   TABLE DATA               ^   COPY public.quesito_aperto (id_a, id_test, punteggio_min, punteggio_max, domanda) FROM stdin;
    public       postgres    false    200   �       e          0    16527    quesito_multiplo 
   TABLE DATA               �   COPY public.quesito_multiplo (id_m, id_test, punteggio_corretto, punteggio_errato, domanda, r_unoc, r_due, r_tre, r_quattro, r_cinque) FROM stdin;
    public       postgres    false    202   #�       d          0    16507    risposta_aperta 
   TABLE DATA               q   COPY public.risposta_aperta (idr_a, username_s, username_i, risposta_data, commento, punteggio_risa) FROM stdin;
    public       postgres    false    201   @�       f          0    16537    risposte_multiple 
   TABLE DATA               e   COPY public.risposte_multiple (idr_m, username_s, risposta_data, corretta, punteggio_rm) FROM stdin;
    public       postgres    false    203   ]�       `          0    16462    studente 
   TABLE DATA               X   COPY public.studente (username_s, password_s, nome, cognome, punteggio_tot) FROM stdin;
    public       postgres    false    197   z�       a          0    16467    test 
   TABLE DATA               l   COPY public.test (id_test, username_i, nome_test, tempo_svolgimento, materia_test, descrizione) FROM stdin;
    public       postgres    false    198   ��       �
           2606    16481    correzione correzione_pkey 
   CONSTRAINT     u   ALTER TABLE ONLY public.correzione
    ADD CONSTRAINT correzione_pkey PRIMARY KEY (username_i, username_s, id_test);
 D   ALTER TABLE ONLY public.correzione DROP CONSTRAINT correzione_pkey;
       public         postgres    false    199    199    199            �
           2606    16461    insegnante insegnante_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.insegnante
    ADD CONSTRAINT insegnante_pkey PRIMARY KEY (username_i);
 D   ALTER TABLE ONLY public.insegnante DROP CONSTRAINT insegnante_pkey;
       public         postgres    false    196            �
           2606    16501    quesito_aperto quiz_aperto_pkey 
   CONSTRAINT     _   ALTER TABLE ONLY public.quesito_aperto
    ADD CONSTRAINT quiz_aperto_pkey PRIMARY KEY (id_a);
 I   ALTER TABLE ONLY public.quesito_aperto DROP CONSTRAINT quiz_aperto_pkey;
       public         postgres    false    200            �
           2606    16531 #   quesito_multiplo quiz_multiplo_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY public.quesito_multiplo
    ADD CONSTRAINT quiz_multiplo_pkey PRIMARY KEY (id_m);
 M   ALTER TABLE ONLY public.quesito_multiplo DROP CONSTRAINT quiz_multiplo_pkey;
       public         postgres    false    202            �
           2606    16511 $   risposta_aperta risposta_aperte_pkey 
   CONSTRAINT     q   ALTER TABLE ONLY public.risposta_aperta
    ADD CONSTRAINT risposta_aperte_pkey PRIMARY KEY (idr_a, username_s);
 N   ALTER TABLE ONLY public.risposta_aperta DROP CONSTRAINT risposta_aperte_pkey;
       public         postgres    false    201    201            �
           2606    16541 (   risposte_multiple risposte_multiple_pkey 
   CONSTRAINT     u   ALTER TABLE ONLY public.risposte_multiple
    ADD CONSTRAINT risposte_multiple_pkey PRIMARY KEY (idr_m, username_s);
 R   ALTER TABLE ONLY public.risposte_multiple DROP CONSTRAINT risposte_multiple_pkey;
       public         postgres    false    203    203            �
           2606    16466    studente studente_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.studente
    ADD CONSTRAINT studente_pkey PRIMARY KEY (username_s);
 @   ALTER TABLE ONLY public.studente DROP CONSTRAINT studente_pkey;
       public         postgres    false    197            �
           2606    16471    test test_pkey 
   CONSTRAINT     Q   ALTER TABLE ONLY public.test
    ADD CONSTRAINT test_pkey PRIMARY KEY (id_test);
 8   ALTER TABLE ONLY public.test DROP CONSTRAINT test_pkey;
       public         postgres    false    198            �
           2620    16646     correzione aggiorna_punteggiotot    TRIGGER     �   CREATE TRIGGER aggiorna_punteggiotot AFTER UPDATE OF voto_test ON public.correzione FOR EACH ROW EXECUTE PROCEDURE public.aggiorna_punteggiotot();
 9   DROP TRIGGER aggiorna_punteggiotot ON public.correzione;
       public       postgres    false    199    231    199            �
           2620    16675    risposta_aperta aggiorna_voto_a    TRIGGER     �   CREATE TRIGGER aggiorna_voto_a AFTER UPDATE OF punteggio_risa ON public.risposta_aperta FOR EACH ROW EXECUTE PROCEDURE public.aggiorna_voto_a();
 8   DROP TRIGGER aggiorna_voto_a ON public.risposta_aperta;
       public       postgres    false    233    201    201            �
           2620    16650    risposte_multiple assegna_bool    TRIGGER     �   CREATE TRIGGER assegna_bool AFTER INSERT OR UPDATE OF risposta_data ON public.risposte_multiple FOR EACH ROW EXECUTE PROCEDURE public.assegna_bool();
 7   DROP TRIGGER assegna_bool ON public.risposte_multiple;
       public       postgres    false    232    203    203            �
           2620    16659 +   insegnante controllo_credenziali_insegnante    TRIGGER     �   CREATE TRIGGER controllo_credenziali_insegnante AFTER INSERT ON public.insegnante FOR EACH ROW EXECUTE PROCEDURE public.controllo_lunghezza_ins();
 D   DROP TRIGGER controllo_credenziali_insegnante ON public.insegnante;
       public       postgres    false    227    196            �
           2620    16657 '   studente controllo_credenziali_studente    TRIGGER     �   CREATE TRIGGER controllo_credenziali_studente AFTER INSERT ON public.studente FOR EACH ROW EXECUTE PROCEDURE public.controllo_lunghezza_stu();
 @   DROP TRIGGER controllo_credenziali_studente ON public.studente;
       public       postgres    false    197    226            �
           2620    16652 +   risposte_multiple controllo_risposta_valida    TRIGGER     �   CREATE TRIGGER controllo_risposta_valida AFTER INSERT OR UPDATE OF risposta_data ON public.risposte_multiple FOR EACH ROW EXECUTE PROCEDURE public.controllo_risposta();
 D   DROP TRIGGER controllo_risposta_valida ON public.risposte_multiple;
       public       postgres    false    203    224    203            �
           2620    16648    test controllo_tempo    TRIGGER     �   CREATE TRIGGER controllo_tempo AFTER INSERT OR UPDATE OF tempo_svolgimento ON public.test FOR EACH ROW EXECUTE PROCEDURE public.controllo_tempo();
 -   DROP TRIGGER controllo_tempo ON public.test;
       public       postgres    false    198    198    223            �
           2620    16655    insegnante controllo_username    TRIGGER     �   CREATE TRIGGER controllo_username AFTER INSERT OR UPDATE OF username_i ON public.insegnante FOR EACH ROW EXECUTE PROCEDURE public.controllo_username();
 6   DROP TRIGGER controllo_username ON public.insegnante;
       public       postgres    false    225    196    196            �
           2620    16654    studente controllo_username    TRIGGER     �   CREATE TRIGGER controllo_username AFTER INSERT OR UPDATE OF username_s ON public.studente FOR EACH ROW EXECUTE PROCEDURE public.controllo_username();
 4   DROP TRIGGER controllo_username ON public.studente;
       public       postgres    false    197    225    197            �
           2620    16667    test inserisci_insegnante_corr    TRIGGER     �   CREATE TRIGGER inserisci_insegnante_corr AFTER INSERT ON public.test FOR EACH ROW EXECUTE PROCEDURE public.inserisci_icorrezione();
 7   DROP TRIGGER inserisci_insegnante_corr ON public.test;
       public       postgres    false    198    221            �
           2620    16665    test inserisci_zdtest_corr    TRIGGER     �   CREATE TRIGGER inserisci_zdtest_corr AFTER INSERT ON public.test FOR EACH ROW EXECUTE PROCEDURE public.inserisci_tcorrezione();
 3   DROP TRIGGER inserisci_zdtest_corr ON public.test;
       public       postgres    false    198    230            �
           2620    16677 "   risposte_multiple somma_punteggiom    TRIGGER     �   CREATE TRIGGER somma_punteggiom AFTER UPDATE OF punteggio_rm ON public.risposte_multiple FOR EACH ROW EXECUTE PROCEDURE public.somma_mul();
 ;   DROP TRIGGER somma_punteggiom ON public.risposte_multiple;
       public       postgres    false    203    234    203            �
           2620    16682 (   correzione verifica_insegnantecorrezione    TRIGGER     �   CREATE TRIGGER verifica_insegnantecorrezione AFTER INSERT ON public.correzione FOR EACH ROW EXECUTE PROCEDURE public.verifica_insegnantecorrezione();
 A   DROP TRIGGER verifica_insegnantecorrezione ON public.correzione;
       public       postgres    false    199    235            �
           2620    16661    insegnante verifica_ipassword    TRIGGER     �   CREATE TRIGGER verifica_ipassword AFTER INSERT ON public.insegnante FOR EACH ROW EXECUTE PROCEDURE public.verifica_ipassword();
 6   DROP TRIGGER verifica_ipassword ON public.insegnante;
       public       postgres    false    228    196            �
           2620    16663    studente verifica_spassword    TRIGGER     ~   CREATE TRIGGER verifica_spassword AFTER INSERT ON public.studente FOR EACH ROW EXECUTE PROCEDURE public.verifica_spassword();
 4   DROP TRIGGER verifica_spassword ON public.studente;
       public       postgres    false    197    229            �
           2606    16492 "   correzione correzione_id_test_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.correzione
    ADD CONSTRAINT correzione_id_test_fkey FOREIGN KEY (id_test) REFERENCES public.test(id_test);
 L   ALTER TABLE ONLY public.correzione DROP CONSTRAINT correzione_id_test_fkey;
       public       postgres    false    198    199    2748            �
           2606    16482 %   correzione correzione_username_i_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.correzione
    ADD CONSTRAINT correzione_username_i_fkey FOREIGN KEY (username_i) REFERENCES public.insegnante(username_i);
 O   ALTER TABLE ONLY public.correzione DROP CONSTRAINT correzione_username_i_fkey;
       public       postgres    false    2744    199    196            �
           2606    16487 %   correzione correzione_username_s_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.correzione
    ADD CONSTRAINT correzione_username_s_fkey FOREIGN KEY (username_s) REFERENCES public.studente(username_s);
 O   ALTER TABLE ONLY public.correzione DROP CONSTRAINT correzione_username_s_fkey;
       public       postgres    false    2746    197    199            �
           2606    16502 '   quesito_aperto quiz_aperto_id_test_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.quesito_aperto
    ADD CONSTRAINT quiz_aperto_id_test_fkey FOREIGN KEY (id_test) REFERENCES public.test(id_test);
 Q   ALTER TABLE ONLY public.quesito_aperto DROP CONSTRAINT quiz_aperto_id_test_fkey;
       public       postgres    false    198    2748    200            �
           2606    16532 +   quesito_multiplo quiz_multiplo_id_test_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.quesito_multiplo
    ADD CONSTRAINT quiz_multiplo_id_test_fkey FOREIGN KEY (id_test) REFERENCES public.test(id_test);
 U   ALTER TABLE ONLY public.quesito_multiplo DROP CONSTRAINT quiz_multiplo_id_test_fkey;
       public       postgres    false    198    2748    202            �
           2606    16522 *   risposta_aperta risposta_aperte_idr_a_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.risposta_aperta
    ADD CONSTRAINT risposta_aperte_idr_a_fkey FOREIGN KEY (idr_a) REFERENCES public.quesito_aperto(id_a);
 T   ALTER TABLE ONLY public.risposta_aperta DROP CONSTRAINT risposta_aperte_idr_a_fkey;
       public       postgres    false    2752    200    201            �
           2606    16517 /   risposta_aperta risposta_aperte_username_i_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.risposta_aperta
    ADD CONSTRAINT risposta_aperte_username_i_fkey FOREIGN KEY (username_i) REFERENCES public.insegnante(username_i);
 Y   ALTER TABLE ONLY public.risposta_aperta DROP CONSTRAINT risposta_aperte_username_i_fkey;
       public       postgres    false    196    2744    201            �
           2606    16512 /   risposta_aperta risposta_aperte_username_s_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.risposta_aperta
    ADD CONSTRAINT risposta_aperte_username_s_fkey FOREIGN KEY (username_s) REFERENCES public.studente(username_s);
 Y   ALTER TABLE ONLY public.risposta_aperta DROP CONSTRAINT risposta_aperte_username_s_fkey;
       public       postgres    false    201    2746    197            �
           2606    16542 .   risposte_multiple risposte_multiple_idr_m_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.risposte_multiple
    ADD CONSTRAINT risposte_multiple_idr_m_fkey FOREIGN KEY (idr_m) REFERENCES public.quesito_multiplo(id_m);
 X   ALTER TABLE ONLY public.risposte_multiple DROP CONSTRAINT risposte_multiple_idr_m_fkey;
       public       postgres    false    2756    203    202            �
           2606    16547 3   risposte_multiple risposte_multiple_username_s_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.risposte_multiple
    ADD CONSTRAINT risposte_multiple_username_s_fkey FOREIGN KEY (username_s) REFERENCES public.studente(username_s);
 ]   ALTER TABLE ONLY public.risposte_multiple DROP CONSTRAINT risposte_multiple_username_s_fkey;
       public       postgres    false    197    2746    203            �
           2606    16472    test test_username_i_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.test
    ADD CONSTRAINT test_username_i_fkey FOREIGN KEY (username_i) REFERENCES public.insegnante(username_i);
 C   ALTER TABLE ONLY public.test DROP CONSTRAINT test_username_i_fkey;
       public       postgres    false    196    198    2744            b      x������ � �      _      x������ � �      c      x������ � �      e      x������ � �      d      x������ � �      f      x������ � �      `      x������ � �      a      x������ � �     