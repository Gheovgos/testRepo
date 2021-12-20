PGDMP                         y            manabi    10.19    10.19 +    &           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                       false            '           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                       false            (           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                       false            )           1262    16456    manabi    DATABASE     �   CREATE DATABASE manabi WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'Italian_Italy.1252' LC_CTYPE = 'Italian_Italy.1252';
    DROP DATABASE manabi;
             postgres    false                        2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
             postgres    false            *           0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                  postgres    false    3                        3079    12924    plpgsql 	   EXTENSION     ?   CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;
    DROP EXTENSION plpgsql;
                  false            +           0    0    EXTENSION plpgsql    COMMENT     @   COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';
                       false    1            �            1259    16477 
   correzione    TABLE     �   CREATE TABLE public.correzione (
    username_i character varying(25) NOT NULL,
    username_s character varying(25) NOT NULL,
    id_test integer NOT NULL,
    corretto boolean,
    voto_test double precision
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
       public         postgres    false    3            �            1259    16497    quiz_aperto    TABLE     �   CREATE TABLE public.quiz_aperto (
    id_a integer NOT NULL,
    id_test integer NOT NULL,
    punteggio_min double precision NOT NULL,
    punteggio_max double precision NOT NULL,
    domanda character varying(50) NOT NULL
);
    DROP TABLE public.quiz_aperto;
       public         postgres    false    3            �            1259    16527    quiz_multiplo    TABLE     �  CREATE TABLE public.quiz_multiplo (
    id_m integer NOT NULL,
    id_test integer NOT NULL,
    punteggio_corretto double precision NOT NULL,
    punteggio_errato double precision NOT NULL,
    domanda character varying(200) NOT NULL,
    r_uno character varying(50) NOT NULL,
    r_due character varying(50) NOT NULL,
    r_tre character varying(50),
    r_quattro character varying(50),
    r_cinque character varying(50)
);
 !   DROP TABLE public.quiz_multiplo;
       public         postgres    false    3            �            1259    16507    risposta_aperta    TABLE       CREATE TABLE public.risposta_aperta (
    idr_a integer NOT NULL,
    username_s character varying(25) NOT NULL,
    username_i character varying(25) NOT NULL,
    risposta_data character varying(200),
    commento character varying(200),
    punteggio_risa double precision
);
 #   DROP TABLE public.risposta_aperta;
       public         postgres    false    3            �            1259    16537    risposte_multiple    TABLE     �   CREATE TABLE public.risposte_multiple (
    idr_m integer NOT NULL,
    username_s character varying(25) NOT NULL,
    risposta_data character varying(50),
    corretta boolean,
    punteggio_rm double precision
);
 %   DROP TABLE public.risposte_multiple;
       public         postgres    false    3            �            1259    16462    studente    TABLE     �   CREATE TABLE public.studente (
    username_s character varying(25) NOT NULL,
    password_s character varying(25) NOT NULL,
    nome character varying(25),
    cognome character varying(25),
    punteggio_tot double precision
);
    DROP TABLE public.studente;
       public         postgres    false    3            �            1259    16467    test    TABLE       CREATE TABLE public.test (
    id_test integer NOT NULL,
    username_i character varying(25) NOT NULL,
    nome_test character varying(25) NOT NULL,
    tempo_svolgimento time without time zone,
    materia_test character varying(25),
    descrizione character varying(100)
);
    DROP TABLE public.test;
       public         postgres    false    3                      0    16477 
   correzione 
   TABLE DATA               Z   COPY public.correzione (username_i, username_s, id_test, corretto, voto_test) FROM stdin;
    public       postgres    false    199   7                 0    16457 
   insegnante 
   TABLE DATA               K   COPY public.insegnante (username_i, password_i, nome, cognome) FROM stdin;
    public       postgres    false    196   07                  0    16497    quiz_aperto 
   TABLE DATA               [   COPY public.quiz_aperto (id_a, id_test, punteggio_min, punteggio_max, domanda) FROM stdin;
    public       postgres    false    200   M7       "          0    16527    quiz_multiplo 
   TABLE DATA               �   COPY public.quiz_multiplo (id_m, id_test, punteggio_corretto, punteggio_errato, domanda, r_uno, r_due, r_tre, r_quattro, r_cinque) FROM stdin;
    public       postgres    false    202   j7       !          0    16507    risposta_aperta 
   TABLE DATA               q   COPY public.risposta_aperta (idr_a, username_s, username_i, risposta_data, commento, punteggio_risa) FROM stdin;
    public       postgres    false    201   �7       #          0    16537    risposte_multiple 
   TABLE DATA               e   COPY public.risposte_multiple (idr_m, username_s, risposta_data, corretta, punteggio_rm) FROM stdin;
    public       postgres    false    203   �7                 0    16462    studente 
   TABLE DATA               X   COPY public.studente (username_s, password_s, nome, cognome, punteggio_tot) FROM stdin;
    public       postgres    false    197   �7                 0    16467    test 
   TABLE DATA               l   COPY public.test (id_test, username_i, nome_test, tempo_svolgimento, materia_test, descrizione) FROM stdin;
    public       postgres    false    198   �7       �
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
           2606    16501    quiz_aperto quiz_aperto_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.quiz_aperto
    ADD CONSTRAINT quiz_aperto_pkey PRIMARY KEY (id_a);
 F   ALTER TABLE ONLY public.quiz_aperto DROP CONSTRAINT quiz_aperto_pkey;
       public         postgres    false    200            �
           2606    16531     quiz_multiplo quiz_multiplo_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.quiz_multiplo
    ADD CONSTRAINT quiz_multiplo_pkey PRIMARY KEY (id_m);
 J   ALTER TABLE ONLY public.quiz_multiplo DROP CONSTRAINT quiz_multiplo_pkey;
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
           2606    16492 "   correzione correzione_id_test_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.correzione
    ADD CONSTRAINT correzione_id_test_fkey FOREIGN KEY (id_test) REFERENCES public.test(id_test);
 L   ALTER TABLE ONLY public.correzione DROP CONSTRAINT correzione_id_test_fkey;
       public       postgres    false    198    199    2701            �
           2606    16482 %   correzione correzione_username_i_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.correzione
    ADD CONSTRAINT correzione_username_i_fkey FOREIGN KEY (username_i) REFERENCES public.insegnante(username_i);
 O   ALTER TABLE ONLY public.correzione DROP CONSTRAINT correzione_username_i_fkey;
       public       postgres    false    2697    199    196            �
           2606    16487 %   correzione correzione_username_s_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.correzione
    ADD CONSTRAINT correzione_username_s_fkey FOREIGN KEY (username_s) REFERENCES public.studente(username_s);
 O   ALTER TABLE ONLY public.correzione DROP CONSTRAINT correzione_username_s_fkey;
       public       postgres    false    199    2699    197            �
           2606    16502 $   quiz_aperto quiz_aperto_id_test_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.quiz_aperto
    ADD CONSTRAINT quiz_aperto_id_test_fkey FOREIGN KEY (id_test) REFERENCES public.test(id_test);
 N   ALTER TABLE ONLY public.quiz_aperto DROP CONSTRAINT quiz_aperto_id_test_fkey;
       public       postgres    false    198    2701    200            �
           2606    16532 (   quiz_multiplo quiz_multiplo_id_test_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.quiz_multiplo
    ADD CONSTRAINT quiz_multiplo_id_test_fkey FOREIGN KEY (id_test) REFERENCES public.test(id_test);
 R   ALTER TABLE ONLY public.quiz_multiplo DROP CONSTRAINT quiz_multiplo_id_test_fkey;
       public       postgres    false    198    2701    202            �
           2606    16522 *   risposta_aperta risposta_aperte_idr_a_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.risposta_aperta
    ADD CONSTRAINT risposta_aperte_idr_a_fkey FOREIGN KEY (idr_a) REFERENCES public.quiz_aperto(id_a);
 T   ALTER TABLE ONLY public.risposta_aperta DROP CONSTRAINT risposta_aperte_idr_a_fkey;
       public       postgres    false    2705    201    200            �
           2606    16517 /   risposta_aperta risposta_aperte_username_i_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.risposta_aperta
    ADD CONSTRAINT risposta_aperte_username_i_fkey FOREIGN KEY (username_i) REFERENCES public.insegnante(username_i);
 Y   ALTER TABLE ONLY public.risposta_aperta DROP CONSTRAINT risposta_aperte_username_i_fkey;
       public       postgres    false    2697    196    201            �
           2606    16512 /   risposta_aperta risposta_aperte_username_s_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.risposta_aperta
    ADD CONSTRAINT risposta_aperte_username_s_fkey FOREIGN KEY (username_s) REFERENCES public.studente(username_s);
 Y   ALTER TABLE ONLY public.risposta_aperta DROP CONSTRAINT risposta_aperte_username_s_fkey;
       public       postgres    false    201    2699    197            �
           2606    16542 .   risposte_multiple risposte_multiple_idr_m_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.risposte_multiple
    ADD CONSTRAINT risposte_multiple_idr_m_fkey FOREIGN KEY (idr_m) REFERENCES public.quiz_multiplo(id_m);
 X   ALTER TABLE ONLY public.risposte_multiple DROP CONSTRAINT risposte_multiple_idr_m_fkey;
       public       postgres    false    2709    202    203            �
           2606    16547 3   risposte_multiple risposte_multiple_username_s_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.risposte_multiple
    ADD CONSTRAINT risposte_multiple_username_s_fkey FOREIGN KEY (username_s) REFERENCES public.studente(username_s);
 ]   ALTER TABLE ONLY public.risposte_multiple DROP CONSTRAINT risposte_multiple_username_s_fkey;
       public       postgres    false    197    2699    203            �
           2606    16472    test test_username_i_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.test
    ADD CONSTRAINT test_username_i_fkey FOREIGN KEY (username_i) REFERENCES public.insegnante(username_i);
 C   ALTER TABLE ONLY public.test DROP CONSTRAINT test_username_i_fkey;
       public       postgres    false    196    2697    198                  x������ � �            x������ � �             x������ � �      "      x������ � �      !      x������ � �      #      x������ � �            x������ � �            x������ � �     