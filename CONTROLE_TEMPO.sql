-------------------------------------------------------------------------------------------------
------------------------------------- INTRODUÇÃO ------------------------------------------------
-------------------------------------------------------------------------------------------------
--
-- O funcionamento desta package é parecido com um cronômetro.
-- Essa package permite controlar o tempo para execução de processos, principal uso dentro de Loops.
-- O cronômetro é reiniciado de forma automática após passar o tempo definido
--
--



--
-- Responsável por permitir realizar ações em intervalos de tempo definidos em segundos, o seu uso é indicado dentro de LOOP
CREATE OR REPLACE PACKAGE CONTROLE_TEMPO IS
--
-- Responsável por permitir realizar ações em intervalos de tempo definidos em segundos, o seu uso é indicado dentro de LOOP
-- O funcionamento desta package é parecido com um cronômetro.
-- Essa package permite controlar o tempo para execução de processos, principal uso dentro de Loops.
-- O cronômetro é reiniciado de forma automática após passar o tempo definido
--
-- Autor: Wesley David Santos
-- Skype: wesleydavidsantos		
-- https://www.linkedin.com/in/wesleydavidsantos
--


    FUNCTION SET_TEMPO_LIMITE(SEGUNDOS_LIMITE IN NUMBER) RETURN VARCHAR2;
    FUNCTION VERIFICAR_TEMPO(SESSION_ID IN VARCHAR2) RETURN BOOLEAN;
	
END CONTROLE_TEMPO;
/


CREATE OR REPLACE PACKAGE BODY CONTROLE_TEMPO IS
--
-- Autor: Wesley David Santos
-- Skype: wesleydavidsantos		
-- https://www.linkedin.com/in/wesleydavidsantos
--
    
	
	TYPE T_TIMER_REC IS RECORD (
        SESSION_ID VARCHAR2(100),
        TEMPO_INICIAL TIMESTAMP,
        TEMPO_LIMITE NUMBER,
        TEMPO_DECORRIDO NUMBER
    );
    
    TYPE T_TIMER_ARRAY IS TABLE OF T_TIMER_REC INDEX BY VARCHAR2(32);
    
    G_TIMERS T_TIMER_ARRAY;
    
	
    FUNCTION SET_TEMPO_LIMITE(SEGUNDOS_LIMITE IN NUMBER) RETURN VARCHAR2 IS
		
        L_SESSION_ID VARCHAR2(100);
        
		L_TIMER_REC T_TIMER_REC;
		
    BEGIN
	
		L_SESSION_ID := SYS_GUID();
	
        L_TIMER_REC.SESSION_ID := L_SESSION_ID;
        L_TIMER_REC.TEMPO_INICIAL := SYSTIMESTAMP;
        L_TIMER_REC.TEMPO_LIMITE := SEGUNDOS_LIMITE;
        L_TIMER_REC.TEMPO_DECORRIDO := 0;
        
		
		begin
			G_TIMERS(L_SESSION_ID) := L_TIMER_REC;
		
		EXCEPTION
			
			WHEN OTHERS THEN
			
				dbms_output.put_line( 'Erro aqui' );
		
		end;
			
        
        RETURN L_SESSION_ID;
		
    END;
    
	
	
    FUNCTION VERIFICAR_TEMPO(SESSION_ID IN VARCHAR2) RETURN BOOLEAN IS
        L_TEMPO_DECORRIDO NUMBER;
    BEGIN
	
        IF G_TIMERS.EXISTS(SESSION_ID) THEN
		
            L_TEMPO_DECORRIDO := EXTRACT(SECOND FROM SYSTIMESTAMP - G_TIMERS(SESSION_ID).TEMPO_INICIAL);
			
            G_TIMERS(SESSION_ID).TEMPO_DECORRIDO := L_TEMPO_DECORRIDO;
            
            IF L_TEMPO_DECORRIDO >= G_TIMERS(SESSION_ID).TEMPO_LIMITE THEN
			
                G_TIMERS(SESSION_ID).TEMPO_INICIAL := SYSTIMESTAMP; -- REINICIA O CRONÔMETRO
				
                RETURN TRUE;
				
            ELSE
			
                RETURN FALSE;
				
            END IF;
			
        ELSE
		
            RETURN FALSE;
			
        END IF;
		
		
    END;
	
END CONTROLE_TEMPO;
/
